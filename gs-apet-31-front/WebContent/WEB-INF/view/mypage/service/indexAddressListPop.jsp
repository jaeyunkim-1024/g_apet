<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%--
  Class Name  : indexAddressList.jsp 
  Description : 회원 주소록 목록
  Author      : 신남원
  Since       : 2016.03.02
  Modification Information 
	          수정일         	     수정자             수정내용
    ----------  -------  -------------------------------------------
    2016.03.02    신남원            최초 작성
    2021.02.10	   김명섭             추가 개발
--%>
		<script>
			
		$(document).ready(function(){
			
			
			// 배송지 추가
			$("[name=addAddressBtn]").click(function(){
				if($(".delist > li").length >= 5){
					ui.toast("배송지는 5개까지 등록할 수 있어요");
					return false;
				}
				openAddressAddPop();
			})
			// 배송지 수정
			$("[name=updateAddressBtn]").click(function(){
				openAddressAddPop($(this).data('dlvra-no'));
			});
			// 배송지 삭제
			$("[name=deleteAddressBtn]").click(function(){
				deleteAddress($(this).data('dlvra-no') , $(this).data('gb-nm') , $(this).data('dftyn'));
			});
			// 배송지 선택시 
			$("#adddressBtn").click(function(){
				var obj = null;
				var formData = $("[name=popAddr]:checked").parents("label").siblings("form").serializeArray();
				if(formData){
					obj = {};
					$.each(formData , function(){
						obj[this.name] = this.value;
					});
				}
				console.log(obj);
				if(obj.popDftYn == "Y"){
					$("#dftDelivery").show();
					 confirmAddress(obj);
				}else{
					ui.confirm("선택한 배송지를 기본 배송지로 설정할까요?" ,{
						ycb:function(){
							updateDftAddress(obj);
							$("#dftDelivery").show()
						}
						, ncb :function(){
							confirmAddress(obj);
							$("#dftDelivery").hide();
						}
						, ybt : "설정하기"
						, nbt : "이번만 배송"
					})
				}
			});
		});
		
		function updateDftAddress(obj){
			var options = {
					url : "<spring:url value ='/mypage/service/updateAddressDefault' />"
					, data : {
						mbrDlvraNo : obj.popDlvraNo
					}
					, done : function(){
						if("${view.deviceGb}" == "PC"){
							ui.alert("변경되었습니다." , {
								ycb:function(){
									confirmAddress(obj)
									$("#dftDelivery").show()
								}
							})
						}else{
							ui.toast("변경되었습니다.");
							confirmAddress(obj);
							$("#dftDelivery").show()
						}
					}
			}
			ajax.call(options);
		}
		
		
		function confirmAddress(obj){
			
			$("#order_payment_mbr_dlvra_no").val(obj.popDlvraNo);
			$("#dlvraGbNmEm").text(obj.popGbNm);
			$("#order_payment_gb_nm").val(obj.popGbNm);
			$("#dlvraAdrsDiv").text("["+obj.popPostNoNew+"]"+obj.popRoadAddr+" "+obj.popRoadDtlAddr);
			$("#dlvraTelsDiv").text(obj.popAdrsNm + "/" + obj.popMobile);
			$("#order_payment_adrs_nm").val(obj.popAdrsNm);
			$("#order_payment_adrs_mobile").val(obj.popMobile);
			$("#order_payment_post_no_new").val(obj.popPostNoNew);
			$("#order_payment_road_addr").val(obj.popRoadAddr);
			$("#order_payment_road_dtl_addr").val(obj.popRoadDtlAddr);
			
			$("#demandGoodsRcvPstCd").text($("label[for='"+ 'goodsRcvPst-' + obj.popGoodsRcvPstCd +"']").text())
			$("#demandPblGateEntMtdCd").text($("label[for='"+ 'pblGateEntMtd-' + obj.popGoodsRcvPstCd +"']").text());
			$("#demandDlvrDemand").text(obj.popDlvrDemand);
			
			if(obj.popDftYn == "Y"){
				$("#dftDelivery").show();
			}else{
				$("#dftDelivery").hide();	
			}
			ui.popLayer.close("popupAddressList1");
			
			
			/**
			 * 결제페이지에서 배송비 재계산용으로 실행하는 함수.
			 */
			try {
				// 배송시간 재계산
				fncGetDlvrArea($("#order_payment_post_no_new").val());
			} catch(e) {
				// 보안성 진단.불필요한 코드 (비어있는 block문)
				console.log("fncGetDlvrArea Exception!");
			}
		}
		// 	배송지 추가 / 수정 팝업
		function openAddressAddPop(dlvraNo){
			if($("li[name^=del_]").length < 5 || (dlvraNo != null && dlvraNo != '')){
				var options = {
						url : "<spring:url value='/mypage/service/popupAddressEdit' />"
						, data : {
							mbrDlvraNo : dlvraNo
							, popYn : "Y"
						}
						, dataType : "html"
						, done : function(html){
							$("#addressAddPop").html(html);
							ui.popLayer.open("addressAddPop");
							ui.popLayer.init();
							setInput(dlvraNo);
						}
				}
				ajax.call(options);
			}else {
				ui.toast("배송지는 5개까지 등록할 수 있어요");
				return false;
			}
		}
		
		// 	배송지 삭제
		function deleteAddress(mbrDlvraNo,gbNm,dftYn){
			if(dftYn == 'Y'){
				ui.alert("<spring:message code='front.web.view.address.alert.dft_address' />");
			}else{
				var msg = "<spring:message code='front.web.view.address.confirm.delete_address' />";
				msg = msg.replace(/\{gbNm\}/g, gbNm);
				ui.confirm(msg , {
					ycb:function(){
						var options = {
								url : "<spring:url value='/mypage/service/deleteAddress' />"
								, data : {mbrDlvraNo : mbrDlvraNo}
								, done : function(result){
									if(result > 0){
										$("li[name=del_"+mbrDlvraNo+"]").remove();
										
										ui.toast("<spring:message code='front.web.view.mypage.service.address.delete.success' />");
										/* window.setTimeout(function(){
										location.reload(true);	
											} , 2000) */
										
									}
								}
						}
						ajax.call(options);
					},
					//보안성검사결과처리. 불필요한 코드 (비어있는 함수) 제거		
					/* ncb:function(){
					}, */
					ybt:'예',
					nbt:'아니오'
				});
			}
		}
		
		</script>
		<div class="pbd">
			<div class="phd">
				<div class="in">
					<h1 class="tit">배송지 선택</h1>
					<button type="button" class="btnPopClose" onclick="window.self.close();">닫기</button>
				</div>
			</div>
			<div class="pct">
				<main class="poptents">
					<div class="uiDelisel">
					<c:if test="${addressList ne '[]'}">
							<ul class="delist">
							<c:forEach items='${addressList }' var="address" varStatus = "stat">
								<li class="active" name="del_${address.mbrDlvraNo }">
									<div class="box">
										<nav class="uidropmu dmenu">
											<button type="button" class="bt st">메뉴열기</button>
											<ul class="menu">
												<li><button type="button" class="bt" name ="updateAddressBtn" data-dlvra-no ="${address.mbrDlvraNo }" data-content="" data-url="openAddressAddPop($(this).data('dlvra-no'));">수정</button></li>
												<li><button type="button" class="bt" name ="deleteAddressBtn" data-dlvra-no ="${address.mbrDlvraNo }"  data-gb-nm="${address.gbNm}" data-dftyn="${address.dftYn }" data-content="" data-url="deleteAddress($(this).data('dlvra-no') , $(this).data('gb-nm') , $(this).data('dftyn'))">삭제</button></li>
											</ul>									
										</nav>
										<form name ="popAddrForm" id ="popAddrForm">
											<input type ="hidden" name ="popDlvraNo" value = "${address.mbrDlvraNo }"/>
											<input type ="hidden" name ="popPostNoNew" value = "${address.postNoNew }"/>
											<input type ="hidden" name ="popRoadAddr" value = "${address.roadAddr }"/>
											<input type ="hidden" name ="popRoadDtlAddr" value ="${address.roadDtlAddr }"/>
											<input type ="hidden" name ="popAdrsNm" value ="${address.adrsNm }"/>
											<input type ="hidden" name ="popGbNm" value ="${address.gbNm}"/>
											<input type ="hidden" name ="popMobile" value ="${address.mobile }"/>
											<input type ="hidden" name ="popDftYn" value ="${address.dftYn }"/>
											<input type ="hidden" name="popGoodsRcvPstCd" value ="${address.goodsRcvPstCd}"/>
											<input type ="hidden" name="popGoodsRcvPstEtc" value ="${address.goodsRcvPstEtc}"/>
											<input type ="hidden" name="popPblGateEntMtdCd" value ="${address.pblGateEntMtdCd}"/>
											<input type ="hidden" name="popPblGatePswd" value ="${address.pblGatePswd}"/>
											<input type= "hidden" name="popDlvrDemand" value="${address.dlvrDemand }"/>
										</form>
										<label class="radio">
												<input type="radio" name="popAddr"  data-dlvra-no="${address.mbrDlvraNo }"/>
												<span class="txt">
													<em class="tt">${address.gbNm}</em> 
													<c:if test = "${address.dftYn eq 'Y'}">
														<em id ="adrDftYn" class="bdg">기본배송지</em>
													</c:if>
												</span>
											</label>
										<div class="inf">
											<div class="adrs">[${address.postNoNew }] ${address.roadAddr} &nbsp; ${address.roadDtlAddr} </div>
											<div class="usrs">	
											<c:if test="${address.adrsNm ne null }">
												${address.adrsNm}
											</c:if>
											<c:if test="${address.tel ne null }">
												| <frame:tel data="${address.tel}" />
											</c:if>
											<c:if test="${address.mobile ne null }">
												| <frame:mobile data="${address.mobile}" />
											</c:if>
											</div>
										</div>
									</div>
								</li>
								</c:forEach>
							</ul>
						</c:if>
						<c:if test="${addressList eq '[]'}">	
						<div class="noneBoxPoint" id ="noneAddressBox">
							<div>
								<span class="noneBoxPoint_img2"></span>
								<div class="noneBoxPoint_infoTxt" style="color:#666;">등록된 배송지가 없습니다.</div>
							</div>
						</div>
					</c:if>
						<div class="btadds">
							<button type="button" class="bt btDiAdd" onclick ="openAddressAddPop()">배송지 추가</button>
						</div>
					</div>
					<!-- article class popDeliPop > popDelsel로 변경시 style 삭제 -->
					<div class="btnSet bot" style ="justify-content: center;margin-top: 90px;"><button type="button" id ="adddressBtn" class="btn lg a">확인</button></div>
				</main>
			</div>
		</div>
		
		<article class="popLayer a popDeliMod noClickClose" id = "addressAddPop">
		</article>

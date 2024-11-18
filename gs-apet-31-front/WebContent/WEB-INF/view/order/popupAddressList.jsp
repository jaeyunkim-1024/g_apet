<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<script type="text/javascript">
	
	$(document).ready(function(){
		
		
		// 배송지 추가
		$("[name=addAddressBtn]").click(function(){
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
			var formData = $("[name=popAddr]:checked").data();
			console.log(formData);
			if(formData.dftYn == "Y"){
				 confirmAddress(formData);
			}else{
				ui.confirm("선택한 배송지를 기본 배송지로 설정할까요?" ,{
					ycb:function(){
						updateDftAddress(formData);
					}
					, ncb :function(){
						confirmAddress(formData);
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
				mbrDlvraNo : obj.mbrDlvraNo
			}
			, done : function(){
				ui.toast("기본 배송지가 설정되었어요");
				obj.dftYn = 'Y';
				confirmAddress(obj);
			}
		}
		ajax.call(options);
	}
	
	
	function confirmAddress(data){
		<c:out value="${param.callBackFnc}" />(data);
		ui.popLayer.close("<c:out value="${param.popId}" />");
	}
	
	// 	배송지 추가 / 수정 팝업
	function openAddressAddPop(dlvraNo){
		if($("#popupAddressCnt").val() >= 5 && !(dlvraNo != null && dlvraNo != '')){
			ui.toast('배송지는 5개까지 등록할 수 있어요');
			return false;
		}else{
			var options = {
				url : "<spring:url value='/mypage/service/popupAddressEdit' />"
				, data : {
					mbrDlvraNo : dlvraNo
					, popYn : "Y"
				}
				, dataType : "html"
				, done : function(html){
					$("#addressAddPop").html(html);
					
					if ($("#addressAddPop #memberAddressForm").length == 0) {
						ui.alert("오류가 발생하였습니다. 관리자에게 문의하시기 바랍니다.");
					} else {
						ui.popLayer.open("addressAddPop");
					}
				}
			}
			ajax.call(options);
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
									$("#popupAddressCnt").val($("#popupAddressCnt").val()-1);
									ui.toast("<spring:message code='front.web.view.mypage.service.address.delete.success' />");
									/* window.setTimeout(function(){
									location.reload(true);	
										} , 2000) */
									
								}
							}
					}
					ajax.call(options);
				},
				ncb:function(){
				},
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
					<input type="hidden" name="popupAddressCnt" id="popupAddressCnt" value="${fn:length(addressList)}" />
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
								<label class="radio">
									<input type="radio" name="popAddr" ${so.mbrDlvraNo eq address.mbrDlvraNo ? ' checked' : '' }
										data-mbr-dlvra-no="${address.mbrDlvraNo }"
										data-gb-nm="${address.gbNm }"
										data-adrs-nm="${address.adrsNm }"
										data-tel="${address.tel }"
										data-mobile="${address.mobile }"
										data-post-no-new="${address.postNoNew }"
										data-road-addr="${address.roadAddr }"
										data-road-dtl-addr="${address.roadDtlAddr }"
										data-dft-yn="${address.dftYn }"
										data-dlvr-demand-yn="${address.dlvrDemandYn }"
										data-goods-rcv-pst-cd="${address.goodsRcvPstCd }"
										data-goods-rcv-pst-nm="${address.goodsRcvPstNm }"
										data-goods-rcv-pst-etc="${address.goodsRcvPstEtc }"
										data-pbl-gate-ent-mtd-cd="${address.pblGateEntMtdCd }"
										data-pbl-gate-ent-mtd-nm="${address.pblGateEntMtdNm }"
										data-pbl-gate-pswd="${address.pblGatePswd }"
										data-dlvr-demand="${address.dlvrDemand }"
									/>
									<span class="txt">
										<em class="tt txd"><c:out value="${address.escapedGbNm }" escapeXml="false"/>
										<c:if test = "${address.dftYn eq 'Y'}">
											<em id ="adrDftYn" class="bdg">기본배송지</em>
										</c:if>
										</em>
									</span>
								</label>
								<div class="inf">
									<div class="adrs">[${address.postNoNew }] ${address.roadAddr} &nbsp; <c:out value="${address.escapedRoadDtlAddr }" escapeXml="false"/> </div>
									<div class="usrs">	
									<c:if test="${address.adrsNm ne null }">
										<c:out value="${address.escapedAdrsNm }" escapeXml="false"/>
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

<div class="layers" id="addLayers">
</div>

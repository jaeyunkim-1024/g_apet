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
<tiles:insertDefinition name="noheader_mo">
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			let addressListCnt = "${fn:length(addressList)}";
			let btnDelChk = false;
			
			$(document).ready(function(){
				$(".mode0").remove()
 
				
				$("[name=rd_deli_sel][data-dftYn='Y']").prop("checked" , true);
				
				// 배송지 추가
				$("[name=addAddressBtn]").click(function(){
// 					if($(".delist > li").length >= 5){
					if(addressListCnt >= 5) {
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
				
				$("[name=rd_deli_sel]").change(function(){
					$("[name=deliLi]").removeClass("active")
					$(this).parents("li").addClass("active");
				});
				
			});
			
			// 	배송지 추가 / 수정 팝업
			function openAddressAddPop(dlvraNo){
				if($("li[name=deliLi]").length < 5 || (dlvraNo != null && dlvraNo != '')){
					var options = {
							url : "<spring:url value='/mypage/service/popupAddressEdit' />"
							, data : {
								mbrDlvraNo : dlvraNo
							}
							, dataType : "html"
							, done : function(html){
								$("#addressAddPop").html(html);
								
								if ($("#addressAddPop #memberAddressForm").length == 0) {
									ui.alert("오류가 발생하였습니다. 관리자에게 문의하시기 바랍니다.");
								} else {
									ui.popLayer.open("addressAddPop");
									ui.popLayer.init();
								}
							}
					}
					ajax.call(options);
				}else{
				
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
											$("#del_"+mbrDlvraNo).remove();
											addressListCnt = addressListCnt - 1;
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
						nbt:'아니요'
					});
				}
			}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<div class="wrap" id="wrap">
			<header class="header pc cu mode7" data-header="set9">
				<div class="hdr">
					<div class="inr">
						<div class="hdt">
							<button id ="backBtn" onclick ="storageHist.goBack()" class="mo-header-backNtn">뒤로</button>
							<div class="mo-heade-tit"><span class="tit">배송지 관리</span></div>
							<div class="mo-header-rightBtn">
							<button type="button" class="mo-header-btnType01" name="addAddressBtn" id="addAddressBtn" data-content="layerAlert" data-url="/mypage/service/popupAddressEdit">
								<span class="mo-header-icon"></span>
								<span class="txt">배송지 추가</span>
							</button>
							</div>
						</div>
					</div>
				</div>
			</header>

		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container page shop delsel" id="container">
			<div class="inr">			
				<!-- 본문 -->
				<div class="contents" id="contents">
				<c:if test="${addressList ne '[]'}">
					<div class="uiDelisel">
						<ul class="delist">
						<c:forEach items='${addressList }' var="address">
							<li name = "deliLi " id="del_${address.mbrDlvraNo }" class="<c:if test="${address.dftYn eq 'Y' }">active</c:if>">
								<div class="box t2">
									<nav class="uidropmu dmenu">
										<button type="button" class="bt st" data-content="" data-url="">메뉴열기</button>
										<ul class="menu">
											<li><button type="button" class="bt" name ="updateAddressBtn" data-dlvra-no ="${address.mbrDlvraNo }" data-content="layerAlert" data-url="/mypage/service/popupAddressEdit?mbrDlvraNo=${address.mbrDlvraNo }">수정</button></li>
											<li><button type="button" class="bt" name ="deleteAddressBtn" data-dlvra-no ="${address.mbrDlvraNo }"  data-gb-nm="${address.gbNm}" data-dftyn="${address.dftYn }" data-content="" data-url="/mypage/service/deleteAddress">삭제</button></li>
										</ul>									
									</nav>
									<div class="new_tit_area<c:if test="${address.dftYn eq 'Y' }"> on</c:if>">
										${address.gbNm}<c:if test="${address.dftYn eq 'Y' }"><em class="bdg">기본배송지</em></c:if>
									</div>
									<div class="inf">
										<div class="adrs">[${address.postNoNew}] ${address.roadAddr} &nbsp; ${address.roadDtlAddr} </div>
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
						</div>
					</c:if>
					<c:if test="${addressList eq '[]'}">	
						<div class="noneBoxPoint" id ="noneAddressBox">
							<div>
								<span class="noneBoxPoint_img2"></span>
								<div class="noneBoxPoint_infoTxt" style="color:#666;">등록된 배송지가 없습니다.</div>
							</div>
						</div>
					</c:if>
<!-- 				<div class="btnSet bot"><button type="button" class="btn lg a">확인</button></div> -->
				</div>

			</div>
		</main>
		<!-- 바디 - 여기 밑으로 템플릿 -->
		<!-- 하단메뉴 -->
		<!-- <include class="menubar" data-include-html="../inc/menubar.html"></include> -->
		<!-- 푸터 -->
		<!-- <include class="footer" data-include-html="../inc/footer.html"></include> -->

		<div class="layers">
			
		<article class="popLayer a popDeliMod noClickClose" id="addressAddPop">
		</article>
		
			<!-- 레이어팝업 넣을 자리 -->
		</div>
		<div class="layers" id="addLayers">
		</div>
	</div>
	</tiles:putAttribute>
</tiles:insertDefinition>

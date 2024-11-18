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
<tiles:insertDefinition name="mypage">
	<tiles:putAttribute name="script.inline">
	<script type="text/javascript" src="/_script/memberAddress/memberAddress.js"></script>
		<script type="text/javascript">
			let addressListCnt = "${fn:length(addressList)}";
			let btnDelChk = false;
			
			$(document).ready(function(){
				
				// ui.shop.lnb.set 실행 prevent
				// 상담톡 버튼 Footer 영역까지 내려가는 현상 수정으로 인해 주석처리 20210527
				//$(window).off("load scroll resize");
				ui.shop.lnb.pos();
				// 배송지 추가
				$("[name=addAddressBtn]").click(function(){
// 					if($(".delist > li").length >= 5){
					// 배송지 5개에서 1개 삭제 후 배송지 추가 시 정상 추가 수정 20210518
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
			});
			
			// 	배송지 추가 / 수정 팝업
			function openAddressAddPop(dlvraNo){
				if($("li[name^=del_]").length < 5 || (dlvraNo != null && dlvraNo != '')){
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
							}
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
											// 배송지 삭제 시 배송지 카운트 수정 20210518
											addressListCnt = addressListCnt - 1;
											
											ui.toast("<spring:message code='front.web.view.mypage.service.address.delete.success' />")
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
		<main class="container lnb page my" id="container">
			<div class="inr">			
				<!-- 본문 -->
				<div class="contents" id="contents">
					<!-- PC 타이틀 모바일에서 제거 -->
					<div class="pc-tit">
						<h2>배송지 관리</h2>
						<button class="btn circle_add add" name ="addAddressBtn" data-content="layerAlert" data-url="/mypage/service/popupAddressEdit" style ="color: #669aff;">배송지 추가</button>
					</div>
					<c:if test="${addressList ne '[]'}">
						<div class="uiDelisel">
							<ul class="delist">
								<c:forEach items='${addressList }' var="address">
									<li class="<c:if test="${address.dftYn eq 'Y' }">active</c:if>" name="del_${address.mbrDlvraNo }">
										<div class="box t2">
											<nav class="uidropmu dmenu">
												<button type="button" class="bt st">메뉴열기</button>
												<ul class="menu">
													<li><button type="button" class="bt" name ="updateAddressBtn" data-dlvra-no ="${address.mbrDlvraNo }" data-content="layerAlert" data-url="/mypage/service/popupAddressEdit?mbrDlvrNo=${address.mbrDlvraNo }">수정</button></li>
													<li><button type="button" class="bt" name ="deleteAddressBtn" data-dlvra-no ="${address.mbrDlvraNo }"  data-gb-nm="${address.gbNm}" data-dftyn="${address.dftYn }" data-content="" data-url="/mypage/service/deleteAddress">삭제</button></li>
												</ul>									
											</nav>
											<div class="new_tit_area <c:if test = "${address.dftYn eq 'Y'}">on</c:if>">
													<c:out value="${address.escapedGbNm }" escapeXml="false" />
												<c:if test = "${address.dftYn eq 'Y'}">
													<em class="bdg">기본배송지</em>
												</c:if>
											</div>
											<div class="inf">
												<div class="adrs">[${address.postNoNew }]${address.roadAddr} &nbsp; <c:out value="${address.escapedRoadDtlAddr}" escapeXml="false" /> </div>
												<div class="usrs">												
													<c:if test="${address.adrsNm ne null }">
														<c:out value="${address.escapedAdrsNm}" escapeXml="false" />
													</c:if>
													<c:if test="${address.tel ne null }">
														/ <frame:tel data="${address.tel}" />
													</c:if>
													<c:if test="${address.mobile ne null }">
														/ <frame:mobile data="${address.mobile}" />
													</c:if>
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
					<!--
					<div class="btnSet bot"><button type="button" class="btn lg a">확인</button></div>
					-->
					</div>
				</div>
			</main>
		<article class="popLayer a popDeliMod noClickClose" id = "addressAddPop">
		</article>
		 
		<div class="layers" id="addLayers">
		</div>
		 <!-- 플로팅 영역 -->
        <c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}" >
			<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
	        	<jsp:param name="floating" value="" />
	        </jsp:include>
        </c:if>
	</tiles:putAttribute>
</tiles:insertDefinition>

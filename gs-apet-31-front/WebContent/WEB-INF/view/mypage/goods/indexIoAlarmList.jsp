<%--
  Created by IntelliJ IDEA.
  User: ssh
  Date: 2021-03-28
  Time: 오후 1:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<tiles:insertDefinition name="mypage">
	<tiles:putAttribute name="script.inline">
		<script>
			$(document).ready(function(e) {
				
				//상단 뒤로가기 버튼 클릭시 마이페이지로
				$(".mo-header-backNtn").removeAttr("onclick");
				$(".mo-header-backNtn").bind("click", function(){
					history.replaceState("","","/mypage/indexMyPage/");
					location.href="/mypage/indexMyPage/";
				});
				
				$(function(){
					$(".re-position-txt").height($(".re-position-txt").children(0).innerHeight());
				})

				$(document).on("click", '[data-target="goods"][data-action="ioAlarmCancel"]', function(e) {
					let $btn = $(this);
					let goodsId = $btn.data("goods-id") || $btn.data("content");
					var options = {
						url : "/mypage/deleteIoAlarm",
						data : {goodsId : goodsId, almYn : "N"},
						done : function(data) {
							// console.log("data : " + JSON.stringify(data));
							// 알림신청시 기존에 등록에 대한 처리는 없음.
							if(data.message == "login") {
								//document.location.href = '/indexLogin?returnUrl='+encodeURIComponent(document.location.href);
							}else if(data.message == "deleted"){
								ui.toast("<spring:message code='front.web.view.mypage.goods.msg.deleteIo.restock.alarm' />",{
									cls : "added" ,
									bot: 74, //바닥에서 띄울 간격
									sec:  3000 //사라지는 시간
								});
								$btn.closest("li").remove();
							}else if(data.message == "noData") {
								//재입고 알림 데이터 없음?
							}else if(data.message == "fail") {
								//실패? ㅜㅜ
							}

						}
					};
					ajax.call(options);

				}).on("click", "#ioAlarmMoreLoad", function(e) {
					let $ioAlarmList = $("#ioAlarmList");
					let page = $ioAlarmList.data("page") || 1;
					page = $.isNumeric(page) ? parseInt(page) : 1;
					var options = {
						url : "/mypage/loadIoAlarmList",
						data : {page: (page+1)},
						dataType: "html",
						done : function(data) {
							$("#ioAlarmList").append(data);
						}
					};
					ajax.call(options);

				});
				
				$("#header_pc").removeClass("mode0");
				$("#header_pc").addClass("mode16");
				$("#header_pc").attr("data-header", "set22");
				$("#header_pc").addClass("noneAc");
				$(".mo-heade-tit .tit").html("<spring:message code='front.web.view.mypage.goods.title.restock.alarm' />");
				
				// footer 없는화면 (재입고 알림 footer PC노출/MO미노출 20210518 수정)
				if ("${view.deviceGb ne frontConstants.DEVICE_GB_10}" == "true") {
					$("#footer").remove();
				}
				
				$("div[name=contentArea]").on('click', 'img, div.tit, em, div.soldouts', function(){
					var goodsId = $(this).parents('div[name=contentArea]').data('goodsId');
					location.href="/goods/indexGoodsDetail?goodsId="+goodsId;
				})
			});
		</script>

	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<main class="container lnb page shop my" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<div class="pc-tit">
						<h2><spring:message code='front.web.view.mypage.goods.title.restock.alarm' /></h2>
					</div>
					<c:choose>
						<c:when test="${empty ioAlarmList}">
							<div class="noData">
								<section class="no_data i1 auto_h">
									<div class="inr">
										<div class="msg"><spring:message code='front.web.view.mypage.goods.msg.no.apply.restock.alarm' /></div>
									</div>
								</section>
								<div class="re-position-txt pc-c1">
									<div class="info-txt t2 ">
										<p class="tit"><spring:message code='front.web.view.common.title.notice' /></p>
										<ul>
											<li><spring:message code='front.web.view.goods.title.send.restockmsg' /></li>
											<li><spring:message code='front.web.view.goods.title.confirm.receiptmsg' /></li>
											<li><spring:message code='front.web.view.goods.title.automatically.delete.restockmsg.after3months' /></li>
										</ul>
									</div>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="exchange-area pc-padding-top10">
								<div class="item-box pc-reposition t3">
									<div class="oder-cancel line-type s4015">
										<!-- page: ${page}
										totalPage: ${totalPage}
										totalCount: ${totalCount}
										-->
										<ul id="ioAlarmList" data-page="${page}">
											<jsp:include page="/WEB-INF/view/mypage/goods/include/includeIoAlarmList.jsp" />
										</ul>
									</div>
								</div>
								<c:if test="${totalPage > page}">
									<div class="moreload ts2 h0">
										<button type="button" class="bt more" id="ioAlarmMoreLoad">내역 더보기</button>
									</div>
								</c:if>

								<div class="re-position-txt pc-c1">
									<div class="info-txt t2 ">
										<p class="tit"><spring:message code='front.web.view.common.title.notice' /></p>
										<ul>
											<li><spring:message code='front.web.view.goods.title.send.restockmsg' /></li>
											<li><spring:message code='front.web.view.goods.title.confirm.receiptmsg' /></li>
											<li><spring:message code='front.web.view.goods.title.automatically.delete.restockmsg.after3months' /></li>
										</ul>
									</div>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</main>

		<div class="layers">
			<!-- 레이어팝업 넣을 자리 -->
		</div>

		<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}" >
			<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
				<jsp:param name="floating" value="talk" />
			</jsp:include>
		</c:if>

	</tiles:putAttribute>
</tiles:insertDefinition>
<script>
	var wrap = $('.noData');
	var top = wrap.find('.no_data');
	var bottom = wrap.find('.info-txt');
	var heightMo =  bottom.outerHeight() + 20;
	var heightPc =  bottom.outerHeight() + 230;
	
	setTimeout(function(){
		var check = ($('link[href *= "style.mo.css"]').length) ? true : false;
		if(check){
			$('.no_data').css({
				height : "calc(100% - " + heightMo +"px)"
			});
		}else {
			$('.no_data').css({
				height : "calc(100% - " + heightPc +"px)"
			});
		}
		console.log(check);
	}, 50);
	
</script>



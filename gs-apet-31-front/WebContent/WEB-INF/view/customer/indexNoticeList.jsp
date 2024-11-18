<tiles:insertDefinition name="noheader_mo">
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
			var page = 1;
			var result = true;
			var scrollPrevent = true;
			$(function(){
				if("${view.deviceGb}" != "PC"){
					<c:if test="${view.deviceGb ne frontConstants.DEVICE_GB_10}">
						$(".mo-heade-tit .tit").text("공지사항");
						$(".mo-header-backNtn").attr('onclick', 'storageHist.goBack();');
						$("#header_pc").addClass('logHeaderAc');
					</c:if>
				}
				
				for(var i = 0 ; i < $("input[name=intervalDay]").length ; i++){
					var value = $("input[name=intervalDay]").eq(i).val();
					if(value > -8){
						$("input[name=intervalDay]").eq(i).next().addClass("new");
					}
				}
				
				$(window).on("scroll" , function(){
					if($(window).scrollTop()+1 >= $(document).height() - $(window).height()){
						if(result && scrollPrevent){
							if($("#noticeul li").length >= 10){
								page++;
								scrollPrevent = false;
								pagingNotice(page);	
							}
						}
					}					
				})
				
				$(document).on("click" , ".hBox" , function(e){
					$(this).find("button").trigger("click")
				});
				
				$(document).on("click" , ".btnTog" , function(e){
					e.stopPropagation();
				})
				
				$(document).on("click" , "#partnerApply" , function(){
					location.href = "/customer/partnerApply"
				});
				
				$(document).on("click" , "#fileDownload" , function(){
					fileDownload("${partner.filePath}" , "${partner.fileName}");
				})
			});
			
			function pagingNotice(noticePage){
				var options = {
						url : "<spring:url value='indexNoticeList'/>"
						, data : {
							page : noticePage
						}
						, dataType : "html"
						, done : function(html){
							$("#noticeul").append(html);
							scrollPrevent = true;
							
							if($("#noticeul li").length % 10 != 0){
								result = false;
							}
						}
				}
				ajax.call(options);
			}
			
			//파일 다운로드
			 function fileDownload(filePath, fileName){
				var deviceGb = "${view.deviceGb}";
				if(deviceGb != "${frontConstants.DEVICE_GB_10}"){
					ui.alert("<spring:message code='front.web.view.customer.filedownload.mobile.msg.check.warning' />");
				}else{
					var inputs = "<input type=\"hidden\" name=\"filePath\" value=\""+filePath+"\"/><input type=\"hidden\" name=\"fileName\" value=\""+fileName+"\"/>";
				 	jQuery("<form action=\"/common/fileDownloadResult\" method=\"post\">"+inputs+"</form>").appendTo('body').submit();					
				}
			 }
			
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
<%-- 	<div class="wrap" id="wrap">
		<c:if test ="${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
			<!-- mobile header --> 
			<header class="header pc cu mode7 logHeaderAc" data-header="set9">
				<div class="hdr">
					<div class="inr">
						<div class="hdt">
							<button class="mo-header-backNtn" onclick="history.go(-1)" data-content="" data-url="history.go(-1)"><spring:message code='front.web.view.common.msg.back' /></button>
							<div class="mo-heade-tit">
								<span class="tit"><spring:message code='front.web.view.common.msg.notice' /></span>
							</div>
						</div>
					</div>
				</div>
			</header>
			<!-- mobile header --> 
		</c:if> --%>
			<!-- 바디 - 여기위로 템플릿 -->
		<main class="container page noti" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<c:if test ="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
						<!-- PC 타이틀 모바일에서 제거  -->
						<div class="pc-tit">
							<h2><spring:message code='front.web.view.common.msg.notice' /></h2>
						</div>
						<!-- // PC 타이틀 모바일에서 제거  -->
					</c:if>
					<!-- 공지사항 컨텐츠 영역 -->
					<section class="sect notilist">
						<ul id ="noticeul" class="uiAccd" data-accd="accd">
							<c:if test = "${partner ne null }">
								<li>
									<div class="hBox">
										<input type="hidden" name="intervalDay" value='${partner.intervalDay }'>
										<p>
											<span class="tit" name="bbsTitle">
											${partner.bbsGbNm }${partner.ttl }
										</p>
										<span class="date"><frame:date date="${partner.stringRegDtm }" type="C" /></span>
										<button type="button" class="btnTog" data-content="" data-url=""><spring:message code='front.web.view.common.msg.button' /></button>
									</div>
									<div class="cBox" style="display:none">
									<p id="fileDownload" style ="cursor:pointer;color:blue;"><spring:message code='front.web.view.customer.entry.store.partnership.filedownload' /></p>
										${partner.content }
									</div>
								</li>
							</c:if>								
							<c:forEach items="${noticeList }" var="notice">
								<li>
									<div class="hBox">
										<input type="hidden" name="intervalDay" value='${notice.intervalDay }'>
										<p>
											<span class="tit"  name="bbsTitle">
											${notice.bbsGbNm }${notice.ttl }
										</p>
										<span class="date"><frame:date date="${notice.stringRegDtm }" type="C" /></span>
										<button type="button" class="btnTog" data-content="" data-url=""><spring:message code='front.web.view.common.msg.button' /></button>
									</div>
									<div class="cBox" style="display:none">
										${notice.content }
									</div>
								</li>
							</c:forEach>
						</ul>
					</section>
					<!-- // 공지사항 컨텐츠 영역 -->
				</div>
			</div>
		</main>
		<!-- </div> -->
		<div class="layers">
			<!-- 레이어팝업 넣을 자리 -->
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>
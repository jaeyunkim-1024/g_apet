<tiles:insertDefinition name="default">
<tiles:putAttribute name="script.include" value="script.member"/>
<tiles:putAttribute name="script.inline">
<script type="text/javascript">
	$(document).ready(function(){
		if("${view.deviceGb}" != "PC"){
			$(".mode0").remove();
			$("#footer").remove();
		}else{
			$(".mode7").remove();
		}		
		
		/* 완료 버튼 활성화/비활성화 */ 
		$(".tagBtn").click(function(e){
			var isSelected = false;
			//선택된 버튼 하나라도 있으면 활성화
			$(".tagBtn").each(function(){
				if($(this).hasClass("active")){
					isSelected = true;
					return;
				}				
			});
			
			//활성화
			if(isSelected){
				$("#activeBtn").show();
				$("#inactiveBtn").hide();
			}else{
				$("#inactiveBtn").show();
				$("#activeBtn").hide();
			}
		});
		
		storageHist.replaceHist();
	});

	/* 선택한 태그 맵핑 insert */
	function fncTagSelect(){
		var tagArray = "";
		$(".tagBtn").each(function(){
			if($(this).hasClass("active")) tagArray += $(this).attr("id") +",";  
		});
		
		var options = {
			url : "<spring:url value='/join/insertTagInfo' />",
			data : {tagArray : tagArray},
			done : function(data){
				if(data.resultCode == "${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS }"){
					if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
						toNativeData.func = 'onLogin';
						toNative(toNativeData);
					}
					
					fncTagInfoLogApi({ url:"/join/indexTag", targetUrl:"/join/indexResult",callback:console.log(data) });
					
					if("${isPBHR}" != "" && "${isPBHR}" != null){
						location.href="/join/indexResult?isPBHR=Y";
						return;
					}
					
					location.href="/join/indexResult";
				}else{
					alert("<spring:message code='front.web.view.common.alert.try.again' />");
				}
			}
		};
		ajax.call(options);
	}
	
	//뒤에서 오기 방지
	/*function noBack(){
		window.history.forward();
	}*/
	
</script>
</tiles:putAttribute>
<tiles:putAttribute name="content">	
<!--<body class="body" onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">-->
	<!--<div class="wrap" id="wrap">-->
		<!-- mobile header -->
			<!-- <header class="header pc cu mode7" data-header="set9">
				<div class="hdr">
					<div class="inr">
						<div class="hdt">
							<div class="mo-heade-tit" style="margin-left:20px;"><span class="tit">회원가입</span></div>
						</div>
					</div>
				</div>
			</header> -->
		<!-- // mobile header -->		
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container page login srch" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<div class="pc-tit">
					<!-- 	<h2>회원가입</h2> -->
					</div>
					<div class="fake-pop">
						<div class="tag-choise">
							<h2>
								<%-- <c:choose>
								<c:when test="${returnUrl ne null and returnUrl ne ''}"> --%>
									<span><spring:message code='front.web.view.join.complete.select.interest_tag.title1' /></span> <spring:message code='front.web.view.join.complete.select.interest_tag.title2' />
									<spring:message code='front.web.view.join.complete.aboutPet.start.title' />
								<%-- </c:when>
								<c:otherwise>
									<span></span>거의 다 끝났어요!
								</c:otherwise>
								</c:choose> --%>
								
							</h2>
							<p class="sub-txt"><spring:message code='front.web.view.join.complete.fit_contents.msg.title' /></p>
							<p class="tag-txt"><spring:message code='front.web.view.join.complete.possible.select_dupl.title' /></p>
							<div class="filter-area t2">
								<div class="filter-item">
									<div class="tag">
										<c:forEach items="${tagList}" var="tagItem" varStatus="stat">
											<c:if test="${stat.index < 10}">
											<button class="tagBtn" id="${tagItem.dtlCd }" data-content="" data-url="" >${tagItem.dtlNm }</button>
											</c:if>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
						<div class="pbt pull">
							<div class="bts" id="inactiveBtn">
								<a href="javascript:;" id="finbtn" class="btn lg gray" data-content="" data-url=""><spring:message code='front.web.view.common.msg.completed' /></a>
							</div>
							<div class="bts" id="activeBtn" style="display:none;">
								<a href="javascript:fncTagSelect();" id="finbtn" class="btn lg a" data-content="" data-url=""><spring:message code='front.web.view.common.msg.completed' /></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>

	<!--</div>-->
<!--</body>-->
</tiles:putAttribute>
</tiles:insertDefinition>
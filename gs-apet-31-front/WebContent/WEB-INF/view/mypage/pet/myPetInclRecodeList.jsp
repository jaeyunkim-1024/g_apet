<tiles:insertDefinition name="mypage">
	<tiles:putAttribute name="script.inline">
		<%--<script src="<spring:eval expression="@bizConfig['vod.player.api.url']" />/iframe_api/v1.js"></script>--%>
		<script type="text/javascript">
		var page = 1;
		var result = true;
		var scrollPrevent = true;
		var age = "${petBase.age}";
		var petGbCd = "${petBase.petGbCd}";
		var petNo = "${petBase.petNo}";
		var deviceGb = "${view.deviceGb}"
		var uiGb;
		var videoUrl = '<spring:eval expression="@bizConfig['vod.player.api.url']" />'+"/load/"
		
		/* ui.shop.lnb.set = function(){
		    $("#container").css("min-height","1800px");
		} */
		
		$(function(){
			if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
				//Device 뒤로가기 버튼 기능을 웹에서 처리시 사용(Y:웹에서 백기능 처리, N:앱에서 처리)-호출 함수
				fncDeviceBackWebUse("fncGoBack");
			}
			
			onloadToast();
			contentHeight();
			recodeHeight();	
			if(deviceGb != "PC"){
				$(".mode0").remove();
				$("#footer").remove();
				$(".menubar").remove();
				uiGb = "mobile";
			}else{
				$(".mode6").remove();
				$(".tops").remove();
				uiGb = "pc";
			}
			
			/* 버튼 클릭 시  (퍼블)*/
			$(".btn").click(function(){
				ui.selAc.open('.acSelect');
				$("body").removeClass("dim");
			});
		
			// 리스트가 없을 시 접종안내 페이지로 진입
			if('${fn:length(recodeList)}' <= 0){
				$("#inclGuide").trigger("click");
			}
			// 안내 문구의 접종 안내 텍스트 클릭 시 
			$("#inclGuideSpan").on("click" , function(){
				$("#inclGuide").trigger("click");	
			});
			
			$(document).on("click" , "[name=inclRecodeInsertBtn]", function(){
				//location.href = "/my/pet/insertMyPetInclRecodePage?petNo="+petNo+"&subYn="+$(this).data("sub-yn");
				storageHist.goBack("/my/pet/insertMyPetInclRecodePage?petNo="+petNo+"&subYn="+$(this).data("sub-yn"));
			});
			
			/*$(document).on("click" , "[name=seriesBtn]" , function(){
				location.href ="/tv/series/petTvSeriesList?srisNo=1&sesnNo=1";
			});*/
			
			/*$(document).on("click" , "#backBtn" , function(){
				if("${requestScope['javax.servlet.forward.query_string']}".indexOf('home=my') > -1){
					storageHist.goBack('/mypage/indexMyPage/');
				}else{
					var form = $("<form></form>");
					form.attr("name" , "petDeatilForm");
					form.attr("method" , "post");
					form.attr("action" , "/my/pet/myPetView");
					form.append($("<input/>", {type: 'hidden', name:'petNo', value:'${petBase.petNo}' }));
					
					form.appendTo("body");
					form.submit();
				}
			});*/
			
			$(document).on("click" , "#inclListTbody > tr" , function(){
				//location.href = "/my/pet/myPetInclRecodeView?inclNo="+$(this).data("inclno");
				fncGoPetInclRecodeView($(this).data("inclno"));
			})
			
			$(window).on("scroll touchmove" , function(){
				if($(window).scrollTop()+1 >= $(document).height() - $(window).height()){
					if(result && scrollPrevent){
						if($("#inclListTbody > tr").length >= 20){
							page++;
							scrollPrevent = false;
							pagingInclRecodeList(page);
						}
					}
				}					
			});
			
			substrAddIncl();
			setAddInclDt();
			addInclDtHtml();
		});
		
		function fncGoPetInclRecodeView(inclNo){
			storageHist.goBack("/my/pet/myPetInclRecodeView?inclNo="+inclNo);
		}
		
		function substrAddIncl(){
			for(var i = 0 ; i < $("[name=itemNm]").length ; i++){
				var itemNm = $("[name=itemNm]").eq(i);
				if(itemNm.text().length > 5){
					$("[name=itemNm]").eq(i).text(itemNm.text().substr(0,5) + "...");
				}				
			}
		}
		
 		/*function callBackVodList(result){
 			for(var i = 0 ; i < $("[name=iframeVideo]").length ; i++){
 				$("[name=iframeVideo]").eq(i).attr("src" , videoUrl+result.contents[i].video_id+"?v=1&loop=0&vtype=mp4&ui="+uiGb );
 			}
 		}*/
		
		function onloadToast(){
			var msg;
			var deleteYn = "${deleteYn}";
			var updateYn = "${updateYn}";
			var subYn = "${subYn}"	
			
			if(updateYn){
				if(updateYn != "N"){
					msg = "<spring:message code ='front.web.view.mypet.update.incl_recode'/>"
				}else{
					msg = "<spring:message code ='front.web.view.mypet.insert.incl_recode'/>"
				}
			}
			
			if(deleteYn){
				if(subYn != 'N'){
					msg = "<spring:message code='front.web.view.mypet.confirm.delete.incl_recode_sub_done'/>";
				}else{
					msg = "<spring:message code='front.web.view.mypet.confirm.delete.incl_recode_done'/>";
				}
				
			}
				
			if(msg){
				ui.toast(msg);
			}
		}
		
		function setAddInclDt(){
			var inclKindCdInput = $("[name=inclKindCd]");
			var valueArr = [];
			for(var i = 0 ; i < inclKindCdInput.length ; i++){
				var inclKindCd = Number($("[name=inclKindCd]").eq(i).val());
				if(valueArr.indexOf(inclKindCd) < 0){
					valueArr.push(inclKindCd);
				}else{
					if(inclKindCd != "${frontConstants.INCL_KIND_9999}"){
						$("[name=addInclDts]").eq(i).html("-");	
						$("[name=intervalDay]").eq(i).val("");
					}
				}
			}
			
			for(var i = 0 ; i < inclKindCdInput.length ; i++){
				var inclKindCd = Number($("[name=inclKindCd]").eq(i).val());
				// 강아지 기초 접종 1~5차  / 고양이 기초 접종 1~3차 일 경우 마지막 차수를 제외한 다음 예정일은 -처리
				if(1000 < inclKindCd && inclKindCd < 1005){
					for(var j = inclKindCd+1 ; j <= 1005 ; j++){
						if(valueArr.indexOf(j) > -1){
							$("[name=addInclDts]").eq(i).html("-");	
							$("[name=intervalDay]").eq(i).val("");		
						}
					}
				}
				
				if(2000 < inclKindCd && inclKindCd < 2003){
					for(var j = inclKindCd+1 ; j <= 2003; j++){
						if(valueArr.indexOf(j) > -1){
							$("[name=addInclDts]").eq(i).html("-");	
							$("[name=intervalDay]").eq(i).val("");		
						}
					}
				}
			}
		}
		
		// 접종 안내 문구 
		function addInclDtHtml(){
			var compare = [];
			var lateCompare = [];
			var minCompare;
			var maxCompare;
			var addInclDts;
			var inclDts = [];
			
			for(var i = 0 ; i < ${fn:length(recodeList)} ; i++){
				var value =  $("input[name=intervalDay]").eq(i).val();
			
				if($("[name=addInclDts]").eq(i).html() != "-" && value){
					if(value >= 0){
						compare.push(value);
					}
					if(value < 0){
						lateCompare.push(value)
					}
					
					if(compare.length > 0){
						minCompare = Math.min.apply(null ,compare);
					}
					if(lateCompare.length > 0){
						maxCompare = Math.max.apply(null ,lateCompare);
					}
				}
				inclDts.push($("[name=inclDtTd]").eq(i).text());
			}
			
			// 접종 예정일이 있을 시 
			if(minCompare != null){
				addInclDts = $("input[name=intervalDay]:input[value="+minCompare+"]").eq(0).next().html();
				$("#existIncl").show();
				$("#existIncl").find("span").text(addInclDts);
			}
			
			// 접종 예정일이 지난 경우만 있을 시
			if(maxCompare != null && minCompare == null){
				addInclDts = $("input[name=intervalDay]:input[value="+maxCompare+"]").eq(0).next().html();
				$("#lateIncl").show();
				$("#lateIncl").find("span").text(addInclDts);
			}
			
			// 접종 예정일이 없을 시 
			if(minCompare == null && maxCompare == null){
				var lastInclDt = inclDts[0];
				addInclDts = $("input[name=intervalDay]:input[value="+maxCompare+"]").eq(0).next().html();
				$("#afterIncl").show();
				$("#afterIncl").find("span").text(lastInclDt);
			}
			
			// 리스트가 없을 시 
			if("${fn:length(recodeList)}" <= 0){
				$("#noneIncl").show();
				$("#noneIncl").siblings("p").hide()
			}
		}
		
		function pagingInclRecodeList(inclPage){
			var options = {
					url : "<spring:url value='indexMypetInclRecode'/>"
					, data : {
						page : inclPage
						, petNo : '${petBase.petNo}'
					}
					, dataType : "html"
					, done : function(html){
						$("#inclListTbody").append(html);
						scrollPrevent = true;
						setAddInclDt();
						addInclDtHtml();
						substrAddIncl();
						recodeHeight();
						if($("#inclListTbody tr").length % 20 != 0){
							result = false;
						}
						
					}
			}
			ajax.call(options);
		}
		
		$(document).on("click" , "#inclGuide , #inclRecode" , function(){
			/*//tempList
			var videoIdList = ["DVAm4599121" , "NmMQ7065783" ,"w4q87107629"]
			// video 셋팅
			var option = {
					channel_id : "${frontConstants.VOD_GROUP_ID_PET_GUIDE}"
					, playlist_id : "${frontConstants.INCL_VOD_LIST_ID}"
					, authKey : sgrGenerate()
			}
			vodList(option , callBackVodList);*/
			if($("#inclGuide").parent("li").hasClass("active")){
				contentHeight();
			}else{
				recodeHeight()
			}
		});
		
		function contentHeight() {
			window.setTimeout(function(){
			 	if($("#inclGuide").parent("li").hasClass("active")){
					if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_10}") {
						$("#container").css("height", parseInt($(".contentHeight").css("height")) +  $("footer").outerHeight());	
					} else {
						$("#container").css("height", parseInt($(".petTabContent").css("height")) +  $("footer").outerHeight());
					}
			 	}	
			}, 300)
		}
		
		function recodeHeight(){
			var height = parseInt($(".recodeHeight").css("height")) + $("footer").outerHeight();	
			if(height > $("#container").height()){
				window.setTimeout(function(){
					if($("#inclRecode").parent("li").hasClass("active")){
				 		if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_10}") {
							$("#container").css("height", height);
						} /* else {
							$("#container").css("height", parseInt($(".petTabContent").css("height")) + 15);
			 			} */
				 	}
				}, 300);
			}
			
			//새로고침 시 토스트 알람문구 계속 노출 방지
			var currentURL = window.location.href
        	if(currentURL.includes('&updateYn=')){
        		var newURL = currentURL.replace(/\&updateYn\=./,'');
        		history.replaceState(null,null,newURL);
        	}
		}
		
		function fncGoBack(){
			if("${requestScope['javax.servlet.forward.query_string']}".indexOf('home=my') > -1){
				storageHist.goBack('/mypage/indexMyPage/');
			}else{
				var form = $("<form></form>");
				form.attr("name", "petDeatilForm");
				form.attr("method", "post");
				form.attr("action", "/my/pet/myPetView");
				form.append($("<input/>", {type: 'hidden', name:'petNo', value:'${petBase.petNo}' }));
				
				form.appendTo("body");
				form.submit();
			}
		}
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<div class="wrap" id="wrap">
			<c:if test = "${view.deviceGb ne frontConstants.DEVICE_GB_10 }">
			<!-- mobile header -->
			<header class="header pc cu mode6">
				<div class="hdr">
					<div class="inr">
						<div class="hdt">
							<button class="mo-header-btnType02">취소</button><!-- on 클래스 추가 시 활성화 -->
							<button class="mo-header-backNtn" id="backBtn" data-content="" data-url="fncGoBack()" onclick="fncGoBack();">뒤로</button>
							<div class="mo-heade-tit">
								<div class="pic">
									<img src="${frame:imagePath(petBase.imgPath) }" alt="">
								</div>			
								건강수첩				
							</div>
							<!--<div class="mo-header-rightBtn">
									<button name="seriesBtn" class="mo-header-btnType01" data-content="" data-url="/tv/series/petTvSeriesList?srisNo=37&sesnNo=1">
										<span class="mo-header-icon-tip"></span>
										기초건강관리
									</button>
							</div>-->
							<!-- <button class="mo-header-close" att></button> -->
						</div>
					</div>
				</div>
			</header>
			<!-- //mobile header -->
			</c:if>
		
			<main class="container lnb page 1dep 2dep" id="container">
				<div class="inr">
					<!-- 본문 -->
					<div class="contents" id="contents">
					<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10 }">
						<tiles:putAttribute name="header.title"/>
					</c:if>
						<!-- PC 타이틀 모바일에서 제거  -->
						<div class="pc-tit">
							<h2>
								<p class="img">
									<img class="img" src="${frame:imagePath(petBase.imgPath) }" alt="이미지">
								</p> 
								건강수첩
							</h2>
							<div class="right-item">
								<!--<div class="mo-header-rightBtn">
									<button name="seriesBtn" class="mo-header-btnType01" data-content="" data-url="/tv/series/petTvSeriesList?srisNo=37&sesnNo=1">
										<span class="mo-header-icon-tip"></span>
										기초건강관리
									</button>
								</div>-->
							</div>
							
						</div>
						<!-- // PC 타이틀 모바일에서 제거  -->
						<!-- tab -->
						<section class="sect petTabContent leftTab">
							<!-- tab header -->
							<ul class="uiTab a line t2">
								<li class="active">
									<button id = "inclRecode" class="bt" data-content="" data-url="" onclick="return false;">예방접종 내역</button>
								</li>
								<li class="">
									<button id ="inclGuide" class="bt active" data-content="" data-url="" onclick="return false;">접종안내</button>
								</li>
							</ul>
							<!-- // tab header -->
							<!-- tab content -->
							<div class="uiTab_content" style="height:calc(100vh - 106px) !important;">
								<ul>
									<li>
										<div class="health-note recodeHeight">
											<div class="item t2">
												<div class="g-box t2">
													<p id = "noneIncl" class="txt" style ="display : none"><strong>${petBase.petNm }</strong>의 예방접종 내역을 관리할 수 있습니다.</p>
													<p id = "existIncl" class="txt" style ="display : none"><strong>${petBase.petNm }</strong>의 다음 예방 접종일은 <span></span>입니다.</p>
													<p id = "lateIncl" class="txt" style ="display : none"><strong>${petBase.petNm }</strong>의 접종 예정일 <span></span>이 지났습니다.</p>
													<p id = "afterIncl" class="txt" style ="display : none"><strong>${petBase.petNm }</strong>의 최종 접종(투약)일은 <span></span>입니다.</p>
													<div class="btn-area">
														<!-- mobile만 노출 -->
														<button class="btn add onMo_if" data-content="" data-url="">접종내역 등록</button>
														<!-- pc만 노출 -->
														<button name="inclRecodeInsertBtn" class="btn add onWeb_if" data-sub-yn="N" data-content="" data-url="/my/pet/insertMyPetInclRecodePage?petNo=${petBase.petNo }&subYn=N">예방접종 등록</button>
														<button name="inclRecodeInsertBtn" class="btn add onWeb_if" data-sub-yn="Y" data-content="" data-url="/my/pet/insertMyPetInclRecodePage?petNo=${petBase.petNo }&subYn=Y">투약 등록</button>
													</div>
												</div>
												<c:if test= "${fn:length(recodeList) <= 0 }" >
												<!-- css 안먹어서 inline style temp -->
													<c:if test = '${petBase.petGbCd == 10 }'>
														<p class="info" style ="margin-top: 100px; padding: 20px; color: #666; font-size: 13px; font-weight: normal; font-stretch: normal; font-style: normal; line-height: 1.69; letter-spacing: -0.2px; text-align: center;">강아지 예방접종 (기초접종, 정기접종) 에 대한 설명은 <span id = "inclGuideSpan" style ="color: #669aff;cursor:pointer">접종 안내</span> 메뉴에서 확인하실 수 있습니다.</p>
													</c:if>
													<c:if test ='${petBase.petGbCd == 20}'>
														<p class="info" style ="margin-top: 100px; padding: 20px; color: #666; font-size: 13px; font-weight: normal; font-stretch: normal; font-style: normal; line-height: 1.69; letter-spacing: -0.2px; text-align: center;">고양이 예방접종 (기초접종, 정기접종) 에 대한 설명은 <span id = "inclGuideSpan" style ="color: #669aff;cursor:pointer">접종 안내</span> 메뉴에서 확인하실 수 있습니다.</p>
													</c:if>
												</c:if>
												<c:if test= "${fn:length(recodeList) > 0 }" >
													<div class="table-type01 t2" id = "inclTable">
														<table>
															<colgroup>
																<col style="width: auto">
																<col style="width: 28%">
																<col style="width: 29%">
																<col style="width: 24%">
															</colgroup>
															<thead>
																<tr>
																	<th scope="col">접종일</th>
																	<th scope="col">필수접종</th>
																	<th scope="col">선택접종</th>
																	<th scope="col">다음예정일</th>
																</tr>
															</thead>
															<tbody id = "inclListTbody">
															<c:forEach items ="${recodeList}" var="recode">
																<tr data-inclno="${recode.inclNo }">
																	<td name = "inclDtTd"><frame:date date="${recode.inclDt }" type="C"/></td>
																	<td>${recode.inclNm }</td>
																	<td>
																		<div class="box">
																			<p name ="itemNm" class="t">${recode.itemNm }</p>
																			<c:if test = "${recode.imgPath ne null }">
																				<span class="icon"></span>
																			</c:if>
																		</div>
																	</td>
																	<td>
																		<div class="box">
																			<p class="t">
																				<input type ="hidden" name ="inclKindCd" value ="${recode.inclKindCd }">
																				<input type ="hidden" name ="intervalDay" value="${recode.intervalDay }">
																				<!-- 다음 예정일이 지나지 않은 경우 붉은색 -->
																				<c:if test = "${recode.intervalDay >= 0 }">
																				<span class="f-blue" name = "addInclDts"><frame:date date="${recode.addInclDt }" type ="C" /></span>
																				</c:if>
																				<!-- 다음 예정일이 지난경우 붉은색 -->
																				<c:if test = "${recode.intervalDay < 0 || recode.intervalDay eq null}">
																				<span class="f-red" name = "addInclDts"><frame:date date="${recode.addInclDt }" type ="C" /></span>
																				</c:if>	
																			</p>
																			<a href="/my/pet/myPetInclRecodeView?inclNo=${recode.inclNo }" data-content="" data-url="/my/pet/myPetInclRecodeView?inclNo=${recode.inclNo }"><span class="icon2"></span></a>
																		</div>
																	</td>
																</tr>
																</c:forEach>
															</tbody>
														</table>
													</div>
												</c:if>
											</div>
										</div>
											<!-- content -->
											<div class="noneBoxPoint p3" style = "display:none">
												<div>
													<div class="noneBoxPoint_infoTxt" style="color:#666;">
													고양이 예방접종(기초접종, 정기접종)에 대한 설<br>
													명은 접종 안내 메뉴에서 확인하실 수 있습니다.
													</div>
												</div>
											</div>
										</li>
									<li>
									<c:if test ="${petBase.petGbCd eq frontConstants.PET_GB_10 }">
										<!-- dog content -->
										<div class="health-note contentHeight" id ="dogContent">
											<div class="item">
												<p class="tit">기초 접종</p>
												<div class="item-right">
													<p class="txt">1년 미만의 강아지는 기초접종이 필요합니다. 생후 6주부터 시작해 2주 간격으로 접종합니다.</p>
													<div class="table-type01">
														<p class="t-info">*선택사항</p>
														<table>
															<colgroup>
																<col style="width: 33%">
																<col style="width: 33%">
																<col style="width: 33%">
															</colgroup>
															<thead>
																<tr>
																	<th scope="col">접종시기</th>
																	<th scope="col">기초접종</th>
																	<th scope="col">선택접종</th>
																</tr>
															</thead>
															<tbody>
																<tr>
																	<td>생후 6주</td>
																	<td>종합백신 1차</td>
																	<td><span class="f-gray">코로나 장염 1차</span></td>
																</tr>
																<tr>
																	<td>생후 8주</td>
																	<td>종합백신 2차</td>
																	<td><span class="f-gray">코로나 장염 2차</span></td>
																</tr>
																<tr>
																	<td>생후 10주</td>
																	<td>종합백신 3차</td>
																	<td><span class="f-gray">켄넬코프 1차</span></td>
																</tr>
																<tr>
																	<td>생후 12주</td>
																	<td>종합백신 4차</td>
																	<td><span class="f-gray">켄넬코프 2차</span></td>
																</tr>
																<tr>
																	<td>생후 14주</td>
																	<td>종합백신 5차</td>
																	<td><span class="f-gray">인플루엔자 1차</span></td>
																</tr>
																<tr>
																	<td>생후 16주</td>
																	<td><span class="f-gray">광견병</span></td>
																	<td><span class="f-gray">인플루엔자 2차</span></td>
																</tr>
															</tbody>
														</table>
														<p class="b-info">항체가검사 : 5차 접종 후 2주뒤</p>
													</div>
												</div>
											</div>
											<div class="item">
												<p class="tit">정기 접종</p>
												<div class="item-right">
													<p class="txt">기초 예방접종을 마친 성견은 매년 1회 접종을 해야 합니다.</p>
													<div class="table-type01">
														<table>
															<colgroup>
																<col style="width: 50%">
																<col style="width: 50%">
															</colgroup>
															<thead>
																<tr>
																	<th scope="col">예방접종명</th>
																	<th scope="col">접종주기</th>
																</tr>
															</thead>
															<tbody>
																<tr>
																	<td>종합백신</td>
																	<td>매년 1회</td>
																</tr>
																<tr>
																	<td>코로나 장염</td>
																	<td>매년 1회</td>
																</tr>
																<tr>
																	<td>켄넬코프</td>
																	<td>매년 1회</td>
																</tr>
																<tr>
																	<td>인플루엔자</td>
																	<td>매년 1회</td>
																</tr>
																<tr>
																	<td>광견병</td>
																	<td>매년 1회</td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
											</div>
											<div class="item">
												<p class="tit">예방접종 종류</p>
												<div class="g-box">
													<p class="tit">종합백신 (DHPPL)</p>
													<p class="txt">설사 또는 구토 증상을 일으키는 전염성 소화기관 질병입니다. 특히 비위생적이거나 밀집된 사육 환경에서 감염이 촉진됩니다.</p>
													<p class="tit">켄넬코프 (보데텔라) </p>
													<p class="txt">전염성이 매우 강한 호흡기 질환입니다. 가벼운 증상일 경우 금방 회복될 수 있지만, 바이러스하나 이상 복합적으로 감염되면 폐렴으로 이어질 수 있습니다. </p>
													<p class="tit">인플루엔자 (신종플루)</p>
													<p class="txt">접촉 및 공기중으로 전염되는 호흡기 바이러스 질환으로 무기력, 식욕감퇴, 고열, 폐렴 등으로 진행될 수 있습니다.</p>
<!-- 													<div class="movie"> -->
<!-- 								                      	<div class="video-area"> -->
<!-- 								                            <div class="video-palyer"> -->
<!-- 								                                <div class="video" name="video"> -->
<!-- 								                            		<iframe id ="iframeVideo" name="iframeVideo" src="" -->
<!-- 																			frameborder="0" -->
<!-- 																			width="100%" -->
<!-- 																			height="100%" -->
<!-- 																			scrolling="no" -->
<!-- 																			allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture;" -->
<!-- 																			playsinline="playsinline" -->
<!-- 																			allowfullscreen> -->
<!-- 																	</iframe>  -->
<!-- 								                                </div> -->
<!-- 								                            </div> -->
<!--                     								    </div> -->
<!-- 													</div> -->
													<p class="tit">광견병</p>
													<p class="txt">강아지 뿐만 아니라 모든 포유동물에게 감염되며, 100% 치사율에 도달하는 무시무시한 질병입니다.</p>
<!-- 													<div class="movie"> -->
<!-- 														<div class="video-area"> -->
<!-- 								                            <div class="video-palyer"> -->
<!-- 								                                <div class="video" name="video" id="player2"> -->
<!-- 								                              	  <iframe name ="iframeVideo" src ="" -->
<!-- 																			frameborder="0" -->
<!-- 																			width="100%" -->
<!-- 																			height="100%" -->
<!-- 																			scrolling="no" -->
<!-- 																			allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" -->
<!-- 																			playsinline="playsinline" -->
<!-- 																			allowfullscreen> -->
<!-- 																	</iframe> -->
<!-- 																</div> -->
<!-- 								                            </div> -->
<!--                     								    </div> -->
<!-- 													</div> -->
													<p class="tit">항체가검사</p>
													<p class="txt">백신 전/후, 항체가검사는 백신 접종 프로그램의 기본입니다. 반려견이 예방접종을 했어도 항체가 높지않으면, 홍역이나 파보 바이러스로부터 안전하지 않습니다.</p>
<!-- 													<div class="movie"> -->
<!-- 														<div class="video-area"> -->
<!-- 								                            <div class="video-palyer"> -->
<!-- 								                                <div class="video" name="video" id="player3"> -->
<!-- 								                                	<iframe name ="iframeVideo" src ="" -->
<!-- 																			frameborder="0" -->
<!-- 																			width="100%" -->
<!-- 																			height="100%" -->
<!-- 																			scrolling="no" -->
<!-- 																			allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" -->
<!-- 																			playsinline="playsinline" -->
<!-- 																			allowfullscreen> -->
<!-- 																	</iframe> -->
<!-- 								                                </div> -->
<!-- 								                            </div> -->
<!--                     								    </div> -->
<!-- 													</div> -->
												</div>
											</div>
											<div class="item">
												<div class="tit">유의사항</div>
												<div class="info-txt">
													<ul>
														<li>
															본 프로그램은 지역별, 병원별로 차이가 있을 수 있습니다. 
														</li>
														<li>
															접종 후에는 때에 따라 가려움, 종창, 발적, 통증, 회농, 발열, 의기소침, 예민, 쇼크 등의 증상이 나타날 수 있습니다. 접종반응이 심하거나 쇼크가 발생하면 즉시 동물병원에서 적절한 조치를 받아야 합니다. 
														</li>
														<li>접종 후 약 1주일 정도는 목욕, 미용, 여행 등의 스트레스를 가급적 피해야 합니다.</li>
														<li>임신, 수술 전후, 투약중, 질병, 바이러스 감염 시에는 접종을 피하거나 수의사의 검진 후에 접종을 해야 합니다. </li>
													</ul>
												</div>
											</div>
										</div>
										<!-- // dog content -->
										</c:if>
										<!-- cat content -->
										<c:if test ="${petBase.petGbCd eq frontConstants.PET_GB_20 }">
										<div class="health-note contentHeight" id ="catContent">
											<div class="item">
												<p class="tit">기초 접종</p>
												<div class="item-right">
													<p class="txt">1년 미만의 고양이는 기초접종이 필요합니다. 생후 8주부터 시작해 3주 간격으로 접종합니다.</p>
													<div class="table-type01">
														<p class="t-info">*선택사항</p>
														<table>
															<colgroup>
																<col style="width: 33%">
																<col style="width: 33%">
																<col style="width: 33%">
															</colgroup>
															<thead>
																<tr>
																	<th scope="col">접종시기</th>
																	<th scope="col">기초접종</th>
																</tr>
															</thead>
															<tbody>
																<tr>
																	<td>생후 8주</td>
																	<td>혼방예방백신 1차</td>
																</tr>
																<tr>
																	<td>생후 11주</td>
																	<td>혼방예방백신 2차</td>
																</tr>
																<tr>
																	<td>생후 14주</td>
																	<td>혼방예방백신 3차</td>
																</tr>
																<tr>
																	<td>생후 17~18주</td>
																	<td><span class="f-gray">전염성복막염</span></td>
																</tr>
																<tr>
																	<td>생후 21주</td>
																	<td><span class="f-gray">광견병</span></td>
																</tr>
															</tbody>
														</table>
														<p class="b-info">항체가검사 : 3차 접종 후 2주뒤</p>
													</div>
												</div>
											</div>
											<div class="item">
												<p class="tit">정기 접종</p>
												<div class="item-right">
													<p class="txt">기초 예방접종을 마친 성묘는 정기 접종을 해야 합니다. 접종 주기는 권장사항입니다.</p>
													<div class="table-type01">
														<table>
															<colgroup>
																<col style="width: 50%">
																<col style="width: 50%">
															</colgroup>
															<thead>
																<tr>
																	<th scope="col">예방접종명</th>
																	<th scope="col">접종주기</th>
																</tr>
															</thead>
															<tbody>
																<tr>
																	<td>혼방예방백신</td>
																	<td>매년 또는 3년 1회</td>
																</tr>
																<tr>
																	<td>전염성복막염</td>
																	<td>매년 1회</td>
																</tr>
																<tr>
																	<td>광견병</td>
																	<td>매년 1회</td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
											</div>
											<div class="item">
												<p class="tit">예방접종 종류</p>
												<div class="g-box">
													<p class="tit">혼합예방백신</p>
													<p class="txt">접촉 및 공기중으로 전염되는 호흡기 바이러스 질환으로 무기력, 식욕감퇴, 고열, 폐렴 등으로 진행될 수 있습니다.</p>
													<p class="tit">전염성복막염</p>
													<p class="txt">백신 전/후, 항체가검사는 백신 접종 프로그램의 기본입니다. 반려견이 예방접종을 했어도 항체가 높지않으면, 홍역이나 파보 바이러스로부터 안전하지 않습니다.</p>
<!-- 													<div class="movie"> -->
<!-- 														<div class="video-area"> -->
<!-- 								                            <div class="video-palyer"> -->
<!-- 								                                <div class="video" name="video" style ="overflow:auto; -webkit-overflow-scrolling:touch;"> -->
<!-- 								                             	   <iframe name="iframeVideo" src ="" -->
<!-- 																			frameborder="0" -->
<!-- 																			width="100%" -->
<!-- 																			height="101%" -->
<!-- 																			allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" -->
<!-- 																			playsinline="playsinline" -->
<!-- 																			allowfullscreen> -->
<!-- 																	</iframe> -->
<!-- 								                                </div> -->
<!-- 								                            </div> -->
<!--                     								    </div> -->
<!-- 													</div> -->
												</div>
											</div>
											<div class="item">
												<div class="tit">유의사항</div>
												<div class="info-txt">
													<ul>
														<li>
															본 프로그램은 지역별, 병원별로 차이가 있을 수 있습니다. 
														</li>
														<li>
															접종 후에는 때에 따라 가려움, 종창, 발적, 통증, 회농, 발열, 의기소침, 예민, 쇼크 등의 증상이 나타날 수 있습니다. 접종반응이 심하거나 쇼크가 발생하면 즉시 동물병원에서 적절한 조치를 받아야 합니다. 
														</li>
														<li>접종 후 약 1주일 정도는 목욕, 미용, 여행 등의 스트레스를 가급적 피해야 합니다.</li>
														<li>임신, 수술 전후, 투약중, 질병, 바이러스 감염 시에는 접종을 피하거나 수의사의 검진 후에 접종을 해야 합니다. </li>
													</ul>
												</div>
											</div>
										</div>
										</c:if>
										<!-- // cat content -->
									</li>
								</ul>
							</div>
							<!-- // tab content -->
						</section>
						<!-- // tab -->
					</div>
				</div>
			</main>
			<div class="acSelect t2">
				<input type="text" class="acSelInput" readonly />
				<div class="head ">
					<div class="con">
						<div class="tit">접종내역 등록</div>
						<a href="#" class="close" onClick="ui.selAc.close(this);return false;" data-content="" data-url="ui.selAc.close(this);"></a>
					</div>
				</div>
				<div class="con">
					<ul>
						<li name="inclRecodeInsertBtn" onClick="ui.selAc.liClick(this)" data-sub-yn="N">예방접종 등록</li>
						<li name="inclRecodeInsertBtn" onClick="ui.selAc.liClick(this)" data-sub-yn="Y">투약 등록</li>
					</ul>
				</div>
			</div>
		</div>
		
		<!-- 플로팅 영역 -->
		<c:choose>
			<c:when test="${view.deviceGb  eq 'PC'}">
			<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
			       <jsp:param name="floating" value="" />
			</jsp:include>
			</c:when>
			<c:otherwise>
			<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
			       <jsp:param name="floating" value="talk" />
			</jsp:include>
			</c:otherwise>
		</c:choose>
	</tiles:putAttribute>
</tiles:insertDefinition>



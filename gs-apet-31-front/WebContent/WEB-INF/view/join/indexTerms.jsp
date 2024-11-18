<tiles:insertDefinition name="common"> 
	<tiles:putAttribute name="script.include" value="script.member"/>
	<tiles:putAttribute name="script.inline">
	<style>
	.footer{ display : none;}
	.menubar{ display: none;}
	</style> 
		<!--<script src="/_html/guide/html.js"></script>-->
		<script type="text/javascript">

		$(function() {
			// 선택 약관 팝업창 동의 버튼 클릭 시 
			$(document).on("click" , "[name=joinAgreeTerm]" , function(){
				var checkBox =  $("#terms_"+$(this).data("terms-no"));
				if(checkBox.prop("checked")){
					checkBox.prop("checked" , false);
				}else{
					checkBox.prop("checked" , true);
				}
				
				if($(this).data("termsCd") == "${frontConstants.TERMS_GB_ABP_MEM_MARKETING}"){
				 	if(checkBox.prop("checked")){
				   		messager.toast({txt:"<spring:message code='front.web.view.join.marketing.term_agree.msg.title' />"});
				   	}else{
			   			messager.toast({txt:"<spring:message code='front.web.view.join.marketing.term_disagree.msg.title' />"});
				   	}
				}

				if($(this).data("termsCd") == "${frontConstants.TERMS_GB_ABP_MEM_LOCATION_INFO}"){
				 	if(checkBox.prop("checked")){
			   			messager.toast({txt:"<spring:message code='front.web.view.join.location.term_agree.msg.title' />"});
				   	}else{
			   			messager.toast({txt:"<spring:message code='front.web.view.join.location.term_disagree.msg.title' />"});
				   	}
				}
				
				if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}"){
					$("html, body").css({"overflow":"auto", "height":"auto"});	
				}
				
				ui.popLayer.close($(this).parents("article").attr("id"));
			})
			
			$(document).on("click" , "#closeBtn" , function(){
				if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}"){
					$("html, body").css({"overflow":"auto", "height":"auto"});	
				}
				$(".layers").hide();
			})
			
			// 약관 팝업창 버튼 클릭 시
 			/*$(document).on("click" , "[name=contentPopBtn]", function(){
 				$(".layers").show();
 				popServiceList($(this).data("index"))
 			});*/
			
			// 약관 팝업창 히스토리 변경 시 
			$(document).on("change" , "[name=termContentSelect]" , function(){
				var value =	$(this).find("option:selected").val();
				var section = $(this).parents("article").find("section");
				section.hide();
				section.eq(value).show()
			});
			
			if("${view.deviceGb}" != "PC"){
				$(".mode0").remove();
				$("#footer").remove();
			}else{
				$(".mode7").remove();
			}			
			
			//전체선택 클릭 시 다 선택되도록
			$("#terms_all").click(function(){
				if($("#terms_all").is(":checked")){
					$("input:checkbox").prop("checked", true);
				}else{
					$("input:checkbox").prop("checked", false);
				}
			});
			
			//필수 약관 다 선택했는지 확인
			$("input:checkbox").click(function(){
				var isRqidAllCheck = true;
				$(".rqidTerm").each(function(index,item) {
					if(!$(item).is(":checked")) isRqidAllCheck = false;
				});
				
				var isAllCheck = true;
				$(".term").each(function(index, item){
					if(!$(item).is(":checked")) isAllCheck = false;
				});
			
				if(!isRqidAllCheck) {
					$("#inactiveBtn").show();
					$("#activeBtn").hide();
				}else{
					$("#inactiveBtn").hide();
					$("#activeBtn").show();
				}
				
				if(!isAllCheck){
					$("#terms_all").prop("checked",false);
				}else {
					$("#terms_all").prop("checked",true);
				}
			});
		});

	    //약관동의 확인 후 본인인증 후 회원등록 페이지로 이동
		function goJoinPage(){
			storageHist.replaceHist();
			
			var isRqidAllCheck = true;
			$(".rqidTerm").each(function(index,item) {
				if(!$(item).is(":checked")) isRqidAllCheck = false;
			});
		
			if(!isRqidAllCheck) {
				alert("<spring:message code='front.web.view.join.term_agree.all.check.msg.title' />");
				return;
			}
		
			var agreeTerms =[];
			$(".term").each(function(index,item) {
				var itemId = $(item).attr('id') ;
				var rcvYnVal = "N";
				if($(item).is(":checked")){
					rcvYnVal = "Y";
					if($(item).next().attr("id") == "2003") $("#pstInfoAgrYn").val("Y");
					else if($(item).next().attr("id") == "2006") $("#mkngRcvYn").val("Y");
				}
				var eachTerm = {termsNo:itemId.split("terms_")[1] , rcvYn:rcvYnVal};
				agreeTerms.push(eachTerm);
		
			});
			$("#termsNo").val(JSON.stringify(agreeTerms));
		
			/*var emailYnVal = "N";
			var smsYnVal = "N";
			if($("#emailRcvYnChk").is(":checked")) emailYnVal = "Y";
			$("#emailRcvYn").val(emailYnVal);
			if($("#smsRcvYnChk").is(":checked")) smsYnVal = "Y";
			$("#smsRcvYn").val(smsYnVal);*/

			$("#vnform_terms_check_yn").val("Y");
			$("#terms_form").attr("target", "_self");
		
			//sns 회원가입인 경우 구분
			if("${snsInfo.snsUuid}" != '' ){
				$("#snsYn").val("Y");
			}
			
			$("#terms_form").attr("action", "/join/indexJoin");
			$("#terms_form").submit();
		
			/* }else{
				//일반 정회원 가입은 약관 동의 후 본인인증팝업 후 회원정보 입력화면
				ui.confirm("본인 확인을 위해 \n 휴대폰 본인인증을 해주세요." ,{
					ycb:function(){
						okCertPopup("00"); 
					},
					ybt:'본인인증하기' ,
					nbt:'취소'
				});
			}  */
		}
			
		//본인인증 콜백 함수
		function okCertCallback(result){
			var data = JSON.parse(result);
			waiting.start();
			
			if(data.RSLT_CD != "B000"){
				//messager.alert("잘못된 정보입니다. 다시 시도해 주세요.", "Info", "info");
				//alert("잘못된 정보입니다. 다시 시도해 주세요.");
				waiting.stop();
				return;
			}
			
			var today = new Date();
			var yyyy = today.getFullYear();
			var mm = today.getMonth() < 9 ? "0" + (today.getMonth() + 1) : (today.getMonth() + 1); // getMonth()
			var dd  = today.getDate() < 10 ? "0" + today.getDate() : today.getDate();
			if(parseInt(yyyy+mm+dd) - parseInt(data.RSLT_BIRTHDAY) - 140000 < 0){
				alert("<spring:message code='front.web.view.join.14years.check.msg.title' />");
				location.href ="/indexLogin";
				return;
			}
	
			$("#auth_json").val(JSON.stringify(data));
			$("#terms_form").attr("action", "/join/indexJoin");
			$("#terms_form").submit(); 
		}
		
		//이용약관 레이어
 	    /*var popServiceList = function(index){
 	        // 레이어팝업 열기 콜백
 	        var checkbox = $('input:checkbox[data-idx='+index+']')
 	        var agreeBtn = $("button[data-terms-no="+checkbox.data('termsNo')+"]");
 	        if(checkbox.prop("checked")){
 	     		$("#termsDisagree").show();
 				$("#termsAgree").hide();
  	     		agreeBtn.text("<spring:message code='front.web.view.join.disagree.button.popup.title' />");
  	     		agreeBtn.removeClass("a");
 	     	}else{
 				$("#termsDisagree").hide();
 				$("#termsAgree").show();
  	     		agreeBtn.text("<spring:message code='front.web.view.common.agree.title' />");
  	     		agreeBtn.addClass("a");
 	     	}
	     	
 	     	 if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10}"){
 					$("html, body").css({"overflow":"hidden", "height":"100%"});
 				}
	     	
  	        ui.popLayer.open('termsContentPop'+index);
	       
 		}*/
		
	    var popCertification = function(){
	        // 레이어팝업 열기 콜백
	        ui.popLayer.open('popCertification',{
	            ocb:function(){
	            },
	            ccb:function(){
	            }
	        });
	    }
		
		//window.history.forward();
		
	  	//뒤에서 오기 방지
		/*function noBack(){
			window.history.forward();
		}*/
	  	
		/*function fncOkCertPopModal(){
			var options = {
				url : "<spring:url value='/common/okCertPop' />",
				data : {
					rqstCausCd : '01',
					popup : 'phone_popup2'
				},
				done : function(data){
					if(data.resultCode == '${frontConstants.CONTROLLER_RESULT_CODE_NOT_USE}'){
						
					}
				}
		  	}
		  	ajax.call(options);
	  	} */
	  
	  	//이용약관 팝업창
		function openTermsSetting(termsCd, settingYn, index){
			var checkBox = $('input:checkbox[data-idx='+index+']');
			var joinPath = checkBox.prop("checked") ? "Y" : "N";
			var options = {
				url : "/introduce/terms/indexTerms"
				, data : {
					termsCd : termsCd
					, settingYn : settingYn
					, joinPath : joinPath
				}
				, dataType : "html"
				, done : function(html){
					$("#termsLayer").html(html);
					ui.popLayer.open('termsContentPop',{ // 콜백사용법
						ocb:function(){
							//popServiceList(index)
						},
						ccb:function(){
							$("#termsLayer .popLayer").remove();
						}
					});
				}
			}
			ajax.call(options)
		}
	</script>
	
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<!--<body class="body"  onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">-->
		<!--<div class="wrap" id="wrap"> -->
				
				<!-- mobile header -->
				<header class="header pc cu mode7" data-header="set9">
					<div class="hdr">
						<div class="inr">
							<div class="hdt">
								<button id ="backBtn" class="mo-header-backNtn" onclick="storageHist.goBack();"><spring:message code='front.web.view.common.msg.back' /></button>
								<div class="mo-heade-tit"><span class="tit"><spring:message code='front.web.view.common.join.title' /></span></div>
							</div>
						</div>
					</div>
				</header>
		
		
				<!-- 바디 - 여기위로 템플릿 -->
				<main class="container page login srch agree" id="container">
					<div class="inr">
						<form id="terms_form" method="post">
							<input type="hidden" id="auth_json" name="authJson" value="" />
							<input type="hidden" id="snsYn" name="snsYn" value="N" />
							<input type="hidden" id="vnform_terms_check_yn" name="termsCheckYn" value="N" />
							<input type="hidden" id="termsNo" name="termsNos"  />
							<input type="hidden" id="pstInfoAgrYn" name="pstInfoAgrYn"  value="N" />
							<input type="hidden" id="mkngRcvYn" name="mkngRcvYn" value="N" />
							<input type="hidden"  name="rcomCode"  value="${rcomCode}" />
						</form>
						<!-- 본문 -->
						<div class="contents" id="contents">
							<!-- PC 타이틀 모바일에서 제거  -->
							<div class="pc-tit">
								<h2>회원가입</h2>
							</div>
							<!-- // PC 타이틀 모바일에서 제거  -->
							<div class="fake-wrap">
								<div class="result"><span class="blue"><spring:message code='front.web.view.join.term_service.result.title' /></span><spring:message code='front.web.view.common.please.result.title' /></div>
								<div class="chk-wrap">
									<dl>
										<dt class="allchk">
											<label class="checkbox">
												<input type="checkbox" id="terms_all">
												<span class="txt" ><spring:message code='front.web.view.join.term_agree.all.check.title' /></span>
											</label>
										</dt>
										<dd>
											<ul>
												<c:forEach items="${terms}" var="item" varStatus ="stat">
													<c:if test="${item.usrDfn1Val == '20'}" >
														<li>
															<label class="checkbox">
																<input type="checkbox" class="${ item.rqidYn == 'Y' ? 'rqidTerm term' :'term' }" id="terms_${item.termsNo }" data-idx = "${stat.index }" data-terms-no="${item.termsNo}">
																<c:if test="${item.rqidYn == 'Y'}"> <span class="txt" id="${item.termsCd}" >[<spring:message code='front.web.view.common.required.title' />] ${item.termsNm}</span></c:if>
																<c:if test="${item.rqidYn == 'N'}"> <span class="txt" id="${item.termsCd}" >[<spring:message code='front.web.view.common.choice.title' />] ${item.termsNm}</span></c:if>
															</label>
															<a href="javascript:openTermsSetting('${item.termsCd}', '${item.rqidYn}', '${stat.index }');" name ="contentPopBtn" title="<spring:message code='front.web.view.common.content.button.popup.title' />" data-content="" data-url="" data-index="${stat.index}"></a>
<%-- 															<a href="javascript:;" name ="contentPopBtn" title="<spring:message code='front.web.view.common.content.button.popup.title' />" data-content="" data-url="" data-index="${stat.index }"></a> --%>
														</li>
													</c:if>
												</c:forEach>
											</ul>
										</dd>
									</dl>
									<%-- <dl>
										<dt>네이버 서비스 이용약관</dt>
										<dd>
											<ul>
												<c:forEach items="${terms}" var="item" varStatus ="stat" >
													<c:if test="${item.usrDfn1Val == '30'}" >
														<li>
															<label class="checkbox">
																<input type="checkbox"   ${ item.rqidYn == 'Y' ? 'class="rqidTerm term"' :'class="term"'} id="terms_${item.termsNo }" data-idx = "${stat.index }" data-terms-no="${item.termsNo}"/>
																<c:if test="${item.rqidYn == 'Y'}" > <span class="txt">[필수] ${item.termsNm}</span></c:if>
																<c:if test="${item.rqidYn == 'N'}"> <span class="txt">[선택] ${item.termsNm}</span></c:if>
															</label>
															<a href="javascript:;" name ="contentPopBtn" title="내용보기" data-content="" data-url="" data-index="${stat.index }"></a>
														</li>
													</c:if>
												</c:forEach>
											</ul>
										</dd>
									</dl> --%>
									<%-- <c:if test="${snsInfo.snsUuid == null or (snsInfo.snsUuid != null and snsInfo.snsUuid != '' and snsInfo.ciCtfVal != '' and snsInfo.ciCtfVal != null ) }">
									<dl>
										<dt>GS포인트 이용약관</dt>
										<dd>
											<ul>
												<c:forEach items="${terms}" var="item" varStatus ="stat">
													<c:if test="${item.usrDfn1Val == '10'}" >
														<li>
															<label class="checkbox">
																<input type="checkbox"   ${ item.rqidYn == 'Y' ? 'class="rqidTerm term"' :'class="term"'} id="terms_${item.termsNo }" data-idx = "${stat.index }" data-terms-no="${item.termsNo}"/>
																<c:if test="${item.rqidYn == 'Y'}" > <span class="txt">[필수] ${item.termsNm}</span></c:if>
																<c:if test="${item.rqidYn == 'N'}"> <span class="txt">[선택] ${item.termsNm}</span></c:if>
															</label>
															<a href="javascript:;"  name ="contentPopBtn" title="내용보기" data-content="" data-url="" data-index="${stat.index }"></a>
														</li>
													</c:if>
												</c:forEach>
											</ul>
										</dd>
									</dl>
									</c:if> --%>
								</div>
								<div class="info-txt pd" style="padding:10px 0px 10px 0px;font-size:12px;">
									<spring:message code='front.web.view.join.info.term_agree.contents1' />
									<ul style="margin-top: 10px;">
										<li>
											<spring:message code='front.web.view.join.info.term_agree.contents2' />
										</li>
									</ul>
								</div>
								<div class="pbt fixed">
									<!-- 버튼 활성화시 -->
									<div class="bts" id="activeBtn" style="display:none;">
										<button type="button" onClick="goJoinPage();return false" class="btn xl a" data-content="" data-url=""><spring:message code='front.web.view.join.go_join.button.title' /></button>
									</div>
			
									<!-- 버튼 비활성화시 -->
									<div class="bts" id="inactiveBtn">
										<button type="button" class="btn xl gray a" data-content="" data-url="" disabeld><spring:message code='front.web.view.join.go_join.button.title' /></button>
									</div>
								</div>
							</div>
						</div>
					</div>
					
				</main>
				
<!-- 				<div class="layers" style="display:none;"> -->
<%-- 				<c:forEach items = "${terms }" var = "term" varStatus = "stat"> --%>
<!-- 				이용 약관 -->
<%-- 				<main class="container page login agree" id="container${stat.index }"> --%>
<!-- 					<div class="inr"> -->
<!-- 					<div class="contents" id="contents"> -->
<!-- 					팝업레이어 A 전체 덮는크기 -->
<%-- 					<article class="popLayer a popSample1" id="termsContentPop${stat.index }"> --%>
<!-- 						<div class="pbd"> -->
<!-- 							<div class="phd"> -->
<!-- 								<div class="in"> -->
<%-- 									<h1 class="tit">${term.termsNm }</h1> --%>
<%-- 									<button type="button" id = "closeBtn" class="btnPopClose"><spring:message code='front.web.view.common.close.btn' /></button> --%>
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 							<div class="pct"> -->
<!-- 								<main class="poptents"> -->
<!-- 									// PC 타이틀 모바일에서 제거  -->
<!-- 									<div class="agree-box"> -->
<!-- 										<div class="select"> -->
<!-- 											<select name ="termContentSelect"> -->
<%-- 												<c:forEach items="${term.listTermsContent}" var ="content" varStatus ="stat"> --%>
<%-- 													<c:if test ="${stat.index eq 0 }"> --%>
<%-- 														<option value ="${stat.index }"><spring:message code='front.web.view.join.start.current_date.title' /> <frame:date date ="${content.termsStrtDt }" type ="K"/></option> --%>
<%-- 													</c:if> --%>
<%-- 													<c:if test ="${stat.index ne 0 }"> --%>
<%-- 														<option value ="${stat.index }"><frame:date date ="${content.termsStrtDt }" type ="K"/> ~ <frame:date date ="${content.termsEndDt }" type ="K"/></option> --%>
<%-- 													</c:if> --%>
<%-- 												</c:forEach> --%>
<!-- 											</select> -->
<!-- 										</div> -->
<%-- 										<c:if test="${term.rqidYn eq frontConstants.COMM_YN_N }"> --%>
<!-- 											<div class="agree-btn" style ="margin-top:20px;"> -->
<%-- 												<p class="txt">${term.termsNm } <spring:message code='front.web.view.terms.msg.ask.agreement' /></p> --%>
<%-- 												<button name ="agreeTerm" id="agreeTermModal" class="btn a" data-terms-no="${term.termsNo }"><spring:message code='front.web.view.common.agree.title' /></button> --%>
<%-- 												<input type="hidden"  value="${term.termsCd }" /> --%>
<!-- 											</div> -->
<%-- 										</c:if> --%>
<%-- 										<c:forEach items="${term.listTermsContent}" var ="content" varStatus ="stat"> --%>
<%-- 											<c:if test="${stat.index eq 0}"> --%>
<!-- 											<section class="exlist"> -->
<!-- 												<dl> -->
<%-- 													${content.content } --%>
<!-- 												</dl> -->
<!-- 											</section> -->
<%-- 											</c:if> --%>
<%-- 											<c:if test="${stat.index ne 0 }"> --%>
<!-- 											<section class="exlist" style = "display:none;"> -->
<!-- 												<dl> -->
<%-- 												${content.content} --%>
<!-- 												</dl> -->
<!-- 											</section> -->
<%-- 											</c:if> --%>
<%-- 										</c:forEach> --%>
<!-- 									</div> -->
<!-- 								</main> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</article> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</main> -->
<%-- 		</c:forEach> --%>
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </body> -->
<div id="termsLayer"></div>
	</tiles:putAttribute>
</tiles:insertDefinition>


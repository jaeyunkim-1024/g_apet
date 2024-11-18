<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<tiles:insertDefinition name="default">
	<%-- 
	Tiles script.inline put
	불 필요시, 해당 영역 삭제 
	--%>
	<tiles:putAttribute name="script.inline">
		<script>
			$(document).ready(function(){
				console.log("${settingYn}")
				$(document).on("change" , "[name=termContentSelect]" , function(){
					var value =	$(this).find("option:selected").val();
					var section = $(this).parents("article").find("section");
					var title = $(this).parents("article").find(".tit");
					var agreeTitle = $(this).parents("article").find(".txt");
					
					section.hide();
					section.eq(value).show();
					
					title.hide();
					title.eq(value).show();
					
					agreeTitle.hide();
					agreeTitle.eq(value).show();
				});
				
				// termsList의 termsCd는 모두 동일
				if("${termsList[0].termsCd}" == "${frontConstants.TERMS_GB_ABP_MEM_LOCATION_INFO}") {		// 위치정보 동의일 경우
					agreeBtnControl("${vo.pstInfoAgrYn}");		
				} else if("${termsList[0].termsCd}" == "${frontConstants.TERMS_GB_ABP_MEM_MARKETING}") {	// 마케팅 수신일 경우
					agreeBtnControl("${vo.mkngRcvYn}");		
				}
			});
			
			function termsAgree(agreeYn, termsCd) {
				var termsNm = $("article").find(".tit").html();
				termsNm = termsNm.replace("<spring:message code='front.web.view.common.agree.title'/>", "");
				var toastText = agreeYn == "Y" ? "<spring:message code='front.web.view.terms.agree'/>" : "<spring:message code='front.web.view.terms.disagree'/>";
				 
				var options = {
					url : "/introduce/terms/updateMemberBaseTermsYn"
					, data : { mbrNo : "${session.mbrNo}", agreeYn : agreeYn, termsCd : termsCd }
					, done : function(result) {
						if(result == '${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}') {
							agreeBtnControl(agreeYn);
							ui.toast(termsNm + toastText + "<spring:message code='front.web.view.terms.msg.you.did'/>");
						}
					}
				}
				ajax.call(options);
			}
			
			function agreeBtnControl(agreeYn) {
				if(agreeYn == "Y") {
					$("#termsDisagree").show();
					$("#termsAgree").hide();
				} else {
					$("#termsDisagree").hide();
					$("#termsAgree").show();
				}
			}
		</script>
	</tiles:putAttribute>
	
	<%-- 
	Tiles content put
	--%>		
	<tiles:putAttribute name="content">
		<!-- 팝업윈도우 A .popLayer.win-->
		<article class="popLayer win a popWin1">
			<div class="pbd">
				<div class="phd">
					<div class="in">
						<c:forEach items="${termsList}" var ="content" varStatus ="stat">
							<c:if test ="${stat.index == 0  }">
								<h1 class="tit">
									${content.termsNm }
								</h1>
							</c:if>
							<c:if test ="${stat.index != 0  }">
								<h1 class="tit" style="display: none;">
									${content.termsNm }
								</h1>
							</c:if>
						</c:forEach>
						<button type="button" class="btnPopClose" onclick="window.self.close();">닫기</button>
					</div>
				</div>
				<div class="pct">
					<main class="poptents">
						<div class="agree-box">
							<c:if test="${settingYn ne 'Y'}">
								<div class="agree-btn" style ="margin-top:20px;">
									<c:forEach items="${termsList}" var ="content" varStatus ="stat">
										<c:if test ="${stat.index == 0  }">
											<p class="txt">${content.termsNm } <spring:message code='front.web.view.terms.msg.ask.agreement'/></p>
										</c:if>
										<c:if test ="${stat.index != 0  }">
											<p class="txt" style="display: none;">${content.termsNm } <spring:message code='front.web.view.terms.msg.ask.agreement'/></p>
										</c:if>
									</c:forEach>
									<button id="termsAgree" name ="agreeTerm" class="btn a" onclick="termsAgree('Y', '${termsList[0].termsCd}');" data-terms-no="${term.termsNo }" data-content="" data-url="">동의</button>
									<button id="termsDisagree" name ="agreeTerm" class="btn" onclick="termsAgree('N', '${termsList[0].termsCd}');" data-terms-no="${term.termsNo }" data-content="" data-url="">동의철회</button>
								</div>
							</c:if>
							<div class="select">
								<select name ="termContentSelect">
									<c:forEach items="${termsList}" var ="content" varStatus ="stat">
										<c:if test ="${stat.index == 0  }">
											<option value ="${stat.index }" selected="selected" >현행 시행일자 : <frame:date date ="${content.termsStrtDt }" type ="K"/></option>
										</c:if>
										<c:if test ="${stat.index != 0 }">
											<option value ="${stat.index }"><frame:date date ="${content.termsStrtDt }" type ="K"/> ~ <frame:date date ="${content.termsEndDt }" type ="K"/></option>
										</c:if>
									</c:forEach>
								</select>
							</div>
							<c:forEach items="${termsList}" var ="content" varStatus ="stat">
								<c:if test="${stat.index == 0}">
								<section class="exlist">
									<dl>
										${content.content }
									</dl>
								</section>
								</c:if>
								<c:if test="${stat.index != 0 }">
								<section class="exlist" style = "display:none;">
									<dl>
									${content.content}
									</dl>
								</section>
								</c:if>
							</c:forEach>
						</div>
					</main>
				</div>
			</div>
		</article>
	</tiles:putAttribute>
</tiles:insertDefinition>

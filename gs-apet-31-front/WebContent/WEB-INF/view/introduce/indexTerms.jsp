<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
	<script>

		$(window).bind("popstate", function(event) {
			ui.popLayer.close('termsContentPop');
		});
	
		$(document).ready(function(){
			history.pushState(null, null, null);
			
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
			if("${termsList[0].termsCd}" == "${frontConstants.TERMS_GB_ABP_MEM_LOCATION_INFO}" && "${joinPath}" == "") {		// 위치정보 동의일 경우
				agreeBtnControl("${vo.pstInfoAgrYn}");		
			} else if("${termsList[0].termsCd}" == "${frontConstants.TERMS_GB_ABP_MEM_MARKETING}" && "${joinPath}" == "") {	// 마케팅 수신일 경우
				agreeBtnControl("${vo.mkngRcvYn}");		
			}
		});
		
		function termsAgree(agreeYn, termsCd) {

			var toastText;
			var mbrYn = "${session.mbrNo}" != 0 ? true : false;
			
			if(termsCd == "${frontConstants.TERMS_GB_ABP_MEM_MARKETING}"){
				toastText = agreeYn == "Y" ? "<spring:message code='front.web.view.join.marketing.term_agree.msg.title' />" : "<spring:message code='front.web.view.join.marketing.term_disagree.msg.title' />";
			}

			if(termsCd == "${frontConstants.TERMS_GB_ABP_MEM_LOCATION_INFO}"){
				toastText = agreeYn == "Y" ? "<spring:message code='front.web.view.join.location.term_agree.msg.title' />" : "<spring:message code='front.web.view.join.location.term_disagree.msg.title' />";
			}

			if(mbrYn){
				var options = {
					url : "/introduce/terms/updateMemberBaseTermsYn"
					, data : { mbrNo : "${session.mbrNo}", agreeYn : agreeYn, termsCd : termsCd }
					, done : function(result) {
						if(result == '${frontConstants.CONTROLLER_RESULT_CODE_SUCCESS}') {
							agreeBtnControl(agreeYn);
							ui.toast(toastText);
						}
					}
				}
				ajax.call(options);
			}
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

<!-- 팝업레이어 A 전체 덮는크기 -->
<article class="popLayer a popSample1" id="termsContentPop">
	<div class="pbd width562">
		<div class="phd">
			<div class="in">
				<c:forEach items="${termsList}" var ="content" varStatus ="stat">
					<c:if test ="${stat.index == 0  }">
						<h1 class="tit">${content.termsNm }</h1>
					</c:if>
					<c:if test ="${stat.index != 0  }">
						<h1 class="tit" style="display: none;">${content.termsNm }</h1>
					</c:if>
				</c:forEach>
				<button onclick="history.go(-1);" type="button" class="btnPopClose"> <spring:message code='front.web.view.common.close.btn'/></button>			
			</div>
		</div>
		
		<div class="pct">
			<main class="poptents">
			
				<!-- // PC 타이틀 모바일에서 제거  -->
				<div class="${settingYn ne 'Y' ? 'agree-box' : ''}">
					<c:if test="${settingYn ne 'Y'}">
						<div class="agree-btn">
							<c:forEach items="${termsList}" var ="content" varStatus ="stat">
								<c:if test ="${stat.index == 0  }">
									<p class="txt">${content.termsNm } <spring:message code='front.web.view.terms.msg.ask.agreement'/></p>
								</c:if>
								<c:if test ="${stat.index != 0  }">
									<p class="txt" style="display: none;">${content.termsNm } <spring:message code='front.web.view.terms.msg.ask.agreement'/></p>
								</c:if>
							</c:forEach>
							
							<c:choose>
								<c:when test="${joinPath eq 'N'}">
									<button name="joinAgreeTerm" class="btn a" data-terms-no="${termsList[0].termsNo}" data-terms-cd="${termsList[0].termsCd}">동의</button>
								</c:when>
								<c:when test="${joinPath eq 'Y'}">
									<button name="joinAgreeTerm" class="btn" data-terms-no="${termsList[0].termsNo}" data-terms-cd="${termsList[0].termsCd}">동의철회</button>
								</c:when>
								<c:otherwise>
									<button id="termsAgree" name ="agreeTerm" class="btn a" onclick="termsAgree('Y', '${termsList[0].termsCd}');" data-terms-no="${termsList[0].termsNo}" data-content="" data-url="">동의</button>
									<button id="termsDisagree" name ="agreeTerm" class="btn" onclick="termsAgree('N', '${termsList[0].termsCd}');" data-terms-no="${termsList[0].termsNo}" data-content="" data-url="">동의철회</button>
								</c:otherwise>
							</c:choose>		
							
							
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
								<dl>${content.content }</dl>
							</section>
						</c:if>
						<c:if test="${stat.index != 0 }">
							<section class="exlist" style = "display:none;">
								<dl>${content.content}</dl>
							</section>
						</c:if>
					</c:forEach>
				</div>
				
			</main>
		</div>
	</div>
</article>


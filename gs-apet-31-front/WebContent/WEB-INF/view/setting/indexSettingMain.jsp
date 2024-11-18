<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%--
  Class Name  : indexPetTvDetail.jsp 
  Description : 설정 > 메인 설정 화면
  Author      : LDS
  Since       : 2021.02.23
  Modification Information 
	          수정일         	     수정자             수정내용
    ----------  -------  -------------------------------------------
    2021.02.23   이동식          	최초 작성
--%>

<%-- 
사용 Tiles 지정
--%>
<tiles:insertDefinition name="default">
	<%-- 
	Tiles script.inline put
	불 필요시, 해당 영역 삭제 
	--%>
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript">
		
			$(document).ready(function(){
				$("input:radio[name='mainSet']").bind("change", function(){
					$("#saveButton").removeClass("disabled");
				});
				
				//앱 설정정보 조회
				// 데이터 세팅
				toNativeData.func = "onSettingInfos";
				toNativeData.callback = "appSettingInfo";
				// APP 호출
				toNative(toNativeData);
			}); // End Ready
			
			//앱 설정정보 값 셋팅(메인 설정)
			function appSettingInfo(jsonString){
				var parseData = JSON.parse(jsonString);
				//mainPage, autoPlay, appVersion
		    	//alert("mainPage : " + parseData.mainPage + "  autoPlay : " + parseData.autoPlay + "  appVersion : " + parseData.appVersion);
				
				//메인 설정값
				var mainPage = parseData.mainPage;
				$("input:radio[name='mainSet']:radio[value='"+ mainPage +"']").prop("checked", true);
			}
			
			function onMainPage() {
				var mainSet = $("input:radio[name='mainSet']:checked").val();
				//alert(mainSet);
				
				// 메인설정값 저장
				// 데이터 세팅
				toNativeData.func = "onMainPage";
				toNativeData.type = mainSet;
				// APP 호출
				toNative(toNativeData);

				ui.toast("메인 서비스 설정이 저장되었어요.");
				$("#saveButton").addClass("disabled");
// 				setTimeout(function(){location.href="/indexLoginSettings"}, 1000); //설정화면으로 이동
				setTimeout(function(){_replace("/indexLoginSettings");}, 1000); //설정화면으로 이동
			}

			function _replace(url) {
				history.replaceState(null, document.title, url);
				history.go(0);
			}
		</script>		
	</tiles:putAttribute>
	
	<%-- 
	Tiles content put
	--%>			
	<tiles:putAttribute name="content">
		<!-- content 내용 부분입니다.	-->	
		<!-- 헤더-->
		<header class="header pc cu mode12" data-header="set17">
			<div class="hdr">
				<div class="inr">
					<div class="hdt">
						<!-- mobile -->
<!-- 						<button class="mo-header-backNtn" onclick="location.href='/indexLoginSettings'" data-content="" data-url="/indexLoginSettings">뒤로</button> -->
						<button class="mo-header-backNtn" onclick="_replace('/indexLoginSettings')" data-content="" data-url="/indexLoginSettings">뒤로</button>
						<div class="mo-heade-tit">
							<span class="tit">메인 서비스 설정</span>
						</div>
						<!-- <div class="mo-header-rightBtn">
							<button class="mo-header-btnType01">
								<span class="mo-header-icon"></span>
								저장
							</button>
						</div> -->
						<button class="mo-header-close"></button>
						<!-- // mobile -->
					</div>
				</div>
			</div>
		</header>
		
		<!-- 바디 -->
		<main class="container page login srch" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<!-- PC 타이틀 영역 -->
					<!-- PC 타이틀 영역 -->

					<div class="fake-pop">
						<div class="result">원하는 서비스를 
							<span class="block"><span class="blue">메인</span>으로 설정할 수 있습니다.</span>
						</div>
						<!-- 설정 컨텐츠 영역 -->
						<div class="choice mt60">
							<ul>
								<li class="tv">
									<label class="radio">
										<input type="radio" name="mainSet" value="TV">
									    <span class="txt"><spring:message code='front.web.view.new.menu.tv'/></span> <!-- APET-1250 210728 kjh02  -->
								    </label>
								</li>
								<li class="log">
									<label class="radio">
										<input type="radio" name="mainSet" value="LOG">
									    <span class="txt"><spring:message code='front.web.view.new.menu.log'/></span> <!-- APET-1250 210728 kjh02  -->
								    </label>
								</li>
								<li class="shop">
									<label class="radio">
										<input type="radio" name="mainSet" value="SHOP" checked>
									    <span class="txt"><spring:message code='front.web.view.new.menu.store'/></span> <!-- APET-1250 210728 kjh02  -->
								    </label>
								</li>
							</ul>
						</div>
						<div class="btnSet fixed">
							<a id="saveButton" href="#" onclick="onMainPage(); return false;" class="btn lg a disabled" data-content="" data-url="onMainPage();">저장</a>
						</div>
						<!-- // 설정 컨텐츠 영역 -->
					</div>
				</div>
			</div>
		</main>

		<div class="layers">
			<!-- 레이어팝업 넣을 자리 -->
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>
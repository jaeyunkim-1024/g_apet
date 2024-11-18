<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%--
  Class Name  : indexPetTvDetail.jsp 
  Description : 설정 > 동영상 자동재생 설정 화면
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
				/*$("input:radio[name='autoSet']").bind("change", function(){
					$("#saveButton").removeClass("disabled");
				});*/
				
				//앱 설정정보 조회
				// 데이터 세팅
				toNativeData.func = "onSettingInfos";
				toNativeData.callback = "appSettingInfo";
				// APP 호출
				toNative(toNativeData);
			}); // End Ready
			
			//앱 설정정보 값 셋팅(동영상 자동재생)
			function appSettingInfo(jsonString){
				var parseData = JSON.parse(jsonString);
				//mainPage, autoPlay, appVersion
		    	//alert("mainPage : " + parseData.mainPage + "  autoPlay : " + parseData.autoPlay + "  appVersion : " + parseData.appVersion);
				
				//자동재생 설정값
				var autoPlay = parseData.autoPlay;
				$("input:radio[name='autoSet']:radio[value='"+ autoPlay +"']").prop("checked", true);
			}

			function onAutoPlay() {
				var autoSet = $("input:radio[name='autoSet']:checked").val();
				//alert(autoSet);
				
				// 동영상 자동재생 설정값 저장
				// 데이터 세팅
				toNativeData.func = "onAutoPlay";
				toNativeData.type = autoSet;
				// APP 호출
				toNative(toNativeData);
				
				ui.toast("자동재생 설정이 저장되었어요.");
				//$("#saveButton").addClass("disabled");
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
							<span class="tit">자동재생 설정</span>
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
		<main class="container page sett" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<!-- PC 타이틀 모바일에서 제거  -->
					<!-- // PC 타이틀 모바일에서 제거  -->
					
					<div class="fake-pop">
						<div class="result mt20">
							<p class="sub">서비스 전체적으로 영상이 자동재생 되는 기능입니다.</p>
						</div>
					    <!-- 설정 컨텐츠 영역 -->
					    <div class="member-input mt40">
							<ul class="list">
								<li>
									<div class="flex-wrap">
										<label class="radio">
											<input type="radio" name="autoSet" value="MW">
											<%--<span class="txt">모바일 데이터 및 Wi-Fi 연결</span>--%>
											<span class="txt">항상 자동 재생</span>
										</label>
									</div>
									<div class="flex-wrap mt30">
										<label class="radio">
											<input type="radio" name="autoSet" value="W">
											<span class="txt">Wi-Fi 연결시에만</span>
										</label>
									</div>
									<div class="flex-wrap mt30">
										<label class="radio">
											<input type="radio" name="autoSet" value="N" checked>
											<span class="txt">동영상 자동재생 사용 안함</span>
										</label>
									</div>
								</li>
							</ul>
						</div>
						<div class="btnSet fixed">
							<a id="saveButton" href="#" onclick="onAutoPlay(); return false;" class="btn lg a" data-content="" data-url="onAutoPlay();">저장</a>
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
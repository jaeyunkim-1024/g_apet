<%--	
 - Class Name	: /sample/sampleLogin.jsp
 - Description	: SNS 로그인 샘플 페이지
 - Since		: 2020.12.17
 - Author		: KKB
--%>

<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.inline">
		<%-- 애플 스크립트 --%>
		<script type="text/javascript">
			$(document).ready(function(){
			}); // End Ready

			/*
			 * SNS 로그인 ( 네이버, 카카오, 구글)
			 */
			var snsPop;
			function snsLogin(chnlId) { //TODO : 채널 아이디 상수지정 및 변경 필요
				// opner 함수 호출을 위한 지정
				//window.name='mainwin';
				
				// 연결
				//snsPop = window.open("/sample/sampleSnsLogin/?chnlId="+chnlId, "_blank");
				location.href="/sample/sampleSnsLogin/?chnlId="+chnlId;
			}

			/*
			 * SNS 로그인 ( 애플 )
			 */    
// 	      	function snsAppleLogin() {
// 	      		AppleID.auth.signIn().then(function(response) {
// 	      			console.log("성공",response);
// 				}, function(err) {
// 					console.log("실패",err);
// 				})
// 			}
	      	
	       //Listen for authorization success
// 	      	document.addEventListener('AppleIDSignInOnSuccess', (data) => {
// 	      	    alert("성공"); 
// 	      		console.log("성공",data);
// 	      	});
	      	//Listen for authorization failures
// 	      	document.addEventListener('AppleIDSignInOnFailure', (error) => {
// 	      		 alert("실패"); 
// 		      		console.log("실패",error);
// 	      	});
	        
	        
			/*
			 * 팝업에서 호출 가능한 함수 지정 ( 네이버, 카카오, 구글 )
			 */
			 
			 // 팝업에서 호출 가능한 함수 지정
			function snsFunc() {
				// 창 닫기
				// snsPop.close();
				// 리로드
				// location.reload();
			}
		</script>

	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<div id="content">
			<!-- 네이버 -->
			<button onclick="snsLogin(10)">네이버</button>
			<!-- 카카오 -->
			<button onclick="snsLogin(20)">카카오</button>
			<!-- 구글 -->
			<button onclick="snsLogin(30)">구글</button>
			<!-- 애플 -->
			<button onclick="snsLogin(40)">
				<img src="https://appleid.cdn-apple.com/appleid/button?color=white&border=true" />
			</button>

		</div>
		<c:if test="${not empty resultJson}">
			<h3> 결과</h3>
			<p>${resultJson}</p>
		</c:if>
	</tiles:putAttribute>
</tiles:insertDefinition>


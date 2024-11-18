<tiles:insertDefinition name="noheader_mo">
<tiles:putAttribute name="script.inline">
<script type="text/javascript">
	$(function(){
		if("${view.deviceGb}" != "PC"){
			$("#header_pc").hide();
		}

		var registraionType = "";
		if('${joinPath}' == '10' || '${joinPath}' == '20' || '${joinPath}' == '30'){
			registraionType = "일반";
		}else if('${joinPath}' == '40'){
			registraionType = "네이버";
		}else if('${joinPath}' == '50'){
			registraionType = "애플";
		}else if('${joinPath}' == '60'){
			registraionType = "구글";
		}else if('${joinPath}' == '70'){
			registraionType = "카카오";
		}

		dataLayer.push({
			"event": "customEvent",
			"customEventCategory": "회원가입",
			"customEventAction": "회원가입 완료",
			"customEventLabel": registraionType,  // SNS 채널을 통한 간편가입이 아닌 일반회원 가입시, 해당 변수 값은 "일반"
			"registraionType": registraionType,  // SNS 채널을 통한 간편가입이 아닌 일반회원 가입시, 해당 변수 값은 "일반"
			"registrationComp": 1
		});

	});
	
	//홈 url설정
	function fncHomeBtn(){
		var joinPath ="${joinPath}";
		/* var returnUrl = "/tv/home"; */
		var returnUrl = "/shop/home/";
		
		if( joinPath == '${frontConstants.JOIN_PATH_20}') returnUrl = '/shop/home' //펫샵 url 붙여주기!!!
		
		location.href = returnUrl;
		return;
	}
	
</script>
</tiles:putAttribute>
<tiles:putAttribute name="content">	

<body class="body">
	<div class="wrap" id="wrap">
<!-- 바디 - 여기위로 템플릿 -->
		<main class="container login srch" id="container">

			<div class="inr complete-wrap">
				<div class="complete-area">
					<div class="complete">
						<p class="txt">
							<spring:message code='front.web.view.join.complete_congratulation.result.title' /> <br>
							<c:choose>
								<c:when test="${isPBHR ne null and isPBHR ne ''}">
									<spring:message code='front.web.view.join.complete_enroll.result.title' />
									<span class="sub"><spring:message code='front.web.view.join.complete_aboutPet.result.title' /></span>
								</c:when>
								<c:otherwise>
									<spring:message code='front.web.view.join.complete_info.result.title' />
									<!-- <span class="sub">이제 어바웃펫을 시작해보세요!</span> -->
								</c:otherwise>
							</c:choose>
							
						</p>
						
						<div class="btn-area">
							<a href="javascript:fncHomeBtn();" class="btn round" data-content="" data-url="" ><spring:message code='front.web.view.common.msg.goHome' /><span class="arrow"></span></a>
						</div>
					</div>
					<div class="bottom">
						<div class="item">
							<div class="box">
								<p class="big-txt">
									<spring:message code='front.web.view.join.info.pet.question.result.title' /> <br>
									<spring:message code='front.web.view.join.info.pet_with.question.result.title' />
								</p>
								<button type="button" class="btn add" onClick="location.href='${view.stDomain}/my/pet/petInsertView'" data-url="/my/pet/petInsertView"><spring:message code='front.web.view.join.mypet_enroll.result.button.title' /></button>
							</div>
							
							<p class="sub-txt"><spring:message code='front.web.view.join.info.mypet_input.msg.title' /> <span class="block"><spring:message code='front.web.view.join.info.mypet_input_contents.msg.title' /></span></p>
						</div>
					</div>
				</div>
			</div>
		</main>
	</div>
</body>
</tiles:putAttribute>
</tiles:insertDefinition>



<%--
// 외부 연동 Block 처리
<!-- WIDERPLANET  SCRIPT START 2017.8.31 -->
<div id="wp_tg_cts" style="display:none;"></div>
<script type="text/javascript">
var wptg_tagscript_vars = wptg_tagscript_vars || [];
wptg_tagscript_vars.push(
(function() {
    return {
    	wp_hcuid:"${not empty session and session.mbrNo ne FrontWebConstants.NO_MEMBER_NO ? session.mbrNo : ''}",   /*Cross device targeting을 원하는 광고주는 로그인한 사용자의 Unique ID (ex. 로그인 ID, 고객넘버 등)를 암호화하여 대입. *주의: 로그인 하지 않은 사용자는 어떠한 값도 대입하지 않습니다.*/
        ti:"37410",
        ty:"Join",                        /*트래킹태그 타입*/
        device:"web",                  /*디바이스 종류 (web 또는 mobile)*/
        items:[{
            i:"회원가입",          /*전환 식별 코드 (한글, 영문, 숫자, 공백 허용)*/
            t:"회원가입",          /*전환명 (한글, 영문, 숫자, 공백 허용)*/
            p:"1",                   /*전환가격 (전환 가격이 없을 경우 1로 설정)*/
            q:"1"                   /*전환수량 (전환 수량이 고정적으로 1개 이하일 경우 1로 설정)*/
        }]
    };
}));
</script>

<script type="text/javascript"> 
 //<![CDATA[ 
 var NeoclickConversionDctSv="type=2,orderID=,amount="; 
 var NeoclickConversionAccountID="21136"; 
 if(location.protocol!="file:"){ 
    document.write(unescape("%3Cscript%20type%3D%22text/javas"+"cript%22%20src%3D%22"+(location.protocol=="https:"?"https":"http")+"%3A//ck.ncclick.co.kr/NCDC_V2.js%22%3E%3C/script%3E")); 
 } 
 //]]> 
</script> 
--%>
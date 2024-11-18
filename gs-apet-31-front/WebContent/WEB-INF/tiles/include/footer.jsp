<%--
// 외부 연동 Block 처리
<!-- 매체별 로그분석 스크립트 -->
<!-- 1. 네이버 -->
<!-- 공통 적용 스크립트 , 모든 페이지에 노출되도록 설치. 단 전환페이지 설정값보다 항상 하단에 위치해야함 --> 
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"> </script> 
<script type="text/javascript"> 
if (!wcs_add) var wcs_add={};
wcs_add["wa"] = "s_150e148bdd8a";
if (!_nasa) var _nasa={};
wcs.inflow();
wcs_do(_nasa);
</script>

<!-- 3. Adgather Log Analysis v2.0 start-->
<script LANGUAGE="JavaScript" type="text/javascript">
var domainKey = "1502239766489"
var _localp = ""
var _refererp = ""
var _aday = new Date(); 
var _fname = ""; 
var _version = String(_aday.getYear())+String(_aday.getMonth()+1)+String(_aday.getDate())+String(_aday.getHours()); 
document.write ("<"+"script language='JavaScript' type='text/javascript' src='"+document.location.protocol+"//logsys.adgather.net/adtracking.js?ver="+_version+"'>");
document.write ("</"+"script>");
</script>
<!--Adgather Log Analysis v2.0 end-->

<!-- WIDERPLANET  SCRIPT START 2017.8.31 -->
<div id="wp_tg_cts" style="display:none;"></div>
<script type="text/javascript">
var wptg_tagscript_vars = wptg_tagscript_vars || [];
wptg_tagscript_vars.push(
(function() {
    return {
        wp_hcuid:"${not empty session and session.mbrNo ne FrontWebConstants.NO_MEMBER_NO ? session.mbrNo : ''}",   /*Cross device targeting을 원하는 광고주는 로그인한 사용자의 Unique ID (ex. 로그인 ID, 고객넘버 등)를 암호화하여 대입. *주의: 로그인 하지 않은 사용자는 어떠한 값도 대입하지 않습니다.*/
        ti:"37410", /*광고주 코드*/
        ty:"Home",  /*트래킹태그 타입*/
        device:"web"    /*디바이스 종류 (web 또는 mobile)*/
    };
}));

</script>
<script type="text/javascript" async src="//cdn-aitg.widerplanet.com/js/wp_astg_4.0.js"></script>
<!-- // WIDERPLANET  SCRIPT END 2017.8.31 -->

<!-- Withpang Tracker v3.0 [공용] start -->
<script type="text/javascript">
    function mobRf() {
	    var rf = new EN();
	    rf.setSSL(true);
	    rf.sendRf();
	}
</script>
<script src="https://cdn.megadata.co.kr/js/enliple_min2.js" async="true" onload="mobRf()"></script>
<!-- Withpang Tracker v3.0 [공용] end -->
--%>
<script type="text/javascript">
	/* 사업자정보 팝업 */
	function openLicensee(licensee) {
		var url = "http://www.ftc.go.kr/info/bizinfo/communicationViewPopup.jsp?wrkr_no="+licensee;
		window.open(url, "communicationViewPopup", "width=750, height=700;");
	}
	
	/* Escrow */
	function openEscrow() {
		var options = {
			url : "/introduce/terms/indexEscrow",
			params : {},
			width : 640,
			height: 690,
			callBackFnc : "",
			modal : true
		};
		pop.open("escrow", options);
	}
	
	// 이용약관 pop
	function openTerms(termsCd , settingYn){
		if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){
			var url = "/introduce/terms/indexTermsApp?termsCd="+ termsCd +"&settingYn="+ settingYn;
			window.open(url, "termsContentPop");
		}else{
			var options = {
				url : "/introduce/terms/indexTerms"
				, data : {
					termsCd : termsCd
					, settingYn : settingYn
				}
				, dataType : "html"
				, done : function(html){
					$("#layers").html(html);
					ui.popLayer.open("termsContentPop");
				}
			}
			ajax.call(options);
		}
	}
	// 입점/제휴 문의 pop
	function openPartnershipInquiry(){
			var options = {
				url : "/customer/notice/indexPartnerNoticeList"
				, data : ''
				, dataType : "html"
				, done : function(html){
					$("#layers").html(html);
					ui.popLayer.open("popInqry");
				}
			}
			ajax.call(options);
		} 
	 function convertVerBtn(gb){
	        $.cookie("DEVICE_GB",gb,{path: '/'});
	         window.location.reload();
	    }
	   
	    $(window).bind("beforeunload", function (e){
	        $.removeCookie("DEVICE_GB");
	    });
	
</script>

<!-- footer -->	
<footer class="footer" id="footer">
	<div class="inr">
		<div class="link">
			<ul class="list">
				<li><a href="#" onclick ="openTerms('${frontConstants.TERMS_GB_ABP_MEM_TERM}' , 'Y'); return false;">서비스 이용약관</a></li>
				<li><a href="#" onclick ="openTerms('${frontConstants.TERMS_GB_ABP_MEM_PRIVACY}' , 'Y'); return false;">개인정보 처리방침</a></li>
				<li><a href="#" onclick ="openPartnershipInquiry()">입점/제휴 문의</a></li>
				<!-- 무조건 모바일웹으로 들어간 1경우에만 나타나게 만들기 -->
				<c:choose>
					<c:when test="${view.os ne frontConstants.DEVICE_TYPE}">
						<li class="change">
						<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_20}">
							<a class="mo" href="javascript:;" onclick="convertVerBtn('PC')" >PC버전으로 보기</a>
						</c:if>
						<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}">
							<a class="pc" href="javascript:;" onclick="convertVerBtn('MO')" >모바일버전으로 보기</a>
						</c:if>
						</li>
					</c:when>
				</c:choose>
		</div>
		<div class="info">
			<ul class="list">
				<li>(주)어바웃펫 대표 : 김경환, 나옥귀</li>
				<li>사업자 등록번호 : 120-87-90035</li>
				<li class="dn">통신판매업신고번호 : 제 2020-서울강남-03142호</li>
				<li>개인정보관리자 : 정명성  hello@aboutpet.co.kr</li>
				<li>TEL : 1644-9601</li>
			</ul>
			<p class="adr">서울특별시 강남구 테헤란로 151 (역삼하이츠빌딩) 지하2층</p>
		</div>
		<div class="copy">&copy; copyright (c) www.aboutpet.co.kr all rights reserved.</div>
	</div>
</footer>
<!--// footer -->

<div id ="layers">
</div>
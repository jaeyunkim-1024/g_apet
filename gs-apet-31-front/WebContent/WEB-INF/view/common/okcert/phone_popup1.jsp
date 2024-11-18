<div id="okCertDiv">
	<!--  
    //**************************************************************************
	// 파일명 : phone_popup1.jsp
	// - 바닥페이지
	// 휴대폰 본인확인 서비스 요청 정보 입력 화면
    //**************************************************************************
	-->
	<script>
		// 	alert("popup1");
		// 	$(document).ready(function(){
		// 		jsSubmit();
		// 	})
			function jsSubmit(){
				window.open("", "auth_popup", "width=430,height=640,scrollbar=yes");
				var okCertForm = document.okCertForm;
				okCertForm.target = "auth_popup";
				okCertForm.submit();
			}
	</script>
		<form name="okCertForm" action="/common/okCertPop" method="post">
			<input type="hidden" name="popup" value="phone_popup2">
			<input type="hidden" name="rqstCausCd" value="${RQST_CAUS_CD}">
       	</form>
       <!-- 휴대폰 본인확인 팝업 처리결과 정보 = phone_popup3 에서 값 입력 -->
	<form name="kcbResultForm" method="post">
		<input type="hidden" name="CP_CD" value=""/>
		<input type="hidden" name="TX_SEQ_NO" />
		<input type="hidden" name="RSLT_CD" />
		<input type="hidden" name="RSLT_MSG" />
		
		<input type="hidden" name="RSLT_NAME" />
		<input type="hidden" name="RSLT_BIRTHDAY" />
		<input type="hidden" name="RSLT_SEX_CD" />
		<input type="hidden" name="RSLT_NTV_FRNR_CD" />
		
		<input type="hidden" name="DI" />
		<input type="hidden" name="CI" />
		<input type="hidden" name="CI_UPDATE" />
		<input type="hidden" name="TEL_COM_CD" />
		<input type="hidden" name="TEL_NO" />
		
		<input type="hidden" name="RETURN_MSG" />
	</form>
</div>
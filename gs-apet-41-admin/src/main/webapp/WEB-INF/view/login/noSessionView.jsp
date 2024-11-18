<!DOCTYPE html>
<html lang="ko">
<head>
	<title>${resultMsg}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<link rel="shortcut icon" href="/images/favicon.ico" />
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" CONTENT="0">
	<meta http-equiv="Cache-Control" content="no-cache" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<%@ include file="/WEB-INF/include/common.jsp" %>
</head>
<body>
	<script language="javascript">
		messager.alert('${resultMsg}' ,"Info","info",function(){
			if(opener) {
				opener.document.location.href='${adminConstants.LOGIN_URL}';
				self.close();
			} else {
				top.location.href='${adminConstants.LOGIN_URL}';
			}
		});
	</script>
</body>
</html>
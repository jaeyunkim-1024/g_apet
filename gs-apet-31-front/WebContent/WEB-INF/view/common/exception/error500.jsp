<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<!doctype html>
<html lang="ko">
<head>
	<title>VECI</title>
	<meta charset="utf-8" />
	<link rel="shortcut icon" href="../images/common/favicon.ico">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<link rel="stylesheet" type="text/css" href="/_css/common.css">
	<link rel="stylesheet" type="text/css" href="/_css/layout.css">
	<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery-1.11.3.min.js" ></script>
	<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery-ui.min.js" ></script>
	<script type="text/javascript"  src="/_script/design-ui.js" ></script>
		
</head>
<body>

<div class="error_wrap404">
	<div class="error">
		<h1>쇼핑에 불편을 드려서 죄송합니다!</h1>
		<div>일시적인 오류로 인하여, 사이트 이용이 불가합니다.<br />잠시 후 다시 이용해 주시길 바랍니다. 감사합니다.</div>
		<div class="mgt50">
			<a href="#" class="btn_h60_type2" onclick="javascript:history.back();return false;">이전페이지</a><a href="/" class="btn_h60_type1 mgl8">메인</a>
		</div>
	</div>
</div>

</body>
</html>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title><t:insertAttribute name="title" ignore="true" defaultValue="관리자"/></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<link rel="shortcut icon" href="/images/favicon.ico" />
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" CONTENT="0">
	<meta http-equiv="Cache-Control" content="no-cache" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<t:insertAttribute name="meta" ignore="true"/>
	<t:insertAttribute name="common"/>
	<t:insertAttribute name="script" ignore="true"/>
</head>

<body>

	<a id="skip_nav" href="#contents">본문 바로가기</a>

	<div id="wrap" class="easyui-layout" style="width:100%;height:100%;">
		<t:insertAttribute name="header"/>
		<t:insertAttribute name="left"/>

		<div id="container" data-options="region:'center'">
			<div id="tt" class="easyui-tabs" style="width:100%;height:100%;" data-options="border:false,fit:true,plain:true">
			</div>
		</div>
	</div>
</body>
</html>





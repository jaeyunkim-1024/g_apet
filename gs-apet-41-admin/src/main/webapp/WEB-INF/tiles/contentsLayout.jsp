<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>${commonMenuDetail.actNm}</title>
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

	<div class="page-title-breadcrumb">
		<p class="pull-right"><i class="fa fa-home"></i>&nbsp;Home &gt; ${commonMenuDetail.menuPathNm}<a href="javascript:updateTab();"><i class="fa fa-refresh ml10"></i></a></p>
	</div>
			
	<div id="contents">
		<t:insertAttribute name="content"/>
	</div>
</body>
</html>





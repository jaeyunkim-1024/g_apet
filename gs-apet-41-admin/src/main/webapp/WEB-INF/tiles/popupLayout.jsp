<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title><t:insertAttribute name="title" ignore="true" defaultValue="관리자 팝업"/></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" CONTENT="0">
	<meta http-equiv="Cache-Control" content="no-cache" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<t:insertAttribute name="meta" ignore="true"/>
	<t:insertAttribute name="script" ignore="true"/>

	<script type="text/javascript">

		$(document).ready(function(){
			var popContentHeight = $(".popArea").height() - 	$(".popArea > .popTitle").height();
			$(".popArea > .popContent").height(popContentHeight - 32);
		});
	</script>
</head>
<body>
	<div class="blankPop">
		<div class="mBlank">
			<div class="popArea">
				<t:insertAttribute name="content"/>
			</div>
		</div>
	</div>
</body>
</html>





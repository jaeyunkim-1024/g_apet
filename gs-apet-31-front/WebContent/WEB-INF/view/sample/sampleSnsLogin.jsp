<script type="text/javascript"  src="<spring:eval expression="@bizConfig['cdn.domain']" />/_script/jquery/jquery-3.3.1.min.js" ></script>
<script type="text/javascript">
	window.focus();

	$(document).ready(function () {
		// 포커스 관리
		$("#focusHere").focus();
		window.location.href = '${goUrl}';
	});
</script>
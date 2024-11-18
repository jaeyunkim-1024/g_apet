<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8"%>
<t:insertDefinition name="mainLayout">
	<t:putAttribute name="title">aboutPet Admin</t:putAttribute>
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {
			addTab('dashboard', '/main/dashBoard.do');
			$('.page-title-breadcrumb').hide();
		});
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
	
	
	</t:putAttribute>
</t:insertDefinition>

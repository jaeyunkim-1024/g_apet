<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<!doctype html>
<html lang="ko">
<head>
	<title>ERROR</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" CONTENT="0">
	<meta http-equiv="Cache-Control" content="no-cache" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	
	<link rel="stylesheet" type="text/css" href="/css/common.css">
	<link rel="stylesheet" type="text/css" href="/css/design.css">
	
	<script type="text/javascript" src="/tools/jquery/jquery-1.12.1.min.js" charset="utf-8"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			if(opener != undefined){
				$("#openerView").show();
				$("#windowsView").hide();
			} else {
				$("#openerView").hide();
				$("#windowsView").show();
			}
		});
	</script>
</head>
<body>
	<div class="error_wrap">
		<div class="error">
			<h1>${exCode eq exceptionConstants.ERROR_NO_CONNECT ? '서비스에 접속할 수 없습니다.' : '불편을 드려서 죄송합니다!'}</h1>
			<div class="cont01">
				<c:if test="${exCode ne exceptionConstants.ERROR_NO_CONNECT}">
					<div class="mb10">
						${empty exMsg ? '찾고 계시는 페이지가 삭제되었거나,<br />이름이 변경되었거나 일시적인 오류로 표시할 수 없습니다.' : exMsg}
					</div>
					<div id="windowsView" class="mt30">
						<button onclick="${empty exUrl ? 'javascript:history.back();' : 'location.href='+exUrl}" class="btn btn-cancel">이전페이지</button>
						<button onclick="location.href='/main/mainView.do'" class="btn btn-add ml10">메인</button>
					</div>
					<div id="openerView" class="mt30">
						<button onclick="javascript:self.close();" class="btn btn-add">닫기</button>
					</div>
				</c:if>
			</div>
			<div class="cont02">
				<%-- <spring:message code="column.help_desk" /> --%>
			</div>
		</div>
	</div>
</body>
</html>
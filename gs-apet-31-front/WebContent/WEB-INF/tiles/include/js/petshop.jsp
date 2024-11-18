<!--라이브 앱과 연동을위한 JS -->
<script src="<spring:eval expression="@bizConfig['aboutpet.sgr.url']" />/web/runInit/v1.js"></script>
<script type="text/javascript">
	//검색API 클릭 이벤트(사용자 액션 로그 수집)
	function userActionLog(contId, action, url, targetUrl){	
		var mbrNo = "${session.mbrNo}";
		if (mbrNo != "${frontConstants.NO_MEMBER_NO}") {
			$.ajax({
				type: 'POST'
				, url : "/common/sendSearchEngineEvent"
				, dataType: 'json'
				, data : {
					"logGb" : "ACTION"
					, "mbr_no" : mbrNo
					, "section" : "shop" 
					, "content_id" : contId
					, "action" : action
					, "url" : (url != null && url) != '' ? url : document.location.href
					, "targetUrl" : (targetUrl != null && targetUrl != '') ? targetUrl : document.location.href
					, "litd" : ""
					, "lttd" : ""
					, "prclAddr" : ""
					, "roadAddr" : ""
					, "postNoNew" : ""
					, "timestamp" : ""
				}
			});
		}
	}
</script>
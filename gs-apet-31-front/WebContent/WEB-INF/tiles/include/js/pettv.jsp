<c:if test="${fn:indexOf(session.reqUri, '/tv/school/indexTvComplete') == -1 && fn:indexOf(session.reqUri, '/tv/petTvList') == -1}">
<script src="<spring:eval expression="@bizConfig['vod.player.api.url']" />/iframe_api/v1.js"></script>	
</c:if>
<c:if test="${fn:indexOf(session.reqUri, '/tv/school/indexTvDetail') == -1 && fn:indexOf(session.reqUri, '/tv/series/indexTvDetail') == -1}">
<script src="<spring:eval expression="@bizConfig['vod.player.api.url']" />/thumb_api/v1.js"></script>
</c:if>
<script type="text/javascript">
//검색API 클릭 이벤트(사용자 액션 로그 수집)
function userActionLog(vdId, action){
	var mbrNo = "${session.mbrNo}";
	if (mbrNo != "${frontConstants.NO_MEMBER_NO}") {
		var agent;
		if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
			agent = "APP_" + jscd.typeOs;
			
			// 위치정보 약관동의 여부
			var headerPstInfoAgrYn = "N";
			<c:if test="${session != null and session.pstInfoAgrYn == 'Y'}">
				headerPstInfoAgrYn = "Y";
			</c:if>
			
			// APP ibricks Interface
			var data = {
				"mbr_no" : mbrNo
				, "section" : "tv"
				, "content_id" : vdId
				, "action" : action
				, "url" : document.location.href
				, "target_url" : document.location.href
				, "agent" : agent
				, "prclAddr" : ""
				, "roadAddr" : ""
				, "postNoNew" : ""
				, "timestamp" : ""
				, "pstInfoAgrYn" : headerPstInfoAgrYn
			};
			toNativeData.func = "onIbrixClick";
			toNativeData.parameters = JSON.stringify(data);
			toNative(toNativeData);
		}else{
			agent = "WEB_" + jscd.typeOs;
			
			$.ajax({
				type: 'POST'
				, url : "/common/sendSearchEngineEvent"
				, dataType: 'json'
				, data : {
					"logGb" : "ACTION"
					, "mbr_no" : mbrNo
					, "section" : "tv" 
					, "content_id" : vdId
					, "action" : action
					, "url" : document.location.href
					, "targetUrl" : document.location.href
					, "agent" : agent
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
}
</script>
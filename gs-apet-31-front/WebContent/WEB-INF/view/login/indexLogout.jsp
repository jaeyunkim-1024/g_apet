<tiles:insertDefinition name="default">
<tiles:putAttribute name="content">
<script>
	
	if('${view.deviceGb}' == 'APP'){
		toNativeData.func = 'onLogout';
		toNative(toNativeData);
		
		var options = {
			url : "<spring:url value='deleteMemberTokenInfo' />",
			data : {orgMbrNo : "${orgMbrNo}" },
			done : function(data){
				if('${returnUrl}' != ""){
					location.href = '${returnUrl}';
				}else{
					location.href="/shop/home/";
				}
			}
		};
		ajax.call(options);
	}else{
		if('${returnUrl}' != ""){
			location.href = '${returnUrl}';
		}else{
			location.href="/shop/home/";
		}
	}
	
</script>

</tiles:putAttribute>
</tiles:insertDefinition>
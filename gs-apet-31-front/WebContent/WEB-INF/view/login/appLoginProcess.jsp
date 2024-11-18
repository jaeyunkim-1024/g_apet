<tiles:insertDefinition name="default">
<tiles:putAttribute name="content">
<script>
	$(function() {
		storageHist.replaceHist();
	});
	
	//로그인 app interface 호출 
	if('${view.deviceGb}' == 'APP'){
		toNativeData.func = 'onLogin';
		toNative(toNativeData);
		
		toNativeData.func = 'onFirstLaunch';
		toNativeData.callback= 'firstLaunchCallback';
		toNative(toNativeData);
	}else{
		//google analytics 호출
		if("${loginPathCd}" != ""){
			login_data.method = "${loginPathCd}";
			sendGtag('login');
		}
		
		setReturnUrl();
	}
	
	//최초 로그인 여부 체크하여 메인페이지 설정
	function firstLaunchCallback(jsonData){
		var jdata = JSON.parse(jsonData);
		if(jdata.firstLaunch == "Y" && '${view.deviceGb}' == 'APP'){
			//실행
			var options = {
				url : "/setMainPathInApp",
				done : function(data){
					if(data != "F") {
						toNativeData.func = "onMainPage";
						toNativeData.type = data
						toNative(toNativeData);
						
						setReturnUrl();
					}
				}
			};
			ajax.call(options); 
		}else{
			setReturnUrl();
		}
	}
	
	function setReturnUrl(){
		if('${returnUrl}' != ""){
			var returnUrl = '${returnUrl}';
			returnUrl = returnUrl.replace(/&amp;/gi, "&");
			
			//App이고 영상상세에서 진입시 onNewPage 호출로 수정
			if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true" && returnUrl.indexOf("/tv/series/indexTvDetail") > -1){
				var reUrl;
				if(decodeReUrl.indexOf("http") == -1){
					reUrl = "${view.stDomain}"+decodeReUrl;
				}else{
					reUrl = decodeReUrl;
				}
				// 데이터 세팅
				toNativeData.func = "onNewPage";
				toNativeData.type = "TV";
				toNativeData.url = reUrl;
				// 호출
				toNative(toNativeData);
				
				history.go(-1);
			}else{
				location.href = returnUrl;
			}
		 }else{
			location.href="/shop/home/";
		} 
	}
</script>

</tiles:putAttribute>
</tiles:insertDefinition>
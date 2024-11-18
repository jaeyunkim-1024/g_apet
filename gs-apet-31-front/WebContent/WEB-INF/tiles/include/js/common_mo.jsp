<script type="text/javascript">
	//ipad check logic
	function ipadCheck(){
		const iPad = (navigator.userAgent.match(/(iPad)/) /* iOS pre 13 */ ||  (navigator.platform === 'MacIntel' && navigator.maxTouchPoints > 1) /* iPad OS 13 */);
		if(iPad){
			$.setCookie("DEVICE_GB", "MO" , 24 );
			window.location.reload();
		}
	}
		
	// scalable No
	$.scalableN = function(){
		var viewportmeta = document.querySelector('meta[name="viewport"]');
	    viewportmeta.content = 'width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no';
	}
		
	// scalable Yes
	$.scalableY = function(){
		var viewportmeta = document.querySelector('meta[name="viewport"]');
	    viewportmeta.content = 'width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no';
	}
	
	// 쿠키 세팅하기
	$.setCookie = function(name, value, expirehours ) {
		var todayDate = new Date();
		todayDate.setHours( todayDate.getHours() + expirehours );
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";";
	}
	
	// 쿠키 불러오기
	$.getCookie = function(cookieName) {
	    cookieName = cookieName + '=';
	    var cookieData = document.cookie;
	    var start = cookieData.indexOf(cookieName);
	    var cookieValue = '';
	    if(start != -1){
	        start += cookieName.length;
	        var end = cookieData.indexOf(';', start);
	        if(end == -1)end = cookieData.length;
	        cookieValue = cookieData.substring(start, end);
	    }
	    return unescape(cookieValue);
	}
	
	$(function(){
		if(document.cookie.indexOf("DEVICE_GB") == -1){
			ipadCheck();
		} else {
			if("MO" == $.getCookie("DEVICE_GB")){
				$.scalableN();
			} else {
				$.scalableY();
			}
		}
	});
</script>
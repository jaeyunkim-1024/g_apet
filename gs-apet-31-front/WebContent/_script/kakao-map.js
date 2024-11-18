var kakaoMap ={
	keyword : function (keyword, callback, lat, lng){
		$(".body").append("<div id='map'></div>");
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(lat, lng) // 지도의 중심좌표	        
	    };  
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places();
		
		 // 검색 옵션 객체
	    var searchOption = {
	        location: new kakao.maps.LatLng(lat, lng)
	    };
		
		// 키워드로 장소를 검색합니다
		ps.keywordSearch(keyword, callback, searchOption);
	},
	location : function (callback, lat, lng) {
		$(".body").append("<div id='map'></div>");
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(lat, lng) // 지도의 중심좌표	        
	    };  
		var map = new kakao.maps.Map(mapContainer, mapOption);
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
			geocoder.coord2Address(lng, lat, callback);
	}
}
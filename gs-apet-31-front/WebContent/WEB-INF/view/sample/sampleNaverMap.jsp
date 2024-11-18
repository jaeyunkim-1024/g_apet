<%--	
 - Class Name	: /sample/sampleLogin.jsp
 - Description	: 네이버지도 생성 샘플 페이지
 - Since		: 2020.12.30
 - Author		: LDS
--%>

<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.inline">
	
		<script type="text/javascript">	
			$(document).ready(function(){
				fncCreateAddrMap("nMap", "서울특별시 강남구 역삼동 679-1");
				
				fncCreateCoordMap("nMap2", '37.4981823', '127.0264208');
			}); // End Ready
			
			//주소로 지도 생성
			function fncCreateAddrMap(id, addr){
				var options = {
						id : id //지도를 삽입할 HTML 요소 id
						, addr : addr //주소
						, zoom : 16 //줌 설정 0~22, 수치가 클수록 지도 확대(줌인), 이 옵션 생략시 기본값 16 (생략가능)
						, zoomControl : false //줌 컨트롤 표시 (기본값 표시안함, 생략가능)
						, mapTypeControl : false //일반ㆍ위성 지도보기 컨트롤 표시 (기본값 표시안함, 생략가능)
				};
				
				addrMap(options);
			}
			
			//좌표로 지도 생성
			function fncCreateCoordMap(id, lat, lng){
				var options = {
						id : id //지도를 삽입할 HTML 요소 id
						, lat : lat //위도
						, lng : lng //경도
						, zoom : 16 //줌 설정 0~22, 수치가 클수록 지도 확대(줌인), 이 옵션 생략시 기본값 16 (생략가능)
						, zoomControl : false //줌 컨트롤 표시 (기본값 표시안함, 생략가능)
						, mapTypeControl : false //일반ㆍ위성 지도보기 컨트롤 표시 (기본값 표시안함, 생략가능)
				};
				
				coordMap(options);
			}
			
			function fncGeocode(){
				/*
				 * 필요값 = 주소(필수값), 기준좌표-위도(선택값), 기준좌표-경도(선택값)
				 * 기준좌표가 입력되면 기준좌표에서 주소까지의 거리가 리턴.(distance)
				 * 참고 = https://apidocs.ncloud.com/ko/ai-naver/maps_geocoding/geocode/
				 */
				var options = {
					url : "<spring:url value='/common/searchNaverMapGoApi'/>"
					, data : {
						srchText:$("#srchText").val()/*,
						lat:$("#lat2").val(),
						lon:$("#lon2").val()*/
					}
					, done : function(result) {
						var resBody = JSON.parse(result.resBody);
						
						if(resBody.status != "OK"){
							alert("Error = " + resBody.errorMessage);
						}else{
							if(resBody.addresses.length > 0){
								var address = resBody.addresses;
								$("#goRoad").val(address[0].roadAddress + " / " + address[0].jibunAddress + " / " + "위도="+address[0].y+", 경도="+address[0].x); //도로명주소
							}else{
								alert("검색 결과값이 없습니다.");
							}
						}
					}
				};
				ajax.call(options);
			}
			
			function fncCoordToAddr(){
				/*
				 * 필요값 = 검색좌표-위도(필수값), 검색좌표-경도(필수값)
				 * 참고 = https://apidocs.ncloud.com/ko/ai-naver/maps_reverse_geocoding/gc/
				 */
				var options = {
					url : "<spring:url value='/common/searchNaverMapGcApi'/>"
					, data : {
						lat:$("#lat2").val(),
						lon:$("#lon2").val()
					}
					, done : function(result) {
						var resBody = JSON.parse(result.resBody);
						
						if(resBody.results != null){
							var roadAddr = resBody.results[3];
							
							$("#gcRoad").val(roadAddr.region.area1.name+" "+roadAddr.region.area2.name+" "+roadAddr.land.name+" "+roadAddr.land.number1);
						}else{
							alert("status code : " + resBody.status.code + " / " + resBody.status.message);
						}
						
					}
				};
				ajax.call(options);
			}
			
		</script>

	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<div id="content">
			<input type="text" id="srchText"/>
			<button type="button" onclick="fncGeocode();">주소상세 조회</button><br>
			<input type="text" id="goRoad" style="width:50%;" readonly="readonly"/><br>
			<input type="text" id="lat2"/>
			<input type="text" id="lon2"/>
			<button type="button" onclick="fncCoordToAddr();">좌표로 주소 조회</button><br>
			<input type="text" id="gcRoad" style="width:50%;" readonly="readonly"/>
			<div id="nMap" style="width:500px;height:500px;margin-top:20px;"></div>
			<div id="nMap2" style="width:500px;height:500px;margin-top:50px;"></div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>


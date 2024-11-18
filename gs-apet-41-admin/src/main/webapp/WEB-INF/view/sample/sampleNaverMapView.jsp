<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
				fncCreateAddrMap("nMap", "서울특별시 강남구 역삼동 679-1");
			});
			
			//좌표 지도생성 레이어팝업
			function fncCreateLayerCoordMap(id, lat, lng){
				$('#'+id).remove();
				var config = {
					id : id
					, width : 700
					, height : 500
					, title : "지도"
					, body : ''
					, button : ''
				}
				layer.create(config);
				
				var options = {
						id : id //지도를 삽입할 HTML 요소의 id
						, lat : lat //위도
						, lng : lng //경도
						, zoom : 17 //줌 설정
						, zoomControl : true //줌 컨트롤 표시
						, mapTypeControl : true //일반ㆍ위성 지도보기 컨트롤 표시
				};
				
				coordMap(options);
			}
			
			//주소로 지도생성
			function fncCreateAddrMap(id, addr){
				var options = {
						id : id //지도를 삽입할 HTML 요소 id
						, addr : addr //주소
						, zoom : 16 //줌 설정
						, zoomControl : false //줌 컨트롤 표시
						, mapTypeControl : false //일반ㆍ위성 지도보기 컨트롤 표시
				};
				
				addrMap(options);
			}
			
			//주소로 주소 상세정보 조회
			function fncGeocode(){
				/*
				 * 필요값 = 주소(필수값), 기준좌표-위도(선택값), 기준좌표-경도(선택값)
				 * 기준좌표가 입력되면 기준좌표에서 주소까지의 거리가 리턴.(distance)
				 * 참고 = https://apidocs.ncloud.com/ko/ai-naver/maps_geocoding/geocode/
				 */
				var options = {
					url : "<spring:url value='/common/searchNaverMapGoApi.do' />"
					, data : {
						srchText:$("#srchText3").val(),
						lat:$("#lat2").val(),
						lon:$("#lon2").val()
					}
					, callBack : function(result) {
						var resBody = JSON.parse(result.resBody);
						
						if(resBody.status != "OK"){
							messager.alert("검색 실패 : " + resBody.errorMessage, "Error", "error");
						}else{
							if(resBody.addresses.length > 0){
								var address = resBody.addresses;
								$("#goRoad").html(address[0].roadAddress); //도로명주소
								$("#goJibun").html(address[0].jibunAddress); //지번주소
								$("#goCoord").html("위도="+address[0].y+", 경도="+address[0].x); //좌표
							}else{
								messager.alert("검색 결과가 없습니다.", "Info", "info");
							}
						}
					}
				};
				ajax.call(options);
			}
			
			//좌표로 주소정보 조회
			function fncCoordToAddr(){
				/*
				 * 필요값 = 검색좌표-위도(필수값), 검색좌표-경도(필수값)
				 * 참고 = https://apidocs.ncloud.com/ko/ai-naver/maps_reverse_geocoding/gc/
				 */
				var options = {
					url : "<spring:url value='/common/searchNaverMapGcApi.do' />"
					, data : {
						lat:$("#lat3").val(),
						lon:$("#lon3").val()
					}
					, callBack : function(result) {
						var resBody = JSON.parse(result.resBody);
						
						if(resBody.results != null){
							var roadAddr = resBody.results[3];
							$("#gcRoad").html(roadAddr.region.area1.name+" "+roadAddr.region.area2.name+" "+roadAddr.land.name+" "+roadAddr.land.number1);
						}else{
							messager.alert(resBody.status.message, "Info", "info");
						}
					}
				};
				ajax.call(options);
			}
			
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="주소로 주소의 상세정보 및 좌표->주소 조회" style="padding:10px">
				<p> - 주소로 주소의 상세정보 조회 <br>
					<input type="text" id="srchText3" placeholder="주소(필수값)"/>
					<input type="text" id="lat2" placeholder="기준좌표-위도"/>
					<input type="text" id="lon2" placeholder="기준좌표-경도"/>
					<button type="button" onclick="fncGeocode();" class="btn">geocode</button>
				</p>
				<p>
					- 결과 <br>
					<table class="table_type1">
						<tbody>
							<tr>
								<th>도로명</th>
								<td id="goRoad">
								</td>
							</tr>
							<tr>
								<th>지번</th>
								<td id="goJibun">
								</td>
							</tr>
							<tr>
								<th>좌표</th>
								<td id="goCoord">
								</td>
							</tr>
						</tbody>
					</table>
				</p>
				<p> - 좌표로 주소 조회 <br>
					<input type="text" id="lat3" placeholder="위도(필수값)"/>
					<input type="text" id="lon3" placeholder="경도(필수값)"/>
					<button type="button" onclick="fncCoordToAddr();" class="btn">reverse_geocode</button>
				</p>
				<p>
					- 결과 <br>
					<table class="table_type1">
						<tbody>
							<tr>
								<th>주소</th>
								<td id="gcRoad">
								</td>
							</tr>
						</tbody>
					</table>
				</p>
			</div>
		</div>
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="Naver Map 생성 안내" style="padding:10px">
				<p> - 좌표로 지도생성 : coordMap(options) </p>
				<p> - 주소로 지도생성 : addrMap(options) </p>
				<p> - options 설명 <br>
					&nbsp;&nbsp;id : 지도를 삽입할 HTML 요소의 id(필수값) <br>
					&nbsp;&nbsp;lat : 검색할 위도 (좌표일때 필수값) <br>
					&nbsp;&nbsp;lng : 검색할 경도 (좌표일때 필수값) <br>
					&nbsp;&nbsp;addr : 검색할 주소 (주소일때 필수값) <br>
					&nbsp;&nbsp;zoom : 줌 설정 (0~22, 수치가 클수록 지도 확대(줌인), 이 옵션 생략시 기본값 16 (생략가능)) <br>
					&nbsp;&nbsp;zoomControl : 줌 컨트롤 표시 (기본값 표시안함, 생략가능) <br>
					&nbsp;&nbsp;mapTypeControl : 일반ㆍ위성 지도보기 컨트롤 표시 (기본값 표시안함, 생략가능)
				</p>
				<p>	- 예시 <br>
					<button type="button" onclick="fncCreateLayerCoordMap('mapLayer', '37.4981823', '127.0264208');" class="btn btn-add">좌표 지도팝업</button>
					<div id="nMap" style="width:400px;height:200px;"></div>
				</p>
			</div>
		</div>
	</t:putAttribute>
</t:insertDefinition>
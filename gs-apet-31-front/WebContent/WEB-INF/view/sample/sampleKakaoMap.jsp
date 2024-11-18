<%--	
   - Class Name	: /sample/sampleKakaoMap.jsp
   - Description: 카카오맵 샘플 화면
   - Since		: 2021.02.17
   - Author		: KKB
   --%>
<tiles:insertDefinition name="default">
	<tiles:putAttribute name="content">
      <style type="text/css">
          table {
		    border: 1px solid #ecedef;
		    border-collapse: collapse;
		  }
		  th, td {
		    border: 1px solid #ecedef;
		    padding: 10px;
		  }
      </style>
      <script type="text/javascript">
		$(document).ready(function(){
			
		});
		
		function callFunc(funcNm) {
			if(funcNm =='keyword'){
				let keyword = $(".key .keyword").val();
				let callback = window[$(".key .callbackFncNm").val()];
				let lat = $(".key .lat").val();
				let lng = $(".key .lng").val();
				kakaoMap.keyword(keyword, callback, lat, lng);
			}else if("location"){ debugger;
				let callback = window[$(".loc .callbackFncNm").val()];
				let lat = $(".loc .lat").val();
				let lng = $(".loc .lng").val();
				kakaoMap.location(callback, lat, lng);
			}
		}
		
		function test1CallBack(data, status, pagination){
			if (status === kakao.maps.services.Status.OK) {
				alert(JSON.stringify(data));
		    }
		}
		
		function test2CallBack(result, status){
			if (status === kakao.maps.services.Status.OK) {
				alert(JSON.stringify(result));
		    }
		}
      </script>
      <main class="container page" id="container">
         <div class="inr">
            <!-- 본문 -->
            <div class="contents" id="contents">
               	<br/>
               	<!-- S: 카카오맵 -->
               	<div class="pageHeadPc">
					<div class="hdt">
						<h3 class="tit">[ 카카오맵 ]</h3>
					</div>
					<br/>
				</div>
				<p>- /gs-apet-31-front/WebContent/_script/kakao-map.js</p>
				<p>- 키워드로 장소검색하기 함수 : kakaoMap.keyword(keyword, callback, lat, lng);</p>
				<p>- 좌표로 주소를 얻어내기 함수 : kakaoMap.location(callback, lat, lng);</p>
				<table style="border: #ecedef solid 1px; border-collapse: collapse;">
					<caption>카카오맵</caption>
					<colgroup>
						<col>
						<col>
						<col>
						<col style="text-align: center;">
					</colgroup>
					<tr>
						<th colspan="2">구 분</th>
						<th>입 력</th>
						<th>확 인</th>
					</tr>
					<tr class="key">
						<th rowspan="3">키워드로 장소검색하기</th>
						<th>키워드</th>
						<td>
							<input class="keyword" type="text" placeholder="키워드">
						</td>
						<td rowspan="3">
							<button onclick="callFunc('keyword');" class="btn sm b">키워드 검색</button>
						</td>
					</tr>
					<tr class="key">
						<th>콜백함수명</th>
						<td>
							<input class="callbackFncNm" type="text" placeholder="callback 함수명" value="test1CallBack">
						</td>
					</tr>
					<tr class="key">
						<th>기준 좌표</th>
						<td>
							<input class="lat" type="text" placeholder="위도">
							<input class="lng" type="text" placeholder="경도">
						</td>
					</tr>
					<tr class="loc">
						<th rowspan="3">좌표로 주소를 얻어내기</th>
						<th>좌표</th>
						<td>
							<input class="lat" type="text" placeholder="위도">
							<input class="lng" type="text" placeholder="경도">
						</td>
						<td rowspan="3">
							<button onclick="callFunc('location');" class="btn sm b">좌표 검색</button>
						</td>
					</tr>
					</tr>
					<tr class="loc">
						<th>콜백함수명</th>
						<td>
							<input class="callbackFncNm" type="text" placeholder="callback 함수명" value="test2CallBack">
						</td>
					</tr>

				</table>
			 	<!-- E: 카카오맵 -->
            </div>
         </div>
      </main>
   </tiles:putAttribute>
</tiles:insertDefinition>
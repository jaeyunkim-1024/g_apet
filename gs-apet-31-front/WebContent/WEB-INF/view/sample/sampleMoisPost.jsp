<%--	
 - Class Name	: /sample/sampleLogin.jsp
 - Description	: 네이버지도 생성 샘플 페이지
 - Since		: 2020.12.30
 - Author		: LDS
--%>

<tiles:insertDefinition name="common">
	<tiles:putAttribute name="script.inline">
		<style type="text/css">
	        .btn {
	            border: 2px solid black;
	            margin: 3px;
	            background-color: gray;
	            color: black;
	            padding: 7px 28px;
	            font-size: 12px;
	            cursor: pointer;
	            border-color: #e7e7e7;
	            color: black;
	        }
	    </style>
    
		<script type="text/javascript">	
			$(document).ready(function(){
				
			}); // End Ready
			
			function fnPopup(callBack){
				window.open("/post/popupMoisPost?callBackFnc="+callBack, "postPopup", "width=500, heigth=500");
			}
			
			function fnJusoCallBack(result){
				$("#zipNo").val(result.zonecode);
				$("#roadAddr").val(result.roadAddress);
				$("#roadDetail").val(result.addrDetail);
			}
			
			function fnJusoCallBack1(result){
				$("#zipNo1").val(result.zonecode);
				$("#roadAddr1").val(result.roadAddress);
				$("#roadDetail1").val(result.addrDetail);
			}
			
			//우편번호 목록 조회 콜백함수
			function fncPostListCallBack(result){
				var html = "";
				
				$(result.juso).each(function(){
					html += "<tr>";
					html += "	<td>("+this.zonecode+") "+this.roadAddress+"</td>";
					html += "</tr>";
				});
				
				$("#rsltPost").html(html);
			}
		</script>

	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<div id="content">
			- 우편번호 조회 결과값 <br>
			&nbsp;&nbsp;zonecode 			/*우편번호 [06141]*/ <br>
			&nbsp;&nbsp;roadAddress 		/*도로명주소 [서울특별시 강남구 논현로 508 (역삼동)]*/ <br>
			&nbsp;&nbsp;roadAddressEnglish 	/*도로명주소(영문) [508, Nonhyeon-ro, Gangnam-gu, Seoul]*/ <br>
			&nbsp;&nbsp;jibunAddress 		/*지번주소 [서울특별시 강남구 역삼동 679 GS강남타워]*/ <br>
			&nbsp;&nbsp;addrDetail 			/*고객입력 상세주소 [지하1층]*/ <br>
			
			<%--/*참고*/ <br>
			&nbsp;&nbsp;roadAddrPart1 		/*도로명주소(참고주소 제외) [서울특별시 강남구 논현로 508]*/ <br>
			&nbsp;&nbsp;roadAddrPart2 		/*참고주소 [(역삼동)]*/ <br>
			&nbsp;&nbsp;admCd				/*행정구역코드 [1168010100]*/ <br>
			&nbsp;&nbsp;rnMgtSn				/*도로명코드 [116803121022]*/ <br>
			&nbsp;&nbsp;bdMgtSn				/*건물관리번호 [1168010100106790001026822]*/ <br>
			&nbsp;&nbsp;detBdNmList			/*상세건물명 []*/ <br>
			&nbsp;&nbsp;bdNm				/*건물명 [GS강남타워]*/ <br>
			&nbsp;&nbsp;bdKdcd				/*공동주택여부(1 : 공동주택, 0 : 비공동주택) [0]*/ <br>
			&nbsp;&nbsp;siNm				/*시도명 [서울특별시]*/ <br>
			&nbsp;&nbsp;sggNm				/*시군구명 [강남구]*/ <br>
			&nbsp;&nbsp;emdNm				/*읍면동명 [역삼동]*/ <br>
			&nbsp;&nbsp;liNm				/*법정리명 []*/ <br>
			&nbsp;&nbsp;rn					/*도로명 [논현로]*/ <br>
			&nbsp;&nbsp;udrtYn				/*지하여부(0 : 지상, 1 : 지하) [0]*/ <br>
			&nbsp;&nbsp;buldMnnm			/*건물본번 [508]*/ <br>
			&nbsp;&nbsp;buldSlno			/*건물부번 [0]*/ <br>
			&nbsp;&nbsp;mtYn				/*산여부(0 : 대지, 1 : 산) [0]*/ <br>
			&nbsp;&nbsp;lnbrMnnm			/*지번본번(번지) [679]*/ <br>
			&nbsp;&nbsp;lnbrSlno			/*지번부번(호) [0]*/ <br>
			&nbsp;&nbsp;emdNo				/*읍면동일련번호 [01]*/ <br> --%>
			<br>
			<input type="text" id="zipNo" readonly="readonly"/>
			<button type="button" onclick="fnPopup('fnJusoCallBack');" style="left:20%;" class="btn">우편번호 검색 팝업</button><br>
			<input type="text" id="roadAddr" style="width:25%;"readonly="readonly"/>
			<input type="text" id="roadDetail" style="width:15%;"readonly="readonly"/>
			<br>
			<input type="text" id="zipNo1" readonly="readonly"/>
			<button type="button" onclick="fnPopup('fnJusoCallBack1');" style="left:20%;" class="btn">우편번호 검색 팝업</button><br>
			<input type="text" id="roadAddr1" style="width:25%;"readonly="readonly"/>
			<input type="text" id="roadDetail1" style="width:15%;"readonly="readonly"/>
			<br/><br/><br/>
			<input type="text" id="srchText"/>
			<button type="button" onclick="moisPostList('srchText', fncPostListCallBack)" class="btn">우편번호 목록 조회</button>
			<table>
				<tbody id="rsltPost">
				</tbody>
			</table>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>


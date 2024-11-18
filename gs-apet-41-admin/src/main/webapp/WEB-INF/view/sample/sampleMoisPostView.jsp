<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			$(document).ready(function(){
			
			});
			
			//우편번호 검색 팝업 결과값
			function fnPostCallBack(result){
				$("#postNoNew").val(result.zonecode);
				$("#roadAddr").val(result.roadAddress);
				$("#roadDtlAddr").val(result.addrDetail);
			}
			
			//우편번호 검색 팝업 결과값
			function fnPostCallBack1(result){
				$("#postNoNew1").val(result.zonecode);
				$("#roadAddr1").val(result.roadAddress);
				$("#roadDtlAddr1").val(result.addrDetail);
			}
			
			//우편번호 목록 검색 결과값
			function fncSrchPostListCallBack(result){
				var html = "";
				
				$(result.juso).each(function(){
					html += "<tr>";
					html += "	<td>("+this.zonecode+") "+this.roadAddress+"</td>";
					html += "</tr>";
				});
				
				$("#rsltPost").html(html);
			}

		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="행정안전부 우편번호 검색" style="padding:10px">
				<p> - 검색 <br>
					<table class="table_type1">
						<tbody>
							<tr>
								<th>검색</th>
								<td>
									<input type="text" name="srchText" id="srchText"/>
									<button type="button" onclick="moisPostList('srchText', fncSrchPostListCallBack);" class="btn">우편번호 검색</button>
								</td>
							</tr>
						</tbody>
					</table>
					<br>
					- 결과 <br>
					<table class="table_type1">
						<tbody id="rsltPost">
						</tbody>
					</table>
				</p>
			</div>
		</div>
		<br/>
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="행정안전부 우편번호 팝업" style="padding:10px">
				<p> - 우편번호  조회 결과값 <br>
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
					
					<%--
					&nbsp;&nbsp;roadAddr 		/*전체 도로명주소 [서울특별시 강남구 논현로 508 (역삼동)]*/ <br>
					&nbsp;&nbsp;roadAddrPart1 	/*도로명주소(참고항목 제외) [서울특별시 강남구 논현로 508]*/ <br>
					&nbsp;&nbsp;roadAddrPart2 	/*도로명주소 참고항목 [(역삼동)]*/ <br>
					&nbsp;&nbsp;addrDetail 		/*고객 입력 상세 주소 [지하1층]*/ <br>
					&nbsp;&nbsp;engAddr			/*도로명주소(영문) [508, Nonhyeon-ro, Gangnam-gu, Seoul]*/ <br>
					&nbsp;&nbsp;jibunAddr		/*지번주소 [서울특별시 강남구 역삼동 679 GS강남타워]*/ <br>
					&nbsp;&nbsp;zipNo			/*우편번호 [06141]*/ <br>
					&nbsp;&nbsp;admCd			/*행정구역코드 [1168010100]*/ <br>
					&nbsp;&nbsp;rnMgtSn			/*도로명코드 [116803121022]*/ <br>
					&nbsp;&nbsp;bdMgtSn			/*건물관리번호 [1168010100106790001026822]*/ <br>
					&nbsp;&nbsp;detBdNmList		/*상세건물명 []*/ <br>
					&nbsp;&nbsp;bdNm			/*건물명 [GS강남타워]*/ <br>
					&nbsp;&nbsp;bdKdcd			/*공동주택여부(1 : 공동주택, 0 : 비공동주택) [0]*/ <br>
					&nbsp;&nbsp;siNm			/*시도명 [서울특별시]*/ <br>
					&nbsp;&nbsp;sggNm			/*시군구명 [강남구]*/ <br>
					&nbsp;&nbsp;emdNm			/*읍면동명 [역삼동]*/ <br>
					&nbsp;&nbsp;liNm			/*법정리명 []*/ <br>
					&nbsp;&nbsp;rn				/*도로명 [논현로]*/ <br>
					&nbsp;&nbsp;udrtYn			/*지하여부(0 : 지상, 1 : 지하) [0]*/ <br>
					&nbsp;&nbsp;buldMnnm		/*건물본번 [508]*/ <br>
					&nbsp;&nbsp;buldSlno		/*건물부번 [0]*/ <br>
					&nbsp;&nbsp;mtYn			/*산여부(0 : 대지, 1 : 산) [0]*/ <br>
					&nbsp;&nbsp;lnbrMnnm		/*지번본번(번지) [679]*/ <br>
					&nbsp;&nbsp;lnbrSlno		/*지번부번(호) [0]*/ <br>
					&nbsp;&nbsp;emdNo			/*읍면동일련번호 [01]*/ <br> --%>
				</p>
				
				<p>	- 예시 <br>
					<table class="table_type1">
						<tbody>
							<tr>
								<th>주소1</th>
								<td>
									<div class="mg5">
										<input type="text" class="readonly" name="postNoNew" id="postNoNew" title="<spring:message code="column.post_no_new"/>" readonly="readonly" />
										<button type="button" onclick="layerMoisPost.create(fnPostCallBack);" class="btn"><spring:message code="column.common.post.btn"/></button>
									</div>
									<div class="mg5">
										<input type="text" class="readonly w300" name="roadAddr" id="roadAddr" title="<spring:message code="column.road_addr"/>" readonly="readonly" />
					                    <input type="text" class="readonly" name="w200 roadDtlAddr" id="roadDtlAddr" title="<spring:message code="column.road_dtl_addr"/>" readonly="readonly"/>
				                    </div>
								</td>
							</tr>
							<tr>
								<th>주소2</th>
								<td>
									<div class="mg5">
										<input type="text" class="readonly" name="postNoNew1" id="postNoNew1" title="<spring:message code="column.post_no_new"/>" readonly="readonly" />
										<button type="button" onclick="layerMoisPost.create(fnPostCallBack1);" class="btn"><spring:message code="column.common.post.btn"/></button>
									</div>
									<div class="mg5">
										<input type="text" class="readonly w300" name="roadAddr1" id="roadAddr1" title="<spring:message code="column.road_addr"/>" readonly="readonly" />
					                    <input type="text" class="readonly" name="w200 roadDtlAddr1" id="roadDtlAddr1" title="<spring:message code="column.road_dtl_addr"/>" readonly="readonly"/>
				                    </div>
								</td>
							</tr>
						</tbody>
					</table>
				</p>
			</div>
		</div>
	</t:putAttribute>
</t:insertDefinition>
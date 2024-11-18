<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {
			createBrandCntsGrid ();
		});

		function searchBrandCntsList () {
			var options = {
				searchParam : $("#brandCntsListForm").serializeJson()
			};
			grid.reload("brandCntsList", options);
		}

		function searchReset () {
			resetForm ("brandCntsListForm" );
		}

		function createBrandCntsGrid () {
			// brandCntsList
			var gridOptions = {
				url : "<spring:url value='/brandCnts/brandCntsGrid.do' />"
				, height : 400
				, searchParam : $("#brandCntsListForm").serializeJson()
				, colModels : [
					{name:"bndCntsNo", label:"<spring:message code='column.bnd_cnts_no' />", width:"105", key: true, align:"center"} /* 브랜드 콘텐츠 번호 */
					, {name:"bndNo", label:"<b><u><tt><spring:message code='column.bnd_no' /></tt></u></b>", width:"80", align:"center", classes:'pointer fontbold'} /* 브랜드 번호 */
					, _GRID_COLUMNS.bndNmKo
					, {name:"bndNmEn", label:"<spring:message code='column.bnd_nm_en' />", width:"150", align:"center", sortable:false } /* 브랜드 영문 */
					// 콘텐츠 구분 코드
 					, {name:"cntsGbCd", label:'<spring:message code="column.cnts_gb_cd" />', width:"120", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.CNTS_GB }' showValue='false' />" } } 
 					// 타이틀
 					, {name:"cntsTtl", label:'<spring:message code="column.cnts_ttl" />', width:"200", align:"center"}
 					// 설명
 					//, {name:"cntsDscrt", label:'<spring:message code="column.dscrt" />', width:"200", align:"center"}
 					// 콘텐츠 이미지 경로
 					, {name:"cntsImgPath", label:'<spring:message code="column.cnts_img_path" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
 							if(rowObject.cntsImgPath != "") {
 								return '<img src="<frame:imgUrl />' + rowObject.cntsImgPath + '" style="width:100px; height:100px;" alt="' + rowObject.cntsImgPath + '" />';
 							} else {
 								return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
 							}
 						}
 					}
 					// 콘텐츠 모바일 이미지 경로
 					, {name:"cntsMoImgPath", label:'<spring:message code="column.cnts_mo_img_path" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
 							if(rowObject.cntsMoImgPath != "") {
 								return '<img src="<frame:imgUrl />' + rowObject.cntsMoImgPath + '" style="width:100px; height:100px;" alt="' + rowObject.cntsMoImgPath + '" />';
 							} else {
 								return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
 							}
 						}
 					}
 					// 썸네일 이미지 경로
 					, {name:"tnImgPath", label:'<spring:message code="column.tn_img_path" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
 							if(rowObject.tnImgPath != "") {
 								return '<img src="<frame:imgUrl />' + rowObject.tnImgPath + '" style="width:100px; height:100px;" alt="' + rowObject.tnImgPath + '" />';
 							} else {
 								return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
 							}
 						}
 					}
 					// 썸네일 모바일 이미지 경로
 					, {name:"tnMoImgPath", label:'<spring:message code="column.tn_mo_img_path" />', width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
 							if(rowObject.tnMoImgPath != "") {
 								return '<img src="<frame:imgUrl />' + rowObject.tnMoImgPath + '" style="width:100px; height:100px;" alt="' + rowObject.tnMoImgPath + '" />';
 							} else {
 								return '<img src="/images/noimage.png" style="width:100px; height:100px;" alt="NoImage" />';
 							}
 						}
 					}
 					, _GRID_COLUMNS.sysRegrNm
 					, _GRID_COLUMNS.sysRegDtm
 					, _GRID_COLUMNS.sysUpdrNm
 					, _GRID_COLUMNS.sysUpdDtm
	            ]
				, onSelectRow : function(ids) {
					var rowdata = $("#brandCntsList").getRowData(ids);
					brandCntsView(rowdata.bndCntsNo);
				}
			}
			grid.create("brandCntsList", gridOptions);
		}
		
		function brandCntsView (bndCntsNo) {
			var url = '/brandCnts/brandCntsView.do?bndCntsNo=' + bndCntsNo;
			if (bndCntsNo == '') 
				addTab('브랜드 콘텐츠 등록', url);
			else
				addTab('브랜드 콘텐츠 상세', url);
		}

		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form id="brandCntsListForm" name="brandCntsListForm" method="post" >
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.bnd_cnts_no" /></th>
								<td>
									<input type="text" name="bndCntsNo" id="bndCntsNo" title="<spring:message code="column.bnd_cnts_no" />" >
								</td>
								<th scope="row"><spring:message code="column.cnts_ttl" /></th>
								<td>
									<input type="text" name="cntsTtl" id="cntsTtl" title="<spring:message code="column.cnts_ttl" />" >
								</td>					
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.bnd_no" /></th>
								<td>
									<input type="text" name="bndNo" id="bndNo" title="<spring:message code="column.bnd_no" />" >
								</td>
								<th scope="row"><spring:message code="column.bnd_nm" /></th>
								<td>
									<input type="text" name="bndNm" id="bndNm" title="<spring:message code="column.bnd_nm" />" >
								</td>					
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.cnts_gb_cd" /></th>	<!-- 상품 상태 -->
								<td colspan="3">
									<select id="cntsGbCd" name="cntsGbCd" >
										<frame:select grpCd="${adminConstants.CNTS_GB }" defaultName="선택" showValue="false" />
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<div class="btn_area_center">
					<button type="button" onclick="searchBrandCntsList();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>				

		<div class="mModule">
			<button type="button" onclick="brandCntsView('');" class="btn btn-add">브랜드 콘텐츠 등록</button>
			
			<table id="brandCntsList" ></table>
			<div id="brandCntsListPage"></div>
		</div>

	</t:putAttribute>

</t:insertDefinition>
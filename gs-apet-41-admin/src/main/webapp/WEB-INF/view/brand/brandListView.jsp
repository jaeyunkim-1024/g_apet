<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {

			createBrandGrid ();
			/**
			 * 키 엔터
			 */
			$('#bndNoArea, #bndNmArea').on('keydown', function(event) {

				if (event.keyCode == 13) {
					if (!event.ctrlKey ){ //|| !event.metaKey
						event.preventDefault();
						console.log('enter key')
						searchBrandList();
					} else {
						console.log('ctrl + enter key')
						var start = this.selectionStart;
						var end = this.selectionEnd;
						this.value = this.value.substring(0, end) + '\r\n' + this.value.substring(end);
						this.selectionEnd = end;
						this.selectionStart = this.selectionEnd = start + 1;
					}
				}
			});
		});

		// 업체 검색
		function searchCompany () {
			var options = {
				multiselect : false
				, callBack : searchCompanyCallback
			}
			layerCompanyList.create (options );
		}
		function searchCompanyCallback (compList ) {
			if(compList.length > 0 ) {
				$("#brandListForm #compNo").val (compList[0].compNo );
				$("#brandListForm #compNm").val (compList[0].compNm );
			}
		}
		
		// 사이트 검색
		function searchSt () {
			var options = {
				multiselect : false
				, callBack : searchStCallback
			}
			layerStList.create (options );
		}
		function searchStCallback (stList ) {
			if(stList.length > 0 ) {
				$("#stId").val (stList[0].stId );
				$("#stNm").val (stList[0].stNm );
			}
		}		

		function searchBrandList () {
			var options = {
				searchParam : $("#brandListForm").serializeJson()
			};
			grid.reload("brandList", options);
		}

		function searchReset () {
			resetForm ("brandListForm" );
		}

		// 브랜드 등록
		function registBrand () {
			addTab('브랜드 등록', "<spring:url value='/brand/brandInsertView.do' />");
		}

		// 브랜드 삭제
		function deleteBrand () {
			var grid = $("#brandList");
			var bndNos = new Array();

			var rowids = grid.jqGrid('getGridParam', 'selarrrow');
			if(rowids.length <= 0 ) {
				messager.alert("<spring:message code='column.common.delete.no_select' />", "Info", "info");
				return;
			}

			messager.confirm("<spring:message code='column.common.confirm.delete' />",function(r){
				if(r){
					for (var i = rowids.length - 1; i >= 0; i--) {
						bndNos.push (rowids[i] );
					}
	
					console.debug (bndNos );
					var options = {
						url : "<spring:url value='/brand/brandDelete.do' />"
						, data : {bndNos : bndNos }
						, callBack : function(data ) {
							messager.alert("<spring:message code='column.common.delete.final_msg' arguments='" + data.delCnt + "' />", "Info", "info", function(){
							searchBrandList ();
							});
						}
					};
					ajax.call(options);
				}
			});
		}

		function createBrandGrid () {
			// brandList
			var gridOptions = {
				url : "<spring:url value='/brand/brandBaseGrid.do' />"
				, height : 400
				, searchParam : $("#brandListForm").serializeJson()
				, colModels : [
					{name:"bndNo", label:"<b><u><tt><spring:message code='column.bnd_no' /></tt></u></b>", width:"120", key: true, align:"center", classes:'pointer fontbold'} /* 브랜드 번호 */
					, {name:'bndNmKo', label:'<spring:message code="column.bnd_nm" />', width:'250', align:'center'}	// 브랜드 명
					//, {name:"bndNmEn", label:"<spring:message code='column.bnd_nm_en' />", width:"200", align:"center"} /* 브랜드 영문 */
					//, {name:"bndGbCd", label:"<spring:message code='column.bnd_gb_cd' />", width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.BND_GB }' showValue='false' />" } } /* 브랜드 구분 */
					, _GRID_COLUMNS.useYn
					//, {name:"bndShowYn", label:" 브랜드 노출여부", width:"80", align:"center", sortable:false } /* 브랜드 노출여부 */
					//, {name:"bndTpCd", label:" 브랜드 유형", width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.BND_TP }' showValue='false' />" } } /* 브랜드 유형, 10:일반, 20:VECI */
					//, {name:"sortSeq", label:"<spring:message code='column.sort_seq' />", width:"100", align:"center", sortable:false, hidden:true } /* 정렬순서 */
					// , {name:"compNm", label:"<spring:message code='column.goods.comp_nm' />", width:"200", align:"center", sortable:false } /* 업체명 */
					// , {name:"compStatCd", label:"<spring:message code='column.comp_stat_cd' />", width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.COMP_STAT }' showValue='false' />" } } /* 사용여부 */
					, {name:'sysRegrNm', label:'<spring:message code="column.sys_regr_nm" />', width:'90', align:'center', sortable:false}	
					, {name:'sysRegDtm', label:'<spring:message code="column.sys_reg_dtm" />', width:'150', align:'center', formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
					, {name:'sysUpdrNm', label:'<spring:message code="column.sys_updr_nm" />', width:'90', align:'center', sortable:false}
					, {name:'sysUpdDtm', label:'<spring:message code="column.sys_upd_dtm" />', width:'150', align:'center', formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", sortable:false}
				]
				, multiselect : true
				, onCellSelect : function (id, cellidx, cellvalue) {
					if (cellidx != 0) {
						viewBrandDetail(id );
					}
				}
			}
			grid.create("brandList", gridOptions);
		}

		// 브랜드 상세
		function viewBrandDetail (bndNo ) {
			var url = '/brand/brandDetailView.do?bndNo=' + bndNo;
			addTab("<spring:message code='admin.web.view.app.brand.detail' />", url);
		}

		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form id="brandListForm" name="brandListForm" method="post" >
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID -->
								<td>
		                            <select id="stIdCombo" name="stId">
		                                <frame:stIdStSelect defaultName="사이트선택" />
		                            </select>
								</td>
								<th scope="row"><spring:message code="column.use_yn" /></th> <!-- 사용여부 -->
								<td>
									<frame:radio name="useYn" grpCd="${adminConstants.USE_YN }" defaultName="전체"/>
								</td>
								<!-- <th scope="row">브랜드 노출 여부</th>
								<td>
									<label class="fRadio"><input type="radio" id="bndShowYn" name="bndShowYn" title="전체" value="" checked="checked" /><span>전체</span></label>
									<label class="fRadio"><input type="radio" id="bndShowYn" name="bndShowYn" title="노출" value="Y" /><span>노출</span></label>
									<label class="fRadio"><input type="radio" id="bndShowYn" name="bndShowYn" title="미노출" value="N" /> <span>미노출</span></label>
								</td> -->
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.bnd_no" /></th> <!-- 브랜드 번호 -->
								<td>
									<textarea rows="3" cols="30" id="bndNoArea" name="bndNoArea" ></textarea>
								</td>
								<th scope="row"><spring:message code="column.bnd_nm" /></th> <!-- 브랜드 명 -->
								<td>
									<textarea rows="3" cols="30" id="bndNmArea" name="bndNmArea" ></textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</form>

				<div class="btn_area_center">
					<button type="button" onclick="searchBrandList();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

				<div class="mModule">
					<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
					<button type="button" onclick="registBrand();" class="btn btn-add">브랜드 등록</button>
					<button type="button" onclick="deleteBrand();" class="btn btn-add">삭제</button>
					</c:if>

					<table id="brandList" ></table>
					<div id="brandListPage"></div>
				</div>

	</t:putAttribute>

</t:insertDefinition>
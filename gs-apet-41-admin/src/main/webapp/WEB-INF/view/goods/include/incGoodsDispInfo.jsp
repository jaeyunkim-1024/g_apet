<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
// 전시 카테고리
function createDispCtgList () {
	var goodsId = "${goodsBase.goodsId }";
	var options = {
// 		url : "<spring:url value='/goods/dispCtgGrid.do' />"
		url : "<spring:url value='/goods/goodsCompDispMapListGrid.do' />"
		, searchParam : {goodsId : goodsId, compNo : $("#compNo").val() , stIds : $("#checkedCompStIds").val() }
		, paging : false
		, cellEdit : true
		, height : 150
		, colModels : [
			{name:"stId", label:"<spring:message code='column.st_id' />", width:"100", align:"center", hidden:true} /* 사이트 ID */
			, _GRID_COLUMNS.stNm
            , {name :"dispClsfCd", label:'분류코드',width:"100", align:"center",formatter:"select",editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.DISP_CLSF}' showValue='false' />"}}
            , {name:"dispClsfNo", label:'<spring:message code="column.disp_clsf_no" />', width:"100", align:"center", key: true, sortable:false } /* 전시분류 번호 */
            , {name:"dispClsfNm", label:'<spring:message code="column.disp_clsf_nm" />', width:"150", align:"center", sortable:false } /* 전시분류 명 */
            , {name:"ctgPath", label:'<spring:message code="column.display.disp_clsf.path" />', width:"300", align:"center", sortable:false } /* 대분류 */
            , {name:"dlgtDispYn", label:'<spring:message code="column.dlgt_disp_yn" />', width:"100", align:"center", formatter:'checkbox', editoptions: { value: "Y:N" }, formatoptions: { disabled: false}} /* 대표전시여부 */
            , {name:"goodsId", label:'', width:"100", align:"center", hidden:true, sortable:false } /* 상품 번호 */
            , {name:"upDispClsfNo", label:'', width:"100", align:"center", hidden:true, sortable:false } /* 상위 전시 번호 */
		]
		, multiselect : true
		, loadComplete : function(){
			// 전시 필터 목록 조회
			if("${goodsBase.goodsId }" !== ''){
				searchDispFilterList(true);
			}
		}
	};
	grid.create("dispCtgList", options);
}

//hjko 만든것. 전시카테고리 추가
function displayCategoryAddPop() {
	// 사이트 선택값
	var stIdVal = $("#stIdCombo option:selected").val();
	// 전시카테고리 선택값
	var dispClsfCdVal = $("#dispClsfCdCombo option:selected").val();
	var compNoVal = $("#compNo").val();

	if($("#compNo").val() == ""){
		messager.alert("<spring:message code='admin.web.view.app.goods.company.no_select' />", "Info", "info");
		$("#compNo").focus();
		return false;
	}
	if(stIdVal == ""){
		messager.alert("<spring:message code='admin.web.view.msg.invalid.site' />", "Info", "info");
		$("#stIdCombo").focus();
		return false;
	}
	if(dispClsfCdVal == ""){
		messager.alert("<spring:message code='admin.web.view.msg.invalid.dispclsfcd' />", "Info", "info", function(){
			$("#dispClsfCdCombo").focus();
		});
		return false;
	}

	var options = {
		multiselect : true
		, stId : stIdVal
		, dispClsfCd : dispClsfCdVal
		, compNo : compNoVal
		, filterGb : "G"
		, plugins : [ "themes" , "checkbox" ]
		, callBack : function(result) {
			
			if(result != null && result.length > 0) {
				var idx = $('#dispCtgList').getDataIDs();
				var message = new Array();
				for(var i in result){
					
					// 3dept check 추가
					if(result[i].dispLvl === 3){
						var addData = {
							  dispClsfNo : result[i].dispNo
							, dispClsfNm : result[i].dispNm
							, ctgPath : result[i].dispPath
							, stId : result[i].stId
							, stNm : $("select[name='stIdCombo']").find("option[value="+result[i].stId+"]").prop("title")
							, compNo : result[i].compNo
							, dispClsfCd: result[i].dispClsfCd
							, upDispClsfNo :result[i].upDispNo
						}
	
						var check = true;
						for(var j in idx) {
							if(addData.dispClsfNo == idx[j]) {
								check = false;
							}
						}
	
						if(check) {
							$("#dispCtgList").jqGrid('addRowData', result[i].dispNo, addData, 'last', null);
						} else {
							message.push(result[i].dispNm + "<spring:message code='admin.web.view.msg.common.dupl.displaycategory' />");
						}
					}else{
						message.push(result[i].dispNm + "<spring:message code='admin.web.view.msg.goods.displaycategory.3dept' />");
					}
				}
				if(message != null && message.length > 0) {
					messager.alert(message.join("<br/>"), "Info", "info");
				}
				
				// 전시 필터 목록 조회
				searchDispFilterList();
			}
		}
	}

	layerCategoryList.create(options);
}
//전시카테고리 대표전시여부 체크. hjko 추가
function dlgtDispYnCheck(){

	var grid = $("#dispCtgList");
	var ids = grid.jqGrid('getDataIDs'); //grid의 id 값을 배열로 가져옴
	var rowIds = null;
	var check = false;

	// 그리드 데이터 가져오기
	var gridData = grid.jqGrid('getRowData');
	var allArray = new Array();
	var ObjArray = new Array();

	if(gridData.length > 0){
		for (var i = 0; i < gridData.length; i++) {
			var curStNm = gridData[i].stNm;
			allArray.push(curStNm);

			$.each(allArray, function(index, element) {

		     	// 일치하는거 없으면 objarray 에 추가
		        //if ($.inArray(curStNm, allArray) == -1) {
		        if ($.inArray(curStNm, ObjArray) == -1) {
		        	ObjArray.push(element);
		        }
		    });

		}

		for (var j = 0; j < gridData.length; j++) {

				var st = gridData[j].stId;
				var dlgt = gridData[j].dlgtDispYn;
				var curStNm = gridData[j].stNm;

				// 중복제거
				if(dlgt=='Y'){
					ObjArray = jQuery.grep(ObjArray,function(value){
						return value !=  curStNm ;
					});
				}
		}
	}
	return ObjArray;
}

//전시카테고리 삭제
function displayCategoryDelDisp() {
	var rowids = $("#dispCtgList").jqGrid('getGridParam', 'selarrrow');
	var delRow = new Array();
	if(rowids != null && rowids.length > 0) {
		for(var i in rowids) {
			delRow.push(rowids[i]);
		}
	}
	if(delRow != null && delRow.length > 0) {
		for(var i in delRow) {
			$("#dispCtgList").delRowData(delRow[i]);
		}
		
		// 삭제 시 전시에 매핑된 태그 재조회
		messager.alert("<spring:message code='admin.web.view.msg.goods.invalidate.reSearch.filter' />", "Info", "info", function(){
			searchDispFilterList(); 
		});
	} else {
		messager.alert("<spring:message code='admin.web.view.msg.invalid.displaycategory' />", "Info", "info");
	}
}
</script>
	<div title="전시 정보" data-options="" style="padding:10px">
		<table class="table_type1">
			<caption>GOODS 등록</caption>
			<tbody>
				<tr>
					<th scope="row"><spring:message code="column.disp_ctg" /></th>	<!-- 전시카테고리 -->
					<td>
						<table>
							<colgroup>
								<col style="width:180px;">
								<col />
							</colgroup>
							<tr>
								<td style="vertical-align:top;">
									<div style="padding-bottom: 10px;">
										<select id="stIdCombo" name="stIdCombo">
											<frame:stIdStSelect defaultName="사이트선택" />
										</select>
									</div>
									<div style="padding-bottom: 10px;">
										<select id="dispClsfCdCombo" name="dispClsfCdCombo">
											<!--frame:select grpCd="${adminConstants.DISP_CLSF }" defaultName="전시분류" />-->
											<option value="${adminConstants.DISP_CLSF_10 }"  title="전시카테고리" selected >전시카테고리</option>
										</select>
									</div>
									<div style="padding-bottom: 10px;">
										<button type="button" class="w90 btn" onclick="displayCategoryAddPop();" ><spring:message code="column.common.addition" /></button>
									</div>
									<div style="padding-bottom: 10px;">
										<button type="button" class="w90 btn" onclick="displayCategoryDelDisp();" ><spring:message code="column.common.delete" /></button>
									</div>
								</td>
								<td style="vertical-align:top;">
									<div class="mModule no_m">
										<table id="dispCtgList"></table>
										<div id="dispCtgListPage"></div>
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<hr />
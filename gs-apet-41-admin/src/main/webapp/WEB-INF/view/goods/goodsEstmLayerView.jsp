<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
$(document).ready(function() {
    createDisplayCategory(1, "${adminConstants.DISP_CLSF_10 }" , "displayCategory", "${adminConstants.DISP_CLSF_10 }");
});

// 전시카테고리 검색조건
function fnChangeCategory(obj){
	var dispClsfNo = $(obj).val();
	
	$("#dispClsfNo").val(dispClsfNo);
	
	var cateDept = $(obj).data('dept');
	var cateNextDept = parseInt(cateDept) + 1;
	var catePrevDept = parseInt(cateDept) - 1;
	
	var displayCategory = $("#displayCategory" + cateDept).val();

	if (displayCategory == "") {
		$("#displayCategoryDispClsfNo").val($("#displayCategory" + cateNextDept).data('no'));
	} else {
		$("#displayCategoryDispClsfNo").val($("#displayCategory" + catePrevDept).data('no'));
		$("#displayCategory" + cateDept).data( "no" , displayCategory);
	}

	if(cateDept !== 3){
		createDisplayCategory(cateNextDept, displayCategory, "displayCategory", "${adminConstants.DISP_CLSF_10 }" );
		deleteAllGridRow('searchEstmList');
	}else{
		$("#goodsEstmForm #estmDispClsfNo").val($("#goodsEstmForm #displayCategory3").val());
		layerEstmList.searchEstmList();
	}
}

// 전시 카테고리 select 생성
function createDisplayCategory(dispLvl, upDispClsfNo, targetId, dispClsfCd, setData) {
	var selectedMsg = setData == null ? "selected='selected'" : "";
	var selectCategory = "<option value='' "+ selectedMsg +">"+"<spring:message code='column.selectData' />"+"</option>";

	if (dispLvl == 0) {
		$("#" + targetId + (dispLvl+1)).html("");
		$("#" + targetId + (dispLvl+1)).append(selectCategory);
		$("#"+ targetId  + "DispClsfNo").val("");
	} else {
		for(var i=3; i >= dispLvl; i--){
			if(dispLvl === i){
				$("#" + targetId  + (i)).html('');
				if(upDispClsfNo == '') {
					$("#" + targetId  + (i)).html(selectCategory);
				}
			}else{
				$("#" + targetId  + (i)).html(selectCategory);
			}
		}

		if (upDispClsfNo != "") {
			var stId = $("#stId").val();

			var options = {
				url : "<spring:url value='/display/listDisplayCategory.do' />"
				, data : {
					stId : stId
					, dispLvl : dispLvl
					, upDispClsfNo : upDispClsfNo
					, dispClsfCd : dispClsfCd
					, dispYn : "${adminConstants.COMM_YN_Y}"
					, estmYn : "${adminConstants.COMM_YN_Y}"
					, cfmYn : "${adminConstants.COMM_YN_Y}"
				}
				, callBack : function(result) {
					if (result.length > 0) {
	 					$(result).each(function(i){
	 						var selectedVal = setData == result[i].dispClsfNo ? "selected='selected'" : "";
	 						selectCategory += "<option value='" + result[i].dispClsfNo + "' "+ selectedVal  +">" + result[i].prmtShowNm + "</option>";
						});
					}
					$("#" + targetId + (dispLvl)).append(selectCategory);
				}
			};

			ajax.call(options);
		}
	}
}
</script>
	
	<form id="goodsEstmForm" name="goodsEstmForm" method="post" >
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<input type="hidden" name="dispClsfNo" id="estmDispClsfNo" value="" />
				<table class="table_type1">
					<caption><spring:message code='column.goods.estmGrp' /></caption>
					<colgroup>
						<col class="th-s" style="width:10%;" />
						<col style="width:50%;" />
						<col class="th-s" style="width:10%;" />
						<col style="width:30%;" />
					</colgroup>
					<tbody>
						<tr>
							<th><spring:message code="column.ctg_cd" /></th>
							<td colspan="3">
								<select class="displayCategorySelect" id="displayCategory1" data-dept="1" onchange="fnChangeCategory(this);" ></select>
							    <select class="displayCategorySelect" id="displayCategory2" data-dept="2" onchange="fnChangeCategory(this);" ></select>
							    <select class="displayCategorySelect" id="displayCategory3" data-dept="3" onchange="fnChangeCategory(this);" ></select>	
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="mModule">
			<table id="searchEstmList" class="grid"></table>
		</div>
	</form>
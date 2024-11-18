<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">
	var searchTagGroup1;
	var searchTagGroup2;
	var searchTagGroup3;
	$(document).ready(function() {
		layerTagBaseList.initTagBaseGrid();
	});
	$(document).on("keydown","#tagBaseSearchForm input",function(){
		if ( window.event.keyCode == 13 ) {
			layerTagBaseList.searchList('')
	  		}
    });
</script>

<form id="tagBaseSearchForm" name="tagBaseSearchForm" method="post" >
	<%--<input type="hidden" id="searchTagGrpNo" name="searchTagGrpNo" value="" />--%>
	<%--<input type="hidden" id="popYn" name="popYn" value="Y" />--%>
	<input type="hidden" id="tagGrpNo" name="tagGrpNo" value="" />
	
	<table class="table_type1">
		<caption>정보 검색</caption>
		<tbody>
			<tr>
				<th>Tag</th>
				<td>
					<input type="text" name="srchWord" id="srchWord" title="Tag" >
				</td>
				<th>Tag Group 선택</th>
				<!-- 태그 그룹 -->
				<td>
				    <select name="searchTagGroup1" id="searchTagGroup1" onchange="javascript:layerTagBaseList.searchTagGroup1Change();"></select>
				    <select name="searchTagGroup2" id="searchTagGroup2" onchange="javascript:layerTagBaseList.searchTagGroup2Change();" style="display: none;"></select>
				    <select name="searchTagGroup3" id="searchTagGroup3" onchange="javascript:layerTagBaseList.searchTagGroup3Change();" style="display: none;"></select>
				    <select name="searchTagGroup4" id="searchTagGroup4" onchange="javascript:layerTagBaseList.searchTagGroup4Change();" style="display: none;"></select>
				</td>
<!-- 				<th scope="row">상태</th> -->
<!-- 				상품 상태 -->
<!-- 				<td> -->
<!-- 					<select id="statCd" name="statCd"> -->
<%-- 					<frame:select grpCd="${adminConstants.TAG_STAT }" defaultName="전체" showValue="false" /> --%>
<!-- 					</select> -->
<!-- 				</td> -->
			</tr>
		</tbody>
	</table>
</form>

<div class="btn_area_center mb30">
	<button type="button" onclick="layerTagBaseList.searchList(''); ", id="searchTags" class="btn btn-ok">조회</button>
	<button type="button" onclick="layerTagBaseList.searchReset();" class="btn btn-cancel">초기화</button>
</div>
		
<div class="mModule">
	<table id="layerTagBaseList" ></table>
	<div id="layerTagBaseListPage"></div>
</div>

<div class="mt30" style="border: 1px solid black; min-height: 50px; max-height: 100px;overflow:auto;">
	<span id="addGoodsTags">
		<!-- 
		<span class="rcorners1 selectedTag  goodsTagNos" id="sel_T000060191" data-tag="T000060191">.강아지져키</span> 
		<img id="sel_T000060191Delete" onclick="layerTagBaseList.deleteTag('sel_T000060191','.강아지져키')" class="tagDeleteBtn" src="/images/icon-header-close.svg">
		-->
	</span>
</div>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
		$(document).ready(function() {
			createGoodsDescCommGrid ();
		});
		
		function createGoodsDescCommGrid () {
			var gridOptions = {
				url : "<spring:url value='/goods/goodsDescCommGrid.do' />"
				, height : 400
				, searchParam : $("#goodsDescCommListForm").serializeJson()
				, colModels : [
					{name:"commGoodsDscrtNo", label:"<b><u><tt><spring:message code='column.no' /></tt></u></b>", width:"80", key: true, align:"center", classes:'pointer fontbold'} /* 번호 */
					, {name:'stNm', label:'<spring:message code="column.st" />', width:'150', align:'center'}	// 사이트
					, {name:"svcGbCd", label:"<spring:message code='column.goods.svcGbCd' />", width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.WEB_MOBILE_GB }' showValue='false' />" } } /*  */
					, {name:"showAreaGbCd", label:"<spring:message code='column.goods.showAreaGbCd' />", width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.SHOW_AREA_GB }' showValue='false' />" } } /*  */
					, {name:'limitedDte', label:'<spring:message code="column.goods.limitedDate" />', width:'350', align:'center', sortable:false}
					, _GRID_COLUMNS.useYn
					, {name:"button", label:'<spring:message code="column.goods.manage"/>', width:"120", align:"center", sortable:false, formatter: function(rowId, val, rawObject, cm) {
		                var str = '<button type="button" onclick="fnGoodsDescCommDetailView(\'' + rawObject.commGoodsDscrtNo + '\')" class="btn_h25_type1"><spring:message code="column.goods.btn.detail"/></button>';
		                return str;
		            }}
				]
			}
			grid.create("goodsDescCommList", gridOptions);
		}

		function searchGoodsDescCommList () {
			
			var svcGbCds = new Array();
			$("[name='svcGb']:checked").each(function(){
				svcGbCds.push($(this).val());
			})
			$("#svcGbCds").val(svcGbCds);
			
			var options = {
				searchParam : $("#goodsDescCommListForm").serializeJson()
			};
			
			grid.reload("goodsDescCommList", options);
		}

		function searchReset () {
			resetForm ("goodsDescCommListForm" );
		}

		// 상품 설명 공통 등록
		function registGoodsDescComm () {
			addTab('상품 설명 공통 등록', "<spring:url value='/goods/goodsDescCommInsertView.do' />");
		}

		// 상품 설명 공통 상세
		function fnGoodsDescCommDetailView (commGoodsDscrtNo ) {
			var url = '/goods/goodsDescCommDeatilView.do?commGoodsDscrtNo=' + commGoodsDscrtNo;
			addTab("<spring:message code='column.goods.goodsDescComm.detail' />", url);
		}

		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form id="goodsDescCommListForm" name="goodsDescCommListForm" method="post" >
					<table class="table_type1">
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row"><spring:message code="column.st_id" /></th>
								<td>
									<spring:message code="column.site.select.placeholder" var="selectSitePh"/>
									<select id="stIdCombo" name="stId">
										<frame:stIdStSelect defaultName="${selectSitePh}" />
									</select>
								</td>
								<th scope="row"><spring:message code="column.web_mobile_gb_cd" /></th> <!-- 대상 매체 -->
								<td>
									<frame:checkbox grpCd="${adminConstants.SVC_GB }" name="svcGb"/>
									<input type="hidden" name="svcGbCds" id="svcGbCds" />
								</td>
							</tr>
							<tr>
								<th scope="row"><spring:message code="column.goods.showAreaGbCd" /></th> <!-- 노출 위치 -->
								<td colspan="3">
									<spring:message code="admin.web.view.common.button.select" var="selectPh"/>
									<select id="showAreaGbCd" name="showAreaGbCd">
										<frame:select grpCd="${adminConstants.SHOW_AREA_GB }" defaultName="${selectPh}" showValue="false" />
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</form>

				<div class="btn_area_center">
					<button type="button" onclick="searchGoodsDescCommList();" class="btn btn-ok"><spring:message code="admin.web.view.common.search" /></button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel"><spring:message code="admin.web.view.common.button.clear" /></button>
				</div>
			</div>
		</div>

		<div class="mModule">
			<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
				<button type="button" onclick="registGoodsDescComm();" class="btn btn-add"><spring:message code="column.goods.goodsDescComm.insert" /></button>
			</c:if>

			<table id="goodsDescCommList" ></table>
			<div id="goodsDescCommListPage"></div>
		</div>

	</t:putAttribute>

</t:insertDefinition>
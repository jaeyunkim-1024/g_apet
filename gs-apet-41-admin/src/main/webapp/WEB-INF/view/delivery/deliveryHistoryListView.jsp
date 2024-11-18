<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">

			$(document).ready(function(){
			});
			
			function createDlvrHistoryList(arrDlvrNo, ordClmGbCd){
				var gridOptions = {
					url : "<spring:url value='/delivery/deliveryHistoryLayerGrid.do' />"
					, height : 300
					, searchParam : {arrDlvrNo : arrDlvrNo}
					, paging : true
					, colModels : [
						{name:"dlvrHistNo", label:'<spring:message code="column.dlvr_hist_no" />', width:"80", align:"center", sortable:false }
						, {name:"dlvrNo", label:'<spring:message code="column.dlvr_no" />', width:"80", align:"center", sortable:false }
                       	, {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"140", align:"center", sortable:false <c:if test="${ordClmGbCd eq adminConstants.ORD_CLM_GB_20}">, hidden:true</c:if> }
                       	, {name:"ordDtlSeq", label:'<spring:message code="column.ord_dtl_seq" />', width:"90", align:"center", sortable:false, formatter:'integer'<c:if test="${ordClmGbCd eq adminConstants.ORD_CLM_GB_20}">, hidden:true</c:if>}
						, {name:"clmNo", label:'<spring:message code="column.clm_no" />', width:"150", align:"center", sortable:false <c:if test="${ordClmGbCd eq adminConstants.ORD_CLM_GB_10}">, hidden:true</c:if>}
						, {name:"clmDtlSeq", label:'<spring:message code="column.clm_dtl_seq" />', width:"100", align:"center", sortable:false, formatter:'integer' <c:if test="${ordClmGbCd eq adminConstants.ORD_CLM_GB_10}">, hidden:true</c:if>}
						, {name:"dlvrCpltDtm", label:'<spring:message code="column.dlvr_cplt_dtm" />', width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}	
						, {name:"sysUpdrNm", label:'<spring:message code="column.sys_updr_nm" />', width:"150", align:"center"}
// 						, {name:"sysUpdDtm", label:'<spring:message code="column.sys_upd_dtm" />', width:"100", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
					]
				}
				grid.create("dlvrHistoryList", gridOptions);
			}

		</script>
	
		<table id="dlvrHistoryList" ></table>
		<div id="dlvrHistoryListPage"></div>


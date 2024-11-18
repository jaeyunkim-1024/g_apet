<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">

	var orderGridListCommon = {
		colModels : [
			// 클레임 번호
			{name:"clmNo", label:'<spring:message code="column.clm_no" />', width:"130", align:"center"}

			// 클레임 상세 순번
			, {name:"clmDtlSeq", label:'<spring:message code="column.clm_dtl_seq" />', width:"80", align:"center", formatter:'integer'}

			// 주문 번호
			, {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"120", align:"center"}

 			// 주문 상세 순번
			, {name:"ordDtlSeq", label:'<spring:message code="column.ord_dtl_seq" />', width:"70", align:"center", formatter:'integer'}

			// 접수자 번호
			, {name:"acptrNo", label:'<spring:message code="column.acptr_no" />', width:"70", align:"center", formatter:'integer'}

			// 취소자 번호
			, {name:"cncrNo", label:'<spring:message code="column.cncr_no" />', width:"70", align:"center", formatter:'integer'}

			// 완료자 번호
			, {name:"cpltrNo", label:'<spring:message code="column.cpltr_no" />', width:"70", align:"center", formatter:'integer'}

			//==============================================================================================
			//== 클레임
			//==============================================================================================

			// 클레임 유형 코드
			, {name:"clmTpCd", label:'<spring:message code="column.clm_tp_cd" />', width:"70", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_TP}" />"}}

			// 클레임 사유 코드
			, {name:"clmRsnCd", label:'<spring:message code="column.clm_rsn_cd" />', width:"150", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_RSN}" />"}}

			// 클레임 상태 코드
			, {name:"clmStatCd", label:'<spring:message code="column.clm_stat_cd" />', width:"70", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_STAT}" />"}}

			// 클레임 접수 일시
			, {name:"clmAcptDtm", label:'<spring:message code="column.clm_acpt_dtm" />', width:"150", align:"center", formatter:gridFormat.date, datefomat:"yyyy-MM-dd HH:mm:ss"}

			// 클레임 완료 일시
			, {name:"clmCpltDtm", label:'<spring:message code="column.clm_cplt_dtm" />', width:"150", align:"center", formatter:gridFormat.date, datefomat:"yyyy-MM-dd HH:mm:ss"}

			// 클레임 취소 일시
			, {name:"clmCncDtm", label:'<spring:message code="column.clm_cnc_dtm" />', width:"150", align:"center", formatter:gridFormat.date, datefomat:"yyyy-MM-dd HH:mm:ss"}

			// 메모
			, {name:"memo", label:'<spring:message code="column.memo" />', width:"200", align:"center"}
			
			//사이트 ID
			, {name:"stId", label:"<spring:message code='column.st_id' />", width:"60", align:"center"}
			
			//  사이트 명
			, {name:"stNm", label:"<spring:message code='column.st_nm' />", width:"100", align:"center", sortable:false}

		]
	};

	// 클레임 상품 리스트 셀병합
	function fnClaimListRowSpan(rowId, val, rawObject, cm) {
		var result = "";
		var num = rawObject.clmDtlRowNum;
		var cnt = rawObject.clmDtlCnt;
		if (num == 1) {
			result = ' rowspan=' + '"' + cnt + '"';
		} else {
			result = ' style="display:none"';
		}
		return result;
	}

	// 주문 상품 리스트 셀병합
	function fnOrderListRowSpan(rowId, val, rawObject, cm) {
		var result = "";
		var num = rawObject.ordDtlRowNum;
		var cnt = rawObject.ordDtlCnt;
		if (num == 1) {
			result = ' rowspan=' + '"' + cnt + '"';
		} else {
			result = ' style="display:none"';
		}
		return result;
	}

	// 주문 상품 리스트 : Reload
	function reloadOrderListGrid(){
		var options = {
			searchParam : {
				ordNo : '${orderSO.ordNo}'
			}
	        , grouping: true
	        , groupField: ["clmNo"]
	        , groupText: "클레임번호"
	        , groupOrder : ["asc"]
	        , groupCollapse: false
		};

		grid.reload("orderList", options);
	}

</script>



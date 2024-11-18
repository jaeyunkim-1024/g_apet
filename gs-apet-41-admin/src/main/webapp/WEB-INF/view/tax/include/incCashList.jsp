<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">

	var orderGridListCommon = {
		colModels : [
 
            // 현금 영수증 번호
              {name:"cashRctNo", label:'<spring:message code="column.cash_rct_no" />', width:"110", align:"center", sortable:false,  classes:'pointer fontbold'}
            // 주문번호			
			, {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"120", align:"center", sortable:false}
			// 주문내역상태코드
			, {name:"ordDtlStatCd", label:'<spring:message code="column.ord_detail_stat_cd" />', width:"90", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ORD_DTL_STAT}" />"}}
			// 발행 유형 코드
			, {name:"crTpCd", label:'<spring:message code="column.cr_tp_cd" />', width:"80", align:"center", sortable:false,  formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CR_TP}" />"}}
			// 현금 영수증 상태 코드
			, {name:"cashRctStatCd", label:'<spring:message code="column.cash_rct_stat_cd" />', width:"80", align:"center", sortable:false,  formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CASH_RCT_STAT}" />"}}
			// 연동 거래 번호
			, {name:"lnkDealNo", label:'<spring:message code="column.lnk_deal_no" />', width:"100", align:"center", sortable:false}
			// 주문접수일자
			, {name:"ordAcptDtm", label:'<spring:message code="column.ord_acpt_dtm" />', width:"150", align:"center", sortable:false,  formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
			// 주문자ID
			, {name:"ordrId", label:'<spring:message code="column.ordUserId" />', width:"100", align:"center", sortable:false}
			// 주문자명
			, {name:"ordNm", label:'<spring:message code="column.ord_nm" />', width:"100", align:"center", sortable:false}
			// 회원명
			, {name:"mbrNm", label:'<spring:message code="column.mbr_nm" />', width:"100", align:"center", sortable:false}
			// 수령인
			, {name:"adrsNm", label:'<spring:message code="column.ord.adrsNm" />', width:"100", align:"center", sortable:false}
			// 상품명
			, {name:"goodsNm", label:'<spring:message code="column.goods_nm" />', width:"250", align:"center", sortable:false}
			// 단품명
// 			, {name:"itemNm", label:'<spring:message code="column.item_nm" />', width:"200", align:"center", sortable:false}
			// 상품금액
			, {name:"saleAmt", label:'<spring:message code="column.sale_amt" />', width:"80", align:"center", sortable:false, formatter:'integer'}
			// 수량
			, {name:"ordQty", label:'<spring:message code="column.ord_qty" />', width:"60", align:"center", sortable:false, formatter:'integer', hidden:true}
			// 적용 수량
			, {name:"aplQty", label:'<spring:message code="column.ord_qty" />', width:"70", align:"center", sortable:false, formatter:'integer'}
			// 사용 구분 코드
			, {name:"useGbCd", label:'<spring:message code="column.use_gb_cd" />', width:"80", align:"center", sortable:false,  formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.USE_GB}" />"}}
			// 발급 수단 코드
			, {name:"isuMeansCd", label:'<spring:message code="column.isu_means_cd" />', width:"80", align:"center", sortable:false,  formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ISU_MEANS}" />"}}
			// 발급 수단 번호
			, {name:"isuMeansNo", label:'<spring:message code="column.isu_means_no" />', width:"100", align:"center", sortable:false}
			// 발행 구분 코드
			, {name:"isuGbCd", label:'<spring:message code="column.isu_gb_cd" />', width:"80", align:"center",  formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ISU_GB}" />"}}
			// 공급 금액
			, {name:"taxSplAmt", label:'<spring:message code="column.spl_amt" />', width:"100", align:"center", sortable:false,  formatter:'integer'}
			// 부가세 금액
			, {name:"staxAmt", label:'<spring:message code="column.stax_amt" />', width:"100", align:"center", ortable:false,  formatter:'integer'}
			// 연동 일시
			, {name:"lnkDtm", label:'<spring:message code="column.lnk_dtm" />', width:"150", align:"center", sortable:false,  formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
			// 연동 결과 메세지
			, {name:"lnkRstMsg", label:'<spring:message code="column.lnk_rst_msg" />', width:"200", align:"center", sortable:false}
			// 업체명
			, {name:"compNm", label:'<spring:message code="column.comp_nm" />', width:"150", align:"center", sortable:false}
		]
	};

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
		};

		grid.reload("orderList", options);
	}

</script>



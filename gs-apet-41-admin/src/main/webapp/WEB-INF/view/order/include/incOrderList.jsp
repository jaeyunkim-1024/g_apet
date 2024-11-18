<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">

	var orderGridListCommon = {
		colModels : [
            // 주문번호
            {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"120", align:"center", sortable:false}			
			// 주문자ID
			, {name:"ordrId", label:'<spring:message code="column.ordUserId" />', width:"80", align:"center", sortable:false}	
			// 주문 상세 카운트
			, {name:"ordDtlCnt", label:'', hidden:true, sortable:false}
			// 주문 상세 번호
			, {name:"ordDtlRowNum", label:'', hidden:true, sortable:false}
			// 주문상세일련번호
			, {name:"ordDtlSeq", label:'<spring:message code="column.ord_dtl_seq" />', width:"70", align:"center", sortable:false}
			// 주문내역상태코드
			, {name:"ordDtlStatCd", label:'<spring:message code="column.ord_dtl_stat_cd" />', width:"80", align:"center", formatter:"select", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ORD_DTL_STAT}" />"}, hidden:true}
			// 주문내역상태코드 이름
            , {name:"ordDtlStatCdNm", label:'<spring:message code="column.ord_stat_cd" />', width:"80", align:"center", sortable:false}
			// 상품명
			, {name:"goodsNm", label:'<spring:message code="column.goods_nm" />', width:"300", align:"left", sortable:false}
			// 주문수량
            , {name:"ordQty", label:'<spring:message code="column.ord_qty" />', width:"60", align:"center", formatter:'integer'}
            // 취소수량
            , {name:"cncQty", label:'<spring:message code="column.cnc_qty" />', width:"60", align:"center", formatter:'integer'}
			// 주문자명
			, {name:"ordNm", label:'<spring:message code="column.ord_nm" />', width:"80", align:"center", sortable:false}
            // 주문접수일자
            , {name:"ordAcptDtm", label:'<spring:message code="column.ord_acpt_dtm" />', width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}			
            // 결제수단
            , {name:"payMeansCd", label:'<spring:message code="column.pay_means_cd" />', width:"60", align:"center", formatter:"select", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.PAY_MEANS}" />"}}
            // 결제일
            ,{name:"rsvPayCpltDtm", label:'<spring:message code="column.ord.payCpltDtm" />', width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
            // 취소일
            ,{name:"ordCncDtm", label:'<spring:message code="column.ord.ordCncDtm" />', width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
            // 건별결제금액
            , {name:"payAmt", label:'<spring:message code="column.order_common.pay_dtl_amt" />', width:"80", align:"center", formatter:'integer', sortable:false}
            // 전체결제금액
            , {name:"payAmtTotal", label:'<spring:message code="column.order_common.pay_tot_amt" />', width:"80", align:"center", formatter:'integer' , sortable:false}
            // 주문매체
            , {name:"ordMdaCd", label:'<spring:message code="column.ord_mda_cd" />', width:"60", align:"center", formatter:"select", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ORD_MDA}" />"}}			
			// 페이지구분
			//, {name:"pageGbCd", label:'<spring:message code="column.page_gb_cd" />', width:"50", align:"center", formatter:"select", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.PAGE_GB}" />"}}
			// 배송정보 > 받는분명
			, {name:"rsvAdrsNm", label:'<spring:message code="column.ord.adrsNm" />', width:"100", align:"center", sortable:false}
			// 주문자 전화번호
			, {name:"ordrTel", label:'<spring:message code="column.ord.ordrTel" />', width:"100", align:"center",  formatter:gridFormat.phonenumber, sortable:false}
			// 주문자 휴대폰
			, {name:"ordrMobile", label:'<spring:message code="column.ord.ordrMobile" />', width:"100", align:"center",  formatter:gridFormat.phonenumber, sortable:false}
			// 수령인 전화번호
			, {name:"rsvTel", label:'<spring:message code="column.ord.tel" />', width:"100", align:"center",  formatter:gridFormat.phonenumber, sortable:false}
			// 수령인 휴대폰
			, {name:"rsvMobile", label:'<spring:message code="column.ord.mobile" />', width:"100", align:"center", formatter:gridFormat.phonenumber, sortable:false}
			// 수령인 주소 1
			, {name:"rsvRoadAddr", label:'<spring:message code="column.ord.roadAddr" />', width:"300", align:"center", sortable:false}
			// 수령인 주소 2
			, {name:"rsvRoadDtlAddr", label:'<spring:message code="column.ord.roadDtlAddr" />', width:"200", align:"center", sortable:false}
			//사이트 ID
			, {name:"stId", label:"<spring:message code='column.st_id' />", width:"70", align:"center", hidden:true}
			//  사이트 명
			, {name:"stNm", label:"<spring:message code='column.st_nm' />", width:"80", align:"center", sortable:false}
		],
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
				ordNo : '${orderBase.ordNo}'
			}
			, grouping: true
	        , groupField: ["ordNo"]
	        , groupText: "주문번호"
	        , groupOrder : ["asc"]
	        , groupCollapse: false
		};

		grid.reload("orderList", options);
	}



</script>



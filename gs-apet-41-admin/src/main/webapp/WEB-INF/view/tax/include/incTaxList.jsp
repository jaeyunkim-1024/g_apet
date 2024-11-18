<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">

	var orderGridListCommon = {
		colModels : [
			// 주문번호
			{name:"checkbox", label:' ', width:"50", align:"center", sortable:false, cellattr:fnOrderListRowSpan, formatter: function(rowId, val, rawObject, cm) {
				return '<input type="checkbox" name="arrOrdNo" value="' + rawObject.ordNo + '">';
			}}
			, {name:"button", label:'주문 상세 보기', width:"80", align:"center", sortable:false, cellattr:fnOrderListRowSpan, formatter: function(rowId, val, rawObject, cm) {
				var str = '<button type="button" onclick="fnOrderDetailView(\'' + rawObject.ordNo + '\')" class="btn_h25_type1">주문 상세</button>';
				return str
			}}
			, {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"120", align:"center", cellattr:fnOrderListRowSpan}

			// 주문상세일련번호
			, {name:"ordDtlSeq", label:'<spring:message code="column.ord_dtl_seq" />', width:"75", align:"center", formatter:'integer'}
			
			// 주문내역상태코드
			, {name:"ordDtlStatCd", label:'<spring:message code="column.ord_dtl_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ORD_DTL_STAT}" />"}}

			// 세금 계산서 상태 코드
			, {name:"taxIvcStatCd", label:'<spring:message code="column.tax_ivc_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.TAX_IVC_STAT}" />"}}
			
			// 주문접수일자
			, {name:"ordAcptDtm", label:'<spring:message code="column.ord_acpt_dtm" />', width:"150", align:"center", cellattr:fnOrderListRowSpan, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}

			// 주문자ID
			, {name:"ordrId", label:'<spring:message code="column.ordUserId" />', width:"100", align:"center", sortable:false, cellattr:fnOrderListRowSpan}

			// 주문자명
			, {name:"ordNm", label:'<spring:message code="column.ord_nm" />', width:"100", align:"center", sortable:false, cellattr:fnOrderListRowSpan}

			// 주문자 휴대폰
// 			, {name:"ordrMobile", label:' ', width:"50", align:"center", sortable:false, cellattr:fnOrderListRowSpan, hidden:true}

			// 회원번호
// 			, {name:"mbrNo", label:'<spring:message code="column.mbr_no" />', width:"50", align:"center", cellattr:fnOrderListRowSpan}

			// 회원명
			, {name:"mbrNm", label:'<spring:message code="column.mbr_nm" />', width:"100", align:"center", cellattr:fnOrderListRowSpan}

			// 업체번호
// 			, {name:"compNo", label:'<spring:message code="column.comp_nm" />', width:"100", align:"center"}

			// 업체명
			, {name:"compNm", label:'<spring:message code="column.comp_nm" />', width:"120", align:"center"}

			// 페이지구분
// 			, {name:"pageGbCd", label:'<spring:message code="column.page_gb_cd" />', width:"80", align:"center", formatter:"select", cellattr:fnOrderListRowSpan, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.PAGE_GB}" />"}}

			// 상품명
			, {name:"goodsNm", label:'<spring:message code="column.goods_nm" />', width:"350", align:"center"}

			// 상품번호
// 			, {name:"goodsId", label:'<spring:message code="column.goods_id" />', width:"60", align:"center"}

			// 단품명
			, {name:"itemNm", label:'<spring:message code="column.item_nm" />', width:"200", align:"center"}

			// 단품번호
// 			, {name:"itemNo", label:'<spring:message code="column.item_no" />', width:"60", align:"center", formatter:'integer'}

			// 상품금액
			, {name:"saleAmt", label:'<spring:message code="column.sale_amt" />', width:"100", align:"center", formatter:'integer'}

			// 수량
			, {name:"ordQty", label:'<spring:message code="column.ord_qty" />', width:"80", align:"center", formatter:'integer'}

			// 상품쿠폰할인금액
// 			, {name:"goodsCpDcAmt", label:'<spring:message code="column.goods_cp_dc_amt" />', width:"100", align:"center", formatter:'integer'}

			// 배송비쿠폰할인금액
// 			, {name:"dlvrcCpDcAmt", label:'<spring:message code="column.dlvrc_cp_dc_amt" />', width:"100", align:"center", formatter:'integer'}

			// 조립비쿠폰할인금액
// 			, {name:"asbcCpDcAmt", label:'<spring:message code="column.asbc_cp_dc_amt" />', width:"100", align:"center", formatter:'integer'}

			// 장바구니쿠폰할인금액
// 			, {name:"birthCpDcAmt", label:'<spring:message code="column.cart_cp_dc_amt" />', width:"100", align:"center", formatter:'integer'}

			// 적립금할인금액
// 			, {name:"svmnDcAmt", label:'<spring:message code="column.svmn_dc_amt" />', width:"90", align:"center", formatter:'integer'}

			// 건별결제금액
// 			, {name:"payAmt", label:'<spring:message code="column.order_common.pay_dtl_amt" />', width:"70", align:"center", formatter:'integer'}

			// 전체결제금액
// 			, {name:"payAmtTotal", label:'<spring:message code="column.order_common.pay_tot_amt" />', width:"70", align:"center", cellattr:fnOrderListRowSpan, formatter:'integer'}

			// 주문매체
// 			, {name:"ordMdaCd", label:'<spring:message code="column.ord_mda_cd" />', width:"100", align:"center", formatter:"select", cellattr:fnOrderListRowSpan, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ORD_MDA}" />"}}

			// 결제수단
// 			, {name:"payMeansCd", label:'<spring:message code="column.pay_means_cd" />', width:"100", align:"center", formatter:"select", cellattr:fnOrderListRowSpan, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.PAY_MEANS}" />"}}

			// 주문 상세 카운트
// 			, {name:"ordDtlCnt", label:'', hidden:true}

			// 주문 상세 번호
// 			, {name:"ordDtlRowNum", label:'', hidden:true}


			// 세금 계산서 번호
// 			, {name:"taxIvcNo", label:'<spring:message code="column.tax_ivc_no" />', width:"100", align:"center", formatter:'integer'}

			// 원 세금 계산서 번호
// 			, {name:"orgTaxIvcNo", label:'<spring:message code="column.org_tax_ivc_no" />', width:"100", align:"center", formatter:'integer'}

			// 주문 클레임 구분 코드
// 			, {name:"ordClmGbCd", label:'<spring:message code="column.ord_clm_gb_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ORD_CLM_GB}" />"}}

			// 주문 번호
// 			, {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"100", align:"center"}

			// 주문 상세 순번
// 			, {name:"ordDtlSeq", label:'<spring:message code="column.ord_dtl_seq" />', width:"100", align:"center", formatter:'integer'}

			// 클레임 번호
// 			, {name:"clmNo", label:'<spring:message code="column.clm_no" />', width:"100", align:"center"}

			// 클레임 상세 순번
// 			, {name:"clmDtlSeq", label:'<spring:message code="column.clm_dtl_seq" />', width:"100", align:"center", formatter:'integer'}

			// 신청자 구분 코드
			, {name:"apctGbCd", label:'<spring:message code="column.apct_gb_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.APCT_GB}" />"}}

			// 회원 번호
// 			, {name:"mbrNo", label:'<spring:message code="column.mbr_no" />', width:"100", align:"center", formatter:'integer'}

			// 사용 구분 코드
// 			, {name:"useGbCd", label:'<spring:message code="column.use_gb_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.USE_GB}" />"}}

			// 발급 수단 코드
// 			, {name:"isuMeansCd", label:'<spring:message code="column.isu_means_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ISU_MEANS}" />"}}

			// 업체 명
			, {name:"taxCompNm", label:'<spring:message code="column.comp_nm" />', width:"100", align:"center"}

			// 대표자 명
			, {name:"ceoNm", label:'<spring:message code="column.ceo_nm" />', width:"100", align:"center"}

			// 업태
// 			, {name:"bizCdts", label:'<spring:message code="column.biz_cdts" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.BIZ}" />"}}
			, {name:"bizCdts", label:'<spring:message code="column.biz_cdts" />', width:"120", align:"center"}

			// 종목
			, {name:"bizTp", label:'<spring:message code="column.biz_tp" />', width:"100", align:"center"}

			// 사업자 번호
			, {name:"bizNo", label:'<spring:message code="column.biz_no" />', width:"100", align:"center"}

			// 우편 번호 구
// 			, {name:"postNoOld", label:'<spring:message code="column.post_no_old" />', width:"100", align:"center"}

			// 우편 번호 신
			, {name:"postNoNew", label:'<spring:message code="column.post_no_new" />', width:"80", align:"center"}

			// 도로 주소
			, {name:"roadAddr", label:'<spring:message code="column.road_addr" />', width:"250", align:"center"}

			// 도로 상세 주소
			, {name:"roadDtlAddr", label:'<spring:message code="column.road_dtl_addr" />', width:"150", align:"center"}

			// 지번 주소
// 			, {name:"prclAddr", label:'<spring:message code="column.prcl_addr" />', width:"100", align:"center"}

			// 지번 상세 주소
// 			, {name:"prclDtlAddr", label:'<spring:message code="column.prcl_dtl_addr" />', width:"100", align:"center"}

			// 공급 금액
			, {name:"taxSplAmt", label:'<spring:message code="column.spl_amt" />', width:"100", align:"center", formatter:'integer'}

			// 부가세 금액
			, {name:"staxAmt", label:'<spring:message code="column.stax_amt" />', width:"100", align:"center", formatter:'integer'}

			// 총 금액
			, {name:"totAmt", label:'<spring:message code="column.tot_amt" />', width:"100", align:"center", formatter:'integer'}

			// 접수 일시
			, {name:"acptDtm", label:'<spring:message code="column.acpt_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}

			// 처리자 번호
			, {name:"prcsrNm", label:'<spring:message code="column.prcsr_nm" />', width:"100", align:"center"}

			// 연동 일시
			, {name:"lnkDtm", label:'<spring:message code="column.lnk_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}

			// 연동 거래 번호
			, {name:"lnkDealNo", label:'<spring:message code="column.lnk_deal_no" />', width:"80", align:"center"}

			// 연동 결과 코드
// 			, {name:"lnkRstCd", label:'<spring:message code="column.lnk_rst_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.LNK_RST}" />"}}
			, {name:"lnkRstCd", label:'<spring:message code="column.lnk_rst_cd" />', width:"80", align:"center"}

			// 연동 결과 메세지
			, {name:"lnkRstMsg", label:'<spring:message code="column.lnk_rst_msg" />', width:"200", align:"center"}

			// 메모
			, {name:"memo", label:'<spring:message code="column.memo" />', width:"300", align:"center"}

			// 시스템 등록자 번호
// 			, {name:"sysRegrNo", label:'<spring:message code="column.sys_regr_no" />', width:"100", align:"center", formatter:'integer'}

			// 시스템 등록 일시
// 			, {name:"sysRegDtm", label:'<spring:message code="column.sys_reg_dtm" />', width:"100", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}

			// 시스템 수정자 번호
// 			, {name:"sysUpdrNo", label:'<spring:message code="column.sys_updr_no" />', width:"100", align:"center", formatter:'integer'}

			// 시스템 수정 일시
// 			, {name:"sysUpdDtm", label:'<spring:message code="column.sys_upd_dtm" />', width:"100", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
// 			, {name:"sysRegrNm", label:'<spring:message code="column.sys_regr_nm" />', width:"100", align:"center"}
// 			, {name:"sysUpdrNm", label:'<spring:message code="column.sys_updr_nm" />', width:"100", align:"center"}

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
				ordNo : '${orderBase.ordNo}'
			}
		};

		grid.reload("orderList", options);
	}

</script>



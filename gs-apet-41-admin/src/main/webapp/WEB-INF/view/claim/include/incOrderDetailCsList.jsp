<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">

	var csGridListCommon = {
		colModels : [
			//상담 번호
			{name:"cusNo", label:'<spring:message code="column.cus_no" />', width:"60", align:"center", formatter:'integer'}
			
			//상담 경로 코드
			, {name:"cusPathCd", label:'<spring:message code="column.cus_path_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_PATH}" />"}}
			
			// 상담 상태 코드
			, {name:"cusStatCd", label:'<spring:message code="column.cus_stat_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_STAT}" />"}}

			// 문의자 명
			, {name:"eqrrNm", label:'<spring:message code="column.eqrr_nm" />', width:"100", align:"center"}

			// 제목
//			, {name:"ttl", label:'<spring:message code="column.ttl" />', width:"200", align:"center"}

			// 내용
 			, {name:"content", label:'<spring:message code="column.content" />', width:"950", align:"center"}

			// 내용상세
//			, {name:"content", label:'내용상세', width:"100", align:"center", formatter: function(rowId, val, rawObject, cm) {
//				var str = "";
//				str = '<button type="button" onclick="csContentDetailLayer(\'' + rawObject.cusNo + '\',\'' + rawObject.content + '\')" class="btn_h25_type1">내용상세</button>';
//				return str;
//			}}

			// 파일 번호
// 			, {name:"flNo", label:'<spring:message code="column.fl_no" />', width:"100", align:"center", formatter:'integer'}

			// 상품 아이디
// 			, {name:"goodsId", label:'<spring:message code="column.goods_id" />', width:"100", align:"center"}

			// 상담 카테고리1 코드
			, {name:"cusCtg1Cd", label:'<spring:message code="column.cus_ctg1_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG1}" />"}}

			// 상담 카테고리2 코드
			, {name:"cusCtg2Cd", label:'<spring:message code="column.cus_ctg2_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG2}" />"}}

			// 상담 카테고리3 코드
			, {name:"cusCtg3Cd", label:'<spring:message code="column.cus_ctg3_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG3}" />"}}

			// 상담 접수 일시
			, {name:"cusAcptDtm", label:'<spring:message code="column.cus_acpt_dtm" />', width:"125", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}

			// 상담 취소 일시
			, {name:"cusCncDtm", label:'<spring:message code="column.cus_cnc_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}

			// 상담 완료 일시
			, {name:"cusCpltDtm", label:'<spring:message code="column.cus_cplt_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}

			// 상담 접수자 번호
			, {name:"cusAcptrNm", label:'<spring:message code="column.order_common.acptr_nm" />', width:"100", align:"center"}

			// 상담 취소자 번호
			, {name:"cusCncrNm", label:'<spring:message code="column.order_common.cncr_nm" />', width:"100", align:"center"}

			// 상담 완료자 번호
			, {name:"cusCpltrNm", label:'<spring:message code="column.order_common.cpltr_nm" />', width:"100", align:"center"}

			// 주문 번호
			, {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"120", align:"center"}

			// 주문 상세 순번
			, {name:"ordDtlSeq", label:'<spring:message code="column.ord_dtl_seq" />', width:"80", align:"center", formatter:'integer'}

			// 클레임 번호
			, {name:"clmNo", label:'<spring:message code="column.clm_no" />', width:"130", align:"center"}

			// 클레임 상세 순번
			, {name:"clmDtlSeq", label:'<spring:message code="column.clm_dtl_seq" />', width:"80", align:"center", formatter:'integer'}
			
			//사이트 ID
			, {name:"stId", label:"<spring:message code='column.st_id' />", width:"100", align:"center"}
			
			//  사이트 명
			, {name:"stNm", label:"<spring:message code='column.st_nm' />", width:"200", align:"center", sortable:false }

		]
	};

	var csMemGridListCommon = {
			colModels : [
				//상담 번호
				{name:"cusNo", label:'<spring:message code="column.cus_no" />', width:"70", align:"center", formatter:'integer'}
				
				// 상담 상태 코드
				, {name:"cusStatCd", label:'<spring:message code="column.cus_stat_cd" />', width:"80", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_STAT}" />"}}

				// 문의자 명
				, {name:"eqrrNm", label:'<spring:message code="column.eqrr_nm" />', width:"100", align:"center"}

				// 제목
				, {name:"ttl", label:'<spring:message code="column.ttl" />', width:"250", align:"center"}

				// 내용
//	 			, {name:"content", label:'<spring:message code="column.content" />', width:"100", align:"center"}

				// 내용상세
				, {name:"content", label:'내용상세', width:"100", align:"center", formatter: function(rowId, val, rawObject, cm) {
					var str = "";
					str = '<button type="button" onclick="csContentDetailLayer(\'' + rawObject.cusNo + '\',\'' + rawObject.content + '\')" class="btn_h25_type1">내용상세</button>';
					return str;
				}}

				// 파일 번호
//	 			, {name:"flNo", label:'<spring:message code="column.fl_no" />', width:"100", align:"center", formatter:'integer'}

				// 상품 아이디
//	 			, {name:"goodsId", label:'<spring:message code="column.goods_id" />', width:"100", align:"center"}

				// 상담 카테고리1 코드
				, {name:"cusCtg1Cd", label:'<spring:message code="column.cus_ctg1_cd" />', width:"120", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG1}" />"}}

				// 상담 카테고리2 코드
				, {name:"cusCtg2Cd", label:'<spring:message code="column.cus_ctg2_cd" />', width:"120", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG2}" />"}}

				// 상담 카테고리3 코드
				, {name:"cusCtg3Cd", label:'<spring:message code="column.cus_ctg3_cd" />', width:"120", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CUS_CTG3}" />"}}

				// 상담 접수 일시
				, {name:"cusAcptDtm", label:'<spring:message code="column.cus_acpt_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}

				// 상담 취소 일시
				, {name:"cusCncDtm", label:'<spring:message code="column.cus_cnc_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}

				// 상담 완료 일시
				, {name:"cusCpltDtm", label:'<spring:message code="column.cus_cplt_dtm" />', width:"150", align:"center", formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}

				// 상담 접수자 번호
				, {name:"cusAcptrNm", label:'<spring:message code="column.order_common.acptr_nm" />', width:"100", align:"center"}

				// 상담 취소자 번호
				, {name:"cusCncrNm", label:'<spring:message code="column.order_common.cncr_nm" />', width:"100", align:"center"}

				// 상담 완료자 번호
				, {name:"cusCpltrNm", label:'<spring:message code="column.order_common.cpltr_nm" />', width:"100", align:"center"}

				// 주문 번호
				, {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"120", align:"center"}

				// 주문 상세 순번
				, {name:"ordDtlSeq", label:'<spring:message code="column.ord_dtl_seq" />', width:"80", align:"center", formatter:'integer'}

				// 클레임 번호
				, {name:"clmNo", label:'<spring:message code="column.clm_no" />', width:"130", align:"center"}

				// 클레임 상세 순번
				, {name:"clmDtlSeq", label:'<spring:message code="column.clm_dtl_seq" />', width:"80", align:"center", formatter:'integer'}
				
				 //사이트 ID
				, {name:"stId", label:"<spring:message code='column.st_id' />", width:"100", align:"center"}
				
				//  사이트 명
				, {name:"stNm", label:"<spring:message code='column.st_nm' />", width:"200", align:"center", sortable:false }

			]
			
		};

	// CS 리스트 셀병합
	function fnCsListRowSpan(rowId, val, rawObject, cm) {
		var result = "";
		var num = rawObject.prcsNoRowNum;
		var cnt = rawObject.prcsNoCnt;
		if (num == 1) {
			result = ' rowspan=' + '"' + cnt + '"';
		} else {
			result = ' style="display:none"';
		}
		return result;
	}

	// CS 리스트 : Reload
	function reloadCsListGrid(ordDtlSeq){

		var options = {
			searchParam : {
				ordNo : '${orderBase.ordNo}'
				, ordDtlSeq : ordDtlSeq
			}
		}
		grid.reload("csList", options);
	}

	// CS 내용 상세 Layer
	function csContentDetailLayer( cusNo, content ) {

		var html = new Array();
		html.push('<div class="mModule">');
		html.push('	<table id="csContentDetailList" >');
		html.push('		<tr>');
		html.push('			<td>');
		html.push(content);
		html.push('			</td>');
		html.push('	</table>');
		html.push('</div>');
		var config = {
			id : "csContentDetailLayer"
			, width : 550
			, height : 800
			, top : 200
			, title : "CS 내용 상세"
			, body : html.join("")
		}
		layer.create(config);

	}
	
</script>



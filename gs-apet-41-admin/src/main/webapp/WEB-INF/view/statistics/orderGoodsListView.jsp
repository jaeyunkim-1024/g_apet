<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
	<script type="text/javascript">
		$(document).ready(function() {
			// 주문 상품별 리스트 생성
			createOrderGoodsGrid();

			$("input[name=compNm]").prop("disabled", true);
			$("select[name=pageGbCd]").prop("disabled", true);
		});

		// 주문 상품별 리스트
		function createOrderGoodsGrid() {
			var gridOptions = {
				url : "<spring:url value='/statistics/orderGoodsListGrid.do'/>"
				, datatype : 'local'
				, height : 500
				, searchParam : $("#orderGoodsForm").serializeJson()
				, colModels : [
					//상품아이디
					{name:"goodsId", label:"<spring:message code='column.statistics.goods_id' />", width:"50", hidden:true}
					// 단품번호
					, {name:"itemNo", label:"<spring:message code='column.statistics.goods_option_no' />", width:"50", hidden:true}
					// 주문번호
					, {name:"ordNo", label:"<spring:message code='column.statistics.order_no' />", width:"150", align:"center", cellattr:listRowSpan}
					// 주문상태
					, {name:"ordDtlStatCd", label:'<spring:message code="column.statistics.ord_dtl_stat_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ORD_DTL_STAT}" />"}}
					// BOM코드
					, {name:"bomCd", label:"<spring:message code='column.statistics.goods_id' />", width:"150", align:"center", hidden:true, hidden : true}
					// 아이디
					, {name:"ordrId", label:"<spring:message code='column.statistics.order_id' />", width:"150", align:"center", sortable:false, cellattr:listRowSpan}
					// 주문자명
					, {name:"ordNm", label:"<spring:message code='column.statistics.order_nm' />", width:"100", align:"center", sortable:false, cellattr:listRowSpan}
					// 판매처
					, {name:"pageGbCd", label:"<spring:message code='column.statistics.sale_sopt' />", width:"100", align:"center", formatter:"select", cellattr:listRowSpan, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.PAGE_GB}" />"}}
					// 업체명
					, {name:"compNm", label:"<spring:message code='column.statistics.company_nm' />", width:"150", align:"center", sortable:false}
					// 주문일
					, {name:"ordAcptDtm", label:"<spring:message code='column.statistics.order_date' />", width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
					// 결제완료일
					, {name:"payCpltDtm", label:"<spring:message code='column.statistics.settle_date' />", width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss"}
					// 성별
					, {name:"sex", label:"<spring:message code='column.statistics.sex' />", width:"100", align:"center", sortable:false, cellattr:listRowSpan}
					// 상품명
					, {name:"goodsNm", label:"<spring:message code='column.statistics.goods_nm' />", width:"200", align:"center", sortable:false}
					// 상품명(옵션추가)
					, {name:"itemNm", label:"<spring:message code='column.statistics.goods_option' />", width:"200", align:"center", sortable:false}
					// 카테고리
					, {name:"dispPath", label:"<spring:message code='column.statistics.category_nm' />", width:"300", align:"center", sortable:false}
					// 수량
					, {name:"ordQty", label:"<spring:message code='column.statistics.quantity' />", width:"100", align:"center", sortable:false, formatter:'integer'}
					// 판매가
					, {name:"saleAmt", label:"<spring:message code='column.statistics.sale_amt' />", width:"100", align:"center", sortable:false, formatter:'integer'}
					// 옵션추가금액
					, {name:"optionAmt", label:"<spring:message code='column.statistics.option_amt' />", width:"100", align:"center", sortable:false, formatter:'integer'}
					// 상품가
					, {name:"goodsAmt", label:"<spring:message code='column.statistics.goodos_amt' />", width:"100", align:"center", sortable:false, formatter:'integer'}
					// 결제총합
					, {name:"payAmt", label:"<spring:message code='column.statistics.settle_amt' />", width:"100", align:"center", sortable:false, formatter:'integer', cellattr:listRowSpan}
					// 공급가
					, {name:"splAmt", label:"<spring:message code='column.statistics.supply_amt' />", width:"100", align:"center", sortable:false, formatter:'integer'}
					// 모바일여부
					, {name:"ordMdaCd", label:'<spring:message code="column.statistics.mobile_yn" />', width:"100", align:"center", formatter:"select", cellattr:listRowSpan, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ORD_MDA}" />"}}
					// 송장번호
					, {name:"invNo", label:"<spring:message code='column.statistics.inv_no' />", width:"100", align:"center", sortable:false}
					// 우편번호
					, {name:"postNoNew", label:"<spring:message code='column.statistics.post_no_new' />", width:"80", align:"center", sortable:false}
					// 도로주소
					, {name:"roadAddr", label:"<spring:message code='column.statistics.road_addr' />", width:"200", align:"center", sortable:false}
					// 상세주소
					, {name:"roadDtlAddr", label:"<spring:message code='column.statistics.road_dtl_addr' />", width:"100", align:"center", sortable:false}
					// 전화
					, {name:"tel", label:"<spring:message code='column.statistics.tel' />", width:"100", align:"center", sortable:false}
					// 휴대폰
					, {name:"mobile", label:"<spring:message code='column.statistics.mobile' />", width:"100", align:"center", sortable:false}
					// 이메일
					, {name:"email", label:"<spring:message code='column.statistics.email' />", width:"100", align:"center", sortable:false}
					// 수취인명
					, {name:"adrsNm", label:"<spring:message code='column.statistics.adrs_nm' />", width:"80", align:"center", sortable:false}
					// 쿠폰명
					, {name:"cpNm", label:"<spring:message code='column.statistics.coupon_nm' />", width:"500", align:"center", sortable:false}
					// 쿠폰금액
					, {name:"cpAmt", label:"<spring:message code='column.statistics.coupon_amt' />", width:"100", align:"center", sortable:false, formatter:'integer'}
					// 결제방법
					, {name:"payMeansNm", label:"<spring:message code='column.statistics.settle_method' />", width:"100", align:"center", sortable:false, cellattr:listRowSpan}
					// 카운트
					, {name:"dtlCnt", label:'', hidden:true}
					// 상세번호
					, {name:"dtlRowNum", label:'', hidden:true}
				]
			}

			grid.create("orderGoodsList", gridOptions);
		}

		// 검색
		function searchOrderGoodsList() {
			// 주문 접수 일시 시작일
			var ordAcptDtmStart = $("#ordAcptDtmStart").val().replace( /-/gi, "" );
			// 주문 접수 일시 종료일
			var ordAcptDtmEnd = $("#ordAcptDtmEnd").val().replace( /-/gi, "" );
			// 시작일과 종료일 3개월 차이 계산
			var diffMonths = getDiffMonths( ordAcptDtmStart, ordAcptDtmEnd );

			if ( eval(diffMonths) > 3 ) {
				messager.alert('<spring:message code="admin.web.view.msg.common.valid.diffMonths" />', "Info", "info");
				return;
			}

			// 외부몰 구분 체크
			if($("input:radio[name=pageCheck]:checked").val() == '01') {
				if($("select[name=pageGbCd]").val() == '') {
					messager.alert('<spring:message code="admin.web.view.msg.statistics.pageCheck.01" />', "Info", "info");
				}
			}

			var data = $("#orderGoodsForm").serializeJson();
			if ( undefined != data.arrOrdDtlStatCd && data.arrOrdDtlStatCd != null && Array.isArray(data.arrOrdDtlStatCd) ) {
				$.extend(data, {arrOrdDtlStatCd : data.arrOrdDtlStatCd.join(",")});
			}

			var options = {
				searchParam : data
			};

			grid.reload("orderGoodsList", options);
		}

		// 셀병합
		function listRowSpan(rowId, val, rawObject, cm) {
			var result = "";
			var num = rawObject.dtlRowNum;
			var cnt = rawObject.dtlCnt;

			if(num == 1) {
				result = ' rowspan=' + '"' + cnt + '"';
			} else {
				result = ' style="display:none"';
			}

			return result;
		}

		// 외부몰 구분 선택
		$(document).on("click", "#orderGoodsForm input[name=pageCheck]", function(e) {
			if($(this).val() == "") {
				$("select[name=pageGbCd]").find("option:first").prop("selected", "selected");
				$("select[name=pageGbCd]").prop("disabled", true);
			} else if($(this).val() == "01") {
				$("select[name=pageGbCd]").prop("disabled", false);
			}
		});

		// 주문상태 클릭 Validation 체크
		$(document).on("click", 'input:checkbox[name="arrOrdDtlStatCd"]', function(e) {
			var all = false;

			if(validation.isNull($(this).val())) {
				all = true;
			}
			if($('input:checkbox[name="arrOrdDtlStatCd"]:checked').length == 0) {
				$('input:checkbox[name="arrOrdDtlStatCd"]').eq(0).prop("checked", true);
			} else {
				$('input:checkbox[name="arrOrdDtlStatCd"]').each(function() {
					if ( all ) {
						if(validation.isNull( $(this).val())) {
							$(this).prop("checked", true);
						} else {
							$(this).prop("checked", false);
						}
					} else {
						if(validation.isNull($(this).val())) {
							$(this).prop("checked", false);
						}
					}
				});
			}
		});

		// 업체 검색
		function fnCallBackCompanySearchPop() {
			var data = {
				multiselect : true
				, callBack : function(result) {
					$("#compNo").val(result[0].compNo);
					$("#compNm").val(result[0].compNm);
				}
			}

			layerCompanyList.create(data);
		}

		// 주문접수일시 변경
		function searchDateChange() {
			var term = $("#checkOptDate").children("option:selected").val();
			if(term == "") {
				$("#ordAcptDtmStart").val("");
				$("#ordAcptDtmEnd").val("");
			} else {
				setSearchDate(term, "ordAcptDtmStart", "ordAcptDtmEnd");
			}
		}

		// 엑셀 다운로드
		function orderGoodsListExcelDownload() {
			createFormSubmit("orderGoodsListExcelDownload", "/statistics/orderGoodsListExcelDownload.do", $("#orderGoodsForm").serializeJson());
		}
	</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<form id="orderGoodsForm" name="orderGoodsForm" method="post" >
			<table class="table_type1">
				<caption>정보 검색</caption>
				<tbody>
					<tr>
						<!-- 주문 접수 일시 -->
						<th scope="row"><spring:message code="column.ord_acpt_dtm" /></th>
						<td>
							<frame:datepicker startDate="ordAcptDtmStart" endDate="ordAcptDtmEnd" startValue="${adminConstants.COMMON_START_DATE }"/>
							&nbsp;&nbsp;
							<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
								<frame:select grpCd="${adminConstants.SELECT_PERIOD }" defaultName="기간선택" />
							</select>
						</td>
						<!-- DPA 여부 -->
						<th scope="row"><spring:message code="column.statistics.dpa_yn" /></th>
						<td>
							<select name="dpaYn" id="dpaYn" title="<spring:message code="column.statistics.dpa_yn"/>" >
								<frame:select grpCd="${adminConstants.COMM_YN}"/>
							</select>
						</td>
					</tr>
					<tr>
						<!-- 주문정보 -->
						<th scope="row"><spring:message code="column.order_common.order_info" /></th>
						<td>
							<select name="searchOrder" title="주문정보" >
								<option selected="selected">전체</option>
								<option value="type01">주문번호</option>
								<option value="type02">주문자명</option>
								<option value="type03">주문자ID</option>
							</select>
							<input type="text" name="searchOrderValue" value="" />
						</td>
						<!-- 상품정보 -->
						<th scope="row"><spring:message code="column.order_common.goods_info" /></th>
						<td>
							<select name="searchGoods" title="상품정보" >
								<option selected="selected">전체</option>
								<option value="type01">상품명</option>
								<option value="type02">단품명</option>
							</select>
							<input type="text" name="searchGoodsValue" value="" />
						</td>
					</tr>
					<tr>
						<!-- 업체명 -->
						<th scope="row"><spring:message code="column.goods.comp_nm" /></th>
						<td>
							<frame:compNo funcNm="fnCallBackCompanySearchPop" />
						</td>
						<!-- 페이지 구분 -->
						<th scope="row"><spring:message code="column.order_common.page_gb_cd" /></th>
						<td>
							<label class="fRadio"><input type="radio" name="pageCheck" value="" checked="checked"> <span>전체</span></label>
							<label class="fRadio"><input type="radio" name="pageCheck" value="01"> <span><spring:message code="column.order_common.search_foreign_mall" /></span></label>

							<select name="pageGbCd" id="pageGbCd" title="선택상자" >
								<frame:select grpCd="${adminConstants.PAGE_GB}" defaultName="선택하세요"/>
							</select>
						</td>
					</tr>
					<tr>
						<!-- 주문상태 -->
						<th scope="row"><spring:message code="column.order_common.ord_stat_cd" /></th>
						<td>
							<frame:checkbox name="arrOrdDtlStatCd" grpCd="${adminConstants.ORD_DTL_STAT }" defaultName="전체" usrDfn1Val="ORDER" />
						</td>
						<!-- 주문매체 -->
						<th scope="row"><spring:message code="column.ord_mda_cd" /></th>
						<td>
							<frame:radio name="ordMdaCd" grpCd="${adminConstants.ORD_MDA }" defaultName="전체" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>

		<div class="btn_area_center">
			<button type="button" onclick="searchOrderGoodsList();" class="btn btn-ok">검색</button>
			<button type="button" onclick="resetForm('orderGoodsForm'); javascript:document.getElementById('pageGbCd').selectedIndex='0'; document.getElementById('pageGbCd').disabled=true;" class="btn btn-cancel">초기화</button>
		</div>

		<div class="mModule">
			<button type="button" onclick="orderGoodsListExcelDownload();" class="btn btn-add btn-excel">엑셀 다운로드</button>
			
			<table id="orderGoodsList"></table>
			<div id="orderGoodsListPage"></div>
		</div>
	</t:putAttribute>
</t:insertDefinition>
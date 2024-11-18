<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="subTabLayout">
	
	<t:putAttribute name="script">

		<script type="text/javascript">
			$(document).ready(function(){
				searchDateChange();
				//setCommonDatePickerEvent('#ordAcptDtmStart','#ordAcptDtmEnd');
				orderList.createGrid();
				
                $(document).on("keydown","#orderSearchForm input",function(){
	        		if ( window.event.keyCode == 13 ) {
	        			orderList.reload();
	      		  	}
                });				
			});

			var orderList = {
				/*
				 * 주문 목록 그리드 생성
				 */
				createGrid : function(){
					var options = {
						url : "<spring:url value='/order/orderListGrid.do' />"
						, colModels : [
							 // 주문번호
							 {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"150", align:"center", sortable:false}
							// 주문상세일련번호
							, {name:"ordDtlSeq", label:'<b><u><tt><spring:message code="column.ord_dtl_seq" /></tt></u></b>', width:"100", align:"center", sortable:false, classes:'pointer fontbold'}
							// 사이트 명
							, _GRID_COLUMNS.stNm
							 // 주문매체
							, {name:"ordMdaCd", label:'<spring:message code="column.ord_mda_cd" />', width:"60", align:"center", formatter:"select", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ORD_MDA}" />"}}
							 // 주문접수일자
							, {name:"ordAcptDtm", label:'<spring:message code="column.ord_acpt_dtm" />', width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm"}
							 // 주문완료일자
							, {name:"ordCpltDtm", label:'<spring:message code="column.ord_cplt_dtm" />', width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm"}
							// 주문자ID
							, {name:"ordrId", label:'<spring:message code="column.ordUserId" />', width:"80", align:"center", sortable:false}
							// 주문자명
							, {name:"ordNm", label:'<spring:message code="column.ord_nm" />', width:"70", align:"center", sortable:false}
							// 주문자 휴대폰
							, {name:"ordrMobile", label:'<spring:message code="column.ord.ordrMobile" />', width:"100", align:"center",  formatter:gridFormat.phonenumber, sortable:false}
							, _GRID_COLUMNS.compNm
							, _GRID_COLUMNS.bndNmKo
							, _GRID_COLUMNS.goodsNm_b
							// 주문내역상태코드 이름
							, {name:"ordDtlStatCdNm", label:'<spring:message code="column.ord_stat_cd" />', width:"80", align:"center", sortable:false}
							// 주문수량
							, {name:"ordQty", label:'<spring:message code="column.ord_qty" />', width:"60", align:"center", formatter:'integer'}
							// 취소수량
							, {name:"cncQty", label:'<spring:message code="column.cnc_qty" />', width:"60", align:"center", formatter:'integer'}
							// 반품수량
							, {name:"rtnQty", label:'<spring:message code="column.rtn_qty" />', width:"60", align:"center",  formatter:'integer', hidden:true}
							// 반품완료수량
							, {name:"rtnCpltQty", label:'<spring:message code="column.rtn_cplt_qty" />', width:"74", align:"center", formatter:'integer', sortable:false}
							// 반품진행수량
							, {name:"rtnIngQty", label:'<spring:message code="column.rtn_ing_qty" />', width:"74", align:"center", formatter:'integer', sortable:false}
							// 교환진행수량
							, {name:"clmExcIngQty", label:'<spring:message code="column.clm_exc_ing_qty" />', width:"74", align:"center", formatter:'integer', sortable:false}
							// 상품금액
							, {name:"saleAmt", label:'<spring:message code="column.sale_unit_prc" />', width:"80", align:"center", formatter:'integer', sortable:false}
							// 쿠폰 할인 금액
							, {name:"cpDcAmt", label:'<spring:message code="column.cp_dc_unit_prc" />', width:"80", align:"center", formatter:'integer', sortable:false}
							// 실 배송 금액
							, {name:"realDlvrAmt", label:'<spring:message code="column.real_dlvr_amt" />', width:"75", align:"center", sortable:false, formatter:'integer', formatoptions:{thousandsSeparator:','}, summaryType:'sum', summaryTpl : 'Totals:', cellattr:fnDeliveryListRowSpan}
							// 건별결제금액
							, {name:"paySumAmt", label:'<spring:message code="column.order_common.pay_dtl_amt" />', width:"80", align:"center", formatter:'integer', sortable:false}
							// 수령인 명
							, {name:"adrsNm", label:'<spring:message code="column.ord.adrsNm" />', width:"150", align:"center", sortable:false}
							// 수령인 휴대폰
							, {name:"mobile", label:'<spring:message code="column.ord.mobile" />', width:"100", align:"center", formatter:gridFormat.phonenumber, sortable:false}
							// 수령인 주소 1
							, {name:"roadAddr", label:'<spring:message code="column.ord.roadAddr" />', width:"300", align:"center", sortable:false}
							// 수령인 주소 2
							, {name:"roadDtlAddr", label:'<spring:message code="column.ord.roadDtlAddr" />', width:"200", align:"center", sortable:false}
							// 배송 처리 유형
							, {name:"dlvrPrcsTpCd", label:'<spring:message code="column.dlvr_prcs_tp_cd" />', width:"80", align:"center", formatter:"select", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.DLVR_PRCS_TP}" />"}
								, cellattr : function(rowId, value, rowObject){
									if(rowObject.dlvrPrcsTpCd == '${adminConstants.DLVR_PRCS_TP_10}'){
										//택배 -주황
										return 'style="color:#FF8047"';
									}else if(rowObject.dlvrPrcsTpCd == '${adminConstants.DLVR_PRCS_TP_20}'){
										//당일배송 -초록
										return 'style="color:#05B36D"';
									}else if(rowObject.dlvrPrcsTpCd == '${adminConstants.DLVR_PRCS_TP_21}'){
										//새벽배송 -파랑
										return 'style="color:#2F6FFD"';
									}else{
										//검정
										return 'style="color:#000000"';
									}
								}
							}
							// 주문제작
							, {name:"mkiGoodsYn", label:'<spring:message code="column.order_common.mki_goods_yn" />', width:"80", align:"center", sortable:false}
							// 사전예약
							, {name:"rsvGoodsYn", label:'<spring:message code="column.order_common.rsv_goods_yn" />', width:"80", align:"center", sortable:false}
							// 사은품여부
							, {name:"frbGoodsYn", label:'<spring:message code="column.order_common.frb_goods_yn" />', width:"80", align:"center", sortable:false}
							// 상품 구성 유형
							, {name:"goodsCstrtTpCd", label:'<spring:message code="column.goods_cstrt_cd" />', width:"80", align:"center", formatter:"select", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.GOODS_CSTRT_TP}" />"}}
							// 묶음 여부
							, {name:"pakGoodsYn", label:'<spring:message code="column.order_common.pak_goods_yn" />', width:"80", align:"center", sortable:false}
							
							// 사이트 ID
							, {name:"stId", label:"<spring:message code='column.st_id' />", hidden:true}
							, {name:"goodsId", label:'<spring:message code="column.goods_id" />', hidden: true}
							// 단품명
							, {name:"itemNm", label:'<spring:message code="column.item_nm" />', hidden: true}
							// 주문내역상태코드
							, {name:"ordDtlStatCd", label:'<spring:message code="column.ord_dtl_stat_cd" />', width:"80", align:"center", formatter:"select", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ORD_DTL_STAT}" />"}, hidden:true}
							// 클레임상태
							, {name:"clmIngYn", label:'<spring:message code="column.clm_stat_cd" />', hidden:true}
							 // 잔여주문수량
							, {name:"rmnOrdQty", label:'<spring:message code="column.rmn_ord_qty" />', hidden:true}
							// 프로모션 할인 금액 삭제
							, {name:"prmtDcAmt", label:'<spring:message code="column.prmt_dc_unit_prc" />', hidden: true}
						]
						, height : 400
						, searchParam : serializeFormData()
						, onCellSelect : function (id, cellidx, cellvalue) {

							var cm = $("#orderList").jqGrid("getGridParam", "colModel");
							var rowData = $("#orderList").getRowData(id);
							if(cm[cellidx].name == "goodsNm"  ){
								viewGoodsDetail(rowData.goodsId  );
							}else{
								fnOrderDetailView(rowData);
							}


						}
						, gridComplete: function() {  /** 데이터 로딩시 함수 **/

							var ids = $('#orderList').jqGrid('getDataIDs');

							// 그리드 데이터 가져오기
							var gridData = $("#orderList").jqGrid('getRowData');

							if(gridData.length > 0){
								// 데이터 확인후 색상 변경
								for (var i = 0; i < gridData.length; i++) {

									// 데이터의 is_test 확인
									if (gridData[i].rmnOrdQty == '0') {

										// 열의 색상을 변경하고 싶을 때(css는 미리 선언)
										$('#orderList tr[id=' + ids[i] + ']').css('color', 'red');
								   }
								}
							}
						}
						, grouping: true
						, groupField: ["ordNo"]
						, groupText: ["주문번호"]
						, groupOrder : ["asc"]
						, groupCollapse: false
						, groupColumnShow : [false]
					};

					// 회원번호가 들어와야 만 조회되도록 변경
					if(!$("#mbrNo").val()) {
						options = $.extend(options, {datatype:"local"});
					}

					grid.create( "orderList", options) ;
				}
				/*
				 * 주문 목록 재조회
				 */
				, reload : function(){
					
					// 주문 접수 일시 시작일
					//var ordAcptDtmStart = $("#ordAcptDtmStart").val().replace( /-/gi, "" );
					//var ordAcptDtmEnd = $("#ordAcptDtmEnd").val().replace( /-/gi, "" );
					/*
					var starr = $("#ordAcptDtmStart").val().split("-");
			    	var endarr = $("#ordAcptDtmEnd").val().split("-");
					var stdate = new Date(starr[0], starr[1], starr[2] );
			    	var enddate = new Date(endarr[0], endarr[1], endarr[2] );
			    	var diff = enddate - stdate;
			    	var diffDays = parseInt(diff/(24*60*60*1000));
			    	if(diffDays > 90){
			    		messager.alert("검색기간은 3개월을 초과할 수 없습니다.","info","info");
			    		return;
			    	}
			    	*/
	            	if(dateCheck($("#ordAcptDtmStart").val(),$("#ordAcptDtmEnd").val())){
	            		return;
	            	}
					
					
					var data = serializeFormData();
					
					//회원검색 확인	
					if(data.mbrNo == null || data.mbrNo==""){
						messager.alert("조회된 회원이 없습니다. 회원조회 후 주문조회 가능합니다.");
						return;
					}
					
					// 쿠폰 체크 후 해제 검색시 빈값을 넘겨줘야됨
					//쿠폰체크 값
					var useCoupon = "";
					if($("#useCoupon").prop("checked")){
						useCoupon = $("#useCoupon").val();
					}
					data.useCoupon = useCoupon;
					//쿠폰체크 값
					
					var options = {
						searchParam : data
					};
					
					grid.reload("orderList", options);
				}

			};

			function serializeFormData() {
				var data = $("#orderSearchForm").serializeJson();
				data.maskingUnlock = "${so.maskingUnlock}";
				return data;
			}

			// 주문 상품 리스트 셀병합
			function fnDeliveryListRowSpan(rowId, val, rawObject, cm) {
				var result = "";
				var num = rawObject.ordDlvNum;
				var cnt = rawObject.ordDlvCnt;

				if (num == 1) {
					result = ' rowspan=' + '"' + cnt + '"';
				} else {
					result = ' style="display:none"';
				}
				return result;
			}

			// 주문상세
			function fnOrderDetailView(rowData) {
				var url = '/order/orderDetailView.do?ordNo=' + rowData.ordNo + '&viewGb=' + '${adminConstants.VIEW_GB_POP}';
				window.open(url,'orderDetail','width=1300,height=600,resizable=true,scrollbars=true');
			}

			// 상품 상세
			function viewGoodsDetail(goodsId) {
				var url = '/order/goodsDetailView.do?goodsId=' + goodsId + '&viewGb=' + '${adminConstants.VIEW_GB_POP}';
				window.open(url,'goodsDetail','width=1300,height=600,resizable=true,scrollbars=true');
			}

			// 초기화 버튼클릭
			function searchReset () {
				//구매내역 초기화사 회원번호 유지
				var searchedMbrNo = $("#mbrNo").val();				
				
				resetForm ("orderSearchForm");
				searchDateChange();
				<c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
				$("#orderSearchForm #compNo").val('${adminSession.compNo}');
				$("#orderSearchForm #showAllLowCompany").val("N");
				</c:if>
				
				$("#mbrNo").val(searchedMbrNo);
			}

			// 엑셀 다운로드
			function orderListExcelDownload(){
				createFormSubmit( "orderListExcelDownload", "/order/orderListExcelDownload.do", $("#orderSearchForm").serializeJson() );
			}

			// 등록일 변경
			function searchDateChange() {
				var term = $("#checkOptDate").children("option:selected").val();
				if(term == "") {
					$("#ordAcptDtmStart").val($("#ordAcptDtmStart").data("origin"));
					$("#ordAcptDtmEnd").val($("#ordAcptDtmEnd").data("origin"));
				} else {
					setSearchDate(term, "ordAcptDtmStart", "ordAcptDtmEnd");
				}
			}
		</script>

	</t:putAttribute>

	<t:putAttribute name="content">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="orderSearchForm" id="orderSearchForm">
					<input type="hidden" id="mbrNo" name="mbrNo" value="${param.mbrNo }"/>
					<input type="hidden" id="searchTypeExcel" name="searchTypeExcel" value="member"/>
					<table class="table_type1">
						<caption>주문 검색</caption>
						<tbody>
							<tr>
								<!-- 거래 일시 -->
								<th scope="row"><spring:message code="column.order_common.tran_date" /></th>
								<td colspan="5">
									<frame:datepicker startDate="ordAcptDtmStart" endDate="ordAcptDtmEnd" />
									&nbsp;&nbsp;
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }"  selectKey="${adminConstants.SELECT_PERIOD_40}" defaultName="기간선택" />
									</select>
								</td>
							</tr>
							<tr>
								 <!-- 거래상태 -->
								<th scope="row"><spring:message code="column.order_common.tran_stat" /></th>
								<td>
									<select name="ordDtlStatCd">
										<frame:select grpCd="${adminConstants.ORD_DTL_STAT}" defaultName="전체" />
									</select>
								</td>
								 <!-- 주문번호 -->
								<th scope="row"><spring:message code="column.order_common.ord_no" /></th>
								<td>
									<input type="text" name="ordNo" id="ordNo" class="w120"  value="" />
								</td>
								<!-- 송장번호 -->
								<th scope="row"><spring:message code="column.order_common.inv_no" /></th>
								<td>
									<input type="text" name="invNo" class="w120" value="" />
								</td>
							</tr>
							<tr>
								<!-- 결제수단 -->
								<th scope="row"><spring:message code="column.pay_means_cd" /></th>
								<td>
									<select name="payMeansCd" >
										<frame:select grpCd="${adminConstants.PAY_MEANS }" defaultName="전체" />
									</select>
								</td>
								<!-- 사용 할인수단 -->
								<th scope="row"><spring:message code="column.order_common.useCoupon" /></th>
								<td colspan="3">
									<label class="fCheck">
										<input type="checkbox" name="useCoupon" id="useCoupon" value="Y">
										<span id="useCoupon">쿠폰</span>
									</label>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				
				<div class="btn_area_center">
					<button type="button" onclick="orderList.reload('');" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>


		<div class="mModule">

			<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
			<button type="button" onclick="orderListExcelDownload();" class="btn btn-add btn-excel">엑셀 다운로드</button>
			</c:if>

			<table id="orderList" ></table>
			<div id="orderListPage"></div>
		</div>
		
	</t:putAttribute>
</t:insertDefinition>
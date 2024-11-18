<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">

		<script type="text/javascript">
			$(document).ready(function() {
				setSearchDate("${adminConstants.SELECT_PERIOD_40}", "dtmStart", "dtmEnd");	// 검색기간 1개월 설정
				
				createOrderListGrid();
				//reloadOrderListGrid();

				// 클레임상세상태 1 선택
				$("#clmDtlTpCd").bind("change", function() {
					var selectVal = $(this).children("option:selected").val();
					if (selectVal == "") {
						$("#clmDtlStatCd").html('');
						return;
					}
					// 분류
					config = {
						  grpCd : '${adminConstants.CLM_DTL_STAT}'
						, usrDfn1Val : selectVal
						, defaultName : '전체'
						, showValue : false
						, callBack : function(html) {
							$("#clmDtlStatCd").html('');
							$("#clmDtlStatCd").append(html);
							//option 제거
							if(selectVal == '${adminConstants.CLM_DTL_TP_20}'){
								$("#clmDtlStatCd option[value='"+'${adminConstants.CLM_DTL_STAT_210}'+"']").remove(); //반품접수 제거
							}else if(selectVal == '${adminConstants.CLM_DTL_TP_30}'){
								$("#clmDtlStatCd option[value='"+'${adminConstants.CLM_DTL_STAT_310}'+"']").remove(); //교환회수접수 제거
							}else if(selectVal == '${adminConstants.CLM_DTL_TP_40}'){
								$("#clmDtlStatCd option[value='"+'${adminConstants.CLM_DTL_STAT_410}'+"']").remove(); //교환배송접수 제거
							}
						}
					};
					codeAjax.select(config);
				});

				// 주문,상품번호 선택
				$("#ordNoGoodsIdSel").change(function() {
					if ($(this).val() == "ordNo") {
						$("#ordNo").show();
						$("#goodsId").hide();
						$("#goodsId").val("");
					} else {
						$("#goodsId").show();
						$("#ordNo").hide();
						$("#ordNo").val("");
					}
				});
				
				// datepicker 날짜선택 유효성
				/* $(document).on("change", "#dtmStart", function() {
					compareDate('dtmStart', 'dtmEnd');
				});
				$(document).on("change", "#dtmEnd", function() {
					compareDate2('dtmStart', 'dtmEnd');
				}); */
				//setCommonDatePickerEvent('#dtmStart','#dtmEnd');
				$("#dtmStart").change(function(){
					compareDate("dtmStart", "dtmEnd");
				});
				
				$("#dtmEnd").change(function(){
					compareDate2("dtmStart", "dtmEnd");
				});
				
				// 엔터키 이벤트
				$(document).on("keydown","#orderSearchForm input[name=invNo], #orderSearchForm input[name=ordNo], #orderSearchForm input[name=goodsId], #orderSearchForm input[name='clmNo']",function(e){
					if (e.keyCode == 13) {
						reloadOrderListGrid('');
					}
				});

			});

			// 주문 상품 그리드
			function createOrderListGrid() {

				var options = {
					  url : "<spring:url value='/delivery/deliveryListGrid.do' />"
					, height : 500
					//, datatype : 'local'
					, colModels : [
/* 			 			// 체크박스
						{name:"checkbox", label:' ', width:"50", align:"center", sortable:false, formatter: function(rowId, val, rawObject, cm) {
							return '<input type="checkbox" name="arrDlvrNo" value="' + rawObject.dlvrNo + '"><input type="hidden" name="arrOrdDtlSeq" value="' + rawObject.ordDtlSeq + '"><input type="hidden" name="arrClmDtlSeq" value="' + rawObject.clmDtlSeq + '"><input type="hidden" name="arrOrdDtlStatCd" value="' + rawObject.ordDtlStatCd + '"><input type="hidden" name="arrClmDtlStatCd" value="' + rawObject.clmDtlStatCd + '"><input type="hidden" name="arrOrdNo" value="' + rawObject.ordNo + '"><input type="hidden" name="arrClmNo" value="' + rawObject.clmNo + '"><input type="hidden" name="arrOrdClmGbCd" value="' + rawObject.ordClmGbCd + '"><input type="hidden" name="arrOrdDtlCnt" value="' + rawObject.ordDtlCnt + '"><input type="hidden" name="arrDlvrTpCd" value="' + rawObject.dlvrTpCd + '"><input type="hidden" name="arrDlvrCpltDtm" value="' + rawObject.dlvrCpltDtm + '">';
						}} */
			 			// 체크박스
						{name:"checkbox", label:' ', width:"50", align:"center", sortable:false, formatter: function(rowId, val, rawObject, cm) {
							
							var disabledFlag = rawObject.compGbCd == "10" && (rawObject.ordDtlStatCd != '150' && rawObject.ordDtlStatCd != '160' && rawObject.clmDtlStatCd != '440' &&  rawObject.clmDtlStatCd != '450' );   
							
							return '<input type="checkbox" name="arrDlvrNo" value="' + rawObject.dlvrNo + '" '+(disabledFlag ? "disabled=\"disabled\"":"") +'>'+
							       '<input type="hidden" name="arrOrdDtlSeq" value="' + rawObject.ordDtlSeq + '">'+
							       '<input type="hidden" name="arrClmDtlSeq" value="' + rawObject.clmDtlSeq + '">'+
							       '<input type="hidden" name="arrOrdDtlStatCd" value="' + rawObject.ordDtlStatCd + '">'+
							       '<input type="hidden" name="arrClmDtlStatCd" value="' + rawObject.clmDtlStatCd + '">'+
							       '<input type="hidden" name="arrOrdNo" value="' + rawObject.ordNo + '">'+
							       '<input type="hidden" name="arrClmNo" value="' + rawObject.clmNo + '">'+
							       '<input type="hidden" name="arrOrdClmGbCd" value="' + rawObject.ordClmGbCd + '">'+
							       '<input type="hidden" name="arrOrdDtlCnt" value="' + rawObject.ordDtlCnt + '">'+
							       '<input type="hidden" name="arrDlvrTpCd" value="' + rawObject.dlvrTpCd + '">'+
							       '<input type="hidden" name="arrDlvrCpltDtm" value="' + rawObject.dlvrCpltDtm + '">'+
							       '<input type="hidden" name="arrCompGbCd" value="' + rawObject.compGbCd + '">';
						}}						
						// 배송번호
						,{name:"dlvrNo", label:'<b><spring:message code="column.dlvr_no" /></b>', width:"80", align:"center", sortable:false , cellattr:fnDeliveryListRowSpan, classes:'pointer fontbold'}
                        // 주문번호
                        , {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"140", align:"center", sortable:false, cellattr:fnDeliveryListRowSpan <c:if test="${orderSO.ordClmGbCd eq adminConstants.ORD_CLM_GB_20}">, hidden:true</c:if>}
                        // 주문 상세 보기
                        , {name:"button", label:'주문 상세 보기', width:"90", align:"center", sortable:false<c:if test="${orderSO.ordClmGbCd eq adminConstants.ORD_CLM_GB_20}">, hidden:true</c:if>, cellattr:fnDeliveryListRowSpan, formatter: function(rowId, val, rawObject, cm) {
                            var str = '<button type="button" onclick="fnOrderDetailView(\'' + rawObject.ordNo + '\')" class="btn_h25_type1">주문 상세</button>';
                            return str;
                        }}
                        // 주문상세일련번호
                        , {name:"ordDtlSeq", label:'<spring:message code="column.ord_dtl_seq" />', width:"90", align:"center", sortable:false, formatter:'integer' <c:if test="${orderSO.ordClmGbCd eq adminConstants.ORD_CLM_GB_20}">, hidden:true</c:if>}
                        // 주문내역상태코드
                        , {name:"ordDtlStatCd", label:'<spring:message code="column.ord_dtl_stat_cd" />', width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ORD_DTL_STAT}" />"} <c:if test="${orderSO.ordClmGbCd eq adminConstants.ORD_CLM_GB_20}">, hidden:true</c:if>}
                     	// 클레임번호
						, {name:"clmNo", label:'<spring:message code="column.clm_no" />', width:"150", align:"center", sortable:false <c:if test="${orderSO.ordClmGbCd eq adminConstants.ORD_CLM_GB_10}">, hidden:true</c:if>}
						// 클레임상세일련번호
						, {name:"clmDtlSeq", label:'<spring:message code="column.clm_dtl_seq" />', width:"100", align:"center", sortable:false, formatter:'integer' <c:if test="${orderSO.ordClmGbCd eq adminConstants.ORD_CLM_GB_10}">, hidden:true</c:if>}
						// 클레입 상세 보기
						, {name:"button", label:'클레임 상세 보기', width:"100", align:"center", sortable:false<c:if test="${orderSO.ordClmGbCd eq adminConstants.ORD_CLM_GB_10}">, hidden:true</c:if>, cellattr:fnDeliveryListRowSpan, formatter: function(rowId, val, rawObject, cm) {
							var str = '<button type="button" onclick="fnClaimDetailView(\'' + rawObject.clmNo + '\')" class="btn_h25_type1">클레임 상세</button>';
							return str;
						}}
						// 클레임상태코드
						, {name:"clmTpCd", label:'<spring:message code="column.clm_tp_cd" />', width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_TP}" />"}, hidden:true}
						// 클레임상태코드
						, {name:"clmDtlStatCd", label:'<spring:message code="column.clm_dtl_stat_cd" />', width:"100", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_DTL_STAT}" />"} <c:if test="${orderSO.ordClmGbCd eq adminConstants.ORD_CLM_GB_10}">, hidden:true</c:if>}
						// 주문완료일자
				        , {name:"ordCpltDtm", label:'<spring:message code="column.ord_cplt_dtm" />', width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss" , cellattr:fnDeliveryListRowSpan}
						// 배송 지시 일시
						, {name:"dlvrCmdDtm", label:'<spring:message code="column.dlvr_cmd_dtm" />', width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", cellattr:fnDeliveryListRowSpan}
                        // 출고 완료 일시
                        , {name:"ooCpltDtm", label:'<spring:message code="column.oo_cplt_dtm" />', width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", cellattr:fnDeliveryListRowSpan}
						// 배송 완료 일시
						, {name:"dlvrCpltDtm", label:'<spring:message code="column.dlvr_cplt_dtm" />', width:"150", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm:ss", cellattr:fnDeliveryListRowSpan}
						// 택배사 코드
						, {name:"hdcCd", label:'<spring:message code="column.hdc_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.HDC}" />"}, cellattr:fnDeliveryListRowSpan}
						// 송장 번호
						, {name:"invNo", label:'<spring:message code="column.inv_no" />', width:"150", align:"center", cellattr:fnDeliveryListRowSpan}
						// 수취인 명
						, {name:"adrsNm", label:'<spring:message code="column.adrs_nm" />', width:"100", align:"center" , cellattr:fnDeliveryListRowSpan }
						// 배송지연일
                        , {name:"dlvrDelayDays", label:'<spring:message code="column.dlvr_delay_days" />', width:"70", align:"center", cellattr:fnDeliveryListRowSpan}
						// 우편 번호 신
						, {name:"postNoNew", label:'<spring:message code="column.post_no_new" />', width:"80", align:"center" , cellattr:fnDeliveryListRowSpan}
						// 도로 주소
						, {name:"roadAddr", label:'<spring:message code="column.road_addr" />', width:"230", align:"center" , cellattr:fnDeliveryListRowSpan}
						// 도로 상세 주소
						, {name:"roadDtlAddr", label:'<spring:message code="column.road_dtl_addr" />', width:"150", align:"center" , cellattr:fnDeliveryListRowSpan}
						// 전화
						, {name:"tel", label:'<spring:message code="column.tel" />',  formatter:gridFormat.phonenumber, width:"120", align:"center" , cellattr:fnDeliveryListRowSpan}
						// 휴대폰
						, {name:"mobile", label:'<spring:message code="column.mobile" />',  formatter:gridFormat.phonenumber, width:"120", align:"center" , cellattr:fnDeliveryListRowSpan}
						// 배송 메모
						, {name:"dlvrMemo", label:'<spring:message code="column.dlvr_memo" />', width:"300", align:"center" , cellattr:fnDeliveryListRowSpan }
			            // 회원명
						//, {name:"mbrNm", label:'<spring:message code="column.mbr_nm" />', width:"100", align:"center", sortable:false, cellattr:fnDeliveryListRowSpan}
						// 업체 구분 유형
                        , {name:"compTpCd", label:'<spring:message code="column.comp_tp_cd" />', width:"70", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.COMP_TP}" />"}}
			            // 업체명
						, {name:"compNm", label:'<spring:message code="column.comp_nm" />', width:"120", align:"center", sortable:false}
						// 상품번호
						, {name:"goodsId", label:'<spring:message code="column.goods_id" />', width:"120", align:"center", sortable:false}
						// 배송처리유형명
						, {name:"dlvrPrcsTpNm", label:'<spring:message code="column.dlvrPrcsTpNm" />', width:"100", align:"center", sortable:false, editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.DLVR_PRCS_TP}" />"}
	                        , cellattr : function(rowId, value, rowObject){
	                            if(rowObject.dlvrPrcsTpCd == '${adminConstants.DLVR_PRCS_TP_10}'){
	                            	//택배 -검정
	                            	return 'style="color:#000000"';
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
						// 상품명
						, {name:"goodsNm", label:'<spring:message code="column.goods_nm" />', width:"300", align:"left", sortable:false}
						// 단품번호
// 						, {name:"itemNo", label:'<spring:message code="column.item_no" />', width:"90", align:"center", sortable:false}
						// 단품명
// 						, {name:"itemNm", label:'<spring:message code="column.item_nm" />', width:"150", align:"center", sortable:false}
						// 상품금액
						, {name:"saleAmt", label:'<spring:message code="column.sale_amt" />', width:"80", align:"right", sortable:false, formatter:'integer'}
						// 결제금액
						, {name:"payAmt", label:'<spring:message code="column.pay_amt" />', width:"80", align:"right", sortable:false, formatter:'integer'}
						// 배송수량
						, {name:"ordQty", label:'<spring:message code="column.dlvr_qty" />', width:"60", align:"center", sortable:false, formatter:'integer' }

						// 주문자ID
			 			, {name:"ordrId", label:'<spring:message code="column.ordUserId" />', width:"80", align:"center", sortable:false}
			 			// 주문자명
			 			, {name:"ordNm", label:'<spring:message code="column.ord_nm" />', width:"140", align:"center", sortable:false}
			 			// 배송비
						, {name:"realDlvrAmt", label:'<spring:message code="column.trans_cost" />', width:"70", align:"right", sortable:false, formatter:'integer' }
						// 회수배송비
						, {name:"rtnRealDlvrAmt", label:'<spring:message code="column.rtn_trans_cost" />', width:"90", align:"right", sortable:false, formatter:'integer' <c:if test="${orderSO.ordClmGbCd eq adminConstants.ORD_CLM_GB_10}">, hidden:true</c:if>}
						, {name:"ordDtlRowNum", label:' ', width:"200", align:"center", sortable:false , hidden:true}
						, {name:"ordDtlCnt", label:' ', width:"200", align:"center", sortable:false , hidden:true}
						, {name:"compGbCd", label:' ', width:"200", align:"center", sortable:false , hidden:true}
					]
					, onSelectRow : function(ids) {	// row click

						// 로우 데이터
						var rowData = $("#deliveryList").getRowData(ids);

						var checked = $("#deliveryList input[name=arrDlvrNo]:checkbox[value=" + rowData.dlvrNo + "]").is(":checked");
						//$("#deliveryList input[name=arrDlvrNo]").prop("checked", false);
						//console.info('행 클릭 rowData.compGbCd='+rowData.compGbCd);
						if(rowData.compGbCd != "10"){ //위탁상품만 체크박스에 체크, 2021.04.28 kek01
							$("#deliveryList input[name=arrDlvrNo]:checkbox[value=" + rowData.dlvrNo + "]").prop("checked", !checked);
						}
					}
					, gridComplete: function() {  /** 데이터 로딩시 함수 **/
						var ids = $('#deliveryList').jqGrid('getDataIDs');

						// 그리드 데이터 가져오기
						var gridData = $("#deliveryList").jqGrid('getRowData');
					}
				};
				options.accessYn = "${adminConstants.COMM_YN_Y}"
				va.la($("#maskingUnlock").val());
				options.searchParam = $.extend($("#orderSearchForm").serializeJson(),va.data);
				grid.create( "deliveryList", options) ;

			}

			// 주문 상품 리스트 셀병합
			function fnDeliveryListRowSpan(rowId, val, rawObject, cm) {
				var result = "";
				/* var num = rawObject.ordDtlRowNum; */
				var num = rawObject.ordDtlRowNum;
				var cnt = rawObject.ordDtlCnt;
				//console.log(num);
				//console.log(cnt);
				if (num == 1) {
					result = ' rowspan=' + '"' + cnt + '"';
				} else {
					result = ' style="display:none"';
				}
				return result;
			}
			
			/* 
				// 그리드 체크 박스 클릭 : 주문번호 단위 토글
			$(document).on("click", "#deliveryList input[name=arrDlvrNo]", function(e){
// 				messager.alert( $(this).val() ,"Info","info" );
				var checked = $(this).is(":checked");
				//$("#deliveryList input[name=arrDlvrNo]").prop("checked", false);
				$(this).prop("checked", checked);
			}); */

			// 주문상세
			function fnOrderDetailView(ordNo) {
				<c:if test="${orderSO.ordClmGbCd eq adminConstants.ORD_CLM_GB_10}">
				var url			= '/delivery/orderDetailView.do';
				</c:if>
				<c:if test="${orderSO.ordClmGbCd eq adminConstants.ORD_CLM_GB_20}">
				var url			= '/claimdelivery/orderDetailView.do';
				</c:if>
				
				url += '?ordNo=' + ordNo + '&viewGb=' + '${adminConstants.VIEW_GB_POP}';
				addTab('주문 상세', url);
			}

			// 클레임 상세
			function fnClaimDetailView(clmNo) {
				addTab('클레임 상세', '/delivery/claimDetailView.do?clmNo=' + clmNo + '&viewGb=' + '${adminConstants.VIEW_GB_POP}');
			}
			
			// 배송 히스토리 상세
			function fnDeliveryHistory() {
			
				var ordInfo = $("#deliveryList input[name=arrDlvrNo]:checked").length;
				if ( ordInfo == 0 ) {
					messager.alert( "배송번호를 선택하세요." ,"Info","info");
					return;
				}
				
				var data = new Array();
				var arrDlvrNo = new Array();
				$("#deliveryList input[name=arrDlvrNo]:checked").each(function(e) {
					data.push( $(this).parent().serializeJson() );
					arrDlvrNo.push($(this).val());
				});

				// 배송완료인 상태만 선택 가능 160,450
				var ordCompFlag = false;
				var clmCompFlag = false;
				
				for(var i in data){
					if("${orderSO.ordClmGbCd eq adminConstants.ORD_CLM_GB_10}" === 'true'){
						if( data[i].arrOrdDtlStatCd != '160'){
							ordCompFlag = true;
						}
					}else if("${orderSO.ordClmGbCd eq adminConstants.ORD_CLM_GB_20}" === 'true'){
						if(data[i].arrClmDtlStatCd != '450'){
							clmCompFlag = true;
						}
					}
				}
				
				if(ordCompFlag){
					messager.alert( "배송완료 상태만 선택하세요." ,"Info","info");
					return;
				}
				
				if(clmCompFlag){
					messager.alert( "교환 배송완료 상태만 선택하세요." ,"Info","info");
					return;	
				}
				
				var options = {
						url : "<spring:url value='/delivery/deliveryHistoryListView.do' />"
						, data : {ordClmGbCd : "${orderSO.ordClmGbCd}"}
						, dataType : "html"
						, callBack : function (html) {
							var config = {
								id : "dlvrHistory"
								, width : 800
								, height : 500
								, top : 200
								, title : "배송완료 변경 이력"
								, body : html
							}
							layer.create(config);
							createDlvrHistoryList(arrDlvrNo, "${orderSO.ordClmGbCd}");
						}
					};
					ajax.call(options);
			}

			// 조회
			function reloadOrderListGrid() {

				// 주문 접수 일시 시작일
				var dtmStart = $("#dtmStart").val().replace(/-/gi, "");
				// 주문 접수 일시 종료일
				var dtmEnd = $("#dtmEnd").val().replace(/-/gi, "");
				
				if (dtmStart == "") {
					messager.alert("검색기간을 입력하세요." ,"Info","info");
					$("#dtmStart").focus();
					return;
				}
				else if (dtmEnd == "") {
					messager.alert("검색기간을 입력하세요." ,"Info","info");
					$("#dtmEnd").focus();
					return;
				}
		
				// 시작일과 종료일 3개월 차이 계산
				/* var diffMonths = getDiffMonths(dtmStart, dtmEnd);

				if ( eval(diffMonths) > 3 ) {
					messager.alert("검색기간은 3개월을 초과할 수 없습니다." ,"Info","info");
					return;
				} */

				var arrCompTpCd = new Array();
				var arrDlvrPrcsTpCd = new Array();
				
				$('input:checkbox[name="compTpCd"]:checked').each( function() {
					arrCompTpCd.push($(this).val());
				});
				$('input:checkbox[name="dlvrPrcsTpCd"]:checked').each( function() {
					arrDlvrPrcsTpCd.push($(this).val());
				});
				
				$("input[name=arrCompTpCd]").val(arrCompTpCd);
				$("input[name=arrDlvrPrcsTpCd]").val(arrDlvrPrcsTpCd);
				
				var data = $("#orderSearchForm").serializeJson();
				if ( undefined != data.arrOrdDtlStatCd && data.arrOrdDtlStatCd != null && Array.isArray(data.arrOrdDtlStatCd) ) {
					$.extend( data, { arrOrdDtlStatCd : data.arrOrdDtlStatCd.join(",") } );
				}

				var options = {
					searchParam : data
				};

				grid.reload( "deliveryList", options );
				va.la($("#maskingUnlock").val());
			}

			// callback : 업체 검색
			function fnCallBackCompanySearchPop() {
				var data = {
					multiselect : false
					, callBack : function(result) {
// 						$("#compNo").val( result[0].compNo );
// 						$("#compNm").val( result[0].compNm );
						$("#orderSearchForm").find("#compNo").val( result[0].compNo );
						$("#orderSearchForm").find("#compNm").val( result[0].compNm );
					}
<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
                    , showLowerCompany : 'Y'
</c:if>
				}
				layerCompanyList.create(data);
			}

            // 하위 업체 검색
            function searchLowCompany () {
                var options = {
                    multiselect : false
                    , callBack : searchLowCompanyCallback
<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
                    , showLowerCompany : 'Y'
</c:if>
                }
                layerCompanyList.create (options );
            }
            // 업체 검색 콜백
            function searchLowCompanyCallback(compList) {
                if(compList.length > 0) {
                    $("#orderSearchForm #lowCompNo").val (compList[0].compNo);
                    $("#orderSearchForm #lowCompNm").val (compList[0].compNm);
                }
            }

			// 배송준비중 처리
			function fnDeliveryReady() {
				if(!isCheckedGsOrderJasa()){return;}
				
				var ordInfo = $("#deliveryList input[name=arrDlvrNo]:checked").length;
				if ( ordInfo == 0 ) {
					messager.alert( "주문 번호를 선택하세요." ,"Info","info");
					return;
				}
				var data = new Array();
				$("#deliveryList input[name=arrDlvrNo]:checked").each(function(e) {
					data.push( $(this).parent().serializeJson() );
				});
				var arrOrdNo =new Array();
				var arrDlvrNo =new Array();
				var arrOrdDtlSeq = new Array();
				var arrOrdDtlCnt = new Array();
				var arrOrdCrmDivision = new Array();

				/* console.log("==========data==========s");
				console.log(data); */

				if ( data != null && data.length > 0 ) {
					for ( var i in data) {
						//if ( data[i].arrOrdClmGbCd != '${adminConstants.ORD_CLM_GB_10}') {
						if (data[i].arrDlvrTpCd != '${adminConstants.DLVR_TP_110}' && data[i].arrDlvrTpCd != '${adminConstants.DLVR_TP_120}') {
							//console.log(data[i].arrOrdClmGbCd);
	  						//messager.alert( "주문 클레임 구분 중 주문 일때만 배송준비중이 가능 합니다." ,"Info","info");
	  						messager.alert( "정상/교환출고인 경우 만 배송 준비중 처리가 가능 합니다." ,"Info","info");
	  						return;
	  					}
						if ( data[i].arrOrdDtlStatCd != '${adminConstants.ORD_DTL_STAT_130}' && data[i].arrClmDtlStatCd != '${adminConstants.CLM_DTL_STAT_420}') {
							//console.log(data[i].arrOrdDtlStatCd);
	  						messager.alert( "배송지시 상태일 때 배송 준비중 처리가 가능합니다." ,"Info","info");
	  						return;
	  					}
						//console.log("data[i].arrOrdDtlStatCd>>>>>>>"+data[i].arrOrdDtlStatCd);

						if(data[i].arrOrdDtlStatCd == '${adminConstants.ORD_DTL_STAT_130}'){
							arrOrdNo.push( data[i].arrOrdNo );
							arrOrdDtlSeq.push( data[i].arrOrdDtlSeq );
							arrOrdDtlCnt.push( data[i].arrOrdDtlCnt );
							arrOrdCrmDivision.push("ord" );
						}else if(data[i].arrClmDtlStatCd == '${adminConstants.CLM_DTL_STAT_420}'){
							arrOrdNo.push( data[i].arrClmNo );
							arrOrdDtlSeq.push( data[i].arrClmDtlSeq );
							arrOrdDtlCnt.push( data[i].arrOrdDtlCnt );
							arrOrdCrmDivision.push("clm" );
						}

							arrDlvrNo.push( data[i].arrDlvrNo );


					}
				}

					for ( var i in data) {
						//console.log(data[i]);
						//주문번호
						var dlvrNo = null;
						// 선택한상품수
						var cnt = 0 ;
						for(var j in  arrDlvrNo ) {
							dlvrNo = arrDlvrNo[j];
					    	if(data[i].arrDlvrNo == dlvrNo){
								cnt = cnt +1;
							}
						}
						if(data[i].arrOrdDtlCnt != cnt ){
						    /*  처리
						    console.log("data[i].arrOrdNo>>"+data[i].arrOrdNo);
							console.log("data[i].arrOrdDtlCnt>>"+data[i].arrOrdDtlCnt);
							console.log("data[i].arrOrdDtlStatCd>>"+data[i].arrOrdDtlStatCd);
							console.log("data[i].arrClmDtlSeq >>" +data[i].arrClmDtlSeq);
							console.log("data[i].arrClmNo >>"+data[i].arrClmNo);
							console.log("cnt>>"+cnt);  */
							messager.alert( "주문의 모든건 선택해야 합니다. \n원하지 않으면 배송분리를 이용하세요." ,"Info","info");
	  						return;
						}
					}
				var data = { arrOrdNo :arrOrdNo ,arrOrdDtlSeq : arrOrdDtlSeq, arrOrdCrmDivision : arrOrdCrmDivision };
				
				messager.confirm('<spring:message code="column.order_common.confirm.delivery_ready" />',function(r){
					if(r){
						var options = {
							url : "<spring:url value='/delivery/deliveryReadyExec.do' />"
							, data : data
							, callBack : function(data) {
								messager.alert( "<spring:message code='column.common.edit.final_msg' />", "Info", "info", function(){
									reloadOrderListGrid();
								});
								
							}
						};
						ajax.call(options);				
					}
				});
					
			}
			//배송분리
			function fnDeliveryDivision(){
				if(!isCheckedGsOrderJasa()){return;}

				var ordInfo = $("#deliveryList input[name=arrDlvrNo]:checked").length;
				if ( ordInfo == 0 ) {
					messager.alert( "주문 번호를 선택하세요." ,"Info","info");
					return;
				}
				var data = new Array();
				$("#deliveryList input[name=arrDlvrNo]:checked").each(function(e) {
					data.push( $(this).parent().serializeJson() );
				});
				//console.log("셀렉한 data");
				//console.log(data);
				var arrOrdNo =new Array();
				var arrOrdDtlSeq = new Array();
				if ( data != null && data.length > 0 ) {
					for ( var i in data) {
						if ( data[i].arrOrdClmGbCd != '${adminConstants.ORD_CLM_GB_10}') {
							//console.log(data[i].arrOrdClmGbCd);
	  						messager.alert( "주문 클레임 구분 중 주문 일때만 배송분리가 가능 합니다." ,"Info","info");
	  						return;
	  					}
						if ( data[i].arrOrdDtlStatCd != '${adminConstants.ORD_DTL_STAT_130}'
						     && data[i].arrOrdDtlStatCd != '${adminConstants.ORD_DTL_STAT_140}') {
							//console.log(data[i].arrOrdDtlStatCd);
	  						messager.alert( "주문상태가 배송지시/배송준비중인 건만 배송분리 할 수 있습니다." ,"Info","info");
	  						return;
	  					}
						arrOrdNo.push( data[i].arrOrdNo );
						arrOrdDtlSeq.push( data[i].arrOrdDtlSeq );
					}
				}

				for ( var i in data) {

					//console.log(data[i]);
					for(var j in  arrOrdNo ) {
					var ordNo = arrOrdNo[j];
					var ordDtlSeq = arrOrdDtlSeq[j];
						//console.log("["+arrOrdNo[0] +"],["+arrOrdNo[j]+"]");
						if (arrOrdNo[0] !=  arrOrdNo[j] ){
							//console.log("["+arrOrdNo[0] +"],["+arrOrdNo[j]+"]");
							messager.alert( "한종류의 주문번호만 배송분리 할수 있습니다." ,"Info","info");
	  						return;
						}
					}
					if(arrOrdNo.length ==1 && data[i].arrOrdDtlCnt ==  1  ){
						//console.log("arrOrdNo.length>>"+arrOrdNo.length);
						//console.log("data[i].ordDtlCnt>>"+data[i].arrOrdDtlCnt);
						messager.alert( "주문상세 순번이 한건인경우 배송분리 할수 없습니다." ,"Info","info");
  						return;
					}
					if(data[i].arrOrdDtlCnt == arrOrdNo.length ){
						messager.alert( "주문의 모든건을 배송분리할수 없습니다." ,"Info","info");
  						return;
					}
				}
				var data = { arrOrdNo :arrOrdNo ,arrOrdDtlSeq : arrOrdDtlSeq  };

				messager.confirm('<spring:message code="column.order_common.confirm.delivery_division_ready" />',function(r){
					if(r){
						var options = {
							url : "<spring:url value='/delivery/deliveryDivision.do' />"
							, data : data
							, callBack : function(data) {
								messager.alert( "<spring:message code='column.common.edit.final_msg' />", "Info", "info", function(){
									reloadOrderListGrid();
								});
								
							}
						};
						ajax.call(options);			
					}
				});
			}
			// 송장건별등록
			function fnDeliveryInvoiceOneCreatePop() {
				if(!isCheckedGsOrderJasa()){return;}

				var ordInfo = $("#deliveryList input[name=arrDlvrNo]:checked").length;
				if ( ordInfo == 0 ) {
					messager.alert( "송장번호를 등록할 대상(주문정보)을 선택하세요." ,"Info","info");
					return;
				}
				var data = new Array();
				$("#deliveryList input[name=arrDlvrNo]:checked").each(function(e) {
					data.push( $(this).parent().serializeJson() );
				});

				var dlvrNo = null;
				var ordNo = null;
				var ordDtlStatCd  = null;
				var ordClmGbCd  = null;
				var arrOrdNo =new Array();
				var arrDlvrNo =new Array();
				if ( data != null && data.length > 0 ) {
					for ( var i in data) {

						if(data[0].arrDlvrNo != data[i].arrDlvrNo  ) {
							messager.alert( "동일한 배송번호 단위로 송장(건별)을 등록할 수 있습니다." ,"Info","info");
	  						return;
					 	}

						if ( data[i].arrOrdClmGbCd == '${adminConstants.ORD_CLM_GB_10}') {
							if ( data[i].arrOrdDtlStatCd != '${adminConstants.ORD_DTL_STAT_140}') {
								messager.alert( "주문상태가 배송준비중인 건만 송장(건별) 등록을 할 수 있습니다." ,"Info","info");
		  						return;
		  					}
							ordNo        = data[i].arrOrdNo;
							ordDtlStatCd = data[i].arrOrdDtlStatCd;
						}
						if ( data[i].arrOrdClmGbCd == '${adminConstants.ORD_CLM_GB_20}') {
							if (   data[i].arrClmDtlStatCd != '${adminConstants.CLM_DTL_STAT_220}'
								&& data[i].arrClmDtlStatCd != '${adminConstants.CLM_DTL_STAT_320}'
								&& data[i].arrClmDtlStatCd != '${adminConstants.CLM_DTL_STAT_430}'
								) {
								messager.alert( "클레임상태가 회수지시/배송준비중 인 건만 송장(건별) 등록을 할 수 있습니다." ,"Info","info");
		  						return;
		  					}
							ordNo        = data[i].arrClmNo;
							ordDtlStatCd = data[i].arrClmDtlStatCd;
						}
						dlvrNo       = data[i].arrDlvrNo;
						ordClmGbCd   = data[i].arrOrdClmGbCd;
						arrOrdNo.push( data[i].arrOrdNo );
						arrDlvrNo.push( data[i].arrDlvrNo );

					}
				}

				for ( var i in data) {
					for(var j in  arrOrdNo ) {
						if (arrOrdNo[0] !=  arrOrdNo[j] ){
							//console.log("["+arrOrdNo[0] +"],["+arrOrdNo[j]+"]");
							messager.alert( "한주문 단위로 송장번호 수정을 등록할 수 있습니다." ,"Info","info");
	  						return;
						}
					}
					var dlvrNo = null;
					// 선택한상품수
					var cnt = 0 ;
					for(var j in  arrDlvrNo ) {
						dlvrNo = arrDlvrNo[j];
				    	if(data[i].arrDlvrNo == dlvrNo){
							cnt = cnt +1;
						}
					}
					if(data[i].arrOrdDtlCnt != cnt ){
						messager.alert( "주문의 모든건 선택해야 합니다. \n원하지 않으면 배송분리를 이용하세요." ,"Info","info");
  						return;
					}
				}
				
				
				// 주문크레임구분코드
				// 배송번호
				// 주문번호  || 클레임번호
				// 주문내역상태코드  || 클레임내역상태코드

				var options = {
					url : '/delivery/deliveryInvoiceOneCreatePopView.do'
					, data : {dlvrNo : dlvrNo}
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "deliveryInvoiceOneCreateView"
							, width : 800
							, height : 300
							, top : 200
							, title : "송장 건별 등록"
							, body : data
							, button : "<button type=\"button\" onclick=\"fnDeliveryInvoiceOneCreateExec();\" class=\"btn btn-ok\">송장건별등록</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options );

			}

			// 송장일괄등록
			function fnDeliveryInvoiceBatchCreatePop() {
				var ordClmGbCd = '10';

				<c:if test="${orderSO.ordClmGbCd eq adminConstants.ORD_CLM_GB_10}">
				    ordClmGbCd = '10';
				</c:if>
				<c:if test="${orderSO.ordClmGbCd eq adminConstants.ORD_CLM_GB_20}">
					ordClmGbCd = '20';
				</c:if>
				
				var options = {
					url : '/delivery/deliveryInvoiceBatchCreatePopView.do'
					, data : {ordClmGbCd : ordClmGbCd}
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "deliveryInvoiceBatchCreateView"
							, width : 800
							, height : 800
							, top : 200
							, title : "송장 일괄 등록"
							, body : data
						}
						layer.create(config);
					}
				}
				ajax.call(options );

			}
			//송장번호수정
			function fnDeliveryInvoiceUpdatePop() {
				var ordInfo = $("#deliveryList input[name=arrDlvrNo]:checked").length;
				if ( ordInfo == 0 ) {
					messager.alert( "송장번호를 등록할 대상(주문정보)을 선택하세요." ,"Info","info");
					return;
				}
				var data = new Array();
				$("#deliveryList input[name=arrDlvrNo]:checked").each(function(e) {
					data.push( $(this).parent().serializeJson() );
				});

				var dlvrNo = null;
				var ordNo = null;
				var ordDtlStatCd  = null;
				var ordClmGbCd  = null;
				var arrOrdNo =new Array();
				var arrDlvrNo =new Array();
				if ( data != null && data.length > 0 ) {
					for ( var i in data) {

						if(data[0].arrDlvrNo != data[i].arrDlvrNo  ) {
							messager.alert( "동일한 배송번호 단위로 송장번호 수정을 등록할 수 있습니다." ,"Info","info");
	  						return;
					 	}

						if ( data[i].arrOrdClmGbCd == '${adminConstants.ORD_CLM_GB_10}') {
							if ( data[i].arrOrdDtlStatCd != '${adminConstants.ORD_DTL_STAT_150}') {
								messager.alert( "주문상태가 배송중인 건만 송장번호 수정을 할 수 있습니다." ,"Info","info");
		  						return;
		  					}
							ordNo        = data[i].arrOrdNo;
							ordDtlStatCd = data[i].arrOrdDtlStatCd;
						}
						if ( data[i].arrOrdClmGbCd == '${adminConstants.ORD_CLM_GB_20}') {
							if (   data[i].arrClmDtlStatCd != '${adminConstants.CLM_DTL_STAT_230}'
								&& data[i].arrClmDtlStatCd != '${adminConstants.CLM_DTL_STAT_330}'
								&& data[i].arrClmDtlStatCd != '${adminConstants.CLM_DTL_STAT_440}'
								) {
								messager.alert( "클레임상태가 회수중/배송중인 건만 송장번호 수정을 할 수 있습니다." ,"Info","info");
		  						return;
		  					}
							ordNo        = data[i].arrClmNo;
							ordDtlStatCd = data[i].arrClmDtlStatCd;
						}
						dlvrNo       = data[i].arrDlvrNo;
						ordClmGbCd   = data[i].arrOrdClmGbCd;
						arrOrdNo.push( data[i].arrOrdNo );
						arrDlvrNo.push( data[i].arrDlvrNo );
					}
				}

				for ( var i in data) {

					for(var j in  arrOrdNo ) {
						if (arrOrdNo[0] !=  arrOrdNo[j] ){
							//console.log("["+arrOrdNo[0] +"],["+arrOrdNo[j]+"]");
							messager.alert( "한주문 단위로 송장번호 수정을 등록할 수 있습니다." ,"Info","info");
	  						return;
						}
					}

					var dlvrNo = null;
					// 선택한상품수
					var cnt = 0 ;
					for(var j in  arrDlvrNo ) {
						dlvrNo = arrDlvrNo[j];
				    	if(data[i].arrDlvrNo == dlvrNo){
							cnt = cnt +1;
						}
					}
					if(data[i].arrOrdDtlCnt != cnt ){
						messager.alert( "주문의 모든건 선택해야 합니다. \n원하지 않으면 배송분리를 이용하세요." ,"Info","info");
  						return;
					}
				}
				// 주문크레임구분코드
				// 배송번호
				// 주문번호  || 클레임번호
				// 주문내역상태코드  || 클레임내역상태코드

				/* var data = { ordClmGbCd   : ordClmGbCd
						    ,dlvrNo       : dlvrNo
					        ,ordNo        : ordNo
					        ,ordDtlStatCd : ordDtlStatCd
 				}; */
 				
				var options = {
					url : '/delivery/deliveryInvoiceUpdatePopView.do'
					, data : {dlvrNo : dlvrNo}
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "deliveryInvoiceUpdateView"
							, width : 800
							, height : 300
							, top : 200
							, title : "송장번호 수정"
							, body : data
							, button : "<button type=\"button\" onclick=\"fnDeliveryInvoiceUpdateExec();\" class=\"btn btn-ok\">송장번호 수정</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options );
			}

			// 배송완료 처리
			function fnDeliveryFinal() {
				// if(!isCheckedGsOrderJasa()){return;}

				var ordInfo = $("#deliveryList input[name=arrDlvrNo]:checked").length;
				if ( ordInfo == 0 ) {
					messager.alert( "주문 번호를 선택하세요." ,"Info","info");
					return;
				}
				var data = new Array();
				$("#deliveryList input[name=arrDlvrNo]:checked").each(function(e) {
					data.push( $(this).parent().serializeJson() );
				});
				var arrOrdNo =new Array();
				var arrOrdDtlSeq = new Array();
				var arrOrdDtlCnt = new Array();
				var arrDlvrNo =new Array();
				var arrOrdCrmDivision = new Array();
				if ( data != null && data.length > 0 ) {
					for ( var i in data) {
						if(data[i].arrOrdDtlStatCd != '${adminConstants.ORD_DTL_STAT_150}' && data[i].arrClmDtlStatCd != '${adminConstants.CLM_DTL_STAT_440}'){
							//(주문상태가 배송완료 && 배송일자가 없을때) 배송완료 처리를 할 수 있도록 조치 - 2021.03.10 by KEK01
							if( data[i].arrOrdDtlStatCd == '${adminConstants.ORD_DTL_STAT_160}' || data[i].arrClmDtlStatCd == '${adminConstants.CLM_DTL_STAT_450}' ){ 
								//배송완료일자가 없으면 배송완료 처리가능하도록 변경
								if (data[i].arrDlvrCpltDtm == "" || data[i].arrDlvrCpltDtm == null || data[i].arrDlvrCpltDtm == "null"){
								}else{
			  						messager.alert( "주문상태가 배송중인건만 배송완료 할 수 있습니다." ,"Info","info");
			  						return;
								}
							}else{
		  						messager.alert( "주문상태가 배송중인건만 배송완료 할 수 있습니다." ,"Info","info");
		  						return;
							}
	  					}
						if(data[i].arrOrdDtlStatCd == '${adminConstants.ORD_DTL_STAT_150}'){
						arrOrdNo.push( data[i].arrOrdNo );
						arrOrdDtlSeq.push( data[i].arrOrdDtlSeq );
						arrOrdDtlCnt.push( data[i].arrOrdDtlCnt );
							arrOrdCrmDivision.push("ord" );
						}else if(data[i].arrClmDtlStatCd == '${adminConstants.CLM_DTL_STAT_440}'){
							arrOrdNo.push( data[i].arrClmNo );
							arrOrdDtlSeq.push( data[i].arrClmDtlSeq );
							arrOrdDtlCnt.push( data[i].arrOrdDtlCnt );
							arrOrdCrmDivision.push("clm" );
						}
						arrDlvrNo.push( data[i].arrDlvrNo );
					}
				}

				for ( var i in data) {
					var dlvrNo = null;
					// 선택한상품수
					var cnt = 0 ;
					for(var j in  arrDlvrNo ) {
						dlvrNo = arrDlvrNo[j];
						if(data[i].arrDlvrNo == dlvrNo){
							cnt = cnt +1;
						}
					}
					if(data[i].arrOrdDtlCnt != cnt ){
						messager.alert( "주문의 모든건 선택해야 합니다. \n원하지 않으면 배송분리를 이용하세요." ,"Info","info");
  						return;
					}
				}

				var resultArray = new Array();
				if(arrDlvrNo == null || arrDlvrNo==undefined) {
				} else {
					for(var i=0; i < arrDlvrNo.length;i++){
					  	var el = arrDlvrNo[i];
					  	var idx = -1;
						if(resultArray ==null || resultArray ==undefined || el ==null || el ==undefined){
						}else{
						    for(var j=0;j < resultArray.length;j++){
							    if(resultArray[j] == el){
								   idx = j;
								    break;
								}
							}
						}
					   	if( idx   ==  -1 ) {
							   resultArray.push(el);
						}
					}
				}
				var data = { arrDlvrNo :resultArray  };

				/* 중복제거 E*/

				// console.log(resultArray);
				// console.log(arrDlvrNo);
				//var data = { arrDlvrNo :arrDlvrNo  };
				
				messager.confirm("<spring:message code='column.order_common.confirm.delivery_final' />",function(r){
					if(r){
						var options = {
							url : "<spring:url value='/delivery/deliveryFinalExec.do' />"
							, data : data
							, callBack : function(data) {
								messager.alert( "<spring:message code='column.common.edit.final_msg' />", "Info", "info", function(){
									reloadOrderListGrid();
								});
								
							}
						};
						ajax.call(options);
					}
				});
			}

            // 초기화 버튼클릭
            function searchReset () {
                resetForm ("orderSearchForm");
                $("#orderSearchForm #searchOrdClmGbCd").val('${orderSO.ordClmGbCd}');
                $("#orderSearchForm #ordClmGbCd").val('${orderSO.ordClmGbCd}'); //추가 2021.03.04, by KEK01
//                 $("#orderSearchForm #mbrNo").val('${orderSO.mbrNo}');			//추가 2021.03.04, by KEK01
                setSearchDate("${adminConstants.SELECT_PERIOD_40}", "dtmStart", "dtmEnd" );
                <c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
                	$("#orderSearchForm #compNo").val('${adminSession.compNo}');
                </c:if>
            }

			// 엑셀 다운로드
			function deliveryListExcelDownload(dos) {
			    if(dos == 1) {
					var searchData = $("#orderSearchForm").serializeJson();
					va.la($("#maskingUnlock").val(),"${adminConstants.INQR_GB_60}");
					var data = $.extend(searchData,va.data);

					if($("#deliveryList [name='arrDlvrNo']:checked").length > 0 ){
						var arrDlvrNos = [];
						$("#deliveryList input[name='arrDlvrNo']:checked").each(function(e) {
							arrDlvrNos.push($(this).val());
						});
						data.arrDlvrNoStr = arrDlvrNos.join();
					}
					
					// 개인정보 해제 시 엑셀 다운로드 마스킹 수정 (CSR-1081) 20210609
					// BO : 무조건 마스킹 (마스킹 O)
					// PO : 마스킹 해제 (마스킹 X)
					if ("${adminConstants.USR_GRP_10}" == "${adminSession.usrGrpCd}") {
						data.maskingUnlock = "${adminConstants.COMM_YN_N}";
					}
					
					createFormSubmit( "deliveryListExcelDownload", "/delivery/deliveryListExcelDownload.do", data );
				}else if(dos == 2) {
				 	//송장일괄등록 	송장자료 SAMPLE 다운로드
				 	//송장번호 등록전 상태의 주문과 클레임들을 일괄 엑셀다운
				 	var searchData = $("#orderSearchForm").serializeJson();
					va.la($("#maskingUnlock").val(),"${adminConstants.INQR_GB_60}");
					var data = $.extend(searchData,va.data);

					data.ordDtlStatCd = ${adminConstants.ORD_DTL_STAT_140 };
					var arrClmDtlStatCd =new Array();

					arrClmDtlStatCd.push( '${adminConstants.CLM_DTL_STAT_220 }'  ) ;
					arrClmDtlStatCd.push( '${adminConstants.CLM_DTL_STAT_320 }'  ) ;
					arrClmDtlStatCd.push( '${adminConstants.CLM_DTL_STAT_430 }'  ) ;
					$.extend( data, { excelDownY : true } );
					$.extend( data, { arrClmDtlStatCd : arrClmDtlStatCd.join(",") } );
					//console.log(data);
					//return;
					
					// 개인정보 해제 시 엑셀 다운로드 마스킹 수정 (CSR-1081) 20210609
					// BO : 무조건 마스킹 (마스킹 O)
					// PO : 마스킹 해제 (마스킹 X)
					if ("${adminConstants.USR_GRP_10}" == "${adminSession.usrGrpCd}") {
						data.maskingUnlock = "${adminConstants.COMM_YN_N}";
					}
				
					createFormSubmit( "deliveryListExcelDownload", "/delivery/deliveryListExcelDownload.do", data  );
				}else if (dos == 3) {
				 	//배송지시인 항목들을 다운받아 배송준비중으로 업데이트후 엑셀다운
				 	var searchData = $("#orderSearchForm").serializeJson() ;
					va.la($("#maskingUnlock").val(),"${adminConstants.INQR_GB_60}");
					var data = $.extend(searchData,va.data);
					data.ordDtlStatCd = ${adminConstants.ORD_DTL_STAT_130 };

					data.clmDtlStatCd = ${adminConstants.CLM_DTL_STAT_420 };
					var arrClmDtlStatCd =new Array();
					arrClmDtlStatCd.push( '${adminConstants.CLM_DTL_STAT_420 }'  ) ;
					$.extend( data, { excelDownY : true } );
					$.extend( data, { arrClmDtlStatCd : arrClmDtlStatCd.join(",") } );

					// 개인정보 해제 시 엑셀 다운로드 마스킹 수정 (CSR-1081) 20210609
					// BO : 무조건 마스킹 (마스킹 O)
					// PO : 마스킹 해제 (마스킹 X)
					if ("${adminConstants.USR_GRP_10}" == "${adminSession.usrGrpCd}") {
						data.maskingUnlock = "${adminConstants.COMM_YN_N}";
					}
					
					createFormSubmit( "deliveryListExcelDownload", "/delivery/deliveryInstructionsListExcelDownload.do", data  );
				}
			}

			//선택된 배송지시상품들을 배송준비중으로 변경후 엑셀 다운
			var checkAll = false;
			function FnDeliveryInstructionsListExcelDownload() {
				var ordInfo = $("#deliveryList input[name='arrDlvrNo']:checked").length;

				if ( ordInfo == 0 ) {
					messager.confirm("현재 화면의 모든 주문정보를 \'배송준비중\'<br>상태로 변경하시겠습니까?",function(r){
						if(r){
							// 화면에 보이는 전체 체크박스를 모두 체크함.
	                        $("#deliveryList input[name='arrDlvrNo']").removeAttr("checked");
	                        $("#deliveryList input[name='arrDlvrNo']").each(function(e) {
	                            $(this).prop("checked", true);
	                        });

							FnDeliveryInstructionsListExcelDownloadExe();

						}else{
							return;
						}
					});
				}else{
					FnDeliveryInstructionsListExcelDownloadExe();
				}
			}
			
			function FnDeliveryInstructionsListExcelDownloadExe(){
				var ordInfo = $("#deliveryList input[name='arrDlvrNo']:checked").length;
				
				var data = new Array();
				$("#deliveryList input[name=arrDlvrNo]:checked").each(function(e) {
					data.push( $(this).parent().serializeJson() );
				});

				var arrOrdNo =new Array();
				var arrDlvrNo =new Array();
				var arrOrdDtlSeq = new Array();
				var arrOrdDtlCnt = new Array();
				var arrOrdCrmDivision = new Array();

				if ( data != null && data.length > 0 ) {
					for ( var i in data) {
						//if ( data[i].arrOrdClmGbCd != '${adminConstants.ORD_CLM_GB_10}') {
						if (data[i].arrDlvrTpCd != '${adminConstants.DLVR_TP_110}' && data[i].arrDlvrTpCd != '${adminConstants.DLVR_TP_120}') {
	  						messager.alert( "정상/교환출고인 경우 만 배송 준비중 처리가 가능 합니다." ,"Info","info");
	                        // 화면에 보이는 전체 체크박스를 모두 체크 해제함.
	                        $("#deliveryList input[name='arrDlvrNo']").removeAttr("checked");
	  						return;
	  					}
						if ( data[i].arrOrdDtlStatCd != '${adminConstants.ORD_DTL_STAT_130}' && data[i].arrClmDtlStatCd != '${adminConstants.CLM_DTL_STAT_420}') {
	  						messager.alert( "주문/클레임 상태가 배송지시인 건만 배송 준비중 처리가 가능합니다." ,"Info","info");
                            // 화면에 보이는 전체 체크박스를 모두 체크 해제함.
                            $("#deliveryList input[name='arrDlvrNo']").removeAttr("checked");
	  						return;
	  					}

						if(data[i].arrOrdDtlStatCd == '${adminConstants.ORD_DTL_STAT_130}'){
							arrOrdNo.push( data[i].arrOrdNo );
							arrOrdDtlSeq.push( data[i].arrOrdDtlSeq );
							arrOrdDtlCnt.push( data[i].arrOrdDtlCnt );
							arrOrdCrmDivision.push("ord" );
						}else if(data[i].arrClmDtlStatCd == '${adminConstants.CLM_DTL_STAT_420}'){
							arrOrdNo.push( data[i].arrClmNo );
							arrOrdDtlSeq.push( data[i].arrClmDtlSeq );
							arrOrdDtlCnt.push( data[i].arrOrdDtlCnt );
							arrOrdCrmDivision.push("clm" );
						}

						arrDlvrNo.push( data[i].arrDlvrNo );
					}
				}

				for ( var i in data) {
					//주문번호
					var dlvrNo = null;
					// 선택한상품수
					var cnt = 0 ;
					for(var j in  arrDlvrNo ) {
						dlvrNo = arrDlvrNo[j];
				    	if(data[i].arrDlvrNo == dlvrNo){
							cnt = cnt +1;
						}
					}
					if(data[i].arrOrdDtlCnt != cnt ){
						messager.alert( "주문의 모든건 선택해야 합니다. \n원하지 않으면 배송분리를 이용하세요." ,"Info","info");
	  						return;
					}
				}

				var data = $("#orderSearchForm").serializeJson() ;
				data.ordDtlStatCd = ${adminConstants.ORD_DTL_STAT_130 };

				data.clmDtlStatCd = ${adminConstants.CLM_DTL_STAT_420 };
				var arrClmDtlStatCd =new Array();
				arrClmDtlStatCd.push( '${adminConstants.CLM_DTL_STAT_420 }'  ) ;
				$.extend( data, { excelDownY : true } );
				$.extend( data, { arrClmDtlStatCd : arrClmDtlStatCd.join(",") } );
				$.extend( data, { arrOrdNo :arrOrdNo } );
				$.extend( data, { arrOrdDtlSeq : arrOrdDtlSeq } );
				$.extend( data, { arrOrdCrmDivision : arrOrdCrmDivision } );
				
				// 개인정보 해제 시 엑셀 다운로드 마스킹 수정 (CSR-1081) 20210609
				// BO : 무조건 마스킹 (마스킹 O)
				// PO : 마스킹 해제 (마스킹 X)
				if ("${adminConstants.USR_GRP_10}" == "${adminSession.usrGrpCd}") {
					data.maskingUnlock = "${adminConstants.COMM_YN_N}";
				}

				// 개별 주문 선택 후 배송준비중 일괄 변경이면
				if (! checkAll) {
					messager.confirm('배송지시를 배송준비중으로 변경하시겠습니까?', function(r){
						if(r){
							createFormSubmit( "deliveryListExcelDownload", "/delivery/deliveryInstructionsListExcelDownload.do", data  );
						} 
					});
				}

				/* var data = { arrOrdNo :arrOrdNo ,arrOrdDtlSeq : arrOrdDtlSeq, arrOrdCrmDivision : arrOrdCrmDivision }; */
				//createFormSubmit( "deliveryListExcelDownload", "/delivery/deliveryInstructionsListExcelDownload.do", data  );

			}

 			//자사상품 선택시 true 리턴 - 2021.04.20 by kek01
			function isCheckedGsOrderJasa(){
				var data = new Array();
				$("#deliveryList input[name=arrDlvrNo]:checked").each(function(e) {
					data.push( $(this).parent().serializeJson() );
				});
				if ( data != null && data.length > 0 ) {
					for ( var i in data) {
						if(data[i].arrCompGbCd == '10'){
							messager.alert( "위탁 상품만 선택 가능합니다.<br/>(배송번호 "+data[i].arrDlvrNo+" 은 자사 상품입니다)" ,"Info","info");
	  						return false;
						}
					}
				}
				return true;
			}

			function fnUnlockPrivacyMasking(){
				var maskingUnlock = $("#maskingUnlock").val();
				if( $("#maskingUnlock").val() == '${adminConstants.COMM_YN_N}' ) {
					messager.confirm("<spring:message code='column.member_search_view.maksing_unlock_msg' />",function(r){
						if(r){
							//개인정보 숨김
							$("#maskingUnlock").val('${adminConstants.COMM_YN_Y}');
							reloadOrderListGrid();

						}
					});
				}else{
					//개인정보 해제
					messager.alert("<spring:message code='column.member_search_view.maksing_unlock_msg_already' />","Info","Info",function(){});
				}
			}

		</script>
	</t:putAttribute>

	<t:putAttribute name="content">
		<!-- ==================================================================== -->
		<!-- 검색 -->
		<!-- ==================================================================== -->
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="orderSearchForm" id="orderSearchForm">
					<input type="hidden" name="arrClmDtlStatCd">
					<input type="hidden" id = "searchOrdClmGbCd" name="searchOrdClmGbCd" value="${orderSO.ordClmGbCd}">
					<input type="hidden" id = "ordClmGbCd" name="ordClmGbCd" value="${orderSO.ordClmGbCd}">
					<input type="hidden" name="mbrNo" value="${orderSO.mbrNo }">
					<input type="hidden" id="maskingUnlock" name="maskingUnlock" value="${orderSO.maskingUnlock }">

					<table class="table_type1">
						<colgroup>
							<col style="width:150px">
							<col style="width:auto">
							<col style="width:150px">
							<col style="width:auto">
						</colgroup>
						<caption>정보 검색</caption>
						<tbody>
							<tr>
								<th scope="row">
									배송지시일자
								</th>
								<td colspan="3">
								    <select name="searchKeyOrder" title="선택상자" class="w120">
		                                <option value="type01" selected="selected">배송지시일자</option>
		                                <option value="type02">배송완료일자</option>
		                                <option value="type03">출고완료일자</option>
		                            </select>
									<frame:datepicker startDate="dtmStart" endDate="dtmEnd"  startValue="${frame:toDate('yyyy-MM-dd') }" endValue="${frame:toDate('yyyy-MM-dd') }" />
								</td>
<%-- 								<th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID --> --%>
<!-- 								<td> -->
<!-- 									<select id="stIdCombo" name="stId"> -->
<%-- 				                    	<frame:stIdStSelect defaultName="사이트선택" /> --%>
<!-- 				                    </select> -->
<!-- 								</td> -->
							</tr>
							<tr>
								<!-- 업체명 -->
								<th scope="row"><spring:message code="column.goods.comp_nm" /></th>
		                        <td>
		                            <frame:compNo funcNm="fnCallBackCompanySearchPop" disableSearchYn="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? 'N' : 'Y'}" placeholder="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? '입점업체를 검색하세요' : ''}"/>
		                            <c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
		                            &nbsp;&nbsp;&nbsp;<frame:lowCompNo funcNm="searchLowCompany" placeholder="하위업체를 검색하세요"/>
		                            </c:if>
		                        </td>
 								<!-- 업체 유형 -->
								<th scope="row"><spring:message code="column.comp_tp_cd" /></th>
								<td>
									 <frame:checkbox name="compTpCd" grpCd="${adminConstants.COMP_TP}" excludeOption="${adminConstants.COMP_TP_30}" />
									 <input type="hidden" name="arrCompTpCd" value="" />
								</td>
							</tr>
							<tr>
							<c:choose>
							<c:when test="${orderSO.ordClmGbCd eq adminConstants.ORD_CLM_GB_10}">
								<th scope="row"><spring:message code="column.ord_dtl_stat_cd" /></th>
		                        <td>
		                        	<select name="ordDtlStatCd" title="선택상자" class="w120">
										<frame:select grpCd="${adminConstants.ORD_DTL_STAT }" defaultName="전체" excludeOption="${adminConstants.ORD_DTL_STAT_110},${adminConstants.ORD_DTL_STAT_120}" />
									</select>
									<span class="blue-desc"> * 주문접수, 주문완료 상태 주문은 조회할 수 없습니다.</span>
		                        </td>
		                        <th scope="row">주문/상품</th>
								<td>
									<select name="ordNoGoodsIdSel" id="ordNoGoodsIdSel" title="선택상자">
										<option value="ordNo">주문번호</option>
										<option value="goodsId">상품번호</option>
									</select>
									<input type="text" name="ordNo" id="ordNo" class="w150" value="">
									<input type="text" name="goodsId" id="goodsId" class="w150" value="" style="display:none;">
		                        </td>
		                    </c:when>
		                    <c:when test="${orderSO.ordClmGbCd eq adminConstants.ORD_CLM_GB_20}">
		                        <th scope="row"><spring:message code="column.clm_dtl_stat_cd" /></th>
		                        <td>
		                        	<select name="clmDtlTpCd" id="clmDtlTpCd" title="선택상자" class="w120">
										<frame:select grpCd="${adminConstants.CLM_DTL_TP }" excludeOption="${adminConstants.CLM_DTL_TP_10}" defaultName="전체"  />
									</select>
		
									<select name="clmDtlStatCd" id="clmDtlStatCd" title="선택상자" >
										<%-- <frame:select grpCd="${adminConstants.CLM_DTL_STAT }" defaultName="전체"  /> --%>
									</select>
		                        </td>
		                        <th scope="row"><spring:message code="column.clm_no" /></th>
		                        <td>
		                            <input type="text" name="clmNo" id="clmNo" class="w150" value="" />
		                        </td>
		                    </c:when>
		                    </c:choose>
							</tr>
							<tr>
		                        <th scope="row"><spring:message code="column.dlvr_delay_days" /></th> <!-- 배송지연기간 -->
		                        <td colspan="3">
		                            <frame:radio name="dlvrDelayPrd" grpCd="${adminConstants.DLVR_DELAY_PRD }" />
		                        </td>
							</tr>
							<tr>
								<!-- 택배사 -->
								<th scope="row"><spring:message code="column.order_common.hdc" /></th>
								<td>
									<select name="hdcCd" title="선택상자" >
										<frame:select grpCd="${adminConstants.HDC }" defaultName="전체"  />
									</select>
		
									<!-- 송장번호 -->
									<input type="text" id="invNo" name="invNo" class="numeric validate[ custom[onlyNum] ]" value="" autocomplete="off" />
								</td>
								<!-- 배송 처리 유형 -->
		                        <th scope="row"><spring:message code="column.dlvr_prcs_tp_cd" /></th>
		                        <td>
									 <frame:checkbox name="dlvrPrcsTpCd" grpCd="${adminConstants.DLVR_PRCS_TP}" />
									 <input type="hidden" name="arrDlvrPrcsTpCd" value="" />
		                        </td>
							</tr>
						</tbody>
					</table>
				</form>
				
				<div class="btn_area_center">
					<button type="button" onclick="reloadOrderListGrid('');" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>
		<!-- ==================================================================== -->
		<!-- 검색 -->
		<!-- ==================================================================== -->

		<!-- ==================================================================== -->
		<!-- 그리드 -->
		<!-- ==================================================================== -->
		<div class="mModule">
			<div class="mButton">
				<div class="leftInner">
					<!-- 배송완료 외 CIS 인터페이스 처리로 제외 2020.01.07 kjhvf01 -->
					<button type="button" onclick="fnDeliveryReady();" class="btn btn-add"><spring:message code='column.order_common.btn.delivery_ready' /></button>
					<%-- <button type="button" onclick="fnDeliveryDivision();" class="btn btn-add"><spring:message code='column.delivery_ivision' /></button> --%>
					<button type="button" onclick="fnDeliveryInvoiceOneCreatePop();" class="btn btn-add"><spring:message code='column.order_common.btn.delivery_invoice_one_create' /></button>
					<button type="button" onclick="fnDeliveryInvoiceBatchCreatePop();" class="btn btn-add"><spring:message code='column.order_common.btn.delivery_invoice_batch_create' /></button>
					<%-- <c:if test="${adminSession.usrGbCd eq adminConstants.USR_GB_1030 or adminSession.usrGbCd eq adminConstants.USR_GB_1031}">
					<button type="button" onclick="fnDeliveryInvoiceUpdatePop();" class="btn btn-add">송장단순수정</button>
					</c:if> --%>
					<button type="button" onclick="fnDeliveryFinal();" class="btn btn-add"><spring:message code='column.order_common.btn.delivery_final' /></button>
					<button type="button" onclick="fnDeliveryHistory();" class="btn btn-add"><spring:message code='column.order_common.btn.delivery_final_history' /></button>
				</div>
				<div class="rightInner">
					<button type="button" onclick="FnDeliveryInstructionsListExcelDownload();" class="btn btn-add btn-excel" style="width:170px">배송준비중 일괄 변경 </button> 
					<button type="button" onclick="deliveryListExcelDownload(1);" class="btn btn-add btn-excel"><spring:message code='column.common.btn.excel_download' /></button>
					<button type="button" style="width:auto;" onclick="fnUnlockPrivacyMasking();" class="btn btn-add" id='privacyBtn'>개인정보 해제</button>
				</div>
			</div>
			
			<table id="deliveryList" ></table>
			<div id="deliveryListPage"></div>
		</div>
		<!-- ==================================================================== -->
		<!-- //그리드 -->
		<!-- ==================================================================== -->

	</t:putAttribute>

</t:insertDefinition>

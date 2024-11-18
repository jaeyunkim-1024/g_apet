
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	
	<t:putAttribute name="script">

		<script type="text/javascript">
			$(document).ready(function(){
				$("#exOrdCancelYn").prop("checked", true);
				$("#compTpCd20").prop("checked", true);
				searchDateChange();
				settlementList.createGrid();
				
				newSetCommonDatePickerEvent('#ordAcptDtmStart','#ordAcptDtmEnd');
				

				// input 엔터 이벤트
				$(document).on("keydown","input[name=searchValueOrder], input[name=searchValueGoods]",function(e){ 
					if ( e.keyCode == 13 ) {
						settlementList.reload('');
					}
				});
			});
			
			// 주문상태 전체 컨트롤
			$(function(){
				$("input:checkbox[name=arrOrdDtlStatCd]").click(function(){
					var all = false;
					if ( validation.isNull( $(this).val() ) ){
						all = true;
					}
					if ( $('input:checkbox[name="arrOrdDtlStatCd"]:checked').length == 0 ) {
						$('input:checkbox[name="arrOrdDtlStatCd"]').eq(0).prop( "checked", true );
					} else {
						$('input:checkbox[name="arrOrdDtlStatCd"]').each( function() {
							if ( all ) {
								if ( validation.isNull( $(this).val() ) ) {
									$(this).prop("checked", true);
								} else {
									$(this).prop("checked", false);
								}
							} else {
								if ( validation.isNull($(this).val() ) ) {
									$(this).prop("checked", false);
								}
							}
						});
					}
				});

			});
			
			// 결제수단 전체 컨트롤
			$(function(){
				$("input:checkbox[name=arrPayMeansCd]").click(function(){
					var all = false;
					if ( validation.isNull( $(this).val() ) ){
						all = true;
					}
					if ( $('input:checkbox[name="arrPayMeansCd"]:checked').length == 0 ) {
						$('input:checkbox[name="arrPayMeansCd"]').eq(0).prop( "checked", true );
					} else {
						$('input:checkbox[name="arrPayMeansCd"]').each( function() {
							if ( all ) {
								if ( validation.isNull( $(this).val() ) ) {
									$(this).prop("checked", true);
								} else {
									$(this).prop("checked", false);
								}
							} else {
								if ( validation.isNull($(this).val() ) ) {
									$(this).prop("checked", false);
								}
							}
						});
					}
				});

			});

			var settlementList = {
				/*
				 * 주문 목록 그리드 생성
				 */
				createGrid : function(){
					var options = {
						url : "<spring:url value='/settlement/settlementListGrid.do' />"
						, colModels : [
							{name:"ordNoPayAmt", label:'<spring:message code="column.ord_no" />', width:"150", align:"center", sortable:false, classes:'cursor_default'},
				             // 주문번호
				             {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"150", align:"center", sortable:false, hidden:true}
                            // 주문상세일련번호
                            , {name:"ordDtlSeq", label:'<b><u><tt><spring:message code="column.ord_dtl_seq" /></tt></u></b>', width:"100", align:"center", sortable:false, classes:'cursor_default'}
				 			 // 주문매체
				            , {name:"ordMdaCd", label:'<spring:message code="column.ord_mda_cd" />', width:"60", align:"center", formatter:"select", sortable:false, classes:'cursor_default', editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ORD_MDA}" />"}}
				 			// 주문자ID
				 			, {name:"ordrId", label:'<spring:message code="column.ordUserId" />', width:"80", align:"center", sortable:false, classes:'cursor_default'}
				 			// 주문자명
				 			, {name:"ordNm", label:'<spring:message code="column.ord_nm" />', width:"70", align:"center", sortable:false, classes:'cursor_default'}
				 			// 주문자 휴대폰
				 			, {name:"ordrMobile", label:'<spring:message code="column.ord.ordrMobile" />', width:"100", align:"center", classes:'cursor_default',  formatter:gridFormat.phonenumber, sortable:false}
                         	<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
                         	// 업체 구분 유형
                            , {name:"compTpCd", label:'<spring:message code="column.comp_tp_cd" />', width:"70", align:"center", sortable:false, classes:'cursor_default', formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.COMP_TP}" />"}}
                            </c:if>
                         	// 업체 명
                            , {name:'compNm', label:'<spring:message code="column.comp_nm" />', width:'130', align:'center', sortable:false, classes:'cursor_default'}
                        	// 배송 처리 유형
				 			, {name:"dlvrPrcsTpNm", label:'<spring:message code="column.dlvr_prcs_tp_cd" />', width:"90", align:"center", classes:'cursor_default'
					 			, cellattr : function(rowId, value, rowObject){
				 				if(rowObject.dlvrPrcsTpCd == '${adminConstants.DLVR_PRCS_TP_10}' || rowObject.compGbCd ==='20'){
				 					//택배 -검정
				 					return 'style="color:#000000"';
				 				}else if(rowObject.dlvrPrcsTpCd == '${adminConstants.DLVR_PRCS_TP_20}'){
				 					//당일배송 -초록
				 					return 'style="color:#05B36D"';
				 				}else if(rowObject.dlvrPrcsTpCd == '${adminConstants.DLVR_PRCS_TP_21}'){
				 					//새벽배송 -파랑
				 					return 'style="color:#2F6FFD"';
				 				}		
					 			}
				 			}
                            , {name:'goodsNm', label:'<b><u><tt><spring:message code="column.goods_nm" /></tt></u></b>', width:'320', align:'center', sortable:false, classes:'cursor_default'}
                            // 주문내역상태코드 이름
                            , {name:"ordDtlStatCdNm", label:'<spring:message code="column.ord_dtl_stat_cd" />', width:"80", align:"center", sortable:false, classes:'cursor_default'}
                         	// 구매확정일시
				            , {name:"purConfDtm", label:'<spring:message code="column.settlement.tax.pur_conf_dtm" />', width:"150", align:"center", sortable:false, classes:'cursor_default', formatter: function(cellvalue, options, rowObject) {
								if(rowObject.ordDtlStatCd == '${adminConstants.ORD_DTL_STAT_170}') {
									return new Date(rowObject.purConfDtm).format("yyyy-MM-dd HH:mm");
								} else {
									return '';
								}
							}, dateformat:"yyyy-MM-dd HH:mm"}
				         	// 정산 상태
			 				, {name:"ordCclStatCd", label:'<spring:message code="column.settlement.stl_stat_nm" />', width:"80", align:"center", formatter:"select", sortable:false, classes:'cursor_default', editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ORD_LST_STL_STT}" />"}}
			 				// 정산완료일시
				            , {name:"ordCclCpltDtm", label:'<spring:message code="column.settlement.tax.stl_cplt_dtm" />', width:"150", align:"center", sortable:false, classes:'cursor_default', formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm"}
				            // 주문접수일자
				            , {name:"ordAcptDtm", label:'<spring:message code="column.ord_acpt_dtm" />', width:"150", align:"center", sortable:false, classes:'cursor_default', formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm"}
				             // 주문완료일자
				            , {name:"ordCpltDtm", label:'<spring:message code="column.ord_cplt_dtm" />', width:"150", align:"center", sortable:false, classes:'cursor_default', formatter:gridFormat.date, dateformat:"yyyy-MM-dd HH:mm"}
				         	// 브랜드명
                            , {name:'bndNmKo', label:'<spring:message code="column.bnd_nm" />', width:'150', align:'center', sortable:false, classes:'cursor_default'}
						 	// 주문수량
						 	, {name:"ordQty", label:'<spring:message code="column.ord_qty" />', width:"60", align:"center", formatter:'integer', classes:'cursor_default'}
						 	// 취소수량
						 	, {name:"cncQty", label:'<spring:message code="column.cnc_qty" />', width:"60", align:"center", formatter:'integer', classes:'cursor_default'}
						 	// 반품수량
						 	, {name:"rtnQty", label:'<spring:message code="column.rtn_qty" />', width:"60", align:"center",  formatter:'integer', hidden:true}
				 			// 반품완료수량
				 			, {name:"rtnCpltQty", label:'<spring:message code="column.rtn_cplt_qty" />', width:"74", align:"center", formatter:'integer', sortable:false, classes:'cursor_default'}
				 			// 반품진행수량
				 			, {name:"rtnIngQty", label:'<spring:message code="column.rtn_ing_qty" />', width:"74", align:"center", formatter:'integer', sortable:false, classes:'cursor_default'}
				 			// 교환진행수량
				 			, {name:"clmExcIngQty", label:'<spring:message code="column.clm_exc_ing_qty" />', width:"74", align:"center", formatter:'integer', sortable:false, classes:'cursor_default'}
				 			// 상품금액
				 			, {name:"saleAmt", label:'<spring:message code="column.sale_unit_prc" />', width:"80", align:"center", formatter:'integer', sortable:false, classes:'cursor_default'}
				 			// 쿠폰 할인 금액
				 			, {name:"cpDcAmt", label:'<spring:message code="column.cp_dc_unit_prc" />', width:"80", align:"center", formatter:'integer', sortable:false, classes:'cursor_default'}
				 			// 실 배송 금액
				 			, {name:"realDlvrAmt", label:'<spring:message code="column.real_dlvr_amt" />', width:"75", align:"center", sortable:false, classes:'cursor_default', formatter:'integer', formatoptions:{thousandsSeparator:','}, summaryType:'sum', summaryTpl : 'Totals:', cellattr:fnDeliveryListRowSpan}
				 			// 건별결제금액
						    , {name:"paySumAmt", label:'<spring:message code="column.order_common.pay_dtl_amt" />', width:"80", align:"center", formatter:'integer', sortable:false, classes:'cursor_default'}
				 			// 수령인 명
				 			, {name:"adrsNm", label:'<spring:message code="column.ord.adrsNm" />', width:"150", align:"center", sortable:false, classes:'cursor_default'}
				 			// 수령인 휴대폰
				 			, {name:"mobile", label:'<spring:message code="column.ord.mobile" />', width:"100", align:"center", formatter:gridFormat.phonenumber, sortable:false, classes:'cursor_default'}
				 			// 수령인 주소 1
				 			, {name:"roadAddr", label:'<spring:message code="column.ord.roadAddr" />', width:"300", align:"center", sortable:false, classes:'cursor_default'}
				 			// 수령인 주소 2
				 			, {name:"roadDtlAddr", label:'<spring:message code="column.ord.roadDtlAddr" />', width:"200", align:"center", sortable:false, classes:'cursor_default'}
				 			// 주문제작
				 			, {name:"mkiGoodsYn", label:'<spring:message code="column.order_common.mki_goods_yn" />', width:"80", align:"center", sortable:false, classes:'cursor_default'}
				 			// 사전예약
				 			, {name:"rsvGoodsYn", label:'<spring:message code="column.order_common.rsv_goods_yn" />', width:"80", align:"center", sortable:false, classes:'cursor_default'}
				 			// 사은품여부
				 			, {name:"frbGoodsYn", label:'<spring:message code="column.order_common.frb_goods_yn" />', width:"80", align:"center", sortable:false, classes:'cursor_default'}
				 			// 상품 구성 유형
			 				, {name:"goodsCstrtTpCd", label:'<spring:message code="column.goods_cstrt_cd" />', width:"80", align:"center", formatter:"select", sortable:false, classes:'cursor_default', editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.GOODS_CSTRT_TP}" />"}}
				 			// 묶음 여부
				 			, {name:"pakGoodsYn", label:'<spring:message code="column.order_common.pak_goods_yn" />', width:"80", align:"center", sortable:false, classes:'cursor_default'}
				 			
				 			// 사이트 ID
				 			, {name:"stId", label:"<spring:message code='column.st_id' />", hidden:true}
				 			, {name:"goodsId", label:'<spring:message code="column.goods_id" />', hidden: true}
				 			// 단품명
						 	, {name:"itemNm", label:'<spring:message code="column.item_nm" />', hidden: true}
						 	// 주문내역상태코드
                            , {name:"ordDtlStatCd", label:'<spring:message code="column.ord_dtl_stat_cd" />', width:"80", align:"center", sortable:false, hidden:true}
                         	// 클레임상태
                            , {name:"clmIngYn", label:'<spring:message code="column.clm_stat_cd" />', hidden:true}
                        	 // 잔여주문수량
				 			, {name:"rmnOrdQty", label:'<spring:message code="column.rmn_ord_qty" />', hidden:true}
				 			// 프로모션 할인 금액 삭제
				 			, {name:"prmtDcAmt", label:'<spring:message code="column.prmt_dc_unit_prc" />', hidden: true}
				 			, {name:"dlvrPrcsTpCd", hidden: true}
				 			//업체구분코드	
				 			, {name:"compGbCd",hidden:true}
				 		]
						, height : 400
						, multiselect : true
						, searchParam : serializeFormData()
						, gridComplete: function() {  /** 데이터 로딩시 함수 **/

			            	var ids = $('#settlementList').jqGrid('getDataIDs');

			                // 그리드 데이터 가져오기
			                var gridData = $("#settlementList").jqGrid('getRowData');

			            	if(gridData.length > 0){
				                // 데이터 확인후 색상 변경
				                for (var i = 0; i < gridData.length; i++) {

				                	// 데이터의 is_test 확인
				                	if (gridData[i].rmnOrdQty == '0') {

				                		// 열의 색상을 변경하고 싶을 때(css는 미리 선언)
				                		$('#settlementList tr[id=' + ids[i] + ']').css('color', 'red');
				                   }
				            		//업무구분코드
				                	if(gridData[i].compGbCd === '20'){
				               			$("#settlementList").jqGrid('setCell', ids[i],'dlvrPrcsTpNm', '택배');
				               			$("#settlementList").jqGrid('setCell', ids[i],'goodsNm', '<span style="color:#000000"></span>' + $("#settlementList").getCell(ids[i], 'goodsNm'));
				                	}else if(gridData[i].dlvrPrcsTpCd === '${adminConstants.DLVR_PRCS_TP_10}'){
				               			$("#settlementList").jqGrid('setCell', ids[i],'dlvrPrcsTpNm', '택배');
									}else if(gridData[i].dlvrPrcsTpCd === '${adminConstants.DLVR_PRCS_TP_20}'){
										$("#settlementList").jqGrid('setCell', ids[i],'dlvrPrcsTpNm', '당일');
										$("#settlementList").jqGrid('setCell', ids[i],'goodsNm', '<span style="color:#05B36D">[당일]</span>' + $("#settlementList").getCell(ids[i], 'goodsNm'));
									}else if(gridData[i].dlvrPrcsTpCd === '${adminConstants.DLVR_PRCS_TP_21}'){
										$("#settlementList").jqGrid('setCell', ids[i],'dlvrPrcsTpNm', '새벽');
										$("#settlementList").jqGrid('setCell', ids[i],'goodsNm', '<span style="color:#2F6FFD">[새벽]</span>' + $("#settlementList").getCell(ids[i], 'goodsNm'));
									}
				                }
			            	}			            			

			            }
						, grouping: true
						, groupField: ["ordNoPayAmt"]
						, groupText: ["주문번호"]
						, groupOrder : ["asc"]
						, groupCollapse: false
						, groupColumnShow : [false]
					};
					options.accessYn = "${adminConstants.COMM_YN_Y}"
					va.la($("#maskingUnlock").val());
					options.searchParam = $.extend(serializeFormData(),va.data);
					grid.create( "settlementList", options);
				}
				/*
				 * 주문 목록 재조회
				 */
				, reload : function(){
					compareDateAlert('ordAcptDtmStart','ordAcptDtmEnd','term');
					
					// 주문 접수 일시 시작일
					var ordAcptDtmStart = $("#ordAcptDtmStart").val().replace( /-/gi, "" );

					// 주문 접수 일시 종료일
					var ordAcptDtmEnd = $("#ordAcptDtmEnd").val().replace( /-/gi, "" );
					
					if ($("#searchKeyOrder").val() == "type01" && $("#searchValueOrder").val().trim() != "") {
						// 주문번호 검색이면 날짜 검색을 안함
					} else {
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
					}
					
					<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
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
					</c:if>

					var options = {
						searchParam : $.extend(serializeFormData(),va.data)
					};
					gridReload('ordAcptDtmStart','ordAcptDtmEnd','settlementList','term', options);
				}
			};

			function serializeFormData() {
	            var data = $("#orderSearchForm").serializeJson();
	            
	            $.extend(data, {exOrdCancelYn : $("#exOrdCancelYn").prop("checked") ? 'Y' : 'N'}); 
	            $.extend(data, {preReserveYn : $("#preReserveYn").prop("checked") ? 'Y' : 'N'}); 
	            
	            // 주문상태
	            if ( undefined != data.arrOrdDtlStatCd && data.arrOrdDtlStatCd != null){ //데이터 있는 경우만
	            	if(Array.isArray(data.arrOrdDtlStatCd)){ // 배열인 경우
	            		 $.extend(data, {
	            			 	arrOrdDtlStatCd : data.arrOrdDtlStatCd.join(","),
	            			 	ordDtlStatCd : ""
	            			 });
	            	}else{									// 배열이 아닌경우
	            		if ($("#arrOrdDtlStatCd_default").not(':checked')) {	// 전체 체크시 param 보내지 않음
	            		 $.extend(data, {
		            			 arrOrdDtlStatCd : "",
		            			 ordDtlStatCd : data.arrOrdDtlStatCd
	            			 });
	            		}
	            	}
	            }
	            
	         // 정산상태
	            if ( undefined != data.arrOrdListStatCd && data.arrOrdListStatCd != null){ //데이터 있는 경우만
	            	if(Array.isArray(data.arrOrdListStatCd)){ // 배열인 경우
	            		 $.extend(data, {
	            			 arrOrdListStatCd : data.arrOrdListStatCd.join(","),
	            			 ordListStatCd : ""
	            			 });
	            	}else{									// 배열이 아닌경우
	            		$.extend(data, {
	            			arrOrdListStatCd : "",
	            			ordListStatCd : data.arrOrdListStatCd
	            		});
	            	}
	            }
	            
	            // 결제 수단
	            if ( undefined != data.arrPayMeansCd && data.arrPayMeansCd != null){ //데이터 있는 경우만
	            	if(Array.isArray(data.arrPayMeansCd)){ // 배열인 경우
	            		 $.extend(data, {
	            			 	arrPayMeansCd : data.arrPayMeansCd.join(","),
	            			 	payMeansCd	: ""
	            		 	});
	            	}else{									// 배열이 아닌경우
	            		if ($("#arrPayMeansCd_default").not(':checked')) {	// 전체 체크시 param 보내지 않음
	            		 $.extend(data, {
	            			 	arrPayMeansCd : "",
	            			 	payMeansCd : data.arrPayMeansCd
	            			});
	            		}
	            	}
	            }
	           
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

			// callback : 업체 검색
			function fnCompanySearchPop() {
				var data = {
					multiselect : false
					, callBack : function(result) {
						$("#compNo").val( result[0].compNo );
						$("#compNm").val( result[0].compNm );
					}
					<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
                    	, showLowerCompany : 'Y'
					</c:if>
				}
				layerCompanyList.create(data);
			}

	          // 하위 업체 검색
            function fnCompayLowSearchPop () {
                var options = {
                    multiselect : false
                    , callBack : fnCompayLowSearchPopCallback
					<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
                    	, showLowerCompany : 'Y'
					</c:if>
                }
                layerCompanyList.create (options );
            }
            // 업체 검색 콜백
            function fnCompayLowSearchPopCallback(compList) {
                if(compList.length > 0) {
                    $("#orderSearchForm #lowCompNo").val (compList[0].compNo);
                    $("#orderSearchForm #lowCompNm").val (compList[0].compNm);
                }
            }

            $(document).on("click", "input:checkbox[name=showAllLowComp]", function(e){
                if ($(this).is(":checked")) {
                    $("#showAllLowCompany").val("Y");
                } else {
                    $("#showAllLowCompany").val("N");
                }
            });

            // 초기화 버튼클릭
            function searchReset () {
                resetForm ("orderSearchForm");
                searchDateChange();
                $("#exOrdCancelYn").prop("checked", true);
                $("#compTpCd20").prop("checked", true);
                $("#maskingUnlock").val('N');
                $("input[name=arrCompTpCd]").val('${adminConstants.COMP_TP_20}');
                <c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
                $("#orderSearchForm #compNo").val('${adminSession.compNo}');
                $("#orderSearchForm #showAllLowCompany").val("N");
                </c:if>
            }

			// 엑셀 다운로드
			function settlementListExcelDownload(type){
				$('#searchTypeExcel').val(type);
				var searchData = $("#orderSearchForm").serializeJson();
				va.la($("#maskingUnlock").val(),"${adminConstants.INQR_GB_60}");
				var data = $.extend(searchData,va.data);
				
				// 개인정보 해제 시 엑셀 다운로드 마스킹 수정 (CSR-1081) 20210609
				// BO : 무조건 마스킹 (마스킹 O)
				// PO : 마스킹 해제 (마스킹 X)
				if ("${adminConstants.USR_GRP_10}" == "${adminSession.usrGrpCd}") {
					data.maskingUnlock = "${adminConstants.COMM_YN_N}";
				}
				
				$.extend(data, {exOrdCancelYn : $("#exOrdCancelYn").prop("checked") ? 'Y' : 'N'});
				
				createFormSubmit( "settlementListExcelDownload", "/settlement/settlementAdjustListExcelDownload.do", data);
			}

			// 등록일 변경
			function searchDateChange() {
				var term = $("#checkOptDate").children("option:selected").val();
				if(term == "") {
					$("#ordAcptDtmStart").val("");
					$("#ordAcptDtmEnd").val("");
				} else if(term == "50") {
					setSearchDateThreeMonth("ordAcptDtmStart","ordAcptDtmEnd");
				} else {
					setSearchDate(term, "ordAcptDtmStart", "ordAcptDtmEnd");
				}
			}
			
			// 
			function searchKeyDateChange() {
				var keyDate = $("#searchKeyDate").children("option:selected").val();
				if(keyDate == "type01") {
					$('input:checkbox[name="arrOrdDtlStatCd"]').prop( "checked", false );
					$("#arrOrdDtlStatCd170").prop("checked", true);
				}
				
				if(keyDate == "type02") {
					$("#arrOrdListStatCd20").prop("checked", true);
					$("#arrOrdListStatCd10").prop("checked", false);
					$('input:checkbox[name="arrOrdDtlStatCd"]').prop( "checked", false );
					$("#arrOrdDtlStatCd170").prop("checked", true);
				}
			}
			//개인정보 해제
			function fnUnlockPrivacyMasking(){		
				if( $("#maskingUnlock").val() == '${adminConstants.COMM_YN_N}' ) {
					messager.confirm("<spring:message code='column.member_search_view.maksing_unlock_msg' />",function(r){
						if(r){
							//개인정보 숨김
							$("#maskingUnlock").val('${adminConstants.COMM_YN_Y}');
							$("#privacyBtn").text("개인정보 해제");
							settlementList.reload();



						}
					});
				}else{
					messager.alert("<spring:message code='column.member_search_view.maksing_unlock_msg_already' />","Info","Info",function(){});
				}
								
			}
			// 정산 상태 일괄 변경
			function batchUpdateStat() {
				let grid = $("#settlementList");
				let rowids = grid.jqGrid('getGridParam', 'selarrrow');
				if(rowids.length <= 0 ) {
					messager.alert("<spring:message code='column.settlement.tax.update.no_select' />", "Info", "info");
					return;
				}
				
				let ordDtlSeqs = new Array();
				
				for (let i = 0; i < rowids.length; i++) {
					let ordNo = grid.getCell(rowids[i], 'ordNo');
					let ordDtlSeq = grid.getCell(rowids[i], 'ordDtlSeq');
					let ordDtlStatCd = grid.getCell(rowids[i], 'ordDtlStatCd');
					let ordCclStatCd = grid.getCell(rowids[i], 'ordCclStatCd');
					
					if (ordDtlStatCd != '${adminConstants.ORD_DTL_STAT_170}') {
						messager.alert("<spring:message code='column.settlement.tax.update.only_purchase_confirm' />", "Info", "info");
						return;
					}
					
					if (ordCclStatCd != '${adminConstants.ORD_LST_STL_STT_10}') {
						messager.alert("<spring:message code='column.settlement.tax.update.only_settlement_wait' />", "Info", "info");
						return;
					}
					ordDtlSeqs.push (ordNo + '|' + ordDtlSeq);
				}

				messager.confirm("<spring:message code='column.settlement.tax.update.confirm' />",function(r){
					if(r){


						let sendData = {
							ordDtlSeqs : ordDtlSeqs
						};

						let options = {
							url : "<spring:url value='/settlement/batchUpdateStat.do' />"
							, data : sendData
							, callBack : function(data) {
								messager.alert("<spring:message code='column.settlement.tax.update.final_msg' />", "Info", "info", function(){
									settlementList.reload();
								});
							}
						};
						ajax.call(options);
					}
				});
				
			}
		</script>

	</t:putAttribute>

	<t:putAttribute name="content">
	
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<form name="orderSearchForm" id="orderSearchForm">
				<input type='hidden' name='maskingUnlock' id='maskingUnlock' value="${adminConstants.COMM_YN_N}">
				<input type='hidden' name='inqrHistNo' id='inqrHistNo' value="${inqrHistNo}">								
					<table class="table_type1">
						<colgroup>
							<col style="width:150px">
							<col style="width:auto">
							<col style="width:150px">
							<col style="width:auto">
						</colgroup>
						<caption>주문 검색</caption>
						<tbody>
							<input type="hidden" id="searchTypeExcel" name="searchTypeExcel" value=""/>
							<tr>
								<!-- 주문 접수 일자 -->
								<th scope="row">조회 기간</th>
								<td colspan="3">
									<select name="searchKeyDate" id="searchKeyDate" class="w100" title="선택상자" onchange="searchKeyDateChange();" >
		                                <option value="type01">구매확정일시</option>
		                                <option value="type02">정산완료일시</option>
		                                <option value="type03">주문접수일시</option>
		                            </select>
									<frame:datepicker startDate="ordAcptDtmStart" endDate="ordAcptDtmEnd" startValue="${frame:toDate('yyyy-MM-dd') }"  endValue="${frame:toDate('yyyy-MM-dd') }"  />
									&nbsp;&nbsp;
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }"  selectKey="${adminConstants.SELECT_PERIOD_40}" defaultName="기간선택" />
									</select>
								</td>
								<!-- 사이트 ID -->
<%-- 			                    <th scope="row"><spring:message code="column.st_id" /></th> <!-- 사이트 ID --> --%>
<!-- 			                    <td> -->
<%-- 			                        <select name="stId" title="<spring:message code="column.st_id" />"> --%>
<%-- 		                       			<frame:stIdStSelect defaultName="사이트선택" /> --%>
<!-- 			                        </select> -->
<!-- 			                    </td> -->
							</tr>
							<tr>
		                        <!-- 업체구분 -->
		                        <th scope="row"><spring:message code="column.goods.comp_nm" /></th>
		                        <td>
		                            <frame:compNo funcNm="fnCompanySearchPop" disableSearchYn="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? 'N' : 'Y'}" placeholder="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? '입점업체를 검색하세요' : ''}"/>
		                            <c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
		                            &nbsp;&nbsp;&nbsp;<frame:lowCompNo funcNm="fnCompayLowSearchPop" placeholder="하위업체를 검색하세요"/>
		                            &nbsp;&nbsp;&nbsp;<input type="checkbox" id="showAllLowComp" name="showAllLowComp"><span>하위업체 전체 선택</span>
		                            <input type="hidden" id="showAllLowCompany" name="showAllLowCompany" value="N"/>
		                            </c:if>
		                        </td>
		                        <!-- 업체 유형 -->
								<th scope="row"><spring:message code="column.comp_tp_cd" /></th>
								<td>
									 <frame:checkbox name="compTpCd" grpCd="${adminConstants.COMP_TP}" excludeOption="${adminConstants.COMP_TP_30}" />
									 <input type="hidden" name="arrCompTpCd" value="${adminConstants.COMP_TP_20}" />
								</td>
							</tr>
							<tr>
								 <!-- 주문정보 -->
		                        <th scope="row"><spring:message code="column.order_common.order_info" /></th>
		                        <td>
		                            <select name="searchKeyOrder" id="searchKeyOrder" class="w100" title="선택상자" >
		                                <option value="type01">주문번호</option>
		                                <option value="type02">주문자명</option>
		                                <option value="type03">주문자ID</option>
		                                <option value="type04">수령인명</option>
		                                <option value="type05">user no</option>
		                                <option value="type06">주문자 연락처</option>
		                            </select>
		                            <input type="text" name="searchValueOrder" id="searchValueOrder" class="w120"  value="" />
		                        </td>
		                        <!-- 상품정보 -->
		                        <th scope="row"><spring:message code="column.order_common.goods_info" /></th>
		                        <td>
		                            <select name="searchKeyGoods" class="w100" title="선택상자" >
		                                <option value="type01">상품명</option>
		                                <option value="type02">상품번호</option>
		                            </select>
		                            <input type="text" name="searchValueGoods" class="w120" value="" />
		                        </td>
							</tr>
							<tr>
								<!-- 주문매체 -->
		                        <%-- <th scope="row"><spring:message code="column.ord_mda_cd" /></th>
		                        <td>
		                            <frame:radio name="ordMdaCd" grpCd="${adminConstants.ORD_MDA }" defaultName="전체" />
		                        </td> --%>
		                        <!-- 정산 상태 -->
		                        <th scope="row"><spring:message code="column.settlement.stl_stat_nm" /></th>
		                        <td>
									 <frame:checkbox name="arrOrdListStatCd" grpCd="${adminConstants.ORD_LST_STL_STT }" checkedArray="${adminConstants.ORD_LST_STL_STT_10}" />
		                        </td>
		                        <!-- 주문 취소 -->
		                        <th scope="row"><spring:message code="column.ord_cancel" /></th>
								<td>
									<label class="fCheck"><input type="checkbox" name="exOrdCancelYn" id="exOrdCancelYn"/><span>주문취소제외</span></label>
								</td>
							</tr>
							<tr>
								<!-- 주문상세상태 -->
								<th scope="row"><spring:message code="column.order_common.ord_stat_cd" /></th>
								<td colspan="3">
									<frame:checkbox name="arrOrdDtlStatCd" grpCd="${adminConstants.ORD_DTL_STAT }" defaultName="전체" defaultId="arrOrdDtlStatCd_default" excludeOption="${adminConstants.USR_GRP_20 eq adminSession.usrGrpCd ? adminConstants.ORD_DTL_STAT_110 : ''},${adminConstants.USR_GRP_20 eq adminSession.usrGrpCd ? adminConstants.ORD_DTL_STAT_120 : ''}" defaultChecked="N" checkedArray="${adminConstants.ORD_DTL_STAT_170}" />
								</td>
							</tr>
							<tr>
								<!-- 결제수단 -->
								<th scope="row"><spring:message code="column.pay_means_cd" /></th>
								<td colspan="3">
									 <frame:checkbox name="arrPayMeansCd" useYn="${adminConstants.COMM_YN_Y}" grpCd="${adminConstants.PAY_MEANS }" defaultName="전체" defaultId="arrPayMeansCd_default" />
								</td>
							</tr>
							<c:choose>
								<c:when test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}" >
									<tr>
										<!-- 사전예약 -->
				                        <th scope="row"><spring:message code="column.pre_reserve" /></th>
				                        <td>
				                            <label class="fCheck"><input type="checkbox" name="preReserveYn" id="preReserveYn"/><span>사전예약만 조회</span></label>
				                        </td>
				                        <!-- 배송 처리 유형 -->
				                        <th scope="row"><spring:message code="column.dlvr_prcs_tp_cd" /></th>
				                        <td>
											 <frame:checkbox name="dlvrPrcsTpCd" grpCd="${adminConstants.DLVR_PRCS_TP}" />
											 <input type="hidden" name="arrDlvrPrcsTpCd" value="" />
				                        </td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr>
										<!-- 사전예약 -->
				                        <th scope="row"><spring:message code="column.pre_reserve" /></th>
				                        <td colspan="3">
				                            <label class="fCheck"><input type="checkbox" name="preReserveYn" id="preReserveYn"/><span>사전예약만 조회</span></label>
				                        </td>
				                    </tr>    
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</form>
				
				<div class="btn_area_center">
					<button type="button" onclick="settlementList.reload('');" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>

		<div class="mModule">
			<div id="resultArea">
				<button type="button" onclick="batchUpdateStat();" class="btn btn-add">정산 상태 일괄 변경</button>
				
				<c:if test="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd}">
				<button type="button" style="width:auto;margin-right: 125px;" onclick="settlementListExcelDownload('adjust');" class="btn btn-add btn-excel right">&nbsp;정산내역 엑셀 다운로드</button>
				</c:if>
				
				<c:if test="${adminConstants.USR_GRP_20 eq adminSession.usrGrpCd}">
				<button type="button" style="width:auto;margin-right: 125px;" onclick="settlementListExcelDownload('adjust');" class="btn btn-add btn-excel right">&nbsp;정산내역 엑셀 다운로드</button>
				</c:if>
	
				<button type="button" style="width:auto;" onclick="fnUnlockPrivacyMasking();" class="btn btn-add right" id='privacyBtn'>개인정보 해제</button>
				
			</div>
			
			<table id="settlementList" ></table>
			<div id="settlementListPage"></div>
		</div>
	</t:putAttribute>

</t:insertDefinition>

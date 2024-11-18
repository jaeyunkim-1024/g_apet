<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<t:insertDefinition name="contentsLayout">

	<t:putAttribute name="script">
	
		<script type="text/javascript">
		
			$(document).ready(function() {
				newSetCommonDatePickerEvent('#clmAcptDtmStart','#clmAcptDtmEnd');
				searchDateChange();
				createIntegrateListGrid();
				
				$("#clmAcptDtmStart").change(function(){
					compareDate("clmAcptDtmStart", "clmAcptDtmEnd");
				});
				
				$("#clmAcptDtmEnd").change(function(){
					compareDate2("clmAcptDtmStart", "clmAcptDtmEnd");
				});
				
				// 달력 선택시 기간 선택으로 변경
				$(".datepicker").focus(function(){
					$("#checkOptDate option:eq(0)").prop("selected", true);
				});
				
				// input 엔터 이벤트
				$(document).on("keydown","#claimIntegrateSearchForm input[name='searchValueOrder'], #claimIntegrateSearchForm input[name='searchValueGoods'], #claimIntegrateSearchForm input[name='clmNo'], #claimIntegrateSearchForm input[name='ordNo']",function(e){
					if ( e.keyCode == 13 ) {
						reloadIntegrateListGrid('');
					}
				});
				
				$("#clmDtlTpCd").hide();
				$("#clmDtlStatCd").hide();
				
				$("#clmTpCd").bind("change", function() {
					
					var selectVal = $(this).children("option:selected").val();
					if(selectVal == '${adminConstants.CLM_TP_30}') {
						$("#clmDtlTpCd").show();
						$("#clmDtlStatCd").hide();
						
						config = {
								grpCd : '${adminConstants.CLM_DTL_TP}'
								, usrDfn1Val : selectVal
								, defaultName : '전체'
								, showValue : false
								, callBack : function(html) {
									$("#clmDtlTpCd").html ('');
									$("#clmDtlTpCd").append (html);
								}
						};
						codeAjax.select(config);
					} else if(selectVal == '${adminConstants.CLM_TP_20}') {	
						
						$("#clmDtlTpCd").hide();
						$("#clmDtlStatCd").show();
						
						config = {
								grpCd : '${adminConstants.CLM_DTL_STAT}'
								, usrDfn1Val : selectVal
								, defaultName : '전체'
								, showValue : false
								, callBack : function(html) {
									$("#clmDtlTpCd").html ('');
									$("#clmDtlStatCd").html ('');
									$("#clmDtlStatCd").append (html);
								}
						};
						codeAjax.select(config);
					} else {
						$("#clmDtlTpCd").html ('');
						$("#clmDtlStatCd").html ('');
						$("#clmDtlTpCd").hide();
						$("#clmDtlStatCd").hide();
					}
				});
				
				$("#clmDtlTpCd").bind("change", function() {
					var selectVal = $(this).children("option:selected").val();
					
					if(selectVal == '${adminConstants.CLM_DTL_TP_30}' || selectVal == '${adminConstants.CLM_DTL_TP_40}') {
						$("#clmDtlStatCd").show();
						// 분류
						config = {
							grpCd : '${adminConstants.CLM_DTL_STAT }'
							, usrDfn1Val : selectVal
							, defaultName : '전체'
							, showValue : false
							, callBack : function(html) {
								$("#clmDtlStatCd").html ('');
								$("#clmDtlStatCd").append (html);
							}
						};
						codeAjax.select(config);
					} else {
						$("#clmDtlStatCd").hide();
					}
				});
				
				$("#cb_claimIntegrateList").bind("click", function() {
					
					var gridData = $("#claimIntegrateList").jqGrid("getRowData");
					var checked = $("#cb_claimIntegrateList").is(":checked");
					
					if(checked) {
						for(var i =0; i < gridData.length; i++) {
							if(gridData[i].clmTpCd == '10') {
								$("#claimIntegrateList").jqGrid('setSelection', i+1, false);
							}
						}
						$("input:checkbox[id=cb_claimIntegrateList]").prop("checked", true);
					} else {
						$("input:checkbox[id=cb_claimIntegrateList]").prop("checked", false);
					}
				});
			});
			
			// 클레임 통합 그리드
			function createIntegrateListGrid() {
				
				var options = $.extend({}, {
					url : "<spring:url value='/claim/claimIntegrateListGrid.do' />"
					, height : 400
					, colModels : [
						// 클레임 번호
						// {name:"clmNo", label:'<spring:message code="column.clm_no" />', width:"120", align:"center"}
						// 주문번호
						{name : "ordNo", label : '<spring:message code="column.ord_no" />', width : "115", align : "center"}//,<b><u><tt><spring:message code="column.ord_no" /></tt></u></b> classes : 'pointer underline'
						// 클레임 유형
						, {name:"clmTpCd", label:'<spring:message code="column.clm_tp_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_TP}" />"}}
						// 클레임 상태
						, {name:"clmStatCd", label:'<spring:message code="column.clm_stat_cd" />', width:"100", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_STAT}" />"}}
						// 클레임 접수 일시
						, {name:"acptDtm", label:'<spring:message code="column.clm_acpt_dtm" />', width:"120", align:"center", formatter:gridFormat.date, datefomat:"yyyy-MM-dd HH:mm:ss"}
						// 클레임 완료 일시
						, {name:"clmCpltDtm", label:'<spring:message code="column.clm_cplt_dtm" />', width:"120", align:"center", formatter:gridFormat.date, datefomat:"yyyy-MM-dd HH:mm:ss"}
						// 클레임 철회 일시
						, {name:"cncDtm", label:'<spring:message code="column.clm_cnc_dtm" />', width:"120", align:"center", formatter:gridFormat.date, datefomat:"yyyy-MM-dd HH:mm:ss"}
						// 클레임 상세 순번
						, {name:"clmDtlSeq", label:'<spring:message code="column.clm_dtl_seq" />', width:"120", align:"center", formatter:'integer'}//<b><u><tt><spring:message code="column.clm_dtl_seq" /></tt></u></b>, classes:'pointer fontbold'
						// 클레임 상세 유형
						, {name:"clmDtlTpCd", label:'<spring:message code="column.clm_dtl_tp_cd" />', width:"120", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_DTL_TP}" />"}}
						// 클레임 상세 상태
						, {name:"clmDtlStatCd", label:'<spring:message code="column.clm_dtl_stat_cd" />', width:"120", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_DTL_STAT}"/>"}}//  usrDfn2Val="30" 
						// 클레임 사유
						, {name:"clmRsnCd", label:'<spring:message code="column.clm_rsn_cd" />', width:"130", align:"center", formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.CLM_RSN}" />"}}
						// 상품명
						, {name:"goodsNm", label:'<spring:message code='column.goods_nm' />', width:"200", align:"center" }
						// 클레임 수량
						, {name:"clmQty", label:'<spring:message code="column.clm_qty" />', width:"100", align:"center", formatter:'integer'}
						, {name:"clmDtlCnt", hidden: true}
						, {name:"clmChainYn", label:'clmChainYn', width:"100", align:"center", hidden: true}
						, {name:"ordDtlSeq", label:'ordDtlSeq', width:"100", align:"center", hidden: true}
						, {name:"claimGroupNm", hidden:true}
						, {name:"clmNo", hidden:true}
					]
					, searchParam : $("#claimIntegrateSearchForm").serializeJson()
					, multiselect : true
					, gridComplete : function() {
						var ids = $("#claimIntegrateList").jqGrid("getDataIDs");
						
						// 그리드 데이터 가져오기
						var gridData = $("#claimIntegrateList").jqGrid("getRowData");
						if(gridData.length > 0) {
							// 데이터 확인 후 색상 변경
							for(var i = 0; i < gridData.length; i++) {
								// 데이터의 is_test확인
								if(gridData[i].clmStatCd == '40') {
									// 열의 색상을 변경하고 싶을때(css는 미리 선언)
									$('#claimIntegrateList tr[id='+ ids[i] +']').css('color', 'blue');
								}
							}
						}
						
						for(var i in gridData) {
							if(gridData[i].clmTpCd == '10') {
								$($("#claimIntegrateList input[type=checkbox]")[i]).prop("disabled", true);
							}
						}
					}
					, onCellSelect : function(rowid, index, contents, e) {	// cell 클릭시
						var cm = $("#claimIntegrateList").jqGrid("getGridParam", "colModel");
						var rowData = $("#claimIntegrateList").getRowData(rowid);
						
						if(cm[index].name != "cb" && cm[index].name != "ordNo") {
							if(rowData.clmTpCd == '10') {
								$("#claimIntegrateList").jqGrid('setSelection', rowid, false);
							}
							fnClaimDetailView(rowData.clmNo);
						}
						
						if(cm[index].name == "ordNo") {
							if(rowData.clmTpCd == '10') {
								$("#claimIntegrateList").jqGrid('setSelection', rowid, false);
							}
							fnOrderDetailView(rowData.ordNo);
						}
						
						if(cm[index].name == "cb") {
							if(rowData.clmTpCd == '10') {
								$("#claimIntegrateList").jqGrid('setSelection', rowid, false);
							}
						}
					}
					, grouping : true
					, groupField : ["claimGroupNm"]
					, groupText : ["클레임번호"]
					, groupOrder : ["desc"]
					, groupCollapse : false
					, groupColumnShow : [false]
				});
				grid.create("claimIntegrateList", options);
			}
			
			// 조회
			function reloadIntegrateListGrid() {
				compareDateAlert('clmAcptDtmStart','clmAcptDtmEnd','term');
				// 클레임 접수 일시 시작일
				var clmAcptDtmStart = $("#clmAcptDtmStart").val().replace(/-/gi, "");
				
				// 클레임 접수 일시 종료일
				var clmAcptDtmEnd = $("#clmAcptDtmEnd").val().replace(/-/gi, "");
				
				var stArr = $("#clmAcptDtmStart").val().split("-");
				var endArr = $("#clmAcptDtmEnd").val().split("-");
				var stDate = new Date(stArr[0], stArr[1], stArr[2]);
				var endDate = new Date(endArr[0], endArr[1], endArr[2]);
				var diff = endDate - stDate;
				var diffDays = parseInt(diff/(24*60*60*1000));
				
				var arrCompTpCd = new Array();
				var arrDlvrPrcsTpCd = new Array();
				var arrPayStatCd = new Array();
				
				$('input:checkbox[name="compTpCd"]:checked').each( function() {
					arrCompTpCd.push($(this).val());
				});
				
				$('input:checkbox[name="dlvrPrcsTpCd"]:checked').each( function() {
					arrDlvrPrcsTpCd.push($(this).val());
				});
				
				$('input:checkbox[name="payStatCd"]:checked').each(function() {
					arrPayStatCd.push($(this).val());
				});
				
				$("input[name=arrCompTpCd]").val(arrCompTpCd);
				$("input[name=arrDlvrPrcsTpCd]").val(arrDlvrPrcsTpCd);
				$("input[name=arrPayStatCd]").val(arrPayStatCd);
				
				var data = $("#claimIntegrateSearchForm").serializeJson();
				
				if(undefined != data.arrCashRctStatCd && data.arrCashRctStatCd != null && Array.isArray(data.arrCashRctStatCd)) {
					$.extend(data, { arrCashRctStatCd : data.arrCashRctStatCd.join(",") });
				}
				
				var options = {
						searchParam : data
				}
				gridReload('clmAcptDtmStart','clmAcptDtmEnd','claimIntegrateList','term', options);
			}
			
			function searchDateChange(){
				var term = $("#checkOptDate").children("option:selected").val();
				if(term == "") {
					$("#clmAcptDtmStart").val("");
					$("#clmAcptDtmEnd").val("");
				} else {
					setSearchDate(term, "clmAcptDtmStart", "clmAcptDtmEnd");
				}
			}
			
			// 초기화 버튼 클릭
			function searchReset() {
				$("#clmDtlTpCd").hide();
				$("#clmDtlStatCd").hide();
				resetForm ("claimIntegrateSearchForm");
				searchDateChange();
				<c:if test="${adminConstants.USR_GRP_10 ne adminSession.usrGrpCd}">
					$("#claimIntegrateSearchForm #compNo").val('${adminSession.compNo}');
				</c:if>
			}
			
			// 업체 검색
			function fnCallBackCompanySearchPop() {
				var options = {
						multiselect : false
						, callBack : function(result) {
							$("#compNo").val(result[0].compNo);
							$("#compNm").val(result[0].compNm);
						}
					<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
						, showLowerCompany : 'Y'
					</c:if>
				}
				layerCompanyList.create(options);
			}
			
			// 하위 업체 검색
			function searchLowCompany() {
				var options = {
						multiselect : false
						, callBack : searchLowCompanyCallback
						<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
							, showLowerCompany : 'Y'
						</c:if>
				}
				layerCompanyList.create(options);
			}
			
			// 업체 검색 CallBack
			function searchLowCompanyCallback(compList) {
				if(compList.length > 0) {
					$("#claimIntegrateSearchForm #lowCompNo").val (compList[0].compNo);
					$("#claimIntegrateSearchForm #lowCompNm").val (compList[0].compNm);
				}
			}
			
			function claimIntegrateListExcelDownload() {
				var data = $("#claimIntegrateSearchForm").serializeJson();
				var rowIds = $("#claimIntegrateList").getGridParam("selarrrow");
				
				if(rowIds.length > 0) {
					var clmNos = [];
					for(var i in rowIds) {
						var rowData = $("#claimIntegrateList").getRowData(rowIds[i]);
						var clmNo = rowData.clmNo;
						var clmDtlSeq = rowData.clmDtlSeq;
						clmNos.push(clmNo + clmDtlSeq);
					}
					data.clmNos = clmNos.join();
				}
				createFormSubmit("claimIntegrateListExcelDownload","/claim/claimIntegrateListExcelDownload.do", data);
			}
			
			// 클레임상세
			function fnClaimDetailView(clmNo) {
				addTab('클레임 상세', '/integrate/claimDetailView.do?clmNo=' + clmNo);
			}
			
			// 주문상세
			function fnOrderDetailView(ordNo) {
				addTab("주문상세", '/integrate/orderDetailView.do?ordNo=' + ordNo + "&viewGb=" + '${adminConstants.VIEW_GB_POP}');
			}
			
			// 반품회수완료
			function fnClaimProductRecoveryFinal() {
				var grid = $("#claimIntegrateList");
				var selectedIDs = grid.getGridParam("selarrrow");
				
				// 선택되지 않은경우
				if(selectedIDs.length == 0) {
					messager.alert("클레임 번호를 선택하세요.", "info", "info");
					return;
				}
				
				if(selectedIDs.length > 1) {
					messager.alert("단일건만 선택하세요.", "info", "info");
					return;
				}
				
				var clmNo;
				var clmDtlSeq;
				var clmChainYn;
				var ordNo;
				var ordDtlSeq;
				
				for(var i in selectedIDs) {
					var rowData = grid.getRowData(selectedIDs[i]);
					
					if(rowData.clmTpCd != '${adminConstants.CLM_TP_20}') {
						messager.alert("반품 데이터가 아닙니다. 관리자에게 문의하세요.", "info", "info");
						return;
					}
					
					if(rowData.clmStatCd != '${adminConstants.CLM_STAT_20}') {
						messager.alert("클레임상태가 회수중인 건만 반품회수완료를 할 수 있습니다.", "info", "info");
						return;
					}
					
					if(rowData.clmDtlStatCd != '${adminConstants.CLM_DTL_STAT_230}') {
						messager.alert("클레임상태가 회수중인 건만 반품회수완료를 할 수 있습니다.", "info", "info");
						return;
					}
					
					clmNo = rowData.clmNo;
					clmDtlSeq = rowData.clmDtlSeq;
					clmChainYn = rowData.clmChainYn;
					ordNo = rowData.ordNo;
					ordDtlSeq = rowData.ordDtlSeq;
				}
				
				var data = {
						clmNo : clmNo
						, clmDtlSeq : clmDtlSeq
						, clmChainYn : clmChainYn
						, ordNo : ordNo
						, ordDtlSeq : ordDtlSeq
				};
				
				messager.confirm('<spring:message code="column.order_common.confirm.claim_return_product_recovery_final" />', function(r) {
					if(r) {
						var options = {
								url : "<spring:url value='/claim/claimProductRecoveryFinalExec.do' />"
								, data : data
								, callBack : function(data) {
									messager.alert("<spring:message code='column.common.process.final_msg' />", "Info", "info", function() {
										reloadIntegrateListGrid();
									});
								}
						};
						ajax.call(options);
					}
				});
				
			}
			
			// 반품승인완료
			function fnClaimProductApprove() {
				
				var grid = $("#claimIntegrateList");
				var selectedIDs = grid.getGridParam("selarrrow");
				
				// 선택되지않은경우
				if(selectedIDs.length == 0) {
					messager.alert("클레임 번호를 선택하세요.", "info", "info");
					return;
				}
				
				var clmNo;
				var isDuplClmNo = true;
				var isCheckAll = true;
				for(var i in selectedIDs) {
					var rowData = grid.getRowData(selectedIDs[i]);
					
					if(rowData.clmTpCd != '${adminConstants.CLM_TP_20}') {
						messager.alert("반품 데이터가 아닙니다. 관리자에게 문의하세요.", "info", "info");
						return;
					}
					
					if(rowData.clmStatCd != '${adminConstants.CLM_STAT_20}') {
						messager.alert("클레임상태가 진행인 건만 반품승인완료를 할 수 있습니다.","info","info");
						return;
					}
					
					if(rowData.clmDtlStatCd != '${adminConstants.CLM_DTL_STAT_240}') {
						messager.alert("클레임상태가 회수완료인 건만 반품승인완료를 할 수 있습니다.","info","info");
						return;
					}
					
					if(clmNo && clmNo != rowData.clmNo){
						isDuplClmNo = false;
					}
					
					if(rowData.clmDtlCnt != selectedIDs.length){
						isCheckAll = false;
					}
					clmNo = rowData.clmNo;
				}
				
				if(!isDuplClmNo){
					messager.alert("동일한 클레임건만 반품승인 처리를 할 수 있습니다.","info","info");
					isDuplClmNo = false;
					return;
				}
				
				if(!isCheckAll){
					messager.alert("클레임 전체 일괄 반품승인 처리만 가능합니다.동일한 클레임번호 내 전체 목록을 선택해주세요.","info","info");
					isCheckAll = false;
					return;
				}
				
				var data = {
						clmNo : clmNo
				};
				
				messager.confirm('<spring:message code="column.order_common.confirm.claim_return_product_approve_final" />',function(r){
					if(r){
						var options = {
							url : "<spring:url value='/claim/claimProductApprove.do' />"
							, data : {
								clmNo : clmNo
							}, callBack : function(data) {
								messager.alert("<spring:message code='column.common.process.final_msg' />", "Info", "info", function(){
									reloadIntegrateListGrid();
								});
								
							}
						};
						ajax.call(options);
					}
				});
			}
			
			// 반품승인거부
			function fnClaimProductRejectionFinal() {
				
				var grid = $("#claimIntegrateList");
				var selectedIDs = grid.getGridParam("selarrrow");
				
				//선택되지 않은경우
				if (selectedIDs.length == 0) {
					messager.alert("클레임 번호를 선택하세요.","info","info");
					return;
				}
				
				var clmNo ;
				var isDuplClmNo = true;
				var isCheckAll = true;
				
				for(var i in selectedIDs) {
					var rowData = grid.getRowData(selectedIDs[i]);

					if(rowData.clmTpCd != '${adminConstants.CLM_TP_20}') {
						messager.alert("반품 데이터가 아닙니다. 관리자에게 문의하세요.","info","info");
						return;
					}
					
					if(rowData.clmStatCd != '${adminConstants.CLM_STAT_20}') {
						messager.alert("클레임상태가 진행인 건만 반품거부완료를 할 수 있습니다.","info","info");
						return;
					}
					
					if(rowData.clmDtlStatCd != '${adminConstants.CLM_DTL_STAT_240}') {
						messager.alert("클레임상태가 회수완료인 건만 반품거부완료를 할 수 있습니다.","info","info");
						return;
					}
					
					if(clmNo && clmNo != rowData.clmNo){
						isDuplClmNo = false;
					}
					
					if(rowData.clmDtlCnt != selectedIDs.length){
						isCheckAll = false;
					}
					
					clmNo = rowData.clmNo ;
				}
				
				if(!isDuplClmNo){
					messager.alert("동일한 클레임건만 반품거부 처리를 할 수 있습니다.","info","info");
					isDuplClmNo = false;
					return;
				}
				
				if(!isCheckAll){
					messager.alert("클레임 전체 일괄 반품거부 처리만 가능합니다.동일한 클레임번호 내 전체 목록을 선택해주세요.","info","info");
					isCheckAll = false;
					return;
				}

				var data = {
						clmNo : clmNo
				};
				
				var options = {
					url : '/claim/claimReturnRefusePopView.do'
					, data : data
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "claimReturnRefuseView"
							, width : 1000
							, height : 400
							, top : 200
							, title : "반품거부"
							, body : data
							, button : "<button type=\"button\" onclick=\"fnClaimReturnRefuseExec();\" class=\"btn btn-ok\">반품거부완료</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options);
			}
			
			// 교환회수완료
			function fnClaimExchangeProductRecoveryFinal() {
				
				var grid = $("#claimIntegrateList");
				var selectedIDs = grid.getGridParam("selarrrow");
				//선택되지 않은경우
				if(selectedIDs.length == 0) {
					messager.alert( "클레임 번호를 선택하세요." ,"Info","info");
					return;
				}
				
				if(selectedIDs.length > 1) {
					messager.alert( "단일건만 선택하세요." ,"Info","info");
					return;
				}

				var clmNo ;
				var clmDtlSeq;
				var clmChainYn;
				var ordNo;
				var ordDtlSeq;
				
				for(var i in selectedIDs) {
					var rowData = grid.getRowData(selectedIDs[i]);

					if(rowData.clmTpCd != '${adminConstants.CLM_TP_30}') {
						messager.alert( "교환 데이터가 아닙니다. 관리자에게 문의하세요." ,"Info","info");
						return;
					}
					
					if(rowData.clmStatCd != '${adminConstants.CLM_STAT_20}') {
						messager.alert( "클레임상태가 진행인 건만 교환회수완료를 할 수 있습니다." ,"Info","info");
						return;
					}
					
					if(rowData.clmDtlStatCd != '${adminConstants.CLM_DTL_STAT_330}') {
						messager.alert( "클레임상태가 회수중인 건만 교환회수완료를 할 수 있습니다." ,"Info","info");
						return;
					}
					
					clmNo = rowData.clmNo ;
					clmDtlSeq = rowData.clmDtlSeq ;
					clmChainYn = rowData.clmChainYn;
					ordNo = rowData.ordNo;
					ordDtlSeq = rowData.ordDtlSeq;
				}
				
				messager.confirm('<spring:message code="column.order_common.confirm.claim_exchange_suger_final" />',function(r) {
					if(r){
						var options = {
							url : "<spring:url value='/claim/claimProductRecoveryFinalExec.do' />"
							, data : {
								clmNo : clmNo
								, clmDtlSeq : clmDtlSeq
								, clmChainYn : clmChainYn
								, ordNo : ordNo
								, ordDtlSeq : ordDtlSeq
							}
							, callBack : function(data) {
								messager.alert("<spring:message code='column.common.process.final_msg' />", "Info", "info", function(){
									reloadIntegrateListGrid();
								});
							}
						};
						ajax.call(options);
					}
				});
			}
			 
			// 교환승인완료
			function fnClaimExchangeProductApprove() {
				
				var grid = $("#claimIntegrateList");
				var selectedIDs = grid.getGridParam("selarrrow");
				
				// 선택되지 않은경우
				if(selectedIDs.length == 0) {
					messager.alert("클레임 번호를 선택하세요.", "Info", "info");
					return;
				}
				
				if(selectedIDs.length > 1) {
					messager.alert("단일건만 선택하세요.", "Info", "info");
					return;
				}
				
				var clmNo;
				var clmDtlSeq;
				var clmChainYn;
				var ordNo;
				var ordDtlSeq;
				
				for(var i in selectedIDs) {
					var rowData = grid.getRowData(selectedIDs[i]);
					
					if(rowData.clmTpCd != '${adminConstants.CLM_TP_30}') {
						messager.alert("교환 데이터가 아닙니다. 관리자에게 문의하세요." ,"Info","info");
						return;
					}
					
					if(rowData.clmStatCd != "${adminConstants.CLM_STAT_20}") {
						messager.alert("클레임상태가 진행인 건만 재픽업완료를 할 수 있습니다." ,"Info","info");
						return;
					}
					
					if(rowData.clmDtlStatCd != '${adminConstants.CLM_DTL_STAT_340}') {
						messager.alert("클레임상태가 회수완료인 건만 교환승인완료를 할 수 있습니다." ,"Info","info");
						return;
					}
					
					clmNo = rowData.clmNo;
					clmDtlSeq = rowData.clmDtlSeq;
					clmChainYn = rowData.clmChainYn;
					ordNo = rowData.ordNo;
					ordDtlSeq = rowData.ordDtlSeq;
				}
					
				messager.confirm('<spring:message code="column.order_common.confirm.claim_exchange_product_approve_final" />',function(r){
					if(r){
						var options = {
							url : "<spring:url value='/claim/claimExchangeProductApprove.do' />"
							, data : {
								clmNo : clmNo
								, clmDtlSeq : clmDtlSeq
								, clmChainYn : clmChainYn
								, ordNo : ordNo
								, ordDtlSeq : ordDtlSeq
							}, callBack : function(data) {
								messager.alert( "<spring:message code='column.common.process.final_msg' />", "Info", "info", function(){
									reloadIntegrateListGrid();
								});
								
							}
						};
						ajax.call(options);
					}
				});
			}
			
			// 교환승인거부
			function fnClaimExchangeProductRejectionFinal() {
				
				var grid = $("#claimIntegrateList");
				var selectedIDs = grid.getGridParam("selarrrow");
				//선택되지 않은경우
				if(selectedIDs.length == 0) {
					messager.alert( "클레임 번호를 선택하세요." ,"Info","info");
					return;
				}
				
				if(selectedIDs.length > 1) {
					messager.alert( "단일건만 선택하세요." ,"Info","info");
					return;
				}

				var clmNo;
				var clmChainYn;
				var arrClmDtlSeq = new Array();

				for (var i in selectedIDs) {
					var rowData = grid.getRowData( selectedIDs[i] );

					if(rowData.clmTpCd != '${adminConstants.CLM_TP_30}') {
						messager.alert("교환 데이터가 아닙니다. 관리자에게 문의하세요." ,"Info","info");
						return;
					}
					
					if(rowData.clmStatCd != '${adminConstants.CLM_STAT_20}') {
						messager.alert("클레임상태가 진행인 건만 교환거부완료를 할 수 있습니다." ,"Info","info");
						return;
					}

					if(rowData.clmDtlStatCd != '${adminConstants.CLM_DTL_STAT_340}') {
						messager.alert("클레임상태가 회수완료인 건만 교환거부완료를 할 수 있습니다." ,"Info","info");
						return;
					}
					
					clmNo = rowData.clmNo ;
					clmChainYn = rowData.clmChainYn;
					arrClmDtlSeq.push(rowData.clmDtlSeq);
				}

				var data = {
						clmNo : clmNo
						, clmChainYn : clmChainYn
						, arrClmDtlSeq : arrClmDtlSeq
				};
				
				var options = {
					url : '/claim/claimExchangeRefusePopView.do'
					, data : data
					, dataType : "html"
					, callBack : function (data ) {
						var config = {
							id : "claimExchangeRefuseView"
							, width : 1000
							, height : 400
							, top : 200
							, title : "교환거부"
							, body : data
							, button : "<button type=\"button\" onclick=\"fnClaimExchangeRefuseExec();\" class=\"btn btn-ok\">교환거부완료</button>"
						}
						layer.create(config);
					}
				}
				ajax.call(options);
			}
		
		</script>
	
	</t:putAttribute>
	
	<t:putAttribute name="content">
	
		<!-- ==================================================================== -->
		<!-- 검색 start-->
		<!-- ==================================================================== -->
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
		
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
			
				<form name="claimIntegrateSearchForm" id="claimIntegrateSearchForm">
				
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
								<!-- 클레임 접수 일시 -->
								<th scope="row"><spring:message code="column.clm_acpt_dtm" /></th>
								<td colspan="3">
									<frame:datepicker startDate="clmAcptDtmStart" endDate="clmAcptDtmEnd" startValue="${frame:toDate('yyyy-MM-dd') }" endValue="${frame:toDate('yyyy-MM-dd') }" />
									&nbsp;&nbsp;
									<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();" style="width:120px !important;">
										<frame:select grpCd="${adminConstants.SELECT_PERIOD }" selectKey="${adminConstants.SELECT_PERIOD_40 }" defaultName="기간선택" />
									</select>
								</td>
							</tr>
							<tr>
								<!-- 업체명 -->
								<th scope="row"><spring:message code="column.goods.comp_nm" /></th>
								<td>
									<frame:compNo funcNm="fnCallBackCompanySearchPop" disableSearchYn="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? 'N' : 'Y'}" placeholder="${adminConstants.USR_GRP_10 eq adminSession.usrGrpCd ? '입점업체를 검색하세요' : ''}" />
									<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">
										&nbsp;&nbsp;&nbsp;<frame:lowCompNo funcNm="searchLowCompany" placeholder="하위업체를 검색하세요"/>
									</c:if>
								</td>
								<!-- 업체유형 -->
								<th scope="row"><spring:message code="column.statistics.comp.kind" /></th>
								<td>
									<frame:checkbox name="compTpCd" grpCd="${adminConstants.COMP_TP }" excludeOption="${adminConstants.COMP_TP_30 }" />
									<input type="hidden" name="arrCompTpCd" value="" />
								</td>
							</tr>
							<tr>
								<!-- 클레임 상태 -->
								<th scope="row"><spring:message code="column.clm_stat_cd" /></th>
								<td>
									<select name="clmTpCd" id="clmTpCd" class="w80" title="선택상자" >
										<frame:select grpCd="${adminConstants.CLM_TP }" defaultName="전체" />
									</select>
									<select name="clmDtlTpCd" id="clmDtlTpCd" class="w120" style="display: none;" title="선택상자" ></select>
									<select name="clmDtlStatCd" id="clmDtlStatCd" class="w120" style="display: none;" title="선택상자" ></select>
								</td>
								<!-- 환불 상태 -->
								<th scope="row"><spring:message code="column.rfd_stat_cd" /></th>
								<td>
									<frame:checkbox name="payStatCd" grpCd="${adminConstants.PAY_STAT }"/>
									<input type="hidden" name="arrPayStatCd" value="" />
								</td>
							</tr>
							<tr>
								<!-- 주문번호 -->
								<th scope="row"><spring:message code="column.ord_no" /></th>
								<td>
									<input type="text" name="ordNo" id="ordNo" class="w150" value="" />
								</td>
								<!-- 클레임 번호 -->
								<th scope="row"><spring:message code="column.clm_no" /></th>
								<td>
									<input type="text" name="clmNo" id="clmNo" class="w150" value="" />
								</td>
							</tr>
							<tr>
								<!-- 주문정보 -->
								<th scope="row"><spring:message code="column.order_common.order_info" /></th>
								<td>
									<select name="searchKeyOrder" id="searchKeyOrder" class="w100" title="선택상자" >
										<option value="type02">주문자명</option>
										<option value="type03">주문자ID</option>
									</select>
									<input type="text" name="searchValueOrder" class="w120"  value="" />
								</td>
								<!-- 상품정보 -->
								<th scope="row"><spring:message code="column.order_common.goods_info" /></th>
								<td>
									<select name="searchKeyGoods" title="선택상자" >
										<option value="type01">상품명</option>
										<option value="type02">상품NO</option>
									</select>
									<input type="text" name="searchValueGoods" class="w120" value="" />
								</td>
							</tr>
							<tr>
								<!-- 배송처리 유형 -->
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
					<button type="button" onclick="reloadIntegrateListGrid('');" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset();" class="btn btn-cancel">초기화</button>
				</div>
			
			</div>
		
		</div>
		<!-- ==================================================================== -->
		<!-- 검색 end-->
		<!-- ==================================================================== -->
		
		
		<!-- ==================================================================== -->
		<!-- 그리드 start -->
		<!-- ==================================================================== -->
		
		<div class="mModule">
			
			<div class="mButton">
				
				<div class="leftInner">
					
					<!-- 반품 회수 완료 -->
					<button type="button" onclick="fnClaimProductRecoveryFinal();" class="btn btn-add">
						<spring:message code="column.order_common.btn.claim_return_product_recovery_final" />
					</button>
					
					<c:if test="${adminConstants.USR_GRP_10 eq session.usrGrpCd}">
					
						<!-- 반품 승인 완료 -->
						<button type="button" onclick="fnClaimProductApprove();" class="btn btn-add">
							<spring:message code="column.order_common.btn.claim_return_product_approve_final" />
						</button>
						
						<!-- 반품 승인 거부 -->
						<button type="button" onclick="fnClaimProductRejectionFinal();" class="btn btn-add">
							<spring:message code="column.order_common.btn.claim_return_product_approve_refuse" />
						</button>
					</c:if>
					
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					
					<!-- 교환회수완료 -->
					<button type="button" onclick="fnClaimExchangeProductRecoveryFinal();" class="btn btn-add">
						<spring:message code='column.order_common.btn.claim_exchange_suger_final' />
					</button>
					
					<c:if test="${adminConstants.USR_GRP_10 eq session.usrGrpCd}" >
						<!-- 교환승인완료 -->
						<button type="button" onclick="fnClaimExchangeProductApprove();" class="btn btn-add">
							<spring:message code='column.order_common.btn.claim_exchange_product_approve_final' />
						</button>
						
						<!-- 교환승인거부 -->
						<button type="button" onclick="fnClaimExchangeProductRejectionFinal();" class="btn btn-add">
							<spring:message code='column.order_common.btn.claim_exchange_product_approve_refuse' />
						</button>
					</c:if>
				
				</div>
				
				<div class="rightInner">
					<button type="button" onclick="claimIntegrateListExcelDownload()" class="btn btn-add btn-excel">
						<spring:message code="column.common.btn.excel_download" />
					</button>
				</div>
				
			</div>
		
			<table id="claimIntegrateList" ></table>
			<div id="claimIntegrateListPage"></div>
		
		</div>
		
		<!-- ==================================================================== -->
		<!-- 그리드 end -->
		<!-- ==================================================================== -->
	
	</t:putAttribute>

</t:insertDefinition>
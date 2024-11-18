<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
 
		<script type="text/javascript">
			$(document).ready(function(){
			});

			// callback : 업체 검색
			function fnCallBackCompanySearchPop() {
				var data = {
					multiselect : true
			        , compStatCd :  '${adminConstants.COMP_STAT_20}'
			        , readOnlyCompStatCd : 'Y'
<c:if test="${adminConstants.USR_GB_2010 eq adminSession.usrGbCd}">			        
		            , showLowerCompany : 'Y'
</c:if>
					, callBack : function(result) {
// 						$("#compNo").val( result[0].compNo );
// 						$("#compNm").val( result[0].compNm );
						$("#deliveryInvcBatchForm").find("#compNo").val( result[0].compNo );
						$("#deliveryInvcBatchForm").find("#compNm").val( result[0].compNm );
						$("#deliveryInvcBatchForm").find("#compGbCd").val( result[0].compGbCd );
					}
				}
				layerCompanyList.create(data);
			}

			// 송장자료 Sample 다운로드
			function fnDeliveryInvoiceBatchSampleDonwload() {
				if($("#deliveryInvcBatchForm").find("#compGbCd").val() == "10"){
					messager.alert( "위탁 업체만 선택 가능합니다." ,"Info","info");
					return;
				}
				//opener.deliveryListExcelDownload(2);
// 				var compNo = $("#compNo").val();
				var compNo = $("#deliveryInvcBatchForm").find("#compNo").val();
				if ( compNo == null || compNo == "" ) {
					messager.alert( "업체를 선택하세요." ,"Info","info");
					return;
				}
				var ordClmGbCd = '';
				
				<c:if test="${orderSO.ordClmGbCd eq adminConstants.ORD_CLM_GB_10}">
				    ordClmGbCd = '10';
				</c:if>
				<c:if test="${orderSO.ordClmGbCd eq adminConstants.ORD_CLM_GB_20}">
					ordClmGbCd = '20';
				</c:if>
				
				var data = {
					 compNo : compNo
					,ordClmGbCd:ordClmGbCd
				}
				 
				createFormSubmit( "deliveryInvcBatchForm", "/delivery/deliveryInvoiceCompanyExcelDownload.do", data );
			}

			// callback : 파일 업로드
			function fnCallBackFileUpload( file ) {
// 				alert( JSON.stringify( file ) );
				$("#fileName").val( file.fileName );
				$("#filePath").val( file.filePath );
			}
			
			 
			// 송장일괄 생성 버튼 클릭
			function fnDeliveryInvoiceBatchCreateExec() {

				if ( $("#filePath").val() == null || $("#filePath").val() == "" ) {
					messager.alert( "업로드 할 파일을 선택하세요." ,"Info","info");
					return;
				}

				messager.confirm("<spring:message code='column.order_common.confirm.delivery_batch_create' />",function(r){
					if(r){
						var fileName = $("#fileName").val();
						var filePath = $("#filePath").val();

						var sendData = {
							fileName : fileName
							, filePath : filePath
						}

						var options = {
							url : "<spring:url value='/delivery/deliveryInvoiceBatchCreateExec.do' />"
							, data : sendData
							, callBack : function(data) {
								var resultListHtml = "";
								
								$("#upload_result").show();
								$("#total_upload_cnt").html( data.cntTotal + "건");
								$("#success_upload_cnt").html( data.cntSuccess + "건");
								$("#fail_upload_cnt").html( data.cntFail + "건");
								/*  */
								$("#resultList").jqGrid({
									datatype: "local",
									height: 250,
									width : '100%',
								   	colModel:[
									      {name:"ordClmGbCd", label:'<spring:message code="column.ord_clm_gb_cd" />', width:"80", align:"center" }
									    , {name:"ordNo", label:'<spring:message code="column.ord_no" />', width:"120", align:"center"}
									    , {name:"dlvrNo", label:'<spring:message code="column.dlvr_no" />', width:"80", align:"center"}
									    /* , {name:"ordDtlSeq", label:'<spring:message code="column.ord_dtl_seq" />', width:"80", align:"center"}
									    , {name:"ordDtlStatCd", label:'<spring:message code="column.ord_dtl_stat_cd" />', width:"80", align:"center" }
									    , {name:"clmNo", label:'<spring:message code="column.clm_no" />', width:"130", align:"center"}
									    , {name:"clmDtlSeq", label:'<spring:message code="column.clm_dtl_seq" />', width:"100", align:"center"}
									    , {name:"clmDtlStatCd", label:'<spring:message code="column.clm_dtl_stat_cd" />', width:"100", align:"center" }  */
									    , {name:"hdcNm", label:'<spring:message code="column.order_common.hdc" />', width:"100", align:"center" }
										, {name:"invNo", label:'<spring:message code="column.inv_no" />', width:"120", align:"center"}
									    , {name:"resultYN", label:'<spring:message code="column.rst_cd" />', width:"50", align:"center"}
									    , {name:"resultMsg", label:'<spring:message code="column.rst_msg" />', width:"200", align:"center"}
									] 
								});
							 
								$.each(data.resultList, function(index, result) { 
								 
									var addData = {
											  ordClmGbCd: result.ordClmGbCd
											, ordNo: result.ordNo
											, dlvrNo: result.dlvrNo
											/* , ordDtlSeq: result.ordDtlSeq
											, ordDtlStatCd: result.ordDtlStatCd
											, clmNo: result.clmNo
											, clmDtlSeq: result.clmDtlSeq
											, clmDtlStatCd: result.clmDtlStatCd */
											, hdcNm: result.hdcNm
											, invNo: result.invNo
											, resultYN: result.resultYN
											, resultMsg: result.resultMsg
										}
									$("#resultList").jqGrid('addRowData', index, addData, 'last', null);
									
									grid.resize();
								});
							}
						};
						ajax.call(options);
					}
				});

			}

		</script>

		<div class="mTitle">
			<h2><spring:message code="column.order_common.delivery_batch_create" /></h2>
		</div>

		<form id="deliveryInvcBatchForm" name="deliveryInvcBatchForm" method="post" >
 			<input type="hidden" name="compGbCd" id="compGbCd">
 			
			<table class="table_type1">
				<caption>글 정보보기</caption>
				<tbody>
					<tr>
						<!-- 등록방법 -->
						<th scope="row"><spring:message code="column.order_common.reg_method" /></th>
						<td colspan="3">
							<strong class="blue-desc" style="margin-top:5px;display:block;">1. 업체 <span class="red-desc">[검색]</span>을 통해 업체를 선택 후 <span class="red-desc">[송장양식 다운로드]</span>를 클릭하여 양식을 받으세요.</strong>
							<strong class="blue-desc" style="margin-top:5px;display:block;">2. 다운받은 양식을 정해진 포맷에 맞게 수정하세요.</strong>
							<strong class="blue-desc" style="margin-top:5px;display:block;"><span class="red-desc" style="margin-left:15px">※</span> 다른 필드는 수정 금지 </strong>
							<strong class="blue-desc" style="margin-top:5px;display:block;"><span class="red-desc" style="margin-left:15px">※</span> 택배사/송장 번호는 <span class="red-desc">셀서식을 텍스트로 변경</span>해 주세요.</strong>
							<strong class="blue-desc" style="margin-top:5px;margin-bottom:5px;display:block;">3. 수정된 엑셀파일 업로드하고 <span class="red-desc">[송장번호 저장]</span> 버튼을 클릭하세요.</strong>
						</td>
					</tr>
					<tr>
						<!-- 업체구분 -->
						<th scope="row"><spring:message code="column.order_common.comp_gbn" /></th>
						<td colspan="3">
							<strong style="margin-top:5px;display:block"></strong>
							<!-- <input type="text" name="compNm" id="compNm" class="w120"  value="" />-->
							<frame:compNo funcNm="fnCallBackCompanySearchPop" />
							<!-- <button type="button" class="btn_h25_type1" onclick="fnCallBackCompanySearchPop();">업체</button>-->
							<button type="button" class="btn" onclick="fnDeliveryInvoiceBatchSampleDonwload();"><spring:message code="column.order_common.btn.delivery_batch_create_sample" /></button>
							<strong class="red-desc" style="margin-top:5px;margin-bottom:5px;display:block;">* 주의 : 정해진 포맷 외 필드 추가나 삭제 하지 마세요.</strong>
						</td>
					</tr>
					<tr>
						<!-- 업로드 -->
						<th scope="row"><spring:message code="column.common.btn.excel_upload" /><strong class="red">*</strong></th>
						<td colspan="3">
							<input type="text" id="fileName" name="fileName" value="" autocomplete="off" />
							<input type="hidden" id="filePath" name="filePath" value="" />
							<button type="button" onclick="javascript:fileUpload.file(fnCallBackFileUpload);" class="btn">파일찾기</button>
						</td>
					</tr>
				</tbody>
			</table>
	</form>

		<div class="btn_area_center">
			<button class="btn btn-ok" onclick="fnDeliveryInvoiceBatchCreateExec();"><spring:message code="column.order_common.btn.delivery_invoice_batch_create_confirm" /></button>
		</div>

	<div id="upload_result" style="display: none;">
		<div class="mModule">
			<div class="leftInner">
				<span><b>전체데이터</b></span> : <span id="total_upload_cnt"></span>
				<span style="margin-left:10px;"><b>성공건수</b></span> : <span id="success_upload_cnt"></span>
				<span style="margin-left:10px;"><b>실패건수</b></span> : <span id="fail_upload_cnt"></span>
			</div>
		</div>
		
		<div class="mModule">
			<table id="resultList" ></table>
		</div>
		
	
	</div>
	
	

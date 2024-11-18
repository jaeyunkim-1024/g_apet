<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
 <%@ page import="framework.common.enums.ImageGoodsSize" %>
 
		<script type="text/javascript">
			$(document).ready(function(){
			});

			 

			// Sample 다운로드
			function fnDeliveryInvoiceBatchSampleDonwload() {
				 
				var data =  null;
				createFormSubmit( "goodsExExcelUploadForm", "/promotion/goodsExListExcelSampleDownload.do", data );
			}

			// callback : 파일 업로드
			function fnCallBackFileUpload( file ) {
// 				alert( JSON.stringify( file ) );
				$("#fileName").val( file.fileName );
				$("#filePath").val( file.filePath );
			}
			
			 
			// 송장일괄 생성 버튼 클릭
			function fnGoodsExListExcelUploadExec() {

				if ( $("#filePath").val() == null || $("#filePath").val() == "" ) {
					alert( "업로드 할 파일을 선택하세요." );
					return;
				}

				if ( confirm("처리 하시겠습니까?" ) ) {

					var fileName = $("#fileName").val();
					var filePath = $("#filePath").val();

					var sendData = {
						fileName : fileName
						, filePath : filePath
					}

					var options = {
						url : "<spring:url value='/promotion/goodsExListExcelUploadExec.do' />"
						, data : sendData
						, callBack : function(data) {
							var resultListHtml = "";
							
							$("#upload_result").show();
							$("#total_upload_cnt").html( data.cntTotal + "건");
							$("#success_upload_cnt").html( data.cntSuccess + "건");
							$("#fail_upload_cnt").html( data.cntFail + "건");
							/*  */
							jQuery("#resultList").jqGrid({
								datatype: "local",
								height: 250,
								width : '100%',
							   	colModel:[
								         {name:"goodsId", label:"<spring:message code='column.goods_id' />", width:"100", key: true, align:"center"} /* 상품 번호 */
									   , {name:"imgPath", label:"이미지", width:"100", align:"center", formatter: function(cellvalue, options, rowObject) {
												if(rowObject.imgPath != "" &&   rowObject.imgPath != undefined ) {
													return "<img src='${frame:optImagePath('"+rowObject.imgPath+"', adminConstants.IMG_OPT_QRY_60)}' alt='' />";
												} else {
													return '<img src="/images/noimage.png" style="width:40px; height:40px;" alt="" />';
												}
											}
										 } 
										, {name:"goodsNm", label:"<spring:message code='column.goods_nm' />", width:"300", align:"center", sortable:false } /* 상품명 */
										, {name:"stIds", label:"<spring:message code='column.st_id' />", width:"100", align:"center", sortable:false, hidden:true } /* 사이트 아이디 */
										, {name:"stNms", label:"<spring:message code='column.st_nm' />", width:"200", align:"center", sortable:false } /* 사이트 명 */
										, {name:"goodsTpCd", label:"<spring:message code='column.goods_tp_cd' />", width:"80", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_TP }' showValue='false' />" } } /* 상품 유형 */
										, {name:"goodsStatCd", label:"<spring:message code='column.goods_stat_cd' />", width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.GOODS_STAT }' showValue='false' />" } } /* 상품 상태 */
										, {name:"mdlNm", label:"<spring:message code='column.mdl_nm' />", width:"200", align:"center", sortable:false } /* 모델명 */
										, {name:"saleAmt", label:"<spring:message code='column.sale_prc' />", width:"100", align:"center", sortable:false, formatter: 'currency', formatoptions:{decimalSeparator:'.', decimalPlaces:0, suffix: ' 원', thousandsSeparator:','} } /* 판매가 */
										, {name:"compNm", label:"<spring:message code='column.goods.comp_nm' />", width:"200", align:"center", sortable:false } /* 업체명 */
										, {name:"bndNmKo", label:"<spring:message code='column.bnd_nm' />", width:"200", align:"center", sortable:false } /* 브랜드명 */
										, {name:"mmft", label:"<spring:message code='column.mmft' />", width:"200", align:"center", sortable:false } /* 제조사 */
										, {name:"saleStrtDtm", label:"<spring:message code='column.sale_strt_dtm' />", width:"200", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"${adminConstants.COMMON_DATE_FORMAT }" }
										, {name:"saleEndDtm", label:"<spring:message code='column.sale_end_dtm' />", width:"200", align:"center", sortable:false, formatter:gridFormat.date, dateformat:"${adminConstants.COMMON_DATE_FORMAT }" }
										, {name:"showYn", label:"<spring:message code='column.show_yn' />", width:"150", align:"center", sortable:false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd='${adminConstants.SHOW_YN }' showValue='false' />" } } /* 노출여부 */
										, {name:"bigo", label:"<spring:message code='column.bigo' />", width:"200", align:"center", sortable:false } /* 비고 */
										, {name:"sysRegrNm", label:"<spring:message code='column.sys_regr_nm' />", width:"150", align:"center"}
										, {name:"sysRegDtm", label:"<spring:message code='column.sys_reg_dtm' />", width:"200", align:"center", formatter:gridFormat.date, dateformat:"${adminConstants.COMMON_DATE_FORMAT }" }  
									    , {name:"resultYN", label:'<spring:message code="column.rst_cd" />', width:"50", align:"center"}
						                , {name:"resultMsg", label:'<spring:message code="column.rst_msg" />', width:"200", align:"center"}
								]
							   ,multiselect: true
							});
							
						 
							$.each(data.resultList, function(index, result) { 
								var addData = {
										goodsId		:result.goodsId		
										,imgPath	:result.imgPath		
										,goodsNm	:result.goodsNm		
										,stIds		:result.stIds		    
										,stNms		:result.stNms			
										,goodsTpCd	:result.goodsTpCd		
										,goodsStatCd:result.goodsStatCd	
										,mdlNm		:result.mdlNm			
										,saleAmt	:result.saleAmt		
										,compNm		:result.compNm		
										,bndNmKo	:result.bndNmKo		
										,mmft		:result.mmft			
										,saleStrtDtm:result.saleStrtDtm	
										,saleEndDtm	:result.saleEndDtm	
										,showYn		:result.showYn		
										,bigo		:result.bigo			
										,sysRegrNm	:result.sysRegrNm		
										,sysRegDtm	:result.sysRegDtm		
										,resultYN	:result.resultYN		
										,resultMsg	:result.resultMsg		
									}
								$("#resultList").jqGrid('addRowData', index, addData, 'last', null);
								
								grid.resize();
							 
								});
							 
						}
					};
					ajax.call(options);
				}

			}
			
			function fnConfirm(){
				var jsonArray = new Array();
				var message = new Array();
				var grid = $("#resultList" );
				var rowids = null;
				var check = true;  
				rowids = grid.jqGrid('getGridParam', 'selarrrow');
				for (var i = rowids.length - 1; i >= 0; i--) {
					if(jsonArray.length > 0 ){
						for (var j = jsonArray.length - 1; j >= 0; j--) { 
							if (jsonArray[j].goodsId  ==  grid.jqGrid('getRowData', rowids[i]).goodsId ){
								message.push( grid.jqGrid('getRowData', rowids[i]).goodsId + " 중복된 상품입니다.");
								check = false ;
							}
						}
					}
					 if (grid.jqGrid('getRowData', rowids[i]).resultYN  == '성공'){
						 jsonArray.push( grid.jqGrid('getRowData', rowids[i])      );	
					 }else if(grid.jqGrid('getRowData', rowids[i]).resultYN  == '실패') {
						 check = false ;
						 message.push( grid.jqGrid('getRowData', rowids[i]).goodsId + " 조회가 안된 상품입니다.");
					 }
				}
				 if (!check){
					 if(message != null && message.length > 0) {
						alert(message.join("\n"));
					 }
				 }else{
					 fnGoodsExListExcelUploadPopCallBack(jsonArray);
					 layer.close('goodsExListExcelUpload');
				 }
			}

		</script>

	<form id="goodsExExcelUploadForm" name="goodsExExcelUploadForm" method="post" >
 
			<table class="table_type1">
				<caption>글 정보보기</caption>
				<tbody>
					<tr>
						<!-- 업체구분 -->
						<th scope="row">Sample 다운로드</th>
						<td colspan="3">
							<strong class="blue-desc">*************************************************</strong><br>
							<strong class="blue-desc">** 1. Sample 다운로드</strong><br>
							<strong class="blue-desc">** 2. 다운받은 양식을 정해진 포맷에 맞게 수정 </strong><br>
							<strong class="blue-desc">** 3.	다른 필드는 수정 금지 </strong><br>
							<strong class="blue-desc">** 4.	최대 1000 건 이상 금지  </strong><br>
							<strong class="blue-desc">** 5. 수정된 파일 업로드 </strong><br>
							<strong class="blue-desc">** 6. "제외상품 일괄등록" 버튼 클릭</strong><br>
							<strong class="blue-desc">*************************************************</strong><br>
							<strong class="red">* 주의 : 정해진 포맷 외 필드 추가나 삭제 하지 마세요.</strong>
							<br/>
							<br/>
							<button type="button" class="btn" onclick="fnDeliveryInvoiceBatchSampleDonwload();">Sample 다운로드</button>
							<br/>
							<br/>
							
						</td>
					</tr>
					<tr>
						<!-- 업로드 -->
						<th scope="row"><spring:message code="column.common.btn.excel_upload" /><strong class="red">*</strong></th>
						<td colspan="3">
							<input type="text" id="fileName" name="fileName" value="" />
							<input type="hidden" id="filePath" name="filePath" value="" />
							<a href="javascript:fileUpload.file(fnCallBackFileUpload);" class="btn">파일선택</a>
						</td>
					</tr>
				</tbody>
			</table>
	</form>
<!-- ==================================================================== -->
<!-- ==================================================================== -->

<!-- ==================================================================== -->
<!-- 버튼 -->
<!-- ==================================================================== -->
		<div class="btn_area_center">
			<button class="btn btn-ok" onclick="fnGoodsExListExcelUploadExec();">제외상품 일괄등록</button>
			<!-- <button class="btn_type2" onclick="popupClose();">닫기</button>   -->
		</div>
<!-- ==================================================================== -->
<!-- //버튼 -->
<!-- ==================================================================== -->

<!-- ==================================================================== -->
<!-- 결과 -->
<!-- ==================================================================== -->



		

	<div id="upload_result" style="display: none;">
		<div class="mModule">
			<div class="leftInner">
			 
			<span><b>전체데이터</b></span> : <span id="total_upload_cnt"></span>
			<span class="ml10"><b>성공건수</b></span> : <span id="success_upload_cnt"></span>
			<span class="ml10"><b>실패건수</b></span> : <span id="fail_upload_cnt"></span>
			</div>
			
			<table id="resultList" ></table>
		</div>

	</div>
	
	
<!-- ==================================================================== -->
<!-- //결과 -->
<!-- ==================================================================== -->


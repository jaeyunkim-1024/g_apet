<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">

			$(document).ready(function(){
			});

			$(function(){
				//수거지 수정
				$("#claimAcceptForm #changeDelivery").click(function(){
					if($(this).hasClass( "old" )){
						$("#claimAcceptForm .dlvra_new").show();
						$("#claimAcceptForm .dlvra_old").hide();
						$(this).removeClass("old");
						$(this).addClass("new");
						$(this).text("취소");
					}else{
						$("#claimAcceptForm .dlvra_new").hide();
						$("#claimAcceptForm .dlvra_old").show();
						$(this).removeClass("new");
						$(this).addClass("old");
						$("#claimAcceptForm input.dlvra_new").val("");
						$("#claimAcceptForm span.dlvra_new").html("");
						$(this).text("수거지 수정");
					}
				});
				
				//교환 배송지 수정
				$("#claimAcceptForm #chgChangeDelivery").click(function(){
					if($(this).hasClass( "old" )){
						$("#claimAcceptForm .chg_dlvra_new").show();
						$("#claimAcceptForm .chg_dlvra_old").hide();
						$(this).removeClass("old");
						$(this).addClass("new");
						$(this).text("취소");
						
						$("#claimAcceptForm #copy_dlvr_label").show();
						$("#claimAcceptForm #copy_dlvr_chk").show();
						$("#claimAcceptForm #copy_dlvr_chk").prop('checked', false);
					}else{
						$("#claimAcceptForm .chg_dlvra_new").hide();
						$("#claimAcceptForm .chg_dlvra_old").show();
						$(this).removeClass("new");
						$(this).addClass("old");
						$("#claimAcceptForm input.chg_dlvra_new").val("");
						$("#claimAcceptForm span.chg_dlvra_new").html("");
						$(this).text("교환 배송지 수정");
						
						$("#claimAcceptForm #copy_dlvr_label").hide();
						$("#claimAcceptForm #copy_dlvr_chk").hide();
					}
				});
				
				//수거지와 동일 버튼
				$("#claimAcceptForm #copy_dlvr_chk").click(function(){
					if($(this).prop("checked")){
						if($("#claimAcceptForm #changeDelivery").hasClass( "new" )){
							$("#claimAcceptForm #chgAdrsNm").val($("#claimAcceptForm #adrsNm").val());
							$("#claimAcceptForm #chgTel").val($("#claimAcceptForm #tel").val());
							$("#claimAcceptForm #chgMobile").val($("#claimAcceptForm #mobile").val());
							$("#claimAcceptForm #chgPostNoNew").val($("#claimAcceptForm #postNoNew").val());
							$("#claimAcceptForm #chgPostNoOld").val($("#claimAcceptForm #postNoOld").val());
							$("#claimAcceptForm #chgRoadAddr").val($("#claimAcceptForm #roadAddr").val());
							$("#claimAcceptForm #chgRoadDtlAddr").val($("#claimAcceptForm #roadDtlAddr").val());
							$("#claimAcceptForm #chgPrclAddr").val($("#claimAcceptForm #prclAddr").val());
							$("#claimAcceptForm #chgDlvrMemo").val($("#claimAcceptForm #dlvrMemo").val());
						}else{
							$("#claimAcceptForm #chgAdrsNm").val($("#claimAcceptForm #orgAdrsNm").val());
							$("#claimAcceptForm #chgTel").val($("#claimAcceptForm #orgTel").val());
							$("#claimAcceptForm #chgMobile").val($("#claimAcceptForm #orgMobile").val());
							$("#claimAcceptForm #chgPostNoNew").val($("#claimAcceptForm #orgPostNoNew").val());
							$("#claimAcceptForm #chgPostNoOld").val($("#claimAcceptForm #orgPostNoOld").val());
							$("#claimAcceptForm #chgRoadAddr").val($("#claimAcceptForm #orgRoadAddr").val());
							$("#claimAcceptForm #chgRoadDtlAddr").val($("#claimAcceptForm #orgRoadDtlAddr").val());
							$("#claimAcceptForm #chgPrclAddr").val($("#claimAcceptForm #orgPrclAddr").val());
							$("#claimAcceptForm #chgDlvrMemo").val($("#claimAcceptForm #orgDlvrMemo").val());
						}
						
					}
					
				});
				/* $("#claimAcceptForm #changeOption").click(function(){
					changeOption($(this));
				}); */
				
				$("#claimAcceptForm #clmRsnCd").change(function(){
					//fnClaimAcceptExpt();
				});
	
			});
			
			/* 
			// 교환 예정  금액 조회
			function fnClaimAcceptExpt(){
				if($("#clmRsnCd").val() != "" && $(".arrExcQty").length > 0){
		 			var options = {
	 					url : "<spring:url value='/claim/claimExchangeExpt.do' />"
	 					, data :  $("#claimAcceptForm").serializeJson()
 						, callBack : function(data){
 							
 							$("#refund_add_dlvr_amt").html(validation.num(data.claimRefund.clmDlvrcAmt));
 							$("#exchange_pay_amt").val(data.claimRefund.clmDlvrcAmt);
 							
 							if(data.claimRefund.clmDlvrcAmt > 0){
 								$("#clm_rsn_enclose_yn").show();
 								$("#clm_rsn_enclose_nm").show();
 							}else{
 								$("#clm_rsn_enclose_yn").hide();
 								$("#clm_rsn_enclose_nm").hide();
 							}
						}
		 			};

 					ajax.call(options);
				}
			} 
			*/
			
			// 교환/반품 접수 실행
			function fnClaimExchangeAcceptExec() {

				if ( validate.check("claimAcceptForm") ) {
					
					var payAmt = parseInt($("#claimAcceptForm #exchange_pay_amt").val());
					if(payAmt > 0){
						console.log("교환배송비 발생함!!");
						/* if(!$("#claimAcceptForm #clm_rsn_enclose_yn").prop("checked")){
							messager.alert( "교환배송비가 존재합니다.\n관리자에서는 교환배송비에 대해 동봉처리만 가능합니다." ,"Info","info");
							return;
						} */
					}
					
					
					messager.confirm('<spring:message code="column.order_common.confirm.claim_exchange_accept" />',function(r){
						if(r){
							//배송지 변경 시 맞교환 N
							if($("#claimAcceptForm #changeDelivery").hasClass( "new" ) || $("#claimAcceptForm #chgChangeDelivery").hasClass( "new" ) || "${orderBase.getDlvrPrcsTpCd()}" === "${adminConstants.DLVR_PRCS_TP_10}" ){
								$("#swapYn").val("N")
							}else{
								$("#swapYn").val("Y")
							}
							
							var options = {
								url : "<spring:url value='/claim/claimExchangeExc.do' />"
								, data : $("#claimAcceptForm").serializeJson()
								, callBack : function(result){
									messager.alert( "<spring:message code="column.order_common.claim_exchange_accept.success" />", "Info", "info", function(){
										document.location.reload();
										layer.close('claimExchangeAcceptView');
									});
									
								}
							};

							ajax.call(options);
						}
					});
				}

			}

			/*
			 * 유효성 검사
			 */
			/* function validClaimExchangeAccept(){
				var goodsIdList = $("input.goodsId");
				var itemNoList = $("input.itemNo");
				var goodsId;
				var itemNo;
				for(var i=0; i<goodsIdList.length; i++){
					goodsId = $(goodsIdList[i]).val();
					itemNo = $(itemNoList[i]).val();
					//교환대상 설정 체크
					if($("#chaneOptionArea_"+goodsId + "_" + itemNo +" > li").length == 0){
						messager.alert( "교환 대상 단품이 설정되지 않았습니다." ,"Info","info");
						return false;
					}

					var targetList = $("#chaneOptionArea_"+goodsId + "_" + itemNo +" > li");
					var maxQty = $("#itemMaxQty_" + goodsId + "_" + itemNo).val();
					var clmQty = 0;

					for(var j=0; j<targetList.length; j++){
						clmQty += parseInt($(targetList[j]).children("ul").children("li.qty").children("select").val());
					}

					if(clmQty > maxQty){
						messager.alert( "교환 대상 수량이 신청가능 수량을 초과하였습니다." ,"Info","info");
						return false;
					}

				//교환수량 체크
				}

				return true;
			} */

<%-- 
			/*
			 * 옵션 변경
			 */
			function changeOption(obj){
				var ordDtlSeq = $(obj).parent().children("input.ordDtlSeq").val();
				var goodsId = $(obj).parent().children("input.goodsId").val();
				var itemNo = $(obj).parent().children("input.itemNo").val();

				var strButton = "<button type=\"button\" onclick=\"addChangeOption(" + ordDtlSeq +", '"+goodsId+"', "+itemNo+");\" class=\"btn btn-ok\">확인</button>";

				//var strButton = "";

				var html = new Array();
				html.push('<div class="mModule">');
				html.push('	<table id="clmExcItemList" ></table>');
				html.push('</div>');
				var config = {
					id : "clmExcItemChangeLayer"
					, width : 500
					, height : 600
					, top : 200
					, title : "단품 선택"
					, body : html.join("")
					, button : strButton
				}
				layer.create(config);

				var options = {
					url : "<spring:url value='/claim/itemListGrid.do' />"
					, paging : false
					, height : 200
					, searchParam : {
						goodsId : goodsId
					}
					, colModels : [
						//단품 번호
						{name:"itemNo", label:'<spring:message code="column.item_no" />', width:"70", align:"center", sortable : false}
						//단품 명
						, {name:"itemNm", label:'<spring:message code="column.item_nm" />', width:"130", align:"center", sortable : false}
						//상태
						, {name:"itemStatCd", label:'<spring:message code="column.item_stat_cd" />', width:"80", align:"center", sortable : false, formatter:"select", editoptions:{value:"<frame:gridSelect grpCd="${adminConstants.ITEM_STAT}" />"}}
						//추가 판매 금액
							, {name:"addSaleAmt", label:'<spring:message code="column.add_sale_amt" />', width:"90", align:"center", formatter:'integer', sortable : false}
						//추가 판매 금액
							, {name:"webStkQty", label:'<spring:message code="column.web_stk_qty" />', width:"90", align:"center", formatter:'integer', sortable : false}
					]
				};
				grid.create("clmExcItemList", options);
			}

			/*
			 * 옵션 변경 내역 추가
			 */
			function addChangeOption(ordDtlSeq, goodsId, itemNo){

				/* 원 단품데이터 조회 */
				var itemData;
            	var ids = $('#clmExcItemList').jqGrid('getDataIDs');
                var gridData = $("#clmExcItemList").jqGrid('getRowData');
                var stkMngYn = $("#stkMngYn_"+goodsId+ "_" + itemNo).val();
 				var maxClmQty = parseInt($("#itemMaxQty_"+goodsId +"_" + itemNo).val());
				var webStkQty = 0;

            	if(gridData.length > 0){
	                // 데이터 확인후 색상 변경
	                for (var i = 0; i < gridData.length; i++) {

	                	// 데이터의 is_test 확인
	                	if (gridData[i].itemNo == itemNo) {
	                		itemData = gridData[i];
	                   }
	                }
            	}

				/* 교환대상 단품 조회 */
				var grid = $("#clmExcItemList");
				var rowKey = grid.getGridParam("selrow");

				if(rowKey == null){
					messager.alert( "단품이 선택되지 않았습니다." ,"Info","info");
					return;
				}

				var rowData = grid.getRowData(rowKey);

 				if(rowData.addSaleAmt != itemData.addSaleAmt){
 					messager.alert( "단품의 결제금액이 다릅니다." ,"Info","info");
					return;
				}

 				if(stkMngYn == "Y" && itemData.webStkQty == 0){
 					messager.alert( "재고가 부족합니다." ,"Info","info");
					return;
 				}

 				var objId = "opction_change_item_no_"+goodsId +"_" + itemNo + "_" +rowData.itemNo;

 				var changeOptionList = $("#chaneOptionArea_" + goodsId + "_" + itemNo +" > li");

 				if(changeOptionList.length > 0){
 					for(var i=0; i < changeOptionList.length; i++){
 						if($(changeOptionList[i]).attr("id") == objId){
 							messager.alert( "이미 추가된 단품입니다." ,"Info","info");
 							return;
 						}
 					}
 				}

 				단품 변경은 1개의 단품으로만 가능하도록 처리, 해당라인 제거 시 멀티 변경 가능
 				$("#chaneOptionArea_"+goodsId +"_" + itemNo).html("");

 				var optionHtml = "";
				optionHtml += "		<li id=\""+objId+"\">";
				optionHtml += "			<ul class=\"itemList\">";
				optionHtml += "				<li style=\"width:50%;\">";
				optionHtml += "					<input type=\"hidden\" name=\"arrOrdDtlSeq\" value=\""+ordDtlSeq+"\" />";
				optionHtml += "					<input type=\"hidden\" name=\"arrExcItemNo\" value=\""+rowData.itemNo+"\" />";
				optionHtml += "					<input type=\"hidden\" name=\"orgItemNo\" value=\""+rowData.itemNo+"\" />";
				optionHtml += "					<span style=\"margin-right:50px;\">" + rowData.itemNm + "</span>";
				optionHtml += "				</li>";

				optionHtml += "				<li style=\"width:30%;\" class=\"qty\">";
				optionHtml += "					<select name=\"arrExcQty\" class=\"arrExcQty\">";

				//최대 변경수량보다 현재고가 작은 경우 최대교환가능수량 재조정
 				if(stkMngYn == "Y" && itemData.webStkQty < maxClmQty){
 					maxClmQty = itemData.webStkQty;
 				}

				for(var j=1; j<=maxClmQty; j++){
					optionHtml += "					<option value=\""+j+"\">" + j + "</option>";
				}
				optionHtml += "					</select>";
				optionHtml += "				</li>";

				옵션 멀티 변경 시에는 해당 주석 제거
// 				optionHtml += "				<li style=\"width:20%;\">";
// 				optionHtml += "					<button type=\"button\" onclick=\"removeChangOption(this);\" class=\"btn_type4\">삭제</button>";
// 				optionHtml += "				</li>";

				optionHtml += "			</ul>";
				optionHtml += "		</li>";
				$("#chaneOptionArea_"+goodsId +"_" + itemNo).append(optionHtml);

				layer.close("clmExcItemChangeLayer");
				
				fnClaimAcceptExpt();
			}

			/*
			 * 교환 대상 옵션 삭제
			 */
			function removeChangOption(obj){
				$(obj).parent().parent().parent().remove();
			} 
--%>
			
			function imgUpload(){
				if($("#claimAcceptForm input[name=imgPaths]").length  >= 5){
					messager.alert("사진은 최대 5개까지만 첨부 가능합니다.", "Info", "info");
					return;
				}
				
				fileUpload.image(resultImage);
			}
			
			function resultImage(file){
				var html = "";
				html += '<div style="float:left;margin-right:10px;margin-bottom:5px;text-align:center;">';
				html += '<input type="hidden" name="imgPaths" value="'+file.filePath+'">';
				html += '<img src="/common/imageView.do?filePath='+file.filePath+'"  onerror="/images/noimage.png" class="thumb" style="width:100px;height:100px" alt="">';
				html += '<br/><button type="button" class="btn" onclick="deleteImage(this)">삭제</button>';
				html += '</div>';
				$("#imageDiv").append(html);
			}
			
			function deleteImage(obj){
				messager.confirm('사진을 삭제하시겠습니까?',function(r){
					if(r){
						$(obj).parent("div").remove();
					}
				});
			}
			
			/*
			 * 우편번호 검색
			 */
			function postPopLayer(gb) {
				
				window.resizeTo(950, 900);
				if(gb =='dlvra'){
					layer.post(postResult);
				}else{
					layer.post(chgPostResult);
				}
			}

			/*
			 * 우편번호 검색 결과
			 */
			function postResult(result){
				window.resizeTo(950, 900);
				$("#claimAcceptForm #postNoOld").val(result.postcode);
				$("#claimAcceptForm #prclAddr").val(result.jibunAddress);
				$("#claimAcceptForm #prclAddrView").html(result.jibunAddress);
				$("#claimAcceptForm #postNoNew").val(result.zonecode);
				$("#claimAcceptForm #roadAddr").val(result.roadAddress);
			}
			
			function chgPostResult(result){
				window.resizeTo(950, 900);
				$("#claimAcceptForm #chgPostNoOld").val(result.postcode);
				$("#claimAcceptForm #chgPrclAddr").val(result.jibunAddress);
				$("#claimAcceptForm #chgPrclAddrView").html(result.jibunAddress);
				$("#claimAcceptForm #chgPostNoNew").val(result.zonecode);
				$("#claimAcceptForm #chgRoadAddr").val(result.roadAddress);
			}

		</script>

			<form id="claimAcceptForm" name="claimAcceptForm" method="post" >
			<input type="hidden" name="ordNo" id="ordNo" value="${orderBase.ordNo}">
			<input type="hidden" name="swapYn" id="swapYn" value="Y">
			<input type="hidden" id="exchange_pay_amt" name="refundAmt" value="0">


			<div class="mTitle">
				<h2><spring:message code="column.order_common.order_info" /></h2>
			</div>
			<table class="table_type1">
				<caption>글 정보보기</caption>
				<colgroup>
					<col class="th-s" />
					<col />
					<col class="th-s" />
					<col />
					<col class="th-s" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><spring:message code="column.ord_no" /></th>
						<td colspan="5">
							${orderBase.ordNo}
						</td>
					</tr>
					<c:forEach items="${listOrderDetail}" var="getOrderDetail" varStatus="idx" >
					<tr class="orderDetailGoods">
						<th scope="row"><spring:message code="column.ord_dtl_seq" /></th>
						<td>
							<input type="hidden" name="arrOrdDtlSeq" value="${getOrderDetail.ordDtlSeq}" />
							${getOrderDetail.ordDtlSeq}
						</td>
						<th scope="row"><spring:message code="column.goods_nm" /></th>
						<td>
							${getOrderDetail.goodsNm}
						</td>
						<th scope="row">
							<spring:message code="column.accept_qty" />
							<%-- <spring:message code="column.accept_psb_qty" /> --%>
						</th>
						<td>
							<%-- <c:set var="maxClmQty" value="${getOrderDetail.rmnOrdQty - getOrderDetail.rtnQty - getOrderDetail.clmExcIngQty}" />
							<input type="hidden" name="arrClmQty" id="arrClmQty" value="${maxClmQty }">
							${maxClmQty} --%>
							<%-- <input type="hidden" id="itemMaxQty_${getOrderDetail.goodsId}_${getOrderDetail.itemNo}" class="maxClmQty" value="${maxClmQty}" />
							<input type="hidden" id="stkMngYn_${getOrderDetail.goodsId}_${getOrderDetail.itemNo}" value="${getOrderDetail.stkMngYn}" /> --%>
							
							<select name="arrClmQty">
								<c:forEach begin="1" end="${getOrderDetail.rmnOrdQty - getOrderDetail.rtnQty - getOrderDetail.clmExcIngQty}" var="qty">
									<option value="${qty}" <c:if test="${getOrderDetail.rmnOrdQty - getOrderDetail.rtnQty - getOrderDetail.clmExcIngQty eq  qty}">selected="selected"</c:if>>${qty}</option>
								</c:forEach>
							</select>
						</td>
						</tr>
					</c:forEach>
					<tr>
						<th scope="row"><spring:message code="column.clm_rsn_cd" /><strong class="red">*</strong></th>
						<td colspan="5">
							<select id="clmRsnCd" name="clmRsnCd" title="선택상자" >
								<c:forEach items="${clmRsnList}" var="clmRsn">
									<c:if test="${clmRsn.dtlCd ne adminConstants.CLM_RSN_370 }">
									<option value="${clmRsn.dtlCd }" data-grp="${clmRsn.usrDfn2Val }">
									${clmRsn.dtlNm}
										( 귀책 :
									<c:if test="${clmRsn.usrDfn2Val eq adminConstants.RSP_RSN_10}">
										고객										
									</c:if>
									<c:if test="${clmRsn.usrDfn2Val eq adminConstants.RSP_RSN_20}">
										업체
									</c:if>
										)										
									</option>
									</c:if>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row" ><spring:message code="column.claim_common.claim_rsn_detail_content" /><strong class="red">*</strong></th>
						<td colspan="2">
							<textarea cols="30" rows="5" style="width:95%;" id="clmRsnContent" name="clmRsnContent" class="validate[required, maxSize[500]]"></textarea>
						</td>
						<th scope="row"><spring:message code="column.claim_common.refund_image" /></th>
						<td colspan="2">
							<button type="button" class="btn btn-add" onclick="imgUpload();">사진 첨부하기</button><br/>
							<div id="imageDiv">
						
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.claim_common.cs_tck_no" /><strong class="red">*</strong></th>
						<td colspan="5">
							<input type="text" class="validate[required,maxSize[100]]" name="twcTckt" id="twcTckt" title="<spring:message code="column.claim_common.cs_tck_no" />" value="" />
						</td>
					</tr>
				</tbody>
			</table>

			<%-- <div class="mTitle mt30">
				<h2><spring:message code="column.order_common.refund_exchnage_amt_info" /></h2>
			</div>
			<table class="table_type1">
				<caption><spring:message code="column.order_common.refund_info" /></caption>
				<colgroup>
					<col class="th-s" />
					<col />
					<col class="th-s" />
					<col />
				</colgroup>
				<tbody>			
					<tr>
						<th scope="row">교환배송비</th>
						<td id="refund_add_dlvr_amt">
						</td>
						<th scope="row">배송비동봉여부</th>
						<td>
							<input type="checkbox" id="clm_rsn_enclose_yn" style="display:none;" name="encloseYn" value="Y" /><label style="display:none;" for="clm_rsn_enclose_yn" id="clm_rsn_enclose_nm">예</label> 
						</td>
					</tr>

				</tbody>
			</table> --%>
		
		
			<div class="row mt30">
				<div class="col-md-6">
					<div class="mTitle">
						<h2>
							<spring:message code="column.claim_common.refund_delivery_info" />
						</h2>
						<div class="buttonArea">
							<button type="button" id="changeDelivery" class="btn btn-add old">수거지 수정</button>
						</div>
					</div>
					
					<!-- 복사용 -->
					<input type="hidden" id="orgAdrsNm" value="${orderDlvra.adrsNm}"/>
					<input type="hidden" id="orgTel" value="${orderDlvra.tel}"/>
					<input type="hidden" id="orgMobile" value="${orderDlvra.mobile}"/>
					<input type="hidden" id="orgPostNoNew" value="${orderDlvra.postNoNew}"/>
					<input type="hidden" id="orgPostNoOld" value="${orderDlvra.postNoOld}"/>
					<input type="hidden" id="orgRoadAddr" value="${orderDlvra.roadAddr}"/>
					<input type="hidden" id="orgRoadDtlAddr" value="${orderDlvra.roadDtlAddr}"/>
					<input type="hidden" id="orgPrclAddr" value="${orderDlvra.prclAddr}"/>
					<input type="hidden" id="orgPrclDtlAddr" value="${orderDlvra.prclDtlAddr}"/>
					<input type="hidden" id="orgDlvrMemo" value="${orderDlvra.dlvrDemand}"/>
					
					<div id="deliveryInfo">
						<table class="table_type1">
							<caption><spring:message code="column.order_common.delivery_info" /></caption>
							<colgroup>
								<col class="th-s" />
								<col />
								<col class="th-s" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code="column.adrs_nm"/><strong class="red">*</strong></th>
									<td colspan="3">
										<!-- 수취인 명-->
										<p class="dlvra_old">${orderDlvra.adrsNm}</p>
										<input type="text" class="validate[required, maxSize[50]] dlvra_new" name="adrsNm" id="adrsNm" title="<spring:message code="column.adrs_nm"/>" value="" style="display:none;"/>
									</td>
								</tr>
								<tr>
									<th><spring:message code="column.tel"/></th>
									<td>
										<!-- 전화-->
										<p class="dlvra_old"><frame:tel data="${orderDlvra.tel}" /></p>
										<input type="text" class="w100 phoneNumber validate[custom[tel]] dlvra_new" name="tel" id="tel" title="<spring:message code="column.tel"/>" value="" style="display:none;"/>
									</td>
									<th><spring:message code="column.mobile"/><strong class="red">*</strong></th>
									<td>
										<!-- 휴대폰-->
										<p class="dlvra_old"><frame:mobile data="${orderDlvra.mobile}" /></p>
										<input type="text" class="w100 phoneNumber validate[required, custom[mobile]] dlvra_new" name="mobile" id="mobile" title="<spring:message code="column.mobile"/>" value="" style="display:none;"/>
									</td>
								</tr>
								<tr>
									<th><spring:message code="column.common.post"/><strong class="red">*</strong></th>
									<td colspan="3">
										<p class="dlvra_old">${orderDlvra.postNoNew}</p>
										
										<input type="text" class="readonly validate[required] w50 dlvra_new" name="postNoNew" id="postNoNew" readonly="readonly" style="display:none;"/>
										<button type="button" onclick="postPopLayer('dlvra');" class="btn dlvra_new" style="display:none;"><spring:message code="column.common.post.btn"/></button>
										<input type="hidden" class="readonly validate[required] dlvra_new" name="postNoOld" id="postNoOld" value="" />
		
										<div class="mg5">
											<strong style="display:inline-block;width:80px;">[도로명 주소]</strong>
											<span class="dlvra_old">${orderDlvra.roadAddr} &nbsp;&nbsp; ${orderDlvra.roadDtlAddr }</span>
											<input type="text" class="readonly w300 validate[required] dlvra_new" name="roadAddr" id="roadAddr" value="" readonly="readonly" style="display:none;"/>
											<input type="text" class="w200 validate[required] dlvra_new" name="roadDtlAddr" id="roadDtlAddr" value="" style="display:none;"/>
										</div>
		
										<div class="mg5">
											<strong style="display:inline-block;width:80px;">[지번 주소]</strong>
											<span class="dlvra_old">${orderDlvra.prclAddr} &nbsp;&nbsp; ${orderDlvra.prclDtlAddr }</span>
											<span id="prclAddrView" class="dlvra_new"></span>
											<input type="text" class="readonly w300 validate[required] dlvra_new" name="prclAddr" id="prclAddr" value="" style="display:none;"/>
										</div>
		
									</td>
								</tr>
								<tr>
									<th><spring:message code="column.order_common.dlvr_demand" /></th>
									<td colspan="3">
										<p class="dlvra_old">${orderDlvra.dlvrDemand }</p>
										<input type="text" class="validate[maxSize[500]] dlvra_new" name="dlvrMemo" id="dlvrMemo" value="" style="width:90%;display:none;" />
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="col-md-6">
					<!-- /교환 배송지 -->
					<div class="mTitle">
						<h2>
							<spring:message code="column.claim_common.exchange_delivery_info" />&nbsp;&nbsp;&nbsp;
							<input type="checkbox" style="display:none;" id="copy_dlvr_chk"/><label style="display:none;" id="copy_dlvr_label">수거지와 동일</label>
						</h2>
						<div class="buttonArea">
							<button type="button" id="chgChangeDelivery" class="btn btn-add old">교환 배송지 수정</button>
						</div>
					</div>
		
					<div id="chgDeliveryInfo">
						<table class="table_type1">
							<caption><spring:message code="column.claim_common.exchange_delivery_info" /></caption>
							<colgroup>
								<col class="th-s" />
								<col />
								<col class="th-s" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th><spring:message code="column.adrs_nm"/><strong class="red">*</strong></th>
									<td colspan="3">
										<!-- 수취인 명-->
										<p class="chg_dlvra_old">${orderDlvra.adrsNm}</p>
										<input type="text" class="validate[required, maxSize[50]] chg_dlvra_new" name="chgAdrsNm" id="chgAdrsNm" title="<spring:message code="column.adrs_nm"/>" value="" style="display:none;"/>
									</td>
								</tr>
								<tr>
									<th><spring:message code="column.tel"/></th>
									<td>
										<!-- 전화-->
										<p class="chg_dlvra_old"><frame:tel data="${orderDlvra.tel}" /></p>
										<input type="text" class="w100 phoneNumber validate[custom[tel]] chg_dlvra_new" name="chgTel" id="chgTel" title="<spring:message code="column.tel"/>" value="" style="display:none;"/>
									</td>
									<th><spring:message code="column.mobile"/><strong class="red">*</strong></th>
									<td>
										<!-- 휴대폰-->
										<p class="chg_dlvra_old"><frame:mobile data="${orderDlvra.mobile}" /></p>
										<input type="text" class="w100 phoneNumber validate[required, custom[mobile]] chg_dlvra_new" name="chgMobile" id="chgMobile" title="<spring:message code="column.mobile"/>" value="" style="display:none;"/>
									</td>
								</tr>
								<tr>
									<th><spring:message code="column.common.post"/><strong class="red">*</strong></th>
									<td colspan="3">
										<p class="chg_dlvra_old">${orderDlvra.postNoNew}</p>
										
										<input type="text" class="readonly validate[required] w50 chg_dlvra_new" name="chgPostNoNew" id="chgPostNoNew" readonly="readonly" style="display:none;"/>
										<button type="button" onclick="postPopLayer('chg');" class="btn chg_dlvra_new" style="display:none;"><spring:message code="column.common.post.btn"/></button>
										<input type="hidden" class="readonly validate[required] chg_dlvra_new" name="chgPostNoOld" id="chgPostNoOld" value="" />
		
										<div class="mg5">
											<strong style="display:inline-block;width:80px;">[도로명 주소]</strong>
											<span class="chg_dlvra_old">${orderDlvra.roadAddr} &nbsp;&nbsp; ${orderDlvra.roadDtlAddr }</span>
											<input type="text" class="readonly w300 validate[required] chg_dlvra_new" name="chgRoadAddr" id="chgRoadAddr" value="" readonly="readonly" style="display:none;"/>
											<input type="text" class="w200 validate[required] chg_dlvra_new" name="chgRoadDtlAddr" id="chgRoadDtlAddr" value="" style="display:none;"/>
										</div>
		
										<div class="mg5">
											<strong style="display:inline-block;width:80px;">[지번 주소]</strong>
											<span class="chg_dlvra_old">${orderDlvra.prclAddr} &nbsp;&nbsp; ${orderDlvra.prclDtlAddr }</span>
											<span id="chgPrclAddrView" class="chg_dlvra_new"></span>
											<input type="text" class="readonly w300 validate[required] chg_dlvra_new" name="chgPrclAddr" id="chgPrclAddr" value="" style="display:none;"/>
										</div>
		
									</td>
								</tr>
								<tr>
									<th><spring:message code="column.order_common.dlvr_demand" /></th>
									<td colspan="3">
										<p class="chg_dlvra_old">${orderDlvra.dlvrDemand }</p>
										<input type="text" class="validate[maxSize[500]] chg_dlvra_new" name="chgDlvrMemo" id="chgDlvrMemo" value="" style="width:90%;display:none;">
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			</form>



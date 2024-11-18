<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<script type="text/javascript">

			$(document).ready(function(){
			});

			$(function(){

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

				$("#claimAcceptForm #clmRsnCd").change(function(){
					fnClaimAcceptExpt();
					var opt = $(this).find("option:checked");
					if(opt.data("grp") == '${adminConstants.RSP_RSN_20}'){
						$("#claimAcceptForm #clmRsnContent").addClass("validate[required]");
						$("#claimAcceptForm #clmRsnContentText").html('<spring:message code="column.claim_common.claim_rsn_detail_content" /><strong class="red">*</strong>');
					}else{
						$("#claimAcceptForm #clmRsnContent").removeClass("validate[required]");
						$("#clmRsnContentText").html('<spring:message code="column.claim_common.claim_rsn_detail_content" />');
					}
				});
				
				$("#claimAcceptForm #clmRsnCd").trigger('change');

				$("#claimAcceptForm select[name=arrClmQty]").change(function(){
					fnClaimAcceptExpt();
				});
				
				$("#claimAcceptForm #bankCd", "#claimAcceptForm #ooaNm", "#claimAcceptForm #acctNo").change(function(){
					$("#claimAcceptForm #cetifyYn").val("N");
				});
				
				$("#claimAcceptForm #fixAcct").change(function(){
					var chk = $(this).find("option:checked");
					$("#claimAcceptForm #depositBankCd").val(chk.data("usrdfn1"));
					$("#claimAcceptForm #depositAcctNo").val(chk.data("usrdfn2"));
					$("#claimAcceptForm #depositAcctNoText").text(chk.data("usrdfn2"));
				});
				
			});

			// 반품 예정 금액 조회
			function fnClaimAcceptExpt(){
				if($("#claimAcceptForm #clmRsnCd").val() != "" && $("#claimAcceptForm #arrClmQty") != ""){
					
					var options = {
	 					url : "<spring:url value='/claim/claimReturnExpt.do' />"
	 					, data :  $("#claimAcceptForm").serializeJson()
 						, callBack : function(data){
 							
 				
 							
 							/* var orgDlvrcAmt = 0; //원배송비
 							var ordDlvrcAmt = 0; //조건부무료배송->배송비 부과
 							if(data.claimRefund.orgDlvrcAmt != undefined){
 								orgDlvrcAmt = parseInt(data.claimRefund.orgDlvrcAmt);
 							
	 							if (orgDlvrcAmt < 0) {
	 								ordDlvrcAmt = parseInt(Math.abs(orgDlvrcAmt));
	 								orgDlvrcAmt = 0;
	 							}
 							} */
							//합계정보
							// 결제정보 상품금액
							var payGoodsAmt = parseInt(data.claimRefund.goodsAmt);
							$("#claimAcceptForm #pay_goods_amt").html(validation.num(payGoodsAmt));
							
							// 결제 정보 쿠폰할인 금액
							var payCpDcAmt = parseInt(data.claimRefund.cpDcAmt) + parseInt(data.claimRefund.cartCpDcAmt);
							$("#claimAcceptForm #pay_cp_amt").html(validation.num(payCpDcAmt * -1));
							
							// 차감정보 쿠폰 할인 금액
							$("#claimAcceptForm #reduce_cp_amt").html(validation.num(payCpDcAmt));
							
							// 결제정보 배송비
							var payDlvrAmt = parseInt(data.claimRefund.refundDlvrAmt) + parseInt(data.claimRefund.realDlvrAmt);
						
							$("#claimAcceptForm #pay_dlvr_amt").html(validation.num(payDlvrAmt));
							
							// 결제 총합
							$("#claimAcceptForm #refund_total_pay").html(validation.num(payGoodsAmt - payCpDcAmt + payDlvrAmt));
							
							// 차감 정보 배송비
							var reduceDlvrAmt = parseInt(data.claimRefund.reduceDlvrcAmt * -1) + parseInt(data.claimRefund.realDlvrAmt * -1);
							$("#claimAcceptForm #reduce_dlvr_amt").html(validation.num(reduceDlvrAmt));
							
							// 차감정보 추가 배송비
							var reduceAddDlvrAmt = parseInt(data.claimRefund.clmDlvrcAmt * -1);
							$("#claimAcceptForm #reduce_add_dlvr_amt").html(validation.num(reduceAddDlvrAmt));
							
							// 차감 총합
							$("#claimAcceptForm #refund_total_reduce").html(validation.num(reduceDlvrAmt + reduceAddDlvrAmt));
							
							// 환불 총합
							var totalAmt = parseInt(data.claimRefund.totAmt);
							$("#claimAcceptForm #refund_total_refund").html(validation.num(totalAmt));
 							
							// 금액 초기화 및 수단별 금액 계산
							$("#claimAcceptForm #refund_pay_amt").html(0);
							$("#claimAcceptForm #refund_pnt_amt").html(0);
							$("#claimAcceptForm #refund_mp_pnt_amt").html(0);
							$("#minus_pay_amt_nm").html("");
							$("#minus_pay_amt").html("");
							
							var refundPayAmt = 0;
							var refundPntAmt = 0;
							
 							jQuery.each(data.claimRefund.meansList, function(i, payMeans){
 								if(payMeans.payMeansCd == '${adminConstants.PAY_MEANS_80}'){
 									refundPntAmt += payMeans.refundAmt;
 									$("#claimAcceptForm #refund_pnt_amt").html(validation.num(payMeans.refundAmt));
 								}else if(payMeans.payMeansCd == '${adminConstants.PAY_MEANS_81}'){
 									refundPntAmt += payMeans.refundAmt;
 									$("#claimAcceptForm #refund_mp_pnt_amt").html(validation.num(payMeans.refundAmt));
 								}else{
 									refundPayAmt += payMeans.refundAmt;
 									$("#claimAcceptForm #refund_pay_amt").html(validation.num(payMeans.refundAmt));
 									if(payMeans.meansNm != null){
 										$("#claimAcceptForm #meansNm").html(payMeans.meansNm +" 환불");
 									} else {
 										$("#claimAcceptForm #meansNm").html("환불");
 									}
 								}
 							});	
							
 							$("#claimAcceptForm #refund_save_pnt").html("");
 							// 최종 환불 금액
 							$("#claimAcceptForm #return_pay_amt").val(data.claimRefund.totAmt);
 							
 							// 마이너스 환불 표시
 							var minusRefund = data.claimRefund.totAmt - (refundPayAmt+refundPntAmt);
 							if(data.claimRefund.totAmt < 0){
 								$("#claimAcceptForm #meansNm").html("환불");
 								$("#claimAcceptForm #refund_pay_amt").html(validation.num(data.claimRefund.totAmt));
 							}else if( minusRefund > 0){
 								$("#minus_pay_amt_nm").html("마이너스 환불");
 								$("#minus_pay_amt").html(validation.num(minusRefund));
 							}else{
 								$("#minus_pay_amt_nm").html("");
 								$("#minus_pay_amt").html("");
 							}
 							 
 							if(data.claimRefund.totAmt < 0){
 								if($("#claimAcceptForm #depositDiv").css("display") == 'none'){
	 								messager.alert( "마이너스 환불금이 발생합니다. 입금 계좌정보를 입력하세요." ,"Info","info");
	 								$("#claimAcceptForm #depositDiv").show();
 								}
 								$("#claimAcceptForm #depositAmt").val(data.claimRefund.totAmt * -1);
 							}else{
 								$("#claimAcceptForm #depositDiv").hide();
 							}
						}
		 			};

 					ajax.call(options);
				}
			}
			
			// 반품 접수 실행
			function fnClaimReturnAcceptExec() {

				if ( validate.check("claimAcceptForm") ) {
					/**
					 * QA 요청으로 validation에서 alert형태로 수정
					 */

					if(!$("#twcTckt").val()) {
						messager.alert("CS 티켓 번호를 입력하세요.", "Info", "info", function(){
							return;
						});
						return;
					}

					if($("#depositDiv").css("display") != "none" && !$("#fixAcct").val()) {
						messager.alert("입금 은행을 선택해주세요.", "Info", "info", function(){
							return;
						});
						return;
					}

					var confirmMsg;
					
					var payAmt = parseInt($("#claimAcceptForm #return_pay_amt").val());
					if(payAmt < 0){
						confirmMsg = "마이너스 환불금이 발생합니다. 그래도 환불 처리 하시겠습니까?";
					}
					
					<c:if test="${orderBase.payMeansCd eq adminConstants.PAY_MEANS_30 }">
						if($("#claimAcceptForm #cetifyYn").val() == 'N'){
							messager.alert("환불계좌인증이 필요합니다.", "Info", "info", function(){
								$("#claimAcceptForm #certifyBtn").focus();
							});
							return;
						}
					</c:if>
					
					if(!confirmMsg){
						confirmMsg = '<spring:message code="column.order_common.confirm.claim_return_accept" />';
					}
					messager.confirm(confirmMsg, function(r){
						if(r){
							var options = {
								url : "<spring:url value='/claim/claimReturnExc.do' />"
								, data : $("#claimAcceptForm").serializeJson()
								, callBack : function(result){
									messager.alert( "<spring:message code="column.common.accept.final_msg" />", "Info", "info", function(){
										document.location.reload();
										layer.close('claimReturnAcceptView');
									});
		 							$(".panel-tool-close").click(function(){
		 								document.location.reload();
										layer.close('claimReturnAcceptView');
		 							})
									
								}
							};

							ajax.call(options);
						}
					});
				}

			}

			function postResult(result){
				console.log('postResult',result);
				window.resizeTo(900, 900);
				$("#claimAcceptForm #postNoOld").val(result.postcode);
				$("#claimAcceptForm #prclAddr").val(result.jibunAddress);
				$("#claimAcceptForm #prclAddrView").html(result.jibunAddress);
				$("#claimAcceptForm #postNoNew").val(result.zonecode);
				$("#claimAcceptForm #roadAddr").val(result.roadAddress);
			}

			function postPopLayer() {
				window.resizeTo(900, 900);
				layer.post(postResult);
			}
			
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

			function certifyAcctNo(){
				
				var isBankCd = $("#claimAcceptForm #bankCd").validationEngine("validate");
				var isOoaNm = $("#claimAcceptForm #ooaNm").validationEngine("validate");
				var isAcctNo = $("#claimAcceptForm #acctNo").validationEngine("validate");
				
				/**
				 * QA요청으로 validation제거하고 alert 형태로 교체함
				 */
				if(!$("#ooaNm").val()) {
					messager.alert("환불 예금주를 입력하세요.", "Info", "info", function(){
						return;
					});
					return;
				}
				if(!$("#acctNo").val()) {
					messager.alert("환불 계좌번호를 입력하세요.", "Info", "info", function(){
						return;
					});
					return;
				}
				if(!isBankCd  && !isOoaNm && !isAcctNo ){
					var options = {
	 					url : "<spring:url value='/common/reqCheckBankAccount.do' />"
	 					, data :  {
	 						bankCd : $("#claimAcceptForm #bankCd").val()
	 						,ooaNm : $("#claimAcceptForm #ooaNm").val()
	 						,acctNo : $("#claimAcceptForm #acctNo").val()
	 					}
						, callBack : function(data){
							console.log('data', data);
							if(!data.isOk){
								messager.alert(data.res.resultMsg, "Info", "info", function(){
									return;
								});
								$("#claimAcceptForm #cetifyYn").val("N");
							}else{
								messager.alert("계좌 인증을 성공하였습니다.", "Info", "info", function(){
									return;
								});
								$("#claimAcceptForm #cetifyYn").val("Y");
							}
							
						}
		 			};

					ajax.call(options);
				}
			}
		</script>
			<form id="claimAcceptForm" name="claimAcceptForm" method="post" >
			<input type="hidden" name="ordNo" id="ordNo" value="${orderBase.ordNo}">
			<input type="hidden" id="return_pay_amt"  name="refundAmt" value="0" />
			
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
					<tr>
						<th scope="row"><spring:message code="column.ord_dtl_seq" /></th>
						<td>
							<input type="hidden" name="arrOrdDtlSeq" id="arrOrdDtlSeq" value="${getOrderDetail.ordDtlSeq}">
							${getOrderDetail.ordDtlSeq}
						</td>
						<th scope="row"><spring:message code="column.goods_nm" /></th>
						<td>
							${getOrderDetail.goodsNm}
						</td>
						<th scope="row"><spring:message code="column.accept_qty" /></th>
						<td>
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
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row" id="clmRsnContentText"><spring:message code="column.claim_common.claim_rsn_detail_content" /></th>
						<td colspan="2">
							<textarea cols="30" rows="5" style="width:95%;" id="clmRsnContent" name="clmRsnContent" class="validate[maxSize[500]]"></textarea>
						</td>
						<th scope="row"><spring:message code="column.claim_common.refund_image" /></th>
						<td colspan="2">
							<button type="button" class="btn btn-add" onclick="imgUpload()">사진 첨부하기</button><br/>
							<div id="imageDiv">
						
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><spring:message code="column.claim_common.cs_tck_no" /><strong class="red">*</strong></th>
						<td colspan="5">
							<input type="text" class="validate[maxSize[100]]" name="twcTckt" id="twcTckt" title="<spring:message code="column.claim_common.cs_tck_no" />" value="" />
						</td>
					</tr>
				</tobdy>
			</table>

			<div class="mTitle mt30">
				<h2><spring:message code="column.order_common.refund_amt_info" /></h2>
			</div>
			<table class="table_type1">
				<caption><spring:message code="column.order_common.refund_info" /></caption>
				<colgroup>
					<col class="th-s" />
					<col />
					<col class="th-s" />
					<col />
					<col class="th-s" />
					<col />
				</colgroup>
				<thead>
					<tr>
						<th colspan="2" class="fontbold" style="border-right:#666 solid 1px;">결제정보</th>
						<th colspan="2" class="fontbold" style="border-right:#666 solid 1px;">차감정보</th>
						<th colspan="2" class="fontbold" style="border-right:#666 solid 1px;">환불정보</th>
					</tr>
				</thead>
				<tbody>			
					<tr>
						<td colspan="2" class="right fontbold" id="refund_total_pay" style="border-right:#666 solid 1px;"></td>
						<td colspan="2" class="right fontbold" id="refund_total_reduce" style="border-right:#666 solid 1px;"></td>
						<td colspan="2" class="right fontbold" id="refund_total_refund" style="border-right:#666 solid 1px;"></td>
					</tr>
					<tr>
						<th scope="row">상품금액</th>
						<td id="pay_goods_amt" class="right" style="border-right:#666 solid 1px;">
						</td>
						<th scope="row">배송비</th>
						<td id="reduce_dlvr_amt" class="right" style="border-right:#666 solid 1px;">
						</td>
						<th scope="row" id="meansNm"> 환불</th>
						<td id="refund_pay_amt" class="right" style="border-right:#666 solid 1px;">
						</td>
					</tr>
					<tr>
						<th scope="row">배송비</th>
						<td id="pay_dlvr_amt" class="right" style="border-right:#666 solid 1px;">
						</td>
						<th scope="row">추가배송비</th>
						<td id="reduce_add_dlvr_amt" class="right" style="border-right:#666 solid 1px;">
						</td>
						<th scope="row">GS 포인트 환불</th>
						<td id="refund_pnt_amt" class="right" style="border-right:#666 solid 1px;">
							0
						</td>
					</tr>
					<tr>
						<th scope="row">쿠폰할인금액</th>
						<td id="pay_cp_amt" class="right" style="border-right:#666 solid 1px;">
						</td>
						<th scope="row"></th>
						<td style="border-right:#666 solid 1px;"></td>
						<th scope="row">우주코인 환불</th>
						<td id="refund_mp_pnt_amt" class="right" style="border-right:#666 solid 1px;">
							0
						</td>
					</tr>
					<tr>
						<th scope="row"></th>
						<td style="border-right:#666 solid 1px;"></td>
						<th scope="row"></th>
						<td style="border-right:#666 solid 1px;"></td>
						<th id="minus_pay_amt_nm"></th>
						<td id="minus_pay_amt" class="right" style="border-right:#666 solid 1px;"> </td>
					</tr>
					
				</tbody>
			</table>
			
<c:if test="${orderBase.payMeansCd eq adminConstants.PAY_MEANS_30 }">
			<input type="hidden" id="cetifyYn" value="N"/>
			<div class="mTitle mt30">
				<h2><spring:message code="column.order_common.refund_info" /></h2>
			</div>
			<table class="table_type1">
				<caption><spring:message code="column.order_common.refund_info" /></caption>
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
						<th scope="row"><spring:message code="column.order_common.refund_bank" /><strong class="red">*</strong></th>
						<td>
							<select name="bankCd" id="bankCd" class="validate[required]" title="선택상자"  >
								<frame:select grpCd="${adminConstants.BANK }"  selectKey="${memberBase.bankCd}" />
							</select>
						</td>
						<th scope="row"><spring:message code="column.order_common.refund_name" /><strong class="red">*</strong></th>
						<td>
							<input type="text" class="validate[maxSize[50]] wth50" id="ooaNm" name="ooaNm" value="${orderBase.ordNm}">
						</td>
						<th scope="row"><spring:message code="column.order_common.refund_account" /><strong class="red">*</strong></th>
						<td>
							<input type="text" class="validate[maxSize[50]] w100" id="acctNo" name="acctNo" value="${memberBase.acctNo}">
							<button type="button" id="certifyBtn" onclick="certifyAcctNo();" class="btn btn-ok"><spring:message code="column.order_common.certify_acctNo" /></button>
						</td>
					</tr>
				</tbody>
			</table>
</c:if>
			<!-- 입금 계좌 정보 -->
			<div id="depositDiv" style="display: none;">
				<input type="hidden" id="depositBankCd" name="depositBankCd" value=""/>
				<input type="hidden" id="depositOoaNm" name="depositOoaNm" value="${orderBase.ordNm }"/>
				<input type="hidden" id="depositAcctNo" name="depositAcctNo" value=""/>
				<input type="hidden" id="depositAmt" 	name="depositAmt" value=""/>
				<input type="hidden" id="depositMobile" name="depositMobile" value="${orderBase.ordrMobile }"/>
				
				<div class="mTitle mt30">
					<h2><spring:message code="column.claim_common.deposit_acct_info" /></h2>
				</div>
				<table class="table_type1">
					<caption><spring:message code="column.claim_common.deposit_acct_info" /></caption>
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
							<th scope="row"><spring:message code="column.claim_common.deposit_bank" /><strong class="red">*</strong></th>
							<td>
								<select name="fixAcct" id="fixAcct" class="" title="선택상자"  >
									<frame:select grpCd="${adminConstants.FIX_ACCT }" defaultName="선택"/>
								</select>
							</td>
							<th scope="row"><spring:message code="column.claim_common.deposit_acct_no" /></th>
							<td id="depositAcctNoText">
							</td>
							<th scope="row"><spring:message code="column.claim_common.deposit_nm" /></th>
							<td id="depositOoaNmText">
								${orderBase.ordNm }
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="mTitle mt30">
				<h2>
					<spring:message code="column.claim_common.refund_delivery_info" />&nbsp;&nbsp;&nbsp;
				</h2>
				<div class="buttonArea">
					<button type="button" id="changeDelivery" class="btn btn-add old">수거지 수정</button>
				</div>
			</div>

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
								<input type="text" class="phoneNumber validate[custom[tel]] dlvra_new" name="tel" id="tel" title="<spring:message code="column.tel"/>" value="" style="display:none;"/>
							</td>
							<th><spring:message code="column.mobile"/><strong class="red">*</strong></th>
							<td>
								<!-- 휴대폰-->
								<p class="dlvra_old"><frame:mobile data="${orderDlvra.mobile}" /></p>
								<input type="text" class="phoneNumber validate[required, custom[mobile]] dlvra_new" name="mobile" id="mobile" title="<spring:message code="column.mobile"/>" value="" style="display:none;"/>
							</td>
						</tr>
						<tr>
							<th><spring:message code="column.common.post"/><strong class="red">*</strong></th>
							<td colspan="3">
								<p class="dlvra_old">${orderDlvra.postNoNew}</p>
								<input type="text" class="readonly validate[required] w50 dlvra_new" name="postNoNew" id="postNoNew" title="<spring:message code="column.post_no_new"/>" value="" readonly="readonly" style="display:none;"/>
								<button type="button" onclick="postPopLayer();" class="btn dlvra_new" style="display:none;"><spring:message code="column.common.post.btn"/></button>
								<input type="hidden" class="readonly validate[required] dlvra_new" name="postNoOld" id="postNoOld" title="<spring:message code="column.post_no_old"/>" value="" />

								<div class="mg5">
									<strong style="display:inline-block;width:80px;">[도로명 주소]</strong>
									<span class="dlvra_old">${orderDlvra.roadAddr} &nbsp;&nbsp; ${orderDlvra.roadDtlAddr }</span>
									<input type="text" class="readonly w300 validate[required] dlvra_new" name="roadAddr" id="roadAddr" title="<spring:message code="column.road_addr"/>" value="" readonly="readonly" style="display:none;"/>
									<input type="text" class="w200 validate[required] dlvra_new" name="roadDtlAddr" id="roadDtlAddr" title="<spring:message code="column.road_dtl_addr"/>" value="" style="display:none;"/>
								</div>

								<div class="mg5">
									<strong style="display:inline-block;width:80px;">[지번 주소]</strong>
									<span class="dlvra_old">${orderDlvra.prclAddr} &nbsp;&nbsp; ${orderDlvra.prclDtlAddr }</span>
									<span id="prclAddrView" class="dlvra_new"></span>
									<input type="hidden" class="readonly w300 validate[required] dlvra_new" name="prclAddr" id="prclAddr" title="<spring:message code="column.prcl_addr"/>" value="" style="display:none;"/>
								</div>

							</td>
						</tr>
						<tr>
							<th><spring:message code="column.order_common.dlvr_demand" /></th>
							<td colspan="3">
								<p class="dlvra_old">${orderDlvra.dlvrDemand }</p>
								<input type="text" class="validate[maxSize[500]] dlvra_new" name="dlvrMemo" id="dlvrMemo" title="<spring:message code="column.dlvrMemo"/>" value="" style="width:97%;"/>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			</form>

	
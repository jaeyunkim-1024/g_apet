<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<script type="text/javascript">

	$(document).ready(function(){
	}); // End Ready

	$(function() {

		// 현금영수증 화면 컨트롤
		$("input:radio[name=useGbCd]").click(function(){
			var cashGbVal = $(this).val();		
			
			//init
			$("#ispan").find("input").remove();
		
 			if(cashGbVal == "<c:out value='${FrontWebConstants.APCT_GB_10}' />"){	//개인
 				
 				$("#ispan").append(	"<input type=\"number\" name=\"isuMeansNoPhn\" id=\"isuMeansNoPhn\" placeholder=\"휴대폰번호를 입력해주세요\" title=\"휴대폰번호\">"); 				
 				
			}else if(cashGbVal == "<c:out value='${FrontWebConstants.APCT_GB_20}' />"){ //사업자
				
 				$("#ispan").append(	"<input type=\"number\" name=\"isuMeansNoBiz\" id=\"isuMeansNoBiz\" placeholder=\"사업자번호를 입력해주세요\" title=\"사업자번호\" maxlength=\"10\">");
			}
		});

	});

	/*
	 * 현금영수증 등록 Validation
	 */
	var cashReceiptValidate = {
		all : function(){
			if($("input[name=useGbCd]").is(":checked") == false){
				alert("증빙구분을 선택해 주세요.");
				$("input:radio[name=useGbCd]").focus();
				return false;
			}
			
			//개인 소득공제용
			if($("input:radio[name=useGbCd]:checked").val() == "<c:out value='${FrontWebConstants.APCT_GB_10}' />"){				

				if($("#isuMeansNoPhn").val() == ""){
					
					//ui.alert(selmeanCd + "을(를) 입력해 주세요.",{
					ui.alert("현금영수증 신청 정보를 입력해 주세요.",{
						ycb:function(){
							$("#isuMeansNoPhn").focus();		 					
						},
						ybt:'확인'	
					});					
					return false;
				}

				if(!valid.mobile.test($("#isuMeansNoPhn").val())){
					
					ui.alert("휴대폰번호 형식이 아닙니다.",{
						ycb:function(){
							$("#isuMeansNoPhn").focus();		 					
						},
						ybt:'확인'	
					}); 					
					return false;
				}
			// 사업자증빙용
			} else if($("input:radio[name=useGbCd]:checked").val() == "<c:out value='${FrontWebConstants.APCT_GB_20}' />"){

				if($("#isuMeansNoBiz").val() == ""){				
					
					ui.alert("사업자번호를 입력해 주세요.",{
						ycb:function(){
							$("#isuMeansNoBiz").focus();		 					
						},
						ybt:'확인'	
					}); 					
					return false;				
					
				}

				if(!valid.bizNo.test($("#isuMeansNoBiz").val())){
					
					ui.alert("사업자번호 형식이 아닙니다.",{
						ycb:function(){
							$("#isuMeansNoBiz").focus();		 					
						},
						ybt:'확인'	
					}); 					
					return false;				
					
				}
			} else {		
				
				ui.alert("증빙구분에 오류가 있습니다. 해당화면을 닫은 후 다시 열어주세요.",{					
					ybt:'확인'	
				}); 					
				return false;	
				
			}

			return true;
		}
	};

	/*
	 * 현금영수증 등록
	 */
	function insertCashReceipt(){
		if(cashReceiptValidate.all()){

			if($("input:radio[name=useGbCd]:checked").val() == "<c:out value='${FrontWebConstants.APCT_GB_10}' />"){
				$("input[name=ReceiptType]").val("1");
				$("input[name=ReceiptTypeNo]").val($("#isuMeansNoPhn").val());
				$("input[name=isuMeansNo]").val($("#isuMeansNoPhn").val());
				$("input[name=isuMeansCd]").val("<c:out value='${FrontWebConstants.ISU_MEANS_20}' />");
				//$("input[name=isuMeansCd]").val($("select[name=meanCd] option:selected").val());
				
			} else {
				$("input[name=ReceiptType]").val("2");
				$("input[name=ReceiptTypeNo]").val($("#isuMeansNoBiz").val());
				$("input[name=isuMeansNo]").val($("#isuMeansNoBiz").val());
				$("input[name=isuMeansCd]").val("<c:out value='${FrontWebConstants.ISU_MEANS_30}' />");
				//$("input[name=isuMeansCd]").val($("select[name=meanCd] option:selected").val());
			}

			var options = {
					url : "<spring:url value='/pay/nicepay/reqCashReceipt' />",					
					data : $("#cash_receipt_form").serialize(),
					done : function(data){		
						
						ui.alert("현금영수증 신청이 완료되었습니다. ",{					
							ybt:'확인'	
						});

						//var next_location="/mypage/order/indexReceiptList";
						var next_location="/mypage/order/indexDeliveryList";

						location.href = next_location;
					}
			};
			ajax.call(options);
		}
	}

</script>

<form id="cash_receipt_form">
	<input type="hidden" id="ordNo" name="ordNo" value="${param.ordNo}" />
	
	<input type="hidden" id="Moid" name="Moid" value="${param.ordNo}" />
	<input type="hidden" id="ReceiptAmt" name="ReceiptAmt" value="${param.payAmt}" />
	<input type="hidden" id="GoodsName" name="GoodsName" value="${param.goodsNm}" />
	<input type="hidden" id="ReceiptType" name="ReceiptType" value="" />
	<input type="hidden" id="ReceiptTypeNo" name="ReceiptTypeNo" value="" />
	
	<input type="hidden" id="isuMeansNo" name="isuMeansNo" value="" />
	<input type="hidden" id="isuMeansCd" name="isuMeansCd" value="" />
	<input type="hidden" name="cashRctNo" id="cashRctNo" value="${param.cashRctNo }"/>
	<article class="popLayer a popReceipt" id="popReceipt">
		<div class="pbd">
			<div class="phd">
				<div class="in">
					<h1 class="tit">현금영수증 신청</h1>
					<button type="button" class="btnPopClose">닫기</button>
				</div>
			</div>
			<script>
			$(function() {
				<c:if test="${not empty cashRctSaveInfo.cashRctGbType}">
					$("#cash_receipt_form input[name='useGbCd']:input[value='${cashRctSaveInfo.cashRctGbType}']").trigger("click");
					
					/* $("#cash_receipt_form select[name='meanCd']").val("${cashRctSaveInfo.cashRctGbCd}"); */
					$("#cash_receipt_form input[name='isuMeansNoPhn']").val("${cashRctSaveInfo.cashRctGbVal}");
					$("#cash_receipt_form input[name='isuMeansNoBiz']").val("${cashRctSaveInfo.cashRctGbVal}");
					
				</c:if>
			});
			</script>
			<div class="pct">
				<main class="poptents">
					<div class="uireceipt">
						<div class="frms">
							<div class="rdos mt04">
								<label class="radio"><input type="radio" name="useGbCd" checked value="<c:out value='${FrontWebConstants.APCT_GB_10}' />" /><span class="txt"><em class="tt">개인소득공제용</em></span></label>
								<label class="radio ml25"><input type="radio" name="useGbCd" value="<c:out value='${FrontWebConstants.APCT_GB_20}' />"><span class="txt"><em class="tt">사업자증빙용</em></span></label>								
							</div>
							<div class="rbox">
								<div class="input" id="ispan"><input type="number" name="isuMeansNoPhn" id="isuMeansNoPhn" value="" placeholder="휴대폰번호를 입력해주세요" title="휴대폰번호"></div>
							</div>
							<div class="saves">
								<label class="checkbox">
									<input type="checkbox" name="cashRctSaveYn" ${cashRctSaveInfo.cashRctSaveYn eq 'Y' ? 'checked':''} value="Y">
									<span class="txt"><em class="tt">현금 영수증 신청정보 저장</em></span>
								</label>
							</div>
						</div>
						<div class="btnSet bot">
							<button type="button" class="btn lg a" data-content="" data-url="/mypage/order/insertCashReceipt" onclick="insertCashReceipt();return false;">저장</button>
						</div>
					</div>
				</main>
			</div>
			
		</div>
	</article>
</form>

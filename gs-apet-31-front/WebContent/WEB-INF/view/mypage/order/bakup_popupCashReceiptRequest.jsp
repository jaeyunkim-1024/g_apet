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

			$('.tax_doc1').hide();

 			if(cashGbVal == "<c:out value='${FrontWebConstants.APCT_GB_10}' />"){
 				$('.tax_doc1_1').show();
			}else if(cashGbVal == "<c:out value='${FrontWebConstants.APCT_GB_20}' />"){
				$('.tax_doc1_2').show();
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

				if($("input[name=isuMeansNoPhn]").val() == ""){
					alert("휴대폰번호를 입력해 주세요.");
					$("input[name=isuMeansNoPhn]").focus();
 					return false;
				}

				if(!valid.mobile.test($("input[name=isuMeansNoPhn]").val())){
					alert("휴대폰번호 형식이 아닙니다.");
					$("input[name=isuMeansNoPhn]").focus();
 					return false;
				}
			// 사업자증빙용
			} else if($("input:radio[name=useGbCd]:checked").val() == "<c:out value='${FrontWebConstants.APCT_GB_20}' />"){

				if($("input[name=isuMeansNoBiz]").val() == ""){
					alert("사업자번호를 입력해 주세요.");
					$("input[name=isuMeansNoBiz]").focus();
 					return false;
				}

				if(!valid.bizNo.test($("input[name=isuMeansNoBiz]").val())){
					alert("사업자번호 형식이 아닙니다.");
					$("input[name=isuMeansNoBiz]").focus();
 					return false;
				}
			} else {
				alert("증빙구분에 오류가 있습니다. 해당화면을 닫은 후 다시 열어주세요.");
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
				$("input[name=isuMeansNo]").val($("input[name=isuMeansNoPhn]").val());
				$("input[name=isuMeansCd]").val("<c:out value='${FrontWebConstants.ISU_MEANS_20}' />");
			} else {
				$("input[name=isuMeansNo]").val($("input[name=isuMeansNoBiz]").val());
				$("input[name=isuMeansCd]").val("<c:out value='${FrontWebConstants.ISU_MEANS_30}' />");
			}

			var options = {
					url : "<spring:url value='/mypage/order/insertCashReceipt' />",
					//url : "<spring:url value='/tax/cashReceiptRePublishExec.do' />",
					data : $("#cash_receipt_form").serialize(),
					done : function(data){

						alert("<spring:message code='front.web.view.common.msg.result.insert' />");

						var next_location="/mypage/order/indexReceiptList";

						location.href = next_location;
					}
			};
			ajax.call(options);
		}
	}

</script>

<form id="cash_receipt_form">
	<input type="hidden" id="ordNo" name="ordNo" value="${param.ordNo}" />
	<input type="hidden" id="isuMeansNo" name="isuMeansNo" value="" />
	<input type="hidden" id="isuMeansCd" name="isuMeansCd" value="" />
	<input type="hidden" name="cashRctNo" id="cashRctNo" value="${param.cashRctNo }"/>
	<div id="pop_contents">
		<div class="cash_receipts_radio">
			<label><input type="radio" name="useGbCd" checked="checked" value="<c:out value='${FrontWebConstants.APCT_GB_10}' />"/> 개인소득공제용</label>
			<label class="mgl38"><input type="radio" name="useGbCd" value="<c:out value='${FrontWebConstants.APCT_GB_20}' />"/> 사업자증빙용</label>
		</div>
		<!-- 개인소득 공제용 -->
		<div class="tax_doc1 tax_doc1_1">
			<div class="cash_receipts_box">
				<div class="mgt10">
					<span class="label_title">휴대폰번호</span>
					<input type="text" class="input_style1" name="isuMeansNoPhn" title="휴대폰번호" style="width:186px;" />
				</div>
			</div>
			<div class="t_center mgt10 point4">
				(- 없이 입력해 주세요.)
			</div>
		</div>
		<!-- //개인소득 공제용 -->
		<!-- 사업자증빙용 -->
		<div class="tax_doc1 tax_doc1_2" style="display:none;">
			<div class="cash_receipts_box">
				<div class="mgt10">
					<span class="label_title">사업자 등록번호</span>
					<input type="text" class="input_style1" name="isuMeansNoBiz" title="사업자 등록번호" style="width:186px;" maxlength="10" />
				</div>
			</div>
			<div class="t_center mgt10 point4">
				(- 없이 입력해 주세요.)
			</div>
		</div>
		<!-- //사업증빙용 -->
	</div>
</form>

<!-- 버튼 공간 -->
<div class="pop_btn_section">
	<a href="#" class="btn_pop_type1" onclick="insertCashReceipt();return false;" >등록</a>
	<a href="#" class="btn_pop_type2 mgl6" onclick="pop.close('<c:out value="${param.popId}" />');return false;">취소</a>
</div>
<!-- //버튼 공간 -->
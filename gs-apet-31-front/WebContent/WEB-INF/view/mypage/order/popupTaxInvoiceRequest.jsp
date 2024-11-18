<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<script type="text/javascript">

	$(document).ready(function(){
		
	}); // End Ready

	/*
	 * 우편번호 팝업
	 */
	function openPostPop(){
		pop.post({callBackFnc : 'cbPostPop'});
	}
	
	/*
	 * 우편번호 CallBack
	 */
	function cbPostPop(data){
		$("#popup_address_edit_post_no_new").val(data.postNoNew);
		$("#popup_address_edit_post_no_old").val(data.postNoOld);
		$("#popup_address_edit_prcl_addr").val(data.prclAddr);
		$("#popup_address_edit_road_addr").val(data.roadAddr);
	}
	
	/*
	 * 세금계산서 신청 Validation
	 */
	var taxInvoiceValidate = {
		all : function(){
			if($("input[name=bizNo]").val() == ""){
				alert("사업자 등록번호를 입력해 주세요.");
				$("input[name=bizNo]").focus();
					return false;
			}
			if(!valid.bizNo.test($("input[name=bizNo]").val())){
				alert("사업자 등록번호 형식이 아닙니다.");
				$("input[name=bizNo]").focus();
					return false;
			}
			
			if($("input[name=compNm]").val() == ""){
				alert("회사명을 입력해 주세요.");
				$("input[name=compNm]").focus();
					return false;
			}
			if($("input[name=ceoNm]").val() == ""){
				alert("대표자명을 입력해 주세요.");
				$("input[name=ceoNm]").focus();
					return false;
			}
			
			if($("input[name=postNoNew]").val() == ""){
				alert("우편번호찾기를 통하여 주소를 입력해주세요.");
				return false;
			}
			if($("input[name=postNoOld]").val() == ""){
				alert("우편번호찾기를 통하여 주소를 입력해주세요.");
				return false;
			}

			if($("input[name=roadDtlAddr]").val() == ""){
				alert("도로명 상세 주소를 입력해주세요.");
				$("input[name=roadDtlAddr]").focus();
				return false;
			}
			
			if($("input[name=prclAddr]").val() != "" && $("input[name=prclDtlAddr]").val() == ""){
				alert("지번 상세 주소를 입력해주세요.");
				$("input[name=prclDtlAddr]").focus();
				return false;
			}
			
			if($("input[name=bizCdts]").val() == ""){
				alert("업태를 입력해 주세요.");
				$("input[name=bizCdts]").focus();
					return false;
			}
			if($("input[name=bizTp]").val() == ""){
				alert("종목을 입력해 주세요.");
				$("input[name=bizTp]").focus();
					return false;
			}
			
			return true;
		}
	};
	
	/*
	 * 세금계산서 신청
	 */
	function insertTaxInvoice(){
	
		if(taxInvoiceValidate.all()){
			
			var options = {
					url : "<spring:url value='/mypage/order/insertTaxInvoice' />",
					data : $("#tax_invoice_form").serialize(),
					done : function(data){
						
						alert("<spring:message code='front.web.view.common.msg.result.insert' />");
						
						location.href="/mypage/order/indexReceiptList";
					}
			};
			ajax.call(options);
		}
	}
	
</script>

<form id="tax_invoice_form">
	<input type="hidden" name="ordNo" value="${param.ordNo}">

	<div id="pop_contents">
		<table class="table_type1">
			<caption>세금계산서 정보 작성</caption>
			<colgroup>
				<col style="width:26%;" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th>사업자 등록번호</th>
					<td>
						<input type="text" name="bizNo" title="사업자등록번호" style="width:85px" maxlength="10" />
						<!-- <input type="text" class="mgl6" title="사업자등록번호2" style="width:85px" />
						<input type="text" class="mgl6" title="사업자등록번호3" style="width:85px" /> -->
					</td>
				</tr>
				<tr>
					<th>회사명</th>
					<td>
						<input type="text" name="compNm" title="회사명" style="width:250px" />
					</td>
				</tr>
				<tr>
					<th>대표자명</th>
					<td>
						<input type="text" name="ceoNm" title="대표자명" style="width:250px" />
					</td>
				</tr>
				<!-- <tr>
					<th>사업장 소재지 : TODO</th>
					<td>
						<input type="text" title="사업장 소재지" style="width:250px" />
					</td>
				</tr> -->
				<tr>
					<th>사업장 소재지</th>
					<td>
						<div>
							<input type="text" id="popup_address_edit_post_no_new" name="postNoNew" title="신우편번호" style="width:55px;" readonly="readonly" />
							<input type="text" id="popup_address_edit_post_no_old" name="postNoOld" title="구우편번호" style="width:55px;" readonly="readonly" />
							<a href="#" id="popup_address_edit_btn_post" class="btn_h30_type4 mgl6" onclick="openPostPop();return false;">우편번호찾기</a>
						</div>
						<div class="mgt10">
							<span>도로명주소</span>
							<input type="text" id="popup_address_edit_road_addr" name="roadAddr" title="기본주소" style="width:280px;" class="disabled" readonly="readonly" />
						</div>
						<div class="mgt10">
							<input type="text" id="popup_address_edit_road_dtl_addr" name="roadDtlAddr" title="상세주소" style="width:340px;" />	
						</div>
						<div class="mgt10">
							<span>지번주소</span>
							<input type="text" id="popup_address_edit_prcl_addr" name="prclAddr" title="기본주소" style="width:292px;" class="disabled" readonly="readonly" />
						</div>
						<div class="mgt10">
							<input type="text" id="popup_address_edit_prcl_dtl_addr" name="prclDtlAddr" title="상세주소" style="width:340px;" />	
						</div>
					</td>
				</tr>
				<tr>
					<th>업태</th>
					<td>
						<input type="text" name="bizCdts" title="업태" style="width:370px" />
					</td>
				</tr>
				<tr>
					<th>종목</th>
					<td>
						<input type="text" name="bizTp" title="종목" style="width:370px" />
					</td>
				</tr>
				<!-- <tr>
					<th>연락처 : TODO</th>
					<td>
						<input type="text" title="연락처" style="width:370px" />
					</td>
				</tr>
				<tr>
					<th>신청자 이메일 : TODO</th>
					<td>
						<input type="text" class="input_style1" title="이메일 아이디" style="width:180px;" />
						@
						<select class="select_type1" title="이메일 도메인" >
							<option>직접입력</option>
						</select>
					</td>
				</tr> -->
				<tr>
					<th>전하실 말씀</th>
					<td>
						<input type="text" name="memo" title="전하실 말씀" style="width:370px" />
					</td>
				</tr>
			</tbody>
		</table>
		<div class="mgt20 mgl10">
			<ul class="ul_list_type1 point3">
				<li>배송된 달의 다음달 10일 오전 12시까지 신청 가능합니다.</li>
				<li>부가가치세법 시행령 제54조 1항에 의거하여 세금계산서 발행기한을 익월 10일을 넘기지 않도록 합니다.</li>
				<li>FAQ 현금영수증, 세금계산서 발급안내를 참조하여 주세요.</li>
			</ul>
		</div>
	</div>
</form>

<!-- 버튼 공간 -->
<div class="pop_btn_section">
	<a href="#" class="btn_pop_type1" onclick="insertTaxInvoice();return false;">신청</a>
	<a href="#" class="btn_pop_type2 mgl6" onclick="pop.close('<c:out value="${param.popId}" />');return false;">취소</a>
</div>
<!-- //버튼 공간 -->

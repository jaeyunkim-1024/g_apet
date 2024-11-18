<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 

<%--
  Class Name  : popupAddressEdit.jsp 
  Description : 회원 주소록 등록 및 수정
  Author      : 신남원
  Since       : 2016.03.02
  Modification Information 
	          수정일         	     수정자             수정내용
    ----------  -------  -------------------------------------------
    2016.03.02    신남원            최초 작성
--%>

<script type="text/javascript">

	$(document).ready(function(){
	}); // End Ready

	$(function() {
		
		
	});

	
	var addressValidate = {
		all : function(){
			 
			$(".note_b").html("");
			 console.log("2");
			if($("#address_edit_gb_nm").val() == ""){
				$("#address_edit_gb_nm_error").html("배송지명을 입력해주세요.");
				$("#address_edit_gb_nm").focus();
				return false;
			}
			 
			if($("#address_edit_adrs_nm").val() == ""){
				$("#address_edit_adrs_nm_error").html("받으실분을 입력해주세요.");
				$("#address_edit_adrs_nm").focus();
				return false;
			}
		 
			if($("#address_edit_mobile").val() == ""){
				$("#address_edit_mobile_error").html("휴대혼번호를 입력해주세요.");
				$("#address_edit_mobile").focus();
				return false;
			}
			 
			if(!valid.mobile.test($("#address_edit_mobile").val())){
				$("#address_edit_mobile_error").html("잘못된 형식의 휴대폰번호 입니다.");
				$("#address_edit_mobile").focus();
				return false;
			}
			 
			if($("#address_edit_tel").val() != ""){
				if(!valid.tel.test($("#address_edit_tel").val())){
					$("#address_edit_tel_error").html("잘못된 형식의 전화번호 입니다.");
					$("#address_edit_tel").focus();
					return false;
				}
			}
			 
			if($("#address_edit_post_no_new").val() == ""){
				$("#address_edit_addr_error").html("우편번호찾기를 통하여 주소를 입력해주세요.");
				$("#address_edit_btn_post").focus();
				return false;
			}
			 
			if($("#address_edit_road_dtl_addr").val() == ""){
				$("#address_edit_addr_error").html("도로명 상세 주소를 입력해주세요.");
				$("#address_edit_road_dtl_addr").focus();
				return false;
			}
			 
			/* if($("#address_edit_prcl_addr").val() != "" && $("#address_edit_prcl_dtl_addr").val() == ""){
				$("#address_edit_addr_error").html("지번 상세 주소를 입력해주세요.");
				$("#address_edit_prcl_dtl_addr").focus();
				return false;
			}
 */
			
			
			return true;
		}
	};
	
 
	/*
	 * 베송지 등록
	 */
	function insertAddress(){
	
	   
		if(addressValidate.all()){
			//if(confirm("<spring:message code='front.web.view.common.msg.confirm.update' />")){
			if(confirm("수정하시겠습니까?")){	
				var options = {
						url : "<spring:url value='/mypage/order/updateDeliveryAddress' />",
						data : $("#address_edit_form").serialize(),
						done : function(data){
							console.log(" data 등록");
							console.log(data);
							//alert("<spring:message code='front.web.view.mypage.service.address.update.success' />");
							alert("수정되었습니다.");
							//location.href=$("#returnPath").val();
							<c:out value="${param.callBackFnc}" />();
							pop.close('<c:out value="${param.popId}" />'); 
						}
				};
				ajax.call(options);
			}
		}
	}

	function goPage(){
 	 //location.href=$("#returnPath").val();
 	pop.close('<c:out value="${param.popId}" />'); 
	}
	/*
	 * 배송지 수정
	 */
	 
	
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
		$("#address_edit_post_no_new").val(data.postNoNew);
		$("#address_edit_post_no_old").val(data.postNoOld);
		$("#address_edit_prcl_addr").val(data.prclAddr);
		$("#address_edit_road_addr").val(data.roadAddr);
		
		$("#address_edit_road_dtl_addr").focus();
	}

	
</script>
<div id="pop_contents">
<form id="address_edit_form">
<input type="hidden" id="ordNo" name="ordNo" value="<c:out value="${param.ordNo}" />" />
<%-- <input type="hidden" id="returnPath" name="returnPath" value="<c:out value="${param.returnPath}" />" /> --%>
 
 


	 
	<table class="table_type1">
		<colgroup>
			<col style="width:200px" />
			<col style="width:auto" />
		</colgroup>
		<tbody>
			 
			<tr>
				<th>받으실 분 *</th>
				<td>
					<input type="text" id="address_edit_adrs_nm" name="adrsNm" title="받으시는분" style="width:150px;" value="<c:out value="${deliveryInfo.adrsNm}" />" /> <span class="mgl6">(10자 내외 입력)</span>
					<div id="address_edit_adrs_nm_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th>휴대폰 번호 *</th>
				<td>
					<input type="text" id="address_edit_mobile" name="mobile" class="input_style1" title="휴대폰번호" style="width:186px;" value="<frame:mobile data="${deliveryInfo.mobile}" />" />
					<div id="address_edit_mobile_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<input type="text" id="address_edit_tel" name="tel" class="input_style1" title="전화번호" style="width:186px;" value="<frame:tel data="${deliveryInfo.tel}" />" />
					<div id="address_edit_tel_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th>받으실 분 주소 *</th>
				<td>
					<div>
						<input type="text" id="address_edit_post_no_new" name="postNoNew" title="신우편번호" style="width:40px;" readonly="readonly" value="<c:out value="${deliveryInfo.postNoNew}" />" />
						<input type="hidden" id="address_edit_post_no_old" name="postNoOld" title="구우편번호" style="width:55px;" readonly="readonly" value="<frame:post data="${deliveryInfo.postNoOld}" />" />
						<a href="#" id="address_edit_btn_post" class="btn_h30_type4 mgl6" onclick="openPostPop();return false;">우편번호찾기</a>
					</div>
					<div class="mgt10">
						<span>도로명주소</span>
						<input type="text" id="address_edit_road_addr" name="roadAddr" title="기본주소" style="width:280px;" class="disabled" readonly="readonly" value="<c:out value="${deliveryInfo.roadAddr}" />" />
					</div>
					<div class="mgt10">
						<input type="text" id="address_edit_road_dtl_addr" name="roadDtlAddr" title="상세주소" style="width:340px;" value="<c:out value="${deliveryInfo.roadDtlAddr}" />" />	
					</div>
 						<input type="hidden" id="address_edit_prcl_addr" name="prclAddr" title="기본주소" style="width:292px;" class="disabled" readonly="readonly" value="<c:out value="${deliveryInfo.prclAddr}" />" />
						<input type="hidden" id="address_edit_prcl_dtl_addr" name="prclDtlAddr" title="상세주소" style="width:340px;" value="<c:out value="${deliveryInfo.prclDtlAddr}" />" />
 					<div id="address_edit_addr_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th>배송메모</th>
				<td>
					<input type="text" id="address_edit_dlvrMemo" name="dlvrMemo" class="배송메모" title="전화번호" style="width:186px;" value="<frame:tel data="${deliveryInfo.dlvrMemo}" />" />
					<div id="address_edit_tel_error" class="note_b point1"></div>
				</td>
			</tr>
		</tbody>
	</table>
	</form>
</div>
<!-- //팝업 내용 -->

<!-- 버튼 공간 -->
<div class="pop_btn_section">
	<a href="#" onclick="goPage();return false;"class="btn_pop_type2 mgl6">취소</a>
	<a href="#" onclick="insertAddress();return false;" class="btn_pop_type1">확인</a>
	
</div>
<!-- //버튼 공간 -->

 
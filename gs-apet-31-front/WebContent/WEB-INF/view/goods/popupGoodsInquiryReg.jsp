<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 

<script type="text/javascript">

	$(document).ready(function(){
		var check = false;
		var emailAddroptions = $("#popup_goods_inquiry_reg_email_addr_select option");
		for(var i=0; i < emailAddroptions.length; i++){
			if($(emailAddroptions[i]).val() == "<c:out value="${member.emailAddr}" />"){
				check = true;				
			}
		}
		
		if(check){
			$("#popup_goods_inquiry_reg_email_addr_select").val("<c:out value="${member.emailAddr}" />");
			$("#popup_goods_inquiry_reg_email_addr").hide();
		}else{
			$("#popup_goods_inquiry_reg_email_addr").show();
			$("#popup_goods_inquiry_reg_email_addr_select").val("");
		}
		
		valid.checkByte('popup_goods_inquiry_reg_iqr_ttl_byte', this, 100); 
		valid.checkByte('popup_goods_inquiry_reg_iqr_content_byte', this, 1000);
	}); // End Ready

	$(function() {
		$("#popup_goods_inquiry_reg_email_addr_select").change(function(){
			if($(this).val() == ""){
				$("#popup_goods_inquiry_reg_email_addr").show();
				$("#popup_goods_inquiry_reg_email_addr").val("");
				$("#popup_goods_inquiry_reg_email_addr").focus();
			}else{
				$("#popup_goods_inquiry_reg_email_addr").hide();
				$("#popup_goods_inquiry_reg_email_addr").val($(this).val());
			}
		});

		$("#popup_goods_inquiry_reg_iqr_ttl").keyup(function(){
			valid.checkByte('popup_goods_inquiry_reg_iqr_ttl_byte', this, 100); 
		});		

		$("#popup_goods_inquiry_reg_iqr_content").keyup(function(){
			valid.checkByte('popup_goods_inquiry_reg_iqr_content_byte', this, 1000); 
		});		

	});

	/*
	 * 상품문의 등록 Validation
	 */
	var inquiryValidate = {
		all : function(){
			
			$(".note_b").html("");

			if($("#popup_goods_inquiry_reg_email_id").val() == ""){
				$("#popup_goods_inquiry_reg_email_error").html("이메일 아이디를 입력해주세요.");
				$("#popup_goods_inquiry_reg_email_id").focus();
				return false;
			}
			
			if($("#popup_goods_inquiry_reg_email_addr").val() == ""){
				$("#popup_goods_inquiry_reg_email_error").html("이메일 도메인을 입력해주세요.");
				$("#popup_goods_inquiry_reg_email_addr_select").focus();
				return false;
			}

			if($("#popup_goods_inquiry_reg_eqrr_mobile").val() == ""){
				$("#popup_goods_inquiry_reg_eqrr_mobile_error").html("연락처를 입력해주세요.");
				$("#popup_goods_inquiry_reg_eqrr_mobile").focus();
				return false;
			}

			if(!valid.mobile.test($("#popup_goods_inquiry_reg_eqrr_mobile").val()) && !valid.tel.test($("#popup_goods_inquiry_reg_eqrr_mobile").val())){
				$("#popup_goods_inquiry_reg_eqrr_mobile_error").html("잘못된 형식의 연락처 입니다.");
				$("#popup_goods_inquiry_reg_eqrr_mobile").focus();
				return false;
			}

			if($("#popup_goods_inquiry_reg_iqr_ttl").val() == ""){
				$("#popup_goods_inquiry_reg_iqr_ttl_error").html("제목을 입력해주세요.");
				$("#popup_goods_inquiry_reg_iqr_ttl").focus();
				return false;
			}

			if($("#popup_goods_inquiry_reg_iqr_content").val() == ""){
				$("#popup_goods_inquiry_reg_iqr_content_error").html("내용을 입력해주세요.");
				$("#popup_goods_inquiry_reg_iqr_content").focus();
				return false;
			}
			
			if($("#chkHiddenYn").is(":checked")) {
				$("#hiddenYn").val("Y");
			}else{
				$("#hiddenYn").val("N");
			}
			
			return true;
			
		}
	};
	
	/*
	 * 상품문의 등록
	 */
	function insertGoodsInquiry(){
		if(inquiryValidate.all()){
			if(confirm("<spring:message code='front.web.view.common.msg.confirm.insert' />")){
				var options = {
					url : "<spring:url value='/goods/insertGoodsInquiry' />",
					data : $("#popup_goods_inquiry_reg_form").serialize(),
					done : function(data){
						alert("<spring:message code='front.web.view.common.msg.result.insert' />");
						
						<c:out value="${param.callBackFnc}" />();
							
						pop.close("<c:out value="${param.popId}" />");
					}
				};
				ajax.call(options);
			}
		}
	}

</script>

<div id="pop_contents">
					
	<div class="pop_ask_cont">
		<form id="popup_goods_inquiry_reg_form">
		<input type="hidden" id="popup_goods_inquiry_reg_goods_id" name="goodsId" value="<c:out value='${param.goodsId}' />" />
		<input type="hidden" id="hiddenYn" name="hiddenYn" value="N" />
		<table class="table_type1">
			<caption>문의내역</caption>
			<colgroup>
				<col style="width:20%;">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th>작성자</th>
					<td>
						<span><c:out value="${session.mbrNm}" /></span>
					</td>
				</tr>
				<tr>
					<th>이메일<span class="req">＊</span></th>
					<td>
						<input type="text" id="popup_goods_inquiry_reg_email_id" name="emailId" class="input_style1" title="이메일 아이디" style="width:100px;" value="<c:out value="${member.emailId}" />" />
						@
						<input type="text" id="popup_goods_inquiry_reg_email_addr" name="emailAddr" class="input_style1" title="이메일 도메인" style="width:120px;" value="<c:out value="${member.emailAddr}" />" />
						<select id="popup_goods_inquiry_reg_email_addr_select" class="select_type1" title="이메일 도메인">
							<option value="">직접입력</option>
							<c:forEach items="${emailAddrCdList}" var="emailAddr">
								<option value="<c:out value="${emailAddr.usrDfn1Val}" />"><c:out value="${emailAddr.dtlNm}" /></option>
							</c:forEach>
						</select>
						<div id="popup_goods_inquiry_reg_email_error" class="note_b point1"></div>
					</td>
				</tr>
				<tr>
					<th>연락처<span class="req">＊</span></th>
					<td>
						<input type="text" id="popup_goods_inquiry_reg_eqrr_mobile" name="eqrrMobile" class="input_style1" title="휴대폰번호" style="width:186px;" value="<frame:mobile data='${member.mobile}' />" />
						<div id="popup_goods_inquiry_reg_eqrr_mobile_error" class="note_b point1"></div>
					</td>
				</tr>
				<tr>
					<th>제목<span class="req">＊</span></th>
					<td>
						<input type="text" id="popup_goods_inquiry_reg_iqr_ttl" name="iqrTtl" class="input_style1" title="문의제목" style="width:450px;">
						<div class="byte" id="popup_goods_inquiry_reg_iqr_ttl_byte"></div>
						<div id="popup_goods_inquiry_reg_iqr_ttl_error" class="note_b point1"></div>
					</td>
				</tr>
				<tr>
					<th>내용<span class="req">＊</span></th>
					<td>
						<textarea id="popup_goods_inquiry_reg_iqr_content" name="iqrContent" class="textarea" title="문의내용" style="width:450px;height:110px;"></textarea>
						<div class="byte" id="popup_goods_inquiry_reg_iqr_content_byte"></div>
						<div id="popup_goods_inquiry_reg_iqr_content_error" class="note_b point1"></div>
					</td>
				</tr>
			</tbody>
			<tbody>
				<tr>
					<td colspan="2"><input type="checkbox" id="chkHiddenYn">비밀글로 문의하기</td>
				</tr>
			</tbody>
		</table>
		</form>
		
		<div class="pop_btn_section">
			<a href="#" onclick="insertGoodsInquiry();return false;" class="btn_pop_type1 mgr10">등록</a>
			<a href="#" onclick="pop.close('<c:out value="${param.popId}" />');return false;" class="btn_pop_type2">취소</a>
		</div>
	</div>
	
</div>
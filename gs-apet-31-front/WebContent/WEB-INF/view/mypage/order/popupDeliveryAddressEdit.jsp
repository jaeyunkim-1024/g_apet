<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

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

			if($("#popup_address_edit_gb_nm").val() == ""){
				$("#popup_address_edit_gb_nm_error").html("배송지명을 입력해주세요.");
				$("#popup_address_edit_gb_nm").focus();
				return false;
			}

			if($("#popup_address_edit_adrs_nm").val() == ""){
				$("#popup_address_edit_adrs_nm_error").html("받으실분을 입력해주세요.");
				$("#popup_address_edit_adrs_nm").focus();
				return false;
			}
			
			if($("#popup_address_edit_mobile").val() == ""){
				$("#popup_address_edit_mobile_error").html("휴대혼번호를 입력해주세요.");
				$("#popup_address_edit_mobile").focus();
				return false;
			}

			if(!valid.mobile.test($("#popup_address_edit_mobile").val())){
				$("#popup_address_edit_mobile_error").html("잘못된 형식의 휴대폰번호 입니다.");
				$("#popup_address_edit_mobile").focus();
				return false;
			}

			if($("#popup_address_edit_tel").val() != ""){
				if(!valid.tel.test($("#popup_address_edit_tel").val())){
					$("#popup_address_edit_tel_error").html("잘못된 형식의 전화번호 입니다.");
					$("#popup_address_edit_tel").focus();
					return false;
				}
			}
			
			if($("#popup_address_edit_post_no_new").val() == ""){
				$("#popup_address_edit_addr_error").html("우편번호찾기를 통하여 주소를 입력해주세요.");
				$("#popup_address_edit_btn_post").focus();
				return false;
			}

			if($("#popup_address_edit_road_dtl_addr").val() == ""){
				$("#popup_address_edit_addr_error").html("도로명 상세 주소를 입력해주세요.");
				$("#popup_address_edit_road_dtl_addr").focus();
				return false;
			}

			/* if($("#popup_address_edit_prcl_addr").val() != "" && $("#popup_address_edit_prcl_dtl_addr").val() == ""){
				$("#popup_address_edit_addr_error").html("지번 상세 주소를 입력해주세요.");
				$("#popup_address_edit_prcl_dtl_addr").focus();
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
			if(confirm("<spring:message code='front.web.view.common.msg.confirm.update' />")){
				var options = {
						url : "<spring:url value='/mypage/order/updateDeliveryAddress' />",
						data : $("#popup_address_edit_form").serialize(),
						done : function(data){
							console.log(" data 등록");
							console.log(data);
							alert("<spring:message code='front.web.view.mypage.service.address.update.success' />");
							//location.href=$("#returnPath").val();
							<c:out value="${param.callBackFnc}" />();
							pop.close('<c:out value="${param.popId}" />'); 
						}
				};
				ajax.call(options);
			}
		}
	}
    
	/*
	 * 팝업 콜백 처리
	 */
	function returnAddress(){
		if(addressValidate.all()){
			var addressEditForm = $("#popup_address_edit_form").serializeArray();
			var data = {};
			$(addressEditForm ).each(function(index, obj){
			    data[obj.name] = obj.value;
			});
			
			<c:out value="${param.callBackFnc}" />(data);
			goPage();
		}
	}

	function goPage(){
 	 //location.href=$("#returnPath").val();
 	pop.close('<c:out value="${param.popId}" />'); 
	}
	/*
	 * 배송지 수정
	 */
	function updateAddress(){
		 
		if(addressValidate.all()){
			if(confirm("<spring:message code='front.web.view.common.msg.confirm.update' />")){
				var options = {
					url : "<spring:url value='/mypage/order/updateDeliveryAddress' />",
					data : $("#popup_address_edit_form").serialize(),
					done : function(data){
						alert("<spring:message code='front.web.view.mypage.service.address.update.success' />");
						//location.href="/mypage/order/popupDeliveryAddressEdit";
					}
				};
				ajax.call(options);
			}
		}
	}
	
	/*
	 * 우편번호 팝업
	 */
	function openPostPop(){
		pop.post({callBackFnc : 'orderDlvra.cbPostPop'});
	}
	
	/*
	 * 우편번호 CallBack
	 */
	/* function cbPostPop(data){
		$("#popup_address_edit_post_no_new").val(data.postNoNew);
		$("#popup_address_edit_post_no_old").val(data.postNoOld);
		$("#popup_address_edit_prcl_addr").val(data.prclAddr);
		$("#popup_address_edit_road_addr").val(data.roadAddr);
		$("#popup_address_edit_prcl_dtl_addr").val("");
		$("#popup_address_edit_road_dtl_addr").val("");
		
		if(data.prclAddr != null && data.prclAddr != ""){
			$("#joinPrclAddr").html("[지번주소] "+data.prclAddr);
		}
		
		$("#popup_address_edit_road_dtl_addr").focus();
		
		
		$("#addressChanged").val("Y");
	} */
	
	/*******************
	 * 배송지 정보 컨트롤
	 *******************/
	var orderDlvra = {
		/* 배송지 데이터 */
		data : {
			adrsNm 	: ""
			,postNoOld 	: ""
			,postNoNew 	: ""
			,roadAddr  	: ""
			,roadDtlAddr : ""
			,prclAddr  	: ""
			,prclDtlAddr : ""
			,tel : ""
			,mobile : ""
		}			
		
		/* 주소검색 팝업 */
		,openPost : function(){
			pop.post({callBackFnc : 'orderDlvra.cbPostPop'});
		}
		/* 주소검색 CallBack */
		,cbPostPop : function(data){
			this.data = data;
			this.chkAddr();
			
		}
		// 도서 산간 지역 체크
		,chkAddr : function(){
			
			if (this.data == null){
				return;
			}
			
			if(this.data.postNoNew != null && this.data.postNoNew != ""){
				
				this.checkLocalPost();
			}
			
			
		}
		,setAddr : function(){
			
			if (this.data == null){
				return;
			}
			
			var chgPostNoNew = this.data.postNoNew;
			var chgPostNoOld = this.data.postNoOld;
			var chgPrclAddr = this.data.prclAddr;
			var chgRoadAddr = this.data.roadAddr;
			
			var ac = $("#addressChanged").val();
			
			if(ac != "N"){
				
				$("#popup_address_edit_post_no_new").val(chgPostNoNew);
				$("#popup_address_edit_post_no_old").val(chgPostNoOld);
				$("#popup_address_edit_prcl_addr").val(chgPrclAddr);
				$("#popup_address_edit_road_addr").val(chgRoadAddr);
				$("#popup_address_edit_prcl_dtl_addr").val("");
				$("#popup_address_edit_road_dtl_addr").val("");
				
				if(chgPrclAddr != null && chgPrclAddr != ""){
					$("#joinPrclAddr").html("[지번주소] " + chgPrclAddr);
				}
				
				$("#popup_address_edit_road_dtl_addr").focus();
			}
			
		}
		, checkLocalPost : function(){
			var options = {
				url : "<spring:url value='/order/checkLocalPost' />"
				,data : {
					postNoNew : this.data.postNoNew
					,postNoOld : format.post(this.data.postNoOld)
				}
				,done : function(data){
					var localPostYn = data.localPostYn;

					if($("#localPostYn").val() != localPostYn){
						if(localPostYn == "Y"){
							alert("일반지역 배송지에서 도서/산간지역으로 배송지를 변경할 수 없습니다.");
							$("#addressChanged").val("N");
						}else{
							alert("도서/산간지역에서 일반지역 배송지로 배송지를 변경할 수 없습니다.");
							$("#addressChanged").val("N");
						}
						
					}else{
						$("#addressChanged").val("Y");
						
					}
					
					orderDlvra.setAddr();
					
				}
			};
			ajax.call(options);
		}
		
	};

	
</script>

<div id="pop_contents">
	<form id="popup_address_edit_form">
	<input type="hidden" id="ordNo" name="ordNo" value="<c:out value="${param.ordNo}" />" />
	<input type="hidden" id="localPostYn" name="localPostYn" value="<c:out value="${localPostYn}" />" />
	<input type="hidden" id="addressChanged" name="addressChanged" value="" />
	<%-- <input type="hidden" id="returnPath" name="returnPath" value="<c:out value="${param.returnPath}" />" /> --%>
	
	<table class="table_type1">
		<colgroup>
			<col style="width:140px" />
			<col style="width:auto" />
		</colgroup>
		<tbody>
			<tr>
				<th>받는사람 *</th>
				<td>
					<input type="text" id="popup_address_edit_adrs_nm" name="adrsNm" title="받으시는분" style="width:150px;" value="<c:out value="${deliveryInfo.adrsNm}" />" maxlength="10" /> <span class="mgl6">(10자 입력 가능)</span>
					<div id="popup_address_edit_adrs_nm_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th>연락처  *</th>
				<td> 
					<input type="text" id="popup_address_edit_mobile" name="mobile" class="input_style1" title="휴대폰번호" style="width:186px;" value="<frame:mobile data="${deliveryInfo.mobile}" />" />
					<div id="popup_address_edit_mobile_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td> 
					<input type="text" id="popup_address_edit_tel" name="tel" class="input_style1" title="전화번호" style="width:186px;" value="<frame:tel data="${deliveryInfo.tel}" />" />
					<div id="popup_address_edit_tel_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th>주소 *</th>
				<td>
					<div>
						<input type="text" id="popup_address_edit_post_no_new" name="postNoNew" title="신우편번호" style="width:40px;" readonly="readonly" value="<c:out value="${deliveryInfo.postNoNew}" />" />
						<input type="hidden" id="popup_address_edit_post_no_old" name="postNoOld" title="구우편번호" style="width:55px;" readonly="readonly" value="<frame:post data="${deliveryInfo.postNoOld}" />" />
						<a href="#" id="popup_address_edit_btn_post" class="btn_h30_type4 mgl6" onclick="orderDlvra.openPost();return false;">우편번호찾기</a>
					</div>
					<div class="mgt10">
						<span>도로명주소</span>
						<input type="text" id="popup_address_edit_road_addr" name="roadAddr" title="기본주소" style="width:280px;" class="disabled" readonly="readonly" value="<c:out value="${deliveryInfo.roadAddr}" />" />
					</div>
					<div class="mgt10">
						<input type="text" id="popup_address_edit_road_dtl_addr" name="roadDtlAddr" title="상세주소" style="width:340px;" value="<c:out value="${deliveryInfo.roadDtlAddr}" />" />	
					</div>
					<p class="note_b" id="joinPrclAddr"></p>
					<div id="popup_address_edit_addr_error" class="note_b point1"></div>
					
					<input type="hidden" id="popup_address_edit_prcl_addr" name="prclAddr" title="지번주소" value="<frame:post data="${deliveryInfo.prclAddr}" />" />
					<input type="hidden" id="popup_address_edit_prcl_dtl_addr" name="prclDtlAddr" title="지번주소 상세" value="<frame:post data="${deliveryInfo.prclDtlAddr}" />" />
				</td>
			</tr>
			<tr>
				<th>배송메모</th>
				<td> 
					<input type="text" id="popup_address_edit_dlvrMemo" name="dlvrMemo" class="bgGray" title="배송메모" value="<frame:tel data="${deliveryInfo.dlvrMemo}" />" />
				</td>
			</tr>
		</tbody>
	</table>
	</form>
</div>
<!-- //팝업 내용 -->

<!-- 버튼 공간 -->
<div class="pop_btn_section">
	<c:if test="${mode ne 'return'}">
		<a href="#" class="btn_pop_type1" onclick="insertAddress();return false;">확인</a>
	</c:if>
	<c:if test="${mode eq 'return'}">
		<a href="#" class="btn_pop_type1" onclick="returnAddress();return false;">확인</a>
	</c:if>
	<a href="#" class="btn_pop_type2 mgl6" onclick="goPage();return false;">취소</a>
</div>
<!-- //버튼 공간 -->
 
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 

<script type="text/javascript">
	// 주문정보 선택 플래그
	var orderFlag = "Y";

	$(document).ready(function(){
		// 화면 로드시 이메일 초기 설정
		initSetEmailAddr();
		
		// 이메일 도메인 변경
		$("#inquiry_email_addr_select").change(function(){
			if($(this).val() == "custom"){
				$("#inquiry_email_addr").show();
				$("#inquiry_email_addr").val("");
				$("#inquiry_email_addr").focus();
			}else if($(this).val() == ""){
				$("#inquiry_email_addr").hide();
				$("#inquiry_email_addr").val("");
			}else{
				$("#inquiry_email_addr").hide();
				$("#inquiry_email_addr").val($(this).val());
			}
		});
		
		// 주문정보 없음 체크박스
		$(".checkbox").click(function(){
			
			if($("#noOrder").prop("checked")){
				orderFlag = "N";
				$(".mgt5").html("");
			}else{
				orderFlag = "Y";
			}
			
			// 주문정보 선택값 초기화
			$("#ordNo").val("");
			$("#ordDtlSeqInfo").html("");
			$("#paramOrderInfo").html("");
			
		});
		
	}); // End Ready
	
	/*
	 * 화면 로드시 이메일 초기 설정
	 */
	function initSetEmailAddr() {
		var check = false;
		var emailAddr = "<c:out value="${member.emailAddr}" />";
		var emailAddroptions = $("#inquiry_email_addr_select option");
		for(var i=0; i < emailAddroptions.length; i++){
			if($(emailAddroptions[i]).val() == emailAddr){
				check = true;
			}
		}
		if(check){
			$("#inquiry_email_addr_select").val(emailAddr);
			$("#inquiry_email_addr").val(emailAddr);
			$("#inquiry_email_addr").hide();
		}else{
			$("#inquiry_email_addr_select").val("custom");
			$("#inquiry_email_addr").val(emailAddr);
			$("#inquiry_email_addr").show();
		}
	}
	
	/*
	 * 문의유형 선택
	 */
	function setCusCtg1Cd(obj, code, code2) {
		$("input[name=cusCtg1Cd]").val(code);
		$(obj).parent().children("a").removeClass("on");
		$(obj).toggleClass("on");
		
		// 주문정보 선택값 초기화
		//$("#ordNo").val("");
		//$("#ordDtlSeqInfo").html("");
		//$("#paramOrderInfo").html("");
	}
	
	/*
	 * 주문정보 선택
	 */
	var orderData = {
		openOderList : function() {
			var options = {
					url : "/mypage/order/popupOrderList",
					params : {},
					width : 700,
					height : 600,
					callBackFnc : "orderData.cbOrderList",
					modal : true
			};
			
			pop.open("popOrderList", options);
		}

		,cbOrderList : function(data){
			
//			$(".checkbox:checked").prop('checked', false);
			
			if(data.orderInfo != null && data.orderInfo.length > 0){
				$("input[name=noOrder]:checked").prop('checked', false);
				
				$("#paramOrderInfo").html("");
				$("#ordDtlSeqInfo").html("");
				$("#cus_ord_no_error").html("");
				
				for(var i=0; i<data.orderInfo.length; i++){
					
					var splitText = data.orderInfo[i].split("|");
					
					// 주문번호
					$("#ordNo").val(splitText[0]);
					
					var showText = "["+splitText[2]+"] "+splitText[3];
					
					$("#paramOrderInfo").append("<li>"+ showText +"</li>");
					$("#ordDtlSeqInfo").append("<input type=\"hidden\" name=\"ordDtlSeqs\" value=\""+ splitText[1] +"\" />");
				}
			}
		}
	}
	
	/*
	 * 문의하기 Validation
	 */
	var inquiryValidate = {
		all : function(){
			
			$(".mgt5").html("");
			
			if($("#cus_ctg1_cd").val() == ""){
				$("#cus_ctg1_cd_error").html("문의유형을 선택해주세요.");
				$('html,body').animate({scrollTop : 200}, 500);
				return false;
			} else {
				$("#cus_ctg1_cd_error").html("");
			}
			
			if(orderFlag == "Y" && $("#ordNo").val()=="") {
				$("#cus_ord_no_error").html("주문정보를 선택해주세요.");
				$("#ordDtchk").focus();
				return false;
			}
			
			if($("#inquiry_mobile").val() == ""){
				$("#inquiry_mobile_error").html("휴대폰 번호를 입력해주세요.");
				$("#inquiry_mobile").focus();
				return false;
			} else {
				$("#inquiry_mobile_error").html("");
			}
			
			if(!valid.mobile.test($("#inquiry_mobile").val().trim())){
				$("#inquiry_mobile_error").html("잘못된 형식의 휴대폰번호 입니다.");
				$("#inquiry_mobile").focus();
				return false;
			} else {
				$("#inquiry_mobile_error").html("");
			}
			
			if($("#inquiry_tel").val().trim() != "" && !valid.tel.test($("#inquiry_tel").val().trim())){
				$("#inquiry_tel_error").html("잘못된 형식의 전화번호 입니다.");
				$("#inquiry_tel").focus();
				return false;
			} else {
				$("#inquiry_tel_error").html("");
			}

			if($("#inquiry_email_id").val().trim() == ""){
				$("#inquiry_email_error").html("이메일을 입력해주세요.");
				$("#inquiry_email_id").focus();
				return false;
			} else {
				$("#inquiry_email_error").html("");
			}
			
			if($("#inquiry_email_addr").val() == ""){
				$("#inquiry_email_error").html("이메일을 선택해주세요.");
				$("#inquiry_email_addr").focus();
				return false;
			} else {
				$("#inquiry_email_error").html("");
			}
			
			if($("#inquiry_title").val() == ""){
				$("#inquiry_title_error").html("문의제목을 입력해주세요.");
				$("#inquiry_title").focus();
				return false;
			} else {
				$("#inquiry_title_error").html("");
			}
			
			if($("#inquiry_content").val().trim() == ""){
				$("#inquiry_content_error").html("문의내용을 입력해주세요.");
				$("#inquiry_content").focus();
				return false;
			} else {
				$("#inquiry_content_error").html("");
			}

			<c:if test="${session.mbrNo eq 0}">
			if(!$("#inquiry_agree").is(":checked")){
				alert("개인정보 수집 이용에 동의해 주세요.");
				$("#inquiry_agree").focus();
				return false;
			}
			</c:if>
			
			return true;
		}
	};
	
	/*
	 * 문의하기 처리
	 */
	function insertInquiry(){
		
		if(inquiryValidate.all()){
			var options = {
					url : "<spring:url value='/customer/inquiry/insertInquiry' />",
					data : $("#inquiry_form").serialize(),
					done : function(data){
						
						alert("<spring:message code='front.web.view.counsel.insert.success' />");
						
						<c:if test="${session.mbrNo eq 0}">
						location.href="/customer/inquiry/indexInquiryList";
						</c:if>

						<c:if test="${session.mbrNo ne 0}">
						location.href="/mypage/inquiry/indexAnswerList";
						</c:if>
					}
			};
	
			ajax.call(options);
		}
	}
	
	//첨부파일 갯수
	var fileIdx = 0;
	
	// 파일 찾기
	function imageUpload () {
		
		if ($('li[id^="fileArea_"]').length >= 5) {
			alert("파일 첨부는 최대 5개까지 가능합니다");
			return false;
		}
		
		// 파일 추가
		fileUpload.image(resultImage);
	}
	
	// 이미지 업로드 결과
	function resultImage(file) {
		
		fileIdx++;
		
		var addHtml = "\
			<li id='fileArea_"+fileIdx+"'>\
			<span class='file' id='file_name_"+fileIdx+"'></span>\
			<span class='bytes' id='file_bytes_"+fileIdx+"'></span>\
			<a href='#' class='btn_delete' onclick='deleteImage("+fileIdx+"); return false;'>삭제</a>\
				<input type='hidden' name='phyPaths' id='phyPath_"+fileIdx+"' title='<spring:message code='column.phy_path'/>' value=''>\
				<input type='hidden' name='flSzs' id='flSz_"+fileIdx+"' title='<spring:message code='column.fl_sz'/>' value=''>\
				<input type='hidden' name='orgFlNms' id='orgFlNm_"+fileIdx+"' title='<spring:message code='column.org_fl_nm'/>' value='' />\
			</li>";
			
		$("#file_list").append(addHtml);
		
		$("#file_name_"+fileIdx).text(file.fileName);
		$("#file_bytes_"+fileIdx).text(Math.floor(file.fileSize / 1024) + " KB");
		
		$("#orgFlNm_"+fileIdx).val(file.fileName);// 원 파일 명
		$("#phyPath_"+fileIdx).val(file.filePath);// 물리 경로
		$("#flSz_"+fileIdx).val(file.fileSize);	// 파일 크기
		
	}
	
	// 첨부 파일 삭제
	function deleteImage (fileIdx) {
		
		$("#file_name_"+fileIdx).text("");
		$("#file_bytes_"+fileIdx).text("");
		
		$("#orgFlNm_"+fileIdx).val("");
		$("#phyPath_"+fileIdx).val("");
		$("#flSz_"+fileIdx).val("");
		
		$("#fileArea_"+fileIdx).remove();
	}
	
	//약관동의 탭 script
	function tabSwich(elm){
		jQuery(elm).parent().addClass('on').siblings().removeClass('on');
		
		jQuery(jQuery(elm).attr('href')).show().siblings().hide();
	}

	
</script>

<div class="box_title_area"> 

	<h3 class="ty02">문의하기</h3>
		<div class="sub_text2 ty02">구매한 상품의 취소/반품/교환은 마이페이지에서 즉시 신청이 가능합니다.<br>
		사이즈 및 색상 등 상품에 대한 상세 문의는 [상품 페이지 > 상품문의]를 이용해주시면 좀 더 빠른 답변이 가능합니다.</div>
</div>

<div class="completion_box">
	
	
</div>

<!-- 문의내역 -->
<form id="inquiry_form">
<input type="hidden" name="eqrrNm" value="${member.mbrNm}" />
<table class="table_type1">
	<caption>문의내역</caption>
	<colgroup>
		<col style="width:15%;" />
		<col />
	</colgroup>
	<tbody>
		<tr>
			<th>문의유형 선택 <span class="req">＊</span></th>
			<td>
				<div class="btn_period_group">
					<c:forEach items="${cusCtg1CdList}" var="cusCtg1">
					<a href="#" onclick="setCusCtg1Cd(this,'<c:out value="${cusCtg1.dtlCd}"/>', '<c:out value="${cusCtg1.usrDfn2Val}"/>'); return false;" class="btn_period"><c:out value="${cusCtg1.dtlNm}" /></a>
					</c:forEach>
					<input type="hidden" id="cus_ctg1_cd" name="cusCtg1Cd" value="" />
				</div>
				<div id="cus_ctg1_cd_error" class="mgt5 point1 pswd"></div>
			</td>
		</tr>
		<!-- 주문데이터 선택 -->
		<tr id="orderCheck">
			<th>주문정보 <span class="req">＊</span></th>
			<td>
				<a href="javascript:void(0)" class="btn_h30_type4" onclick="orderData.openOderList();return false;" id="ordDtchk">주문정보 선택</a>
				<input type="checkbox" class="checkbox" id="noOrder" name="noOrder" title="선택" >주문정보 없음
				<ul class="answerList" id="paramOrderInfo"></ul>
				<input type="hidden" id="ordNo" name="ordNo" value="" />
				<div id="ordDtlSeqInfo" style="display:none;"></div>
				<div id="cus_ord_no_error" class="mgt5 point1 pswd"></div>			
			</td>
		</tr>
		<tr>
			<th>휴대폰 번호 <span class="req">＊</span></th>
			<td>
				<input type="text" id="inquiry_mobile" name="eqrrMobile" class="input_style1" title="휴대폰 번호" style="width:186px;" value="<frame:mobile data="${member.mobile}" />" />
				<div id="inquiry_mobile_error" class="mgt5 point1 pswd"></div>
			</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>
				<input type="text" id="inquiry_tel" name="eqrrTel" class="input_style1" title="전화번호" style="width:186px;" value="<frame:tel data="${member.tel}" />" />
				<div id="inquiry_tel_error" class="mgt5 point1 pswd"></div>
			</td>
		</tr>
		<tr>
			<th>이메일 <span class="req">＊</span></th>
			<td>
				<input type="text" id="inquiry_email_id" name="emailId" class="input_style1" title="이메일 아이디" style="width:186px;" value="${member.emailId}" />
				@
				<input type="text" id="inquiry_email_addr" name="emailAddr" class="input_style1" title="이메일 도메인" style="width:186px;display:none;" />
				<select id="inquiry_email_addr_select" class="select_type1" title="이메일 도메인" >
					<option value="">선택</option>
					<option value="custom">직접입력</option>
					<c:forEach items="${emailAddrCdList}" var="emailAddr">
					<option value="<c:out value="${emailAddr.usrDfn1Val}" />"><c:out value="${emailAddr.dtlNm}" /></option>
					</c:forEach>
				</select>
				<div id="inquiry_email_error" class="mgt5 point1 pswd"></div>
			</td>
		</tr>
		<tr>
			<th>문의제목 <span class="req">＊</span></th>
			<td>
				<input type="text" id="inquiry_title" name="ttl" class="input_style1" title="문의제목" style="width:590px;" maxlength="50" />
				<div id="inquiry_title_error" class="mgt5 point1 pswd"></div>
			</td>
		</tr>
		<tr>
			<th>문의내용 <span class="req">＊</span></th>
			<td>
				<textarea class="textarea" id="inquiry_content" name="content" title="문의내용" style="width:590px;height:110px;" maxlength="500"></textarea>
				<div id="inquiry_content_error" class="mgt5 point1 pswd"></div>
			</td>
		</tr>
		<tr>
			<th>파일첨부</th>
			<td>
				<input type="text" class="input_style1 disabled" readonly="readonly" style="width:440px;" title="파일"  />
				<span class="btn_h30_type1 ui_add_file"><input type="file" class="input_file" title="파일첨부" onclick="imageUpload(); return false;"/> 파일찾기</span>
				<div class="mgt5 point3">
					※ 상담 시 이미지가 필요한 경우 파일을 첨부해 주세요. 
					<br/>
					※ 파일크기는 1MB이하, JPG, PNG 또는 GIF형식의 파일만 가능합니다.
				</div>
				<ul class="multi_file_list" id="file_list">
				</ul>
			</td>
		</tr>
	</tbody>
</table>
</form>

<c:if test="${session.mbrNo eq 0}">
<div class="content_middle mgt41">
	<div class="box_title_area">
		<h3>비회원 정보수집 동의</h3>
		<div class="sub_text2">
			비회원 1:1문의 처리를 위해 다음의 개인정보 수집 이용에 동의 후 원활한 서비스 이용이 가능 합니다.
		</div>
	</div>
</div>
<div class="non_members_section mgb57">
	<div class="switch_tab tab_menu01">
		<ul>
			<li class="on"><a href="#temsBox1" onclick="tabSwich(this);return false;">개인정보 수집항목</a></li>
			<li><a href="#temsBox2" onclick="tabSwich(this);return false;">개인정보 수집목적</a></li>
			<li><a href="#temsBox3" onclick="tabSwich(this);return false;">개인정보 보유 이용 기간</a></li>
		</ul>
	</div>
	
	<div class="term_boxs">
		<div id="temsBox1" class="term_box02" tabindex="0" style="width: 100%; display: block;">
			성명, 휴대폰번호, 전화번호, 이메일
		</div>
		<div id="temsBox2" class="term_box02" tabindex="0" style="width: 100%; display: none;">
			<ul class="ul_list_type3">
				<li>성명, 이메일주소, 전화번호, 휴대폰번호 : 비회원 1:1문의 결과 회신</li>
			</ul>
		</div>
		<div id="temsBox3" class="term_box02" tabindex="0" style="width: 100%; display: none;">
			전자상거래 등에서의 소비자보호에 관한 법률 등에서 정한 보존기간 동안 고객님의 개인 정보를 보유합니다. <br />
			비회원 개인정보 수집 이용에 대한 내용을 확인 하였으며 이에 동의 합니다.
		</div>
	</div>
	<label><input type="checkbox" class="checkbox" id="inquiry_agree">비회원 개인정보 수집 이용에 대한 내용을 확인하였으며 이에 동의합니다.</label>
</div>
</c:if>

<div class="btn_area_center">
	<a href="#" class="btn_h60_type1" onclick="insertInquiry();return false;">1:1 문의등록</a>
</div>
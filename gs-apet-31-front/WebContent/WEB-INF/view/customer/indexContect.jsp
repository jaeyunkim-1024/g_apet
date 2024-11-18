<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>

<script type="text/javascript">

	// Start Ready
	$(document).ready(function(){
		
	});
	// End Ready
	
	// Start Function
	$(function() {
		
		// byte체크  ****************************************
		$("#comp_itrdc").keyup(function(){	// 회사(브랜드) 소개 
			valid.checkByte('comp_itrdc_byte', this, 1000);
		});
		$("#goods_itrdc").keyup(function(){	// 대표상품 소개 
			valid.checkByte('goods_itrdc_byte', this, 1000);
		});
		
		// 입점희망 카테고리 선택시 카테고리번호, 카테고리명 저장
		$("#hopeCtg").change(function(){
			
			var ctgNo = $(this).val().split(',')[0];
			var ctgNm = $(this).val().split(',')[1];

			$("#se_hope_ctg_no").val(ctgNo);
			$("#se_hope_ctg_nm").val(ctgNm);
			
		});

	});
	// End Function
	
	/*
	 * 입점문의 등록 Validation
	 * URL (SNS), 첨부파일 외에는 모두 필수입력항목
	 */
	var contectValidate = {
		all : function(){
			
			$(".note_b").html("");
						
			if($("#comp_nm").val().trim() == ""){
				$("#comp_nm_error").html("회사명을 입력해주세요.");
				$("#comp_nm").focus();
				return false;
			}
			/* if($("#ceo_nm").val().trim() == ""){
				$("#ceo_nm_error").html("대표자명을 입력해주세요.");
				$("#ceo_nm").focus();
				return false;
			}
			if($("#biz_no").val().trim() == ""){
				$("#biz_no_error").html("사업자 번호를 입력해주세요.");
				$("#biz_no").focus();
				return false;
			} */
			if($("#biz_no").val().trim() != "" && !valid.bizNo.test($("#biz_no").val())){
				$("#biz_no_error").html("잘못된 형식의 사업자 번호 입니다.");
				$("#biz_no").focus();
				return false;
			}
			/* if($("#post_no_new").val().trim() == ""){
				$("#post_no_error").html("우편번호를 입력해주세요.");
				$("#post_no_new").focus();
				return false;
			}*/
			if($("#post_no_new").val().trim() != "" && ($("#road_addr").val().trim() == "" || $("#road_dtl_addr").val().trim() == "")){
				$("#road_dtl_addr_error").html("도로명주소를 입력해주세요.");
				$("#road_dtl_addr").focus();
				return false;
			}
			if($("#pic_nm").val().trim() == ""){
				$("#pic_nm_error").html("담당자명/직급을 입력해주세요.");
				$("#pic_nm").focus();
				return false;
			}
			/* if($("#pic_dpm").val().trim() == ""){
				$("#pic_dpm_error").html("부서를 입력해주세요.");
				$("#pic_dpm").focus();
				return false;
			} */
			if($("#pic_email").val().trim() == ""){
				$("#pic_email_error").html("E-mail을 입력해주세요.");
				$("#pic_email").focus();
				return false;
			}
			if(!valid.email.test($("#pic_email").val())){
				$("#pic_email_error").html("잘못된 형식의 E-mail 입니다.");
				$("#pic_email").focus();
				return false;
			}
			if($("#pic_mobile").val().trim() == ""){
				$("#pic_mobile_error").html("담당자 핸드폰을 입력해주세요.");
				$("#pic_mobile").focus();
				return false;
			}
			if(!valid.mobile.test($("#pic_mobile").val())){
				$("#pic_mobile_error").html("잘못된 형식의 핸드폰번호 입니다.");
				$("#pic_mobile").focus();
				return false;
			}
			if($("#web_st").val().trim() == ""){
				$("#web_st_error").html("URL (website)을 입력해주세요.");
				$("#web_st").focus();
				return false;
			}
			if(!valid.url_website.test($("#web_st").val())){
				$("#web_st_error").html("잘못된 형식의 URL (website) 입니다.");
				$("#web_st").focus();
				return false;
			}
			if($("#bnd_nm").val().trim() == ""){
				$("#bnd_nm_error").html("브랜드명을 입력해주세요.");
				$("#bnd_nm").focus();
				return false;
			}
			if($("#comp_itrdc").val().trim() == ""){
				$("#comp_itrdc_error").html("회사(브랜드) 소개를 입력해주세요.");
				$("#comp_itrdc").focus();
				return false;
			}
			/* if($("#goods_itrdc").val().trim() == ""){
				$("#goods_itrdc_error").html("대표상품 소개  입력해주세요.");
				$("#goods_itrdc").focus();
				return false;
			}
			if($("#goods_prc_rng").val().trim() == ""){
				$("#goods_prc_rng_error").html("상품 평균 가격대를  입력해주세요.");
				$("#goods_prc_rng").focus();
				return false;
			}
			if($("#stp_cust").val().trim() == ""){
				$("#stp_cust_error").html("주요 고객층 (판매 타겟)을  입력해주세요.");
				$("#stp_cust").focus();
				return false;
			} */
			if($("input[name=seGoodsTpCd]").is(":checked") == false){
				$("#se_goods_tp_cd_error").html("상품 유형을  선택해주세요.");
				$("input[name=seGoodsTpCd]").eq(0).focus();
				return false;			
			}
			if($("input[name=seSaleTpCd]").is(":checked") == false){
				$("#se_sale_tp_cd_error").html("판매 유형을  선택해주세요.");
				$("input[name=seSaleTpCd]").eq(0).focus();
				return false;
			}
			/* if($("input[name=seDstbTpCd]").is(":checked") == false){
				$("#se_dstb_tp_cd_error").html("물류 유형을  선택해주세요.");
				$("input[name=seDstbTpCd]").eq(0).focus();
				return false;
			} */
			if ($("select[name=hopeCtg]").val() == "") {
				$("#se_hope_ctg_no_error").html("입점희망 카테고리를  선택해주세요.");
				$("#se_hope_ctg_no").focus();
				return false;
			}
			/* if($("#se_hope_ctg_nm").val().trim() == ""){
				$("#se_hope_ctg_nm_error").html("입점희망 카테고리를  입력해주세요.");
				$("#se_hope_ctg_nm").focus();
				return false;
			} */
			// TODO : 이미지 첨부 체크
			
			if($("#check_agree").is(":checked") == false){
				alert("개인정보 수집에 동의하셔야 접수하실 수 있습니다.");
				$("#check_agree").focus();
				return false;
			}
			
			// http:// 추가 
			var httpWebSt = "http://"+$("#web_st").val();
			$("#web_st").val(httpWebSt);
			
			return true;
		}
	};
	
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
		$("#post_no_new").val(data.postNoNew);
		$("#road_addr").val(data.roadAddr);
		
		$("#road_dtl_addr").focus();
	}
	
	//첨부파일 갯수
	var fileIdx = 0;
	
	// 파일 찾기
	function contectFileUpload () {
		
		if ($('li[id^="fileArea_"]').length >= 10) {
			alert("파일 첨부는 최대 10개까지 가능합니다");
			return false;
		}
		
		// 파일 추가
		fileUpload.file(resultFile);
	}
	
	// 이미지 업로드 결과
	function resultFile(file) {
		
		fileIdx++;
		
		
		var addHtml = "\
			<li id='fileArea_"+fileIdx+"'>\
			<span class='file' id='file_name_"+fileIdx+"'></span>\
			<span class='bytes' id='file_bytes_"+fileIdx+"'></span>\
			<a href='#' class='btn_delete' onclick='deleteFile("+fileIdx+"); return false;'>삭제</a>\
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
	function deleteFile (fileIdx) {
		
		$("#file_name_"+fileIdx).text("");
		$("#file_bytes_"+fileIdx).text("");
		
		$("#orgFlNm_"+fileIdx).val("");
		$("#phyPath_"+fileIdx).val("");
		$("#flSz_"+fileIdx).val("");
		
		$("#fileArea_"+fileIdx).remove();
	}
	
	/*
	 * 입점문의 등록
	 */
	function insertShopEnter(){
		if(contectValidate.all()){
			if(confirm("<spring:message code='front.web.view.common.msg.confirm.insert' />")){
				
				var options = {
					url : "<spring:url value='/customer/contect/insertShopEnter' />",
					data : $("#shop_enter_form").serialize(),
					done : function(data){
						alert("<spring:message code='front.web.view.introduce.contect.insert.success' />");
						// 페이지 clear
						window.location.reload(true);
					}
				};
				ajax.call(options);
			}
		}
	}
</script>

<!-- 현위치 -->
<div class="location_path">
	<ul>
		<li class="home"><a href="/main">Home</a></li>
		<li class="current">신규입점문의 </li>	
	</ul>
</div>
<!-- //현위치 -->

<div class="border_contents">
	<h2 class="page_title">
		신규입점문의 <span class="sub_text">귀사의 입점문의 및 제안을 기다리고 있습니다. 입점 문의사항 검토 후, 담당자가 개별 연락 드리겠습니다. 감사합니다.</span><span class="import_section">* 항목은 필수 항목입니다.</span>
	</h2>
	<form id="shop_enter_form">
	<table class="table_type1">
		<caption>신규입점문의</caption>
		<colgroup>
			<col style="width:15%">
			<col style="width:auto">
			<col style="width:15%">
			<col style="width:35%">
		</colgroup>
		<tbody>
			<tr>
				<th><strong>회사명*</strong></th>
				<td colspan="3">
					<input type="text" id="comp_nm" name="compNm" class="input_style1" style="width:200px" title="회사명" maxlength="100" />
					<div id="comp_nm_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th><strong>대표자명</strong></th>
				<td colspan="3">
					<input type="text" id="ceo_nm" name="ceoNm" class="input_style1" style="width:200px" title="대표자명" maxlength="50" />
					<div id="ceo_nm_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th><strong>사업자 등록번호</strong></th>
				<td colspan="3">
					<input type="text" id="biz_no" name="bizNo" class="input_style1" style="width:200px" title="사업자 등록번호" maxlength="12" placeholder="- 구분자 필수입력" />
					<div id="biz_no_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th><strong>회사주소</strong></th>
				<td colspan="3">
					<div class="zip_code">
						<input type="text" id="post_no_new" name="postNoNew" class="input_style1" style="width:185px" title="신우편번호" readonly="readonly" />
						<a href="#" id="join_btn_post" class="btn_h30_type3 mgl7" onclick="openPostPop();return false;">우편번호 검색</a>
						<div id="post_no_error" class="note_b point1"></div>
					</div>
					<div class="address_box">
						<strong class="label_tit">도로명주소</strong>
						<input type="text" id="road_addr" name="roadAddr" class="input_style1" style="width:350px" title="도로명주소" readonly="readonly" />
						<input type="text" id="road_dtl_addr" name="roadDtlAddr" class="input_style1" style="width:250px" title="상세주조입력" placeholder="도로명주소 상세" value="" maxlength="50" />
						<div id="road_dtl_addr_error" class="note_b point1"></div>
					</div>
				</td>
			</tr>
			<tr>
				<th><strong>담당자명 /직급*</strong></th>
				<td>
					<input type="text" id="pic_nm" name="picNm" class="input_style1" style="width:200px" title="담당자명" maxlength="50" />
					<div id="pic_nm_error" class="note_b point1"></div>
				</td>
				<th><strong>부서</strong></th>
				<td>
					<input type="text" id="pic_dpm" name="picDpm" class="input_style1" style="width:200px" title="부서" maxlength="50" />
					<div id="pic_dpm_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th><strong>E-mail*</strong></th>
				<td>
					<input type="text" id="pic_email" name="picEmail" class="input_style1" style="width:200px" title="E-mail" maxlength="100" />
					<div id="pic_email_error" class="note_b point1"></div>
				</td>
				<th><strong>담당자 핸드폰*</strong></th>
				<td>
					<input type="text" id="pic_mobile" name="picMobile" class="input_style1" style="width:200px" title="담당자 핸드폰" maxlength="13" />
					<div id="pic_mobile_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th><strong>URL (website)*</strong></th>
				<td colspan="3">
					<input type="text" id="web_st" name="webSt" class="input_style1" style="width:350px" title="URL(website)" maxlength="100" />
					<div id="web_st_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th><strong>URL (SNS)</strong></th>
				<td colspan="3">
					<input type="text" id="sns" name="sns" class="input_style1" style="width:350px" title="URL (SNS)" maxlength="200" />
					<div id="sns_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th><strong>브랜드명*</strong></th>
				<td colspan="3">
					<input type="text" id="bnd_nm" name="bndNm" class="input_style1" style="width:350px" title="브랜드명" maxlength="100" />
					<div id="bnd_nm_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th><strong>회사(브랜드) 소개*</strong> <br />(<span id="comp_itrdc_byte">0/1000 byte</span>)</th>
				<td colspan="3">
					<textarea class="textarea" id="comp_itrdc" name="compItrdc" style="width:650px" title="회사(브랜드) 소개" maxlength="1000" ></textarea>
					<div id="comp_itrdc_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th><strong>대표상품 소개</strong><br />(<span id="goods_itrdc_byte">0/1000 byte</span>)</th>
				<td colspan="3">
					<textarea class="textarea" id="goods_itrdc" name="goodsItrdc" style="width:650px" title="대표상품 소개" maxlength="1000" ></textarea>
					<div id="goods_itrdc_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th><strong>상품 평균 가격대</strong></th>
				<td colspan="3">
					<input type="text" id="goods_prc_rng" name="goodsPrcRng" class="input_style1" style="width:350px" title="상품 평균 가격대" maxlength="100" />
					<div id="goods_prc_rng_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th><strong>주요 고객층 (판매 타겟)</strong></th>
				<td colspan="3">
					<input type="text" id="stp_cust" name="stpCust" class="input_style1" style="width:350px" title="주요 고객층" maxlength="100" />
					<div id="stp_cust_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th><strong>상품 유형*</strong></th>
				<td colspan="3">
					<c:forEach items="${seGoodsTpCdList}" var="seGoodsTpCd">
					<label class="label_w160"><input type="radio" id="se_goods_tp_cd_${seGoodsTpCd.dtlCd}" name="seGoodsTpCd" value="<c:out value="${seGoodsTpCd.dtlCd}"/>" class="radio" /><c:out value="${seGoodsTpCd.dtlNm}" /></label>
					</c:forEach>
					<div id="se_goods_tp_cd_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th><strong>판매 유형*</strong></th>
				<td colspan="3">
					<c:forEach items="${seSaleTpCdList}" var="seSaleTpCd">
					<label class="label_w160"><input type="radio" id="se_sale_tp_cd_${seSaleTpCd.dtlCd}" name="seSaleTpCd" value="<c:out value="${seSaleTpCd.dtlCd}"/>" class="radio" /><c:out value="${seSaleTpCd.dtlNm}" /></label>
					</c:forEach>
					<div id="se_sale_tp_cd_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th><strong>물류 유형</strong></th>
				<td colspan="3">
					<c:forEach items="${seDstbTpCdList}" var="seDstbTpCd">
					<label class="label_w160"><input type="radio" id="se_dstb_tp_cd_${seDstbTpCd.dtlCd}" name="seDstbTpCd" value="<c:out value="${seDstbTpCd.dtlCd}"/>" class="radio" /><c:out value="${seDstbTpCd.dtlNm}" /></label>
					</c:forEach>
					<div id="se_dstb_tp_cd_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th><strong>입점희망 카테고리*</strong></th>
				<td colspan="3">
					<select id="hopeCtg" name="hopeCtg" class="select_design2" title="카테고리" style="width:150px">
						<option value="">카테고리를 선택하세요</option>
					<c:forEach var="cate" items="${dispHopeCate }">
						<option value="${cate.dispClsfNo }">${cate.dispClsfNm }</option>
					</c:forEach>
					</select>
					<div id="se_hope_ctg_no_error" class="note_b point1"></div>
					
					<input type="hidden" id="se_hope_ctg_no" name="seHopeCtgNo" value="" />
					<input type="hidden" id="se_hope_ctg_nm" name="seHopeCtgNm" value="" />
					
					<!-- <div class="mgt5">
						<input type="text" id="se_hope_ctg_nm" name="seHopeCtgNm" class="input_style1" style="width:350px" title="카테고리 직접입력" maxlength="200" />
						<div id="se_hope_ctg_nm_error" class="note_b point1"></div>
					</div> -->
				</td>
			</tr>
			<tr>
				<th><strong>첨부파일</strong></th>
				<td colspan="3">
					<p>회사 브랜드 소개서 상품소개서 입점제안서 등을 첨부하세요 <span class="btn_h30_type3 mgl10 ui_add_file">파일선택 
					<input type="file" class="input_file" title="파일선택" onclick="contectFileUpload(); return false;"/></span></p>
					<ul class="multi_file_list" id="file_list"></ul>
					
				</td>
			</tr>
		</tbody>
	</table>
	</form>
	<h2 class="page_title mgt80">
		신규입점 문의를 위한 정보수집 및 이용동의 <span class="sub_text1">VECI(이하 “회사”라 함)는 개인정보보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 관련 법령상의 개인정보보호 규정을 준수하며, 파트너의 개인정보 보호에 최선을 다하고 있습니다.</span>
	</h2>
	<div class="note_box2">
		<ul class="ul_list_type0">
			<li>1. 개인정보 수집 및 이용주체 : 입점 신청을 통해 제공하신 정보는 “회사”가 직접 접수하고 관리합니다.</li>
			<li>2. 동의를 거부할 권리 및 동의 거부에 따른 불이익 : 신청자는 개인정보제공 등에 관해 동의하지 않을 권리가 있습니다.(이 경우 입점신청이 불가능합니다.)</li>
			<li>3. 수집하는 개인정보 항목 : 담당자명, 담당자부서, 담당자 연락처, 담당자 이메일 주소</li>
			<li>4. 수집 및 이용목적 : 입점 검토, 입점 관리시스템의 운용, 공지사항의 전달 등</li>
			<li>5. 보유기간 및 이용기간 : 수집된 정보는 입점 처리기간이 종료되는 시점까지 보관됩니다.</li>
		</ul>
		<div class="agree_box">
			<label><input type="checkbox" id="check_agree" class="checkbox" /> 신규입점 문의를 위한 개인정보를 수집하는데 동의합니다.</label>
		</div>
	</div>
	<div class="btn_area_center">
		<a href="#" onclick="insertShopEnter();return false;" class="btn_h44_type1 fix_w190">접수하기</a>
	</div>
</div>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 제목, 내용영역의 byte체크 초기값 설정 (ex : 0/100Byte)
		valid.checkByte('popup_goods_comment_ttl_byte', this, 100); 
		valid.checkByte('popup_goods_comment_content_byte', this, 1000);
		
	}); // End Ready

	$(function() {

		// 제목, 내용영역의 byte체크
		$("#popup_goods_comment_ttl").keyup(function(){
			valid.checkByte('popup_goods_comment_ttl_byte', this, 100); 
		});
		$("#popup_goods_comment_content").keyup(function(){
			valid.checkByte('popup_goods_comment_content_byte', this, 1000);
		});

	});

	/*
	 * 상품평가 등록 Validation
	 */
	var inquiryValidate = {
		all : function(){
			
			$(".note_b").html("");

			if($("#popup_goods_comment_ttl").val().trim() == ""){
				$("#popup_goods_comment_ttl_error").html("제목을 입력해주세요.");
				$("#popup_goods_comment_ttl").focus();
				return false;
			}
			if($("#popup_goods_comment_content").val().trim() == ""){
				$("#popup_goods_comment_content_error").html("내용을 입력해주세요.");
				$("#popup_goods_comment_content").focus();
				return false;
			}	
			if($("#popup_goods_comment_estm_score_select").val() == ""){
				$("#popup_goods_comment_estm_score_select_error").html("평점을 선택해주세요.");
				return false;
			}

			return true;
		}
	};
	
	/*
	 * 상품평가 등록
	 */
	function insertGoodsComment(){
		if(inquiryValidate.all()){
			if(confirm("<spring:message code='front.web.view.common.msg.confirm.insert' />")){
				var options = {
					url : "<spring:url value='/mypage/service/insertGoodsComment' />",
					data : $("#popup_goods_comment_form").serialize(),
					done : function(data){
						alert("<spring:message code='front.web.view.goods.comment.msg.result.insert' />");
						
						// 상품평 등록 CallBack 함수 호출 : cbGoodsCommentReg();
						<c:out value="${param.callBackFnc}" />();
						// 상품평 등록 팝업 닫기: popupGoodsCommentReg
						pop.close("<c:out value="${param.popId}" />");
					}
				};
				ajax.call(options);
			}
		}
	}
	
	/*
	 * 상품평가 수정
	 */
	function updateGoodsComment(){
		if(inquiryValidate.all()){
			if(confirm("<spring:message code='front.web.view.common.msg.confirm.update' />")){
				var options = {
					url : "<spring:url value='/mypage/service/updateGoodsComment' />",
					data : $("#popup_goods_comment_form").serialize(),
					done : function(data){
						alert("<spring:message code='front.web.view.goods.comment.msg.result.update' />");
						
						// 상품평 등록 CallBack 함수 호출 : cbGoodsCommentUpd();
						<c:out value="${param.callBackFnc}" />();
						// 상품평 등록 팝업 닫기: popupGoodsCommentReg
						pop.close("<c:out value="${param.popId}" />");
					}
				};
				ajax.call(options);
			}
		}
	}
	
	// 첨부된 이미지 갯수
	var imgIdx = 0;
	
	// 파일 찾기
	function imageUpload () {
		if ($('li[id^="imageArea_"]').length >= 5) {
			alert("이미지 첨부는 최대 5개까지 가능합니다");
			return false;
		}
		
		// 상품평 수정인 경우, 첨부된 이미지 카운트를 설정
		if ($("#popup_goods_comment_goods_estm_no").val() != "") {
			imgIdx = $("#last_img_seq").val();
		}
		
		// 파일 추가
		fileUpload.image(resultImage);
	}
	
	// 이미지 업로드 결과
	function resultImage (file ) {
		imgIdx++;
		var addHtml = "\
			<li id='imageArea_"+imgIdx+"'>\
				<div class='add_img'>\
				<img name='goodsCommentImgPathView' src='/common/imageView.do?filePath=" + file.filePath +"' alt='상품명' />\
				</div>\
				<a href='#' class='btn_file_del' onclick='deleteImage(\"R\", "+imgIdx+"); return false;'>\
					<img src='${view.imgComPath}/common/btn_delete.gif' alt='첨부 이미지 삭제' />\
				</a>\
				<input type='hidden' name='imgPath' value='"+file.filePath+"' />\
			</li>";
			
		$("#add_image_list").append(addHtml);
	}
	
	// 첨부 이미지 삭제
	function deleteImage (type, imgIdx) {
		$("#imageArea_"+imgIdx).remove();
		
		// 상품평 수정인 경우, 삭제 대상 이미지 순번을 설정한다.
		if (type == "U") {
			$("#popup_goods_comment_form").append("<input type='hidden' name='deleteSeq' value='"+imgIdx+"' />");
		}
	}

</script>

<div id="pop_contents">
	<div class="mgl10 point3">
		<ul>
			<li>상품리뷰를 작성하시면 ${text }p를 적립금으로 드립니다. (포토상품리뷰는 ${photo }p 적립)</li>
			<li class="mgt5">상품을 취소/반품 하실 경우 지급된 적립금은 자동 회수됩니다.</li>
		</ul>
	</div>
	<form id="popup_goods_comment_form">
	<input type="hidden" id="popup_goods_comment_goods_id" 			name="goodsId" 		value="<c:out value='${param.goodsId}' />" />
	<input type="hidden" id="popup_goods_comment_goods_estm_no" 	name="goodsEstmNo" 	value="<c:out value='${param.goodsEstmNo}' />" />
	<input type="hidden" id="popup_goods_comment_goods_ord_no" 		name="ordNo" 		value="<c:out value='${param.ordNo}' />" />
	<input type="hidden" id="popup_goods_comment_goods_ord_dtl_seq" name="ordDtlSeq" 	value="<c:out value='${param.ordDtlSeq}' />" />
	<table class="table_type1 mgt20">
		<colgroup>
			<col style="width:130px" />
			<col style="width:auto" />
		</colgroup>
		<tbody>
			<tr>
				<td colspan="2">
					<div class="product_info_cell">
						<frame:goodsImage goodsId="${goods.goodsId}" seq="${goods.imgSeq}" imgPath="${goods.imgPath}" size="${ImageGoodsSize.SIZE_70.size}" />
						<div class="product_name">
							<a href="#">[<c:out value="${goods.bndNmKo}" />] <c:out value="${goods.goodsNm}" /></a> 
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" id="popup_goods_comment_ttl" name="ttl" title="제목" style="width:360px;" value="<c:out value="${goodsComment.ttl}" />">
					<div class="byte" id="popup_goods_comment_ttl_byte"></div>
					<div id="popup_goods_comment_ttl_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea class="textarea" id="popup_goods_comment_content" name="content" title="내용" style="width:360px;height:140px;"><c:out value="${goodsComment.content}" /></textarea>
					<div class="byte" id="popup_goods_comment_content_byte"></div>
					<div id="popup_goods_comment_content_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th>평점</th>
				<td>
					<select id="popup_goods_comment_estm_score_select" name="estmScore" class="select_star" title="별점 선택">
						<option value="5" <c:if test="${goodsComment.estmScore eq 5}">selected="selected"</c:if>>★★★★★</option>
						<option value="4" <c:if test="${goodsComment.estmScore eq 4}">selected="selected"</c:if>>★★★★☆</option>
						<option value="3" <c:if test="${goodsComment.estmScore eq 3}">selected="selected"</c:if>>★★★☆☆</option>
						<option value="2" <c:if test="${goodsComment.estmScore eq 2}">selected="selected"</c:if>>★★☆☆☆</option>
						<option value="1" <c:if test="${goodsComment.estmScore eq 1}">selected="selected"</c:if>>★☆☆☆☆</option>
					</select>
					<div id="popup_goods_comment_estm_score_select_error" class="note_b point1"></div>
				</td>
			</tr>
			<tr>
				<th>파일첨부</th>
				<td>
					<input type="text" class="input_style1 disabled" readonly="readonly" style="width:265px;" title="파일"  />
					<span class="btn_h30_type1 ui_add_file mgl6"><input type="file" class="input_file" title="파일첨부" onclick="imageUpload(); return false;"/> 파일찾기</span>
					<div class="mgt7 point3">
						파일크기는 1MB이하, JPG, PNG 또는 GIF형식의 파일만 가능합니다.
					</div>
					<div class="add_file_list_box">
						<ul id="add_image_list">
						<c:if test="${goodsComment ne null}">
							<!-- 상품평 수정 : 파일 첨부 영역 -->
							<c:forEach items="${goodsComment.goodsCommentImageList}" var="commentImage" varStatus="status">
							<c:if test="${commentImage.imgSeq ne null}">
							<li id="imageArea_${commentImage.imgSeq}">
								<div class="add_img">
									<img id="goodsCommentImgPathView" name="goodsCommentImgPathView" src="<c:out value='${view.imgDomain}' />${commentImage.imgPath}" alt="상품명" />
									<input type="hidden" id="goodsCommentImgPath" name="goodsCommentImgPath" value="" />
								</div>
								<a href="#" class="btn_file_del" onclick="deleteImage('U', ${commentImage.imgSeq}); return false;">
									<img src="${view.imgComPath}/common/btn_delete.gif" alt="첨부 이미지 삭제" />
								</a>
								<input type="hidden" name="imgSeq" value="<c:out value='${commentImage.imgSeq}' />" />
							</li>
							<!-- 마지막 이미지 순번을 저장. -->
							<c:if test="${status.last}">
								<input type="hidden" id="last_img_seq" value="<c:out value='${commentImage.imgSeq}' />" />
							</c:if>
							</c:if>
							</c:forEach>
						</c:if>
						<c:if test="${goodsComment eq null}">
							<!-- 상품평 등록 : 파일 첨부 영역 -->
						</c:if>
						</ul>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
	</form>
</div>
<!-- //팝업 내용 -->
<!-- 버튼 공간 -->
<div class="pop_btn_section">
	<c:if test="${goodsComment eq null}">
	<a href="#" onclick="insertGoodsComment();return false;" class="btn_pop_type1">등록</a>
	</c:if>
	<c:if test="${goodsComment ne null}">
	<a href="#" onclick="updateGoodsComment('<c:out value="${goodsComment.goodsEstmNo}" />');return false;" class="btn_pop_type1">수정</a>
	</c:if>
	<a href="#" onclick="pop.close('<c:out value="${param.popId}" />');return false;" class="btn_pop_type2 mgl6">취소</a>
</div>
<!-- //버튼 공간 -->
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>

<script type="text/javascript">

	$(document).ready(function(){
	}); // End Ready

	$(function() {
		// 페이지 클릭 이벤트
		$("#goods_inquiry_list_page a").click(function(){

			var page =$(this).children("span").html();
			$("#goods_inquiry_list_search_page").val(page);
			loadGoodsInquiry();
			
			return false;
		});

	});

	/*
	 * 상품문의 화면 재조회
	 */
	function loadGoodsInquiry(){
		ajax.load("goods_inquiry_area", "/goods/indexGoodsInquiryList", $("#goods_inquiry_list_form").serializeJson());
	}

	/*
	 * 상품 문의 등록 팝업
	 */
	function openPopGoodsInquiryReg(){
		
		var options = {
			url : "/goods/popupGoodsInquiryReg",
			params : {goodsId : '<c:out value="${so.goodsId}" />'},
			width : 700,
			height: 604,
			callBackFnc : "cbGoodsInquiryReg",
			modal : true
		};
		
		pop.open("popupGoodsInquiryReg", options);	
		
		
	}
	
	/*
	 * 상품문의 등록 CallBack
	 */
	function cbGoodsInquiryReg(data){
		$("#goods_inquiry_list_search_page").val("1");
		loadGoodsInquiry();
	}
	
	/*
	 * 상품문의 삭제
	 */
	function deleteGoodsInquiry(goodsIqrNo){
		
		if(confirm("<spring:message code='front.web.view.common.msg.confirm.delete' />")){
			var options = {
				url : "<spring:url value='/goods/deleteGoodsInquiry' />",
				data : {goodsIqrNo : goodsIqrNo},
				done : function(data){
					alert("<spring:message code='front.web.view.common.msg.result.delete' />");
					$("#goods_inquiry_list_search_page").val("1");
					loadGoodsInquiry();
				}
			};
			ajax.call(options);
		}
	}
	
	function fnShowAnswer(self,target){
		if(!$(self).hasClass('on')){
			$('.show_answer').removeClass('on');
			$(self).addClass('on');
			$('.'+target).hide();
			$(self).parents('tr').next('.'+target).show();
		}else{
			$(self).removeClass('on');
			$(self).parents('tr').next('.'+target).hide();
		}
	}

	
</script>

<h3 class="sub_title1">상품문의 (<c:out value='${so.totalCount}' />)</h3>
<ul class="ul_list_type2 mgb15 mgt_10">
	<li>구매한 상품의 취소/반품/교환은 마이페이지에서 즉시 신청이 가능합니다.</li>
	<li>상품문의를 통한 취소나 환불, 교환, 반품 신청은 처리되지 않습니다.</li>
	<li>본 상품과 관련되지 않은 내용이나 비방, 홍보글, 도배글, 개인정보가 포함된 글은 예고 없이 삭제됩니다.</li>
	<li>홈페이지 오류/장애 등 관련 문의는 1:1문의를 이용해주세요.</li>
	<li>문의 내용에 전화번호, 이름, 주소, 이메일 등 개인정보를 남기시면 타인에 의해 도용될 수 있으니 절대 남기지 말아주세요.</li>
</ul>
<div class="btn_abs">
	<a href="#" onclick="openPopGoodsInquiryReg();return false;" class="btn_h30_type3">상품문의하기</a>
	<a href="/customer/inquiry/indexRequest" onclick="#" class="btn_h30_type4">1:1 문의하기</a>
</div>
<div class="reply_list_wrap">
	<form id="goods_inquiry_list_form">
	<input type="hidden" id="goods_inquiry_list_search_page" name="page" value="<c:out value="${so.page}" />" />
	<input type="hidden" id="goods_inquiry_list_search_goods_id" name="goodsId" value="<c:out value="${so.goodsId}" />" />
	<table class="reply_list1">
		<caption>상품문의 글 목록</caption>
		<colgroup>
			<col style="width:140px;" />
			<col style="width:auto;" />
			<col style="width:160px;" />
		</colgroup>
		<tbody>
		<c:if test="${goodsInquiryList eq '[]'}">
			<tr>
				<td colspan="3" class="nodata">문의하신 내역이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${goodsInquiryList ne '[]'}">
		<c:forEach items="${goodsInquiryList}" var="goodsInquiry">
			<tr class="tr_question">
				<td class="t_right"><span class="point3"><c:out value="${goodsInquiry.iqrStatNm }" /></span></td>
				<td class="t_left">
					<c:choose>
						<c:when test="${session.mbrNo ne goodsInquiry.eqrrMbrNo and goodsInquiry.hiddenYn eq 'Y'}">
							<img alt="secret" src="/_images/common/icon_key.png"><span style="padding-left:6px;">비밀글입니다.</span>
						</c:when>
						<c:otherwise>
							<a href="javascript:void(0);" class="show_answer" onclick="fnShowAnswer(this,'tr_answer');return false;"><c:out value='${goodsInquiry.iqrTtl}' /></a>
						</c:otherwise>
					</c:choose>
					<c:if test="${session.mbrNo eq goodsInquiry.eqrrMbrNo and goodsInquiry.goodsIqrStatCd eq FrontWebConstants.GOODS_IQR_STAT_10}">
					<a href="javascript:void(0);" onclick="deleteGoodsInquiry('<c:out value='${goodsInquiry.goodsIqrNo}' />');return false;" class="btn_icon" title="글삭제"><img src="<c:out value='${view.imgPath}' />/common/btn_delete_icon.gif" alt="삭제" /></a>
					</c:if>
				</td>
				<td>
					<div class="u_id"><frame:secret data="${goodsInquiry.eqrrId}" /></div>
					<div class="date">(<frame:timestamp date="${goodsInquiry.sysRegDtm}" dType="H" />)</div>
				</td>
			</tr>
			<tr class="tr_answer">
				<td>&nbsp;</td>
				<td>
				<div class="question_sec">
					<frame:content data='${goodsInquiry.iqrContent}' />
				</div>
				<c:if test="${goodsInquiry.goodsIqrStatCd eq FrontWebConstants.GOODS_IQR_STAT_20}">
				<div class="answer_sec">
					<c:if test="${goodsInquiry.usrGrpCd eq FrontWebConstants.USR_GRP_10}">
						[관리자] <br/>
					</c:if>
					<c:if test="${goodsInquiry.usrGrpCd eq FrontWebConstants.USR_GRP_20}">
						[판매자] <br/>
					</c:if>
					<% pageContext.setAttribute("newLineChar", "\n"); %>
					<c:out value='${goodsInquiry.rplContentHeader}' /><br>
					${fn:replace(goodsInquiry.rplContent,newLineChar, '<br>')}<br>
					<c:out value='${goodsInquiry.rplContentFooter}' /><br>
				</div>
				</c:if>
				</td>
				<td>&nbsp;</td>
			</tr>
		</c:forEach>
		</c:if>
		</tbody>
	</table>
	</form>
</div>

<frame:listPage recordPerPage="${so.rows}" currentPage="${so.page}" totalRecord="${so.totalCount}" indexPerPage="10" id="goods_inquiry_list_page" />
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %> 
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<script type="text/javascript">

	$(document).ready(function(){
		var popYn = "${popYn}";
		if(popYn){
			ui.popLayer.open("popRevCom");
		}
		
		
		// 페이지 클릭 이벤트
		$("#goods_comment_list_page a").click(function(){
			var page =$(this).children("span").html();
			$("#goods_comment_list_search_page").val(page);
			loadGoodsComment();
			return false;
		});
		
		// 문의제목 선택시 상세내용 펼침
		var v_index = null;
		$(".info").each(function(index) {
			$(this).click(function() {				
				if (v_index == (index)){
					$(".comment_detail:eq("+index+")").toggle();
					v_index = null;
				} else {
					if ( v_index == null ){
						$(".comment_detail:eq("+index+")").toggle();
					} else {
						$(".comment_detail:eq("+v_index+")").toggle();
						$(".comment_detail:eq("+index+")").toggle();
					}
					v_index = (index);
				}
				return false;	
			});
		});
		
	}); // End Ready

	/*
	 * 작성가능한 상품평 화면 재조회
	 */
	function loadGoodsComment(){
		$("#goods_comment_list_form").attr("target", "_self");
		$("#goods_comment_list_form").attr("action", "/mypage/service/indexGoodsCommentList");
		$("#goods_comment_list_form").submit();
	}
	
	/*
	 * 상품평 수정 팝업 호출
	 */
	function openPopGoodsCommentUpd(sGoodsId, sGoodsEstmNo){
		var options = {
			url : "/mypage/service/popupGoodsCommentReg",
			params : {goodsId : sGoodsId, goodsEstmNo : sGoodsEstmNo},
			width : 580,
			height: 598,
			callBackFnc : "cbGoodsCommentUpd",
			modal : true
		};
		pop.open("popupGoodsCommentReg", options);	
	}
	
	/*
	 * 상품평 수정 CallBack
	 */
	function cbGoodsCommentUpd(data){
		$("#goods_comment_list_search_page").val("1");
		loadGoodsComment();
	}
	
	/*
	 * 상품평 삭제
	 */
	function deleteGoodsComment(sGoodsEstmNo){
		if(confirm("<spring:message code='front.web.view.common.msg.confirm.delete' />")){
			var options = {
				url : "<spring:url value='/mypage/service/deleteGoodsComment' />",
				data : {goodsEstmNo : sGoodsEstmNo},
				done : function(data){
					alert("<spring:message code='front.web.view.goods.comment.msg.result.delete' />");
					
					$("#goods_comment_list_search_page").val("1");
					loadGoodsComment();
				}
			};
			ajax.call(options);
		}
	}
	
	$(function() {

	});
	
	/**********************************************************************
	 * 기간별 검색조건 관련 함수 Start
	 ***********************************************************************/
	 
	// Calendar 생성
	$(function() {
		calendar.range("start_dt", "end_dt", {yearRange : 'c-10:c'});
	});
	
	// 기간선택 시 날짜 설정
	function searchPeriod(period) {
		$("input[name=period]").val(period);
		calendar.autoRange("start_dt", "end_dt", period);
		searchList();
	}
	
	// 날짜 조회 버튼 선택
	function searchDate(period) {
		$("input[name=period]").val("");
		searchList();
	}
	
	// 조회
	function searchList() {
		var startDt = new Date($("#start_dt").val());
		var endDt = new Date($("#end_dt").val());
		
		var diff = endDt.getTime() - startDt.getTime(); 
		
		if ( 365 < Math.floor(diff/(1000*60*60*24)) ) {
			alert("조회기간은 최대 12개월까지 설정가능 합니다.");
			return;
		}
		
		$("#goods_comment_list_search_page").val("1");// 페이지 번호 초기화
		$("#goods_comment_list_form").attr("target", "_self");
		$("#goods_comment_list_form").attr("action", "/mypage/service/indexGoodsCommentList");
		$("#goods_comment_list_form").submit();
	}
	
	/**********************************************************************
	 * 기간별 검색조건 관련 함수 End
	 ***********************************************************************/


</script>

<div class="box_title_area">
	<h3>상품 리뷰 관리</h3>
	<div class="sub_text2">구매하신 상품리뷰를 등록/조회하실 수 있습니다.</div>
</div>

<!-- 탭 -->
<div class="tab_menu01 length5s mgt10">
	<ul>
		<li><a href="/mypage/service/indexGoodsComment">리뷰 작성</a></li>
		<li class="on"><a href="/mypage/service/indexGoodsCommentList">리뷰 수정/보기</a></li>
	</ul>
</div>

<!-- 기간별 조회 -->
<div class="order_lookup_box border_none mgt10">
	<form id="goods_comment_list_form">
	<input type="hidden" id="goods_comment_list_search_page" name="page" value="<c:out value="${paging.page}" />" />
	<dl>
		<dt>기간별 조회</dt>
		<dd>
			<div class="btn_period_group">
				<a href="#" class="btn_period <c:if test="${goodsCommentSO.period eq '1'}">on</c:if>" onclick="searchPeriod(1);return false;">1개월</a>
				<a href="#" class="btn_period <c:if test="${goodsCommentSO.period eq '3'}">on</c:if>" onclick="searchPeriod(3);return false;">3개월</a>
				<a href="#" class="btn_period <c:if test="${goodsCommentSO.period eq '6'}">on</c:if>" onclick="searchPeriod(6);return false;">6개월</a>
				<a href="#" class="btn_period <c:if test="${goodsCommentSO.period eq '12'}">on</c:if>" onclick="searchPeriod(12);return false;">12개월</a>
				<input type="hidden" name="period" value="<c:out value="${goodsCommentSO.period}" />" />
			</div>
		</dd>
	</dl>
	<dl class="mgl20">
		<dt>날짜조회</dt>
		<dd>
			<span class="datepicker_wrap">
				<input type="text" readonly="readonly" class="datepicker" id="start_dt" name="sysRegDtmStart" value="<frame:timestamp date="${goodsCommentSO.sysRegDtmStart}" dType="H" />" title="날짜" />
			</span>
			-
			<span class="datepicker_wrap">
				<input type="text" readonly="readonly" class="datepicker" id="end_dt" name="sysRegDtmEnd" value="<frame:timestamp date="${goodsCommentSO.sysRegDtmEnd}" dType="H" />" title="날짜" />
			</span>
		</dd>
	</dl>
	<a href="#" onclick="searchDate();return false;" class="btn_h25_type1 mgl10">조회</a>
	</form>
</div>

<!-- 상품평 -->
<div class="review_detail_view mgt10">
	<ul class="list_wrap">
		<c:if test="${goodsCommentList eq '[]'}">
		<li class="list_item t_center pdt50 pdb50">
			등록된 리뷰가 없습니다.
		</li>
		</c:if>
		<c:if test="${goodsCommentList ne '[]'}">
		<c:forEach items="${goodsCommentList}" var="comment">
		<li class="list_item">
			<div class="subject_section">
				<div class="product_info_cell">
					<a href="/goods/indexGoodsDetail?goodsId=<c:out value="${comment.goodsId}"/>" >
						<frame:goodsImage goodsId="${comment.goodsId}" seq="${comment.goodsImgSeq}" imgPath="${comment.goodsImgPath}" size="${ImageGoodsSize.SIZE_70.size}" />
					</a>
					<div class="product_name">
						<a href="/goods/indexGoodsDetail?goodsId=<c:out value="${comment.goodsId}"/>" >
							[<c:out value='${comment.bndNmKo}' />] <c:out value='${comment.goodsNm}' />
						</a> 
						<div class="pdt15">
							<a class="info"><strong><c:out value='${comment.ttl}' /></strong></a>
						</div>	
					</div>
				</div>
				<div class="abs">
					<div class="star_point<c:out value='${comment.estmScore}' />"></div>
					<div class="date"><frame:timestamp date="${comment.sysRegDtm}" dType="H" /></div>
				</div>
			</div>
		</li>
		<li class="list_item comment_detail" style="display: none">
			<div class="contents_section">
				<frame:content data='${comment.content}' />
				<c:if test="${comment.imgRegYn eq 'Y'}">
				<c:forEach items="${comment.goodsCommentImageList}" var="image">
				<img src="<c:out value='${view.imgDomain}' />${image.imgPath}" alt="" />
				</c:forEach>
				</c:if>
				<div class="btn_section mgt18">
					<a href="#" onclick="openPopGoodsCommentUpd('${comment.goodsId}','${comment.goodsEstmNo}');return false;" class="btn_pop_type1">수정</a>
					<%-- <a href="#" onclick="deleteGoodsComment('${comment.goodsEstmNo}');return false;" class="btn_pop_type2 mgl6">삭제</a> --%>
				</div>
			</div>
		</li>
		</c:forEach>
		</c:if>
	</ul>
</div>
<!-- //상품평 -->

<!-- 페이징 -->
<frame:listPage recordPerPage="${paging.rows}" currentPage="${paging.page}" totalRecord="${paging.totalRecord}" indexPerPage="10" id="goods_comment_list_page" />
<!-- 페이징 -->

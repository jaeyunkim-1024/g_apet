<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<%@ page import="framework.common.enums.ImageGoodsSize" %>

<script type="text/javascript">

	$(document).ready(function(){

		// 페이지 클릭 이벤트
		$("#goods_inquiry_list_page a").click(function(){
			var page =$(this).children("span").html();
			$("#goods_inquiry_list_search_page").val(page);
			loadGoodsInquiry();
			return false;
		});
		
		// 문의제목 선택시 상세내용 펼침
		var v_index = null;
		$(".td_inquiry_title > .qa").each(function(index) {
			$(this).click(function() {				
				if (v_index == (index)){
					$(".tr_answer:eq("+index+")").toggle();
					v_index = null;
				} else {
					if ( v_index == null ){
						$(".tr_answer:eq("+index+")").toggle();
					} else {
						$(".tr_answer:eq("+v_index+")").toggle();
						$(".tr_answer:eq("+index+")").toggle();
					}
					v_index = (index);
				}
				return false;	
			});
		});
		
	}); // End Ready
	
	/*
	 * 상품문의 화면 재조회
	 */
	function loadGoodsInquiry(){
		$("#goods_inquiry_list_form").attr("target", "_self");
		$("#goods_inquiry_list_form").attr("action", "/mypage/service/indexGoodsInquiryList");
		$("#goods_inquiry_list_form").submit();
	}
	/* function loadGoodsInquiry(){
		ajax.load("goods_inquiry_area", "/goods/indexGoodsInquiryList", $("#goods_inquiry_list_form").serializeJson());
	} */
	
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

</script>

<div class="box_title_area">
	<h3>상품문의 관리</h3>
	<div class="sub_text2">
		상품페이지에 문의하신 질문에 대한 답변을 확인하실 수 있습니다.
	</div>
</div>

<!-- 상품문의 목록 -->
<div>
	<table class="table_cartlist1">
		<caption>상품문의</caption>
		<colgroup>
			<col style="width:15%">
			<col style="width:70px">
			<col style="width:auto">
			<col style="width:20%">  
			<col style="width:20%">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">등록일시</th> 
				<th scope="col" colspan="2">상품명</th>
				<th scope="col">문의제목</th>
				<th scope="col">처리상태</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${goodsInquiry eq '[]'}">
			<tr>
				<td colspan="5" class="nodata">문의하신 내역이 없습니다.</td>
			</tr>
			</c:if>
			<c:if test="${goodsInquiry ne '[]'}">
			<c:forEach items="${goodsInquiry}" var="inquiry">
			<tr>
				<td>
					<div><frame:timestamp date="${inquiry.sysRegDtm}" dType="H" tType="HS" /></div>
					<!-- TODO : 날짜 포멧 확인 필요 (1라인 or 2라인)
					<div>2016-01-07</div>
					<div>14:23:26</div>
					-->
				</td>
				<td class="img_cell v_top">
					<a href="/goods/indexGoodsDetail?goodsId=<c:out value="${inquiry.goodsId}"/>" >
						<frame:goodsImage goodsId="${inquiry.goodsId}" seq="${inquiry.imgSeq}" imgPath="${inquiry.imgPath}" size="${ImageGoodsSize.SIZE_70.size}" />
					</a>
				</td>
				<td class="t_left v_top">
					<div class="product_name">
						<c:if test="${inquiry.bndNo ne null}">
						<a href="/goods/indexGoodsDetail?goodsId=<c:out value="${inquiry.goodsId}"/>" >
							[<c:out value="${inquiry.bndNmKo}" />] <c:out value="${inquiry.goodsNm}" />
						</a> 
						</c:if>
						<c:if test="${inquiry.bndNo eq null}">
						<a href="/goods/indexGoodsDetail?goodsId=<c:out value="${inquiry.goodsId}"/>" >
							<c:out value="${inquiry.goodsNm}" />
						</a> 
						</c:if>
						
						<!-- TODO : 상품옵션 및 상품 가격 표시 여부 확인필요
						<div class="product_option">
							<span>샌드블루/화이트</span>
						</div>
						<div class="product_cost">
							<span>66,000원</span> / <span>1개</span>
						</div>
						-->
					</div>
				</td>
				<td class="td_inquiry_title"><a href="#" class="qa"><c:out value="${inquiry.iqrTtl}" /></a></td>
				<td>
					<div><frame:codeValue items="${goodsIqrStatCdList}" dtlCd="${inquiry.goodsIqrStatCd}"/></div>
					<c:if test="${inquiry.goodsIqrStatCd eq FrontWebConstants.GOODS_IQR_STAT_20}">
					<div>(<frame:timestamp date="${inquiry.rplDtm}" dType="H" />)</div>
					</c:if>
				</td>
			</tr>
			
			<tr class="tr_answer" style="display:none">
				<td colspan="5" class="t_left">
					<div class="q_sec">
						<div class="user">문의자 <span><c:out value="${inquiry.eqrrNm}" /></span></div>
						<div class="cont">
							<frame:content data="${inquiry.iqrContent}" />
						</div>
						<c:if test="${inquiry.goodsIqrStatCd eq FrontWebConstants.GOODS_IQR_STAT_10}">
						<div class="a_bnt">
							<a href="#" onclick="deleteGoodsInquiry('${inquiry.goodsIqrNo}');return false;" class="btn_h20_type6 fix_w65">삭제하기</a>
						</div>
						</c:if>
					</div>
					<c:if test="${inquiry.goodsIqrStatCd eq FrontWebConstants.GOODS_IQR_STAT_20}">
					<div class="a_sec">
						<c:if test="${inquiry.usrGrpCd eq FrontWebConstants.USR_GRP_10}">
							[관리자] <br/>
						</c:if>
						<c:if test="${inquiry.usrGrpCd eq FrontWebConstants.USR_GRP_20}">
							[판매자] <br/>
						</c:if>
						<!-- TODO : 답변 포멧 확인 필요 ( 답변자명, 답변내용, 답변일시 등등 ) -->
						<c:out value="${inquiry.rplContent}" />
					</div>
					</c:if>
				</td>
			</tr>
			</c:forEach>
			</c:if>
		</tbody>
	</table>
	
	<!-- 페이징 -->
	<form id="goods_inquiry_list_form">
	<input type="hidden" id="goods_inquiry_list_search_page" name="page" value="<c:out value="${paging.page}" />" />
	<frame:listPage recordPerPage="${paging.rows}" currentPage="${paging.page}" totalRecord="${paging.totalRecord}" indexPerPage="10" id="goods_inquiry_list_page" />
	</form>
	<!-- 페이징 -->
	
</div>
<!-- //상품문의 목록 -->
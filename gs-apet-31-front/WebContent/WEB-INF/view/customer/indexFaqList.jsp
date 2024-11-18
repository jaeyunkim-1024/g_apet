<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="/WEB-INF/tld/frame.tld" prefix="frame" %> 

<%--
  Class Name  : indexFaqList.jsp 
  Description : FAQ 목록
  Author      : 박현용
  Since       : 2016.03.02
  Modification Information 
	          수정일         	     수정자             수정내용
    ----------  -------  -------------------------------------------
    2016.03.02    박현용            최초 작성
    2016.04.06    신남원           자주하는질문 TOP10 설정
--%>

<script type="text/javascript">

	$(document).ready(function(){
	}); // End Ready

	$(function() {
		var v_index_top = null;
		var v_index = null;
		
		// 페이지 클릭 이벤트
		$("#faq_list_page a").click(function(){
			var page = $(this).children("span").html();
			$("#faq_list_search_page").val(page);
			reloadFaqList();
			
			return false;
		});
		
		/*
		 * Faq 타이틀 클릭 이벤트
		 */
		$(".info").each(function(index) {
			$(this).click(function() {
				if (v_index == (index)){
					$("tr#faq_ttl:eq("+v_index+")").toggleClass("togglecolor");
					$("tr#faq_content:eq("+v_index+")").toggle();
					v_index = null;
				} else {
					if ( v_index != null ){
						$("tr#faq_ttl:eq("+v_index+")").toggleClass("togglecolor");
						$("tr#faq_content:eq("+v_index+")").toggle();
					}
					$("tr#faq_ttl:eq("+(index)+")").toggleClass("togglecolor");
					$("tr#faq_content:eq("+(index)+")").toggle();
					v_index = (index);
				}
				
				return false;
			});
		});
		
		/*
		 * Faq Top 10 타이틀 클릭 이벤트
		 */		
		$(".infos").each(function(index) {
			$(this).click(function() {
				if (v_index_top == (index)){
					$(".faq_cont01:eq("+v_index_top+")").toggle();
					v_index_top = null;
				} else {
					if ( v_index_top != null ){
						$(".faq_cont01:eq("+v_index_top+")").toggle();
					}
					$(".faq_cont01:eq("+index+")").toggle();
					v_index_top = (index);
				}
				
				return false;	
			});
		});
		
		// 고객센터 메인에서 FAQ글번호 선택으로 인한 진입시, 선택한 공지사항 글번호 상세 보기
		if ($("#hdn_lettNo").val() != "") {
			$("tr#faq_ttl:eq("+($("#hdn_lettNo").val())+")").toggleClass("togglecolor");
			$("tr#faq_content:eq("+($("#hdn_lettNo").val())+")").toggle();
			v_index = $("#hdn_lettNo").val();
		}

	});
	
	/*
	 * FAQ 화면 탭 선택
	*/
	function selectFaqGb(faqGbCd){
		$("#faq_list_search_faq_gb_cd").val(faqGbCd);
		$("#faq_list_search_page").val("1");
		reloadFaqList();
	}
	
	/*
	 * FAQ 화면 리로딩
	 */
	function reloadFaqList(){
		$("#faq_list_form").attr("target", "_self");
		$("#faq_list_form").attr("action", "/customer/faq/indexFaqList");
		$("#faq_list_form").submit();
		
	}

</script>

<div class="box_title_area">
	<h3>FAQ</h3>
	<div class="sub_text2">찾으시는 질문이 없으시면 <a href="/customer/inquiry/indexRequest">1:1 문의</a>를 이용해 주세요.</div>
</div>

<div class="tab_menu02">
	<ul>
		<c:if test="${so.bbsGbNo eq null}">
		<li class="on">
		</c:if>
		<c:if test="${so.bbsGbNo ne null}">
		<li>
		</c:if>
			<a href="#" onclick="selectFaqGb('');return false;">자주 찾는 FAQ</a>
		</li>
		<c:forEach items="${faqGbList}" var="faqGb" varStatus="idx">
		<c:if test="${faqGb.bbsGbNo eq so.bbsGbNo}">
		<li class="on">
		</c:if>
		<c:if test="${faqGb.bbsGbNo ne so.bbsGbNo}">
		<li>
		</c:if>
			<a href="#" onclick="selectFaqGb('<c:out value="${faqGb.bbsGbNo}" />');return false;"><c:out value="${faqGb.bbsGbNm}" /></a>
		</li>
		</c:forEach>
	</ul>
</div>

<form id="faq_list_form">
<input type="hidden" id="faq_list_search_page" name="page" value="<c:out value="${so.page}" />" />
<input type="hidden" id="faq_list_search_faq_gb_cd" name="bbsGbNo" value="<c:out value="${so.bbsGbNo}" />" />
<input type="hidden" id="hdn_lettNo" value="" />
<table class="table_cartlist1 mgt20">
	<caption>위시리스트내역</caption>
	<colgroup>
		<col style="width:13%">	
		<col style="width:16%">
		<col style="width:auto">
	</colgroup>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">항목</th>
			<th scope="col">질문</th>
		</tr>
	</thead>
	<tbody>
	
		<c:if test="${faqList eq '[]'}">
		<tr>
			<td colspan="3">FAQ가 없습니다.</td>
		</tr>
		</c:if>

		<c:if test="${faqList ne '[]'}">
			<c:forEach items="${faqList}" var="faq" varStatus="status">
			<tr id="faq_ttl">
				<td class="v_top">${((so.page == 0?1:so.page)-1)*10+status.count}</td>									
				<td class="v_top">
					<c:forEach items="${faqGbList}" var="faqGb" varStatus="idx">
					<c:if test="${faq.bbsGbNo eq faqGb.bbsGbNo }">
						<c:out value='${faqGb.bbsGbNm}'/>
					</c:if>
					</c:forEach>
				</td>
				<td class="t_left v_top"><a class="info"><c:out value="${faq.ttl}" /></a></td>
			</tr>
			<tr id="faq_content" class="bcont">
				<td colspan="3" class="t_left v_top">
					${faq.content}
				</td>
			</tr>
			<c:if test="${so.lettNo eq faq.lettNo}">
				<script>
					// 고객센터 메인에서 FAQ글번호 선택으로 인한 진입시, 선택한 글번호 변수에 저장
					$("#hdn_lettNo").val("<c:out value='${status.index}' />");
				</script>
			</c:if>
			</c:forEach>
		</c:if>
	</tbody>
</table>
</form>

<frame:listPage recordPerPage="${so.rows}" currentPage="${so.page}" totalRecord="${so.totalCount}" indexPerPage="10" id="faq_list_page" />
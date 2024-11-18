<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript">
	$(function (){
		$('#pdRevCnt').text('${commentTotalCnt}');
	})
</script>
<!-- 후기 -->
<c:if test="${not empty commentTotalCnt && commentTotalCnt != 0 }">
	<div class="starpoint">
		<span class="stars sm p_${fn:replace(scoreList.estmAvgStar, ".", "_") }"></span>
		<span class="point"><fmt:formatNumber value="${not empty scoreList.estmAvg ? scoreList.estmAvg/2 : 0}" pattern="0.0"/></span>
		<span class="revew"><a href="javascript:;" class="lk" onclick="$('i[name=pdRevCnt]').trigger('click'); return false;" name="pdRevCnt">(${not empty commentTotalCnt ? commentTotalCnt : 0})</a></span>
	</div>
</c:if>
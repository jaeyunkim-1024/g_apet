<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">

</script>
<c:forEach items="${listPaks}" var="obj" varStatus="status">
<li>
	<div class="gdset bundl">
		<div class="num">상품 ${obj.rownum}</div>
		<div class="thum">
			<a href="javascript:" class="pic">
<%--				<img class="img" src="${obj.imgPath}" alt="이미지">--%>
<!-- 				직사각형을 정사각형으로 변경함. frontConstants.IMG_OPT_QRY_340 >>>> frontConstants.IMG_OPT_QRY_500 -->
				<img class="img" src="${frame:optImagePath( obj.imgPath , frontConstants.IMG_OPT_QRY_500 )}"  />
			</a>
		</div>
		<div class="boxs">
			<div class="tit"><a href="javascript:" class="lk">${obj.cstrtShowNm}</a></div>
			<a href="javascript:" class="inf">
				<span class="prc"><em class="p">${obj.saleAmt}</em><i class="w">원</i></span>
				<span class="pct"><em class="n">90</em><i class="w">%</i></span>
			</a>
			<div class="bts btnSet">
				<button type="button" class="btn c sm">자세히</button>
				<button type="button" class="btn c sm" id="btnPakSelected${obj.itemNo }" onclick="fnOption.exPaksAdd('btn', ${obj.rownum }, '${obj.itemNo }', '${obj.saleAmt}', '${obj.imgPath}', '${obj.cstrtShowNm}', '${obj.subGoodsId}')">상품선택</button>
			</div>
		</div>
	</div>
</li>

</c:forEach>
<%--	<div class="gdset bundl">--%>
<%--		<div class="num">상품 1</div>--%>
<%--		<div class="thum">--%>
<%--			<a href="javascript:;" class="pic"><img class="img" src="../../_images/_temp/goods_1.jpg" alt="이미지"></a>--%>
<%--		</div>--%>
<%--		<div class="boxs">--%>
<%--			<div class="tit"><a href="javascript:;" class="lk">${obj.cstrtShowNm}</a></div>--%>
<%--			<a href="javascript:;" class="inf">--%>
<%--				<span class="prc"><em class="p">23,000</em><i class="w">원</i></span>--%>
<%--				<span class="pct"><em class="n">90</em><i class="w">%</i></span>--%>
<%--			</a>--%>
<%--			<div class="bts btnSet">--%>
<%--				<button type="button" class="btn c sm">자세히</button>--%>
<%--				<button type="button" class="btn c sm">상품선택</button>--%>
<%--			</div>--%>
<%--		</div>--%>
<%--	</div>--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
	<meta http-equiv="Content-type"			content="text/html; charset=UTF-8"/>
	<meta property="og:title"				content="${title}" />
	<meta property="og:description"			content="${desc}"/>
	<meta property="og:image"				content="${not empty img ? img : '/_images/common/aboutpet_logo@2x.png'}"/>
	<meta property="og:site_name"			content="${site_name}"/>
	<meta property="og:type"				content="website" />
	<meta property="og:locale:alternate"	content="ko_KR" />
</head>
<body>
	<!-- app interface --> 
	<script type="text/javascript" src="/_script/app-interface.js"></script>
	<script type="text/javascript">
	var url = "";
	//펫로그
	<c:if test="${not empty pageGb and pageGb eq 'petLog'}">
		var shareGb = "${shareGb}";
		var shareNo = "${shareNo}";
		url = "${view.stDomain}/log/indexPetLogDetailView?petLogNo="+shareNo+"&shareAcc=Y";
		if( shareGb !== undefined && shareGb == 'M'){
			var shareCodes = shareNo.split('_');
			url = "${view.stDomain}/log/indexMyPetLog/"+ shareCodes[0] + "?mbrNo=" + shareCodes[1];
		}
	</c:if>
	//이벤트
	<c:if test="${not empty pageGb and pageGb eq 'event'}">	
		var eventNo = "${eventNo}";
		url = window.location.protocol + "//" + window.location.host + "/event/detail?eventNo="+eventNo;
	</c:if>
	//펫샵 상품 상세
	<c:if test="${not empty pageGb and pageGb eq 'goodsDetail'}">
		var goodsId = "${goodsId}";
		url = "${view.stDomain}/goods/indexGoodsDetail?goodsId=" + goodsId;
	</c:if>
	//펫샵 브랜드관
	<c:if test="${not empty pageGb and pageGb eq 'brand'}">
		var bndNo = "${bndNo}";
		var cateCdL = "${cateCdL}";
		url = "${view.stDomain}/brand/indexBrandDetail?bndNo="+bndNo+"&cateCdL=" +cateCdL;
	</c:if>
	//친구 초대하기
	<c:if test="${not empty pageGb and pageGb eq 'invite'}">
		var frdRcomKey = "${frdRcomKey}";
		url = "${view.stDomain}/welcome?frdRcomKey="+ frdRcomKey;
	</c:if>
	//기획전
	<c:if test="${not empty pageGb and pageGb eq 'exhibit'}">
		var exhbtNo = "${exhbtNo}";
		var dispClsfNo = "${dispClsfNo}";
		url = "${view.stDomain}/event/indexExhibitionDetail?exhbtNo="+exhbtNo+"&dispClsfNo="+dispClsfNo;
	</c:if>
	location.href = url;

	</script>
</body>
</html>

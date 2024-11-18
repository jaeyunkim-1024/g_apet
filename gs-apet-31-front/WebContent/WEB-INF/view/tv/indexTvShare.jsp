<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
	<meta http-equiv="Content-type" 		content="text/html; charset=UTF-8"/>
	<meta property="og:title" 				content="${title}" />
	<meta property="og:description" 		content="${desc}"/>
	<meta property="og:image" 				content="${img}"/>
	<meta property="og:site_name" 			content="${site_name}"/>
	<meta property="og:type" 				content="website" />
	<meta property="og:locale:alternate" 	content="ko_KR" />
</head>
<body>
	<!-- app interface --> 
	<script type="text/javascript" src="/_script/app-interface.js"></script>
	<script type="text/javascript">
		var url = "";
		
		if( "${gubun}" == "petschool" ){
			url = "/tv/school/indexTvDetail?vdId=${vdId}&linkYn=Y";
			location.href = url;
		}else{
			if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true"){ //APP
				url = "${view.stDomain}/tv/series/indexTvDetail?vdId=${vdId}&sortCd=${sortCd}&listGb=${listGb}";
				
				// 데이터 세팅
				toNativeData.func = "onNewPage";
				toNativeData.type = "TV";
				toNativeData.url = url;
				// APP 호출
				toNative(toNativeData);
				
				history.go(-1);
			}else{
				url = "/tv/series/indexTvDetail?vdId=${vdId}&sortCd=${sortCd}&listGb=${listGb}";
				location.href = url;
			}
		}
	</script>
</body>
</html>

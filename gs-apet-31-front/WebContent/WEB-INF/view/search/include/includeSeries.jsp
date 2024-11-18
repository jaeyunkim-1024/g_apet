<c:forEach items="${result.seriesList}" var="series" varStatus="idx" >
<li class="scrhItem ts${series.sris_no}${series.sesn_no}" data-srisno="${series.sris_no}" data-srisnm="${series.sesn_no}" onclick="searchResult.goSeries('${series.sris_no}','${series.sesn_no}');">
	<p class="img"><img src="${fn:indexOf(series.sris_img, 'cdn.ntruss.com') > -1 ? series.sris_img : frame:optImagePath(series.sris_img, frontConstants.IMG_OPT_QRY_710)}" alt="${series.sris_img}" onerror="this.src='../../_images/common/icon-img-profile-default-m@2x.png'"></p>
	<div class="txt">
		<p class="t1">${fn:replace(series.sris_nm, 'amp;', '')}</p>
		<p class="t2">${series.sesn_nm}</p>
	</div> 
</li>
</c:forEach>		

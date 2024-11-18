<script type="text/javascript">
	var rcntList = null;// 최근본 상품 호출여부 판단(petshopShortCut.jsp 에서 사용)
	
	var reqUri = '${session.reqUri}';
	var thisPath =  window.location.pathname + window.location.search;
	$(document).ready(function(){
		// 최근본 상품
		$.ajax({
			type: "POST",
			data : {mbrNo : '${session.mbrNo}'},
			url: "/shop/getOneGoodsDtlInqrHist",
			beforeSend : function name() {
				rcntList = '';
			},
			success: function (result) {
				$(".rcntImgArea").data('loading','ing');
				var thisImgPath = '';
				var thisHtml = 	'<a class="box" href="javascript:void(0);" onclick="location.href=\'/mypage/indexRecentViews/\'" data-content="" data-url="/mypage/indexRecentViews/">';
				thisHtml += 	'<b class="t">최근본상품</b><div class="thumb" ><div class="pic">';
				if(result.dtlHist == undefined || result.dtlHist.imgPath == null){
					thisHtml += 	'<img src="/_images/common/img-rc-vw-gds.jpg" alt="" class="img rcntImgArea">';
				}else{
					var imgDomain = "<spring:eval expression="@bizConfig['naver.cloud.optimizer.domain']" />" ;
					thisImgPath = imgDomain + result.dtlHist.imgPath + "?type=f&w=70&h=70&quality=90&align=4";
					thisHtml += 	'<img src="'+thisImgPath+'" alt="'+result.dtlHist.goodsNm+'" class="img rcntImgArea">';
				}
				thisHtml += '</div></div></a>';
				$("#rcntThumbArea").html(thisHtml);
				if($("#contents .rcntImgArea").length > 0 && thisImgPath != ''){	// 샵메인 최근본상품에 적용
					$("#contents .rcntImgArea").attr("src",thisImgPath);
					$("#contents .rcntImgArea").attr("alt",result.dtlHist.goodsNm);
					rcntList = 'done';
				}else{
					rcntList = 'fail';
				}
			},
			error : function() {
				rcntList = 'fail';
			}
		});  
		
		var cateCdL = "${so.cateCdL}"	// 12564
		
 		$.each($('li[id^=shortCut] a'), function(){
 			var thisHrefUrl = $(this).data("url").replace(location.origin,"");
 			if(thisPath.indexOf(thisHrefUrl) > -1 && thisPath.indexOf("shortCutYn=Y") > -1){
 				$(this).parent('li').attr("class", "active");
 				if($(this).attr("onclick").indexOf("/event/indexSpecialExhibitionZone") != -1 
 						&& $(this).attr("onclick").indexOf('exhbtNo='+'${so.exhbtNo}') == -1){
	 					 $(this).parent('li').attr("class", "");
	 			}
	 		}else if(thisPath.indexOf("/shop/indexBestGoodsList") > -1 && thisHrefUrl.indexOf("/shop/indexBestGoodsList") > -1) {
	 			// 베스트 전체보기로 진입했을 경우
	 			$(this).parent('li').attr("class", "active");
	 		}
 		});
		
		showMyLnbList(cateCdL);
		$("#lnb").show();
		$("#contents").show();
		$("li[id^=menu_tab_]").one('click', function(){
			var dispClsfNo = $(this).data("dispclsfno");
			sendDispClsfNo(dispClsfNo);
		});
		
		// 카테고리 버튼 열기/닫기 버튼 쿠키 저장
		$("li[id^=tab_category_]").children('a').click(function(){
			var categoryClass = $(this).parent().attr("class");
			if(categoryClass == 'open') {
				$.cookie('categoryYn', 'N', {path:'/'});
			}else{
				$.cookie('categoryYn', 'Y', {path:'/'});
			}
		});
	});
	
	function loadCornerGoodsList(dispClsfNo, dispCornNo, dispClsfCornNo, dispType, timeDeal) {
		var petNo = $("#petNo_rec").val();
		var form = document.createElement("form");
		document.body.appendChild(form);
		var url = "/shop/indexGoodsList";
		form.setAttribute("method", "GET");
		form.setAttribute("action", url);

		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "dispClsfNo");
		hiddenField.setAttribute("value", dispClsfNo);
		form.appendChild(hiddenField);
		document.body.appendChild(form);
		hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "dispCornNo");
		hiddenField.setAttribute("value", dispCornNo);
		form.appendChild(hiddenField);
		document.body.appendChild(form);
		hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "dispClsfCornNo");
		hiddenField.setAttribute("value", dispClsfCornNo);
		form.appendChild(hiddenField);
		document.body.appendChild(form);
		hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "dispType");
		hiddenField.setAttribute("value", dispType);
		form.appendChild(hiddenField);
		document.body.appendChild(form);
		if(timeDeal != undefined) {
			hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "timeDeal");
			hiddenField.setAttribute("value", timeDeal);
			form.appendChild(hiddenField);
			document.body.appendChild(form);
		}
		if(dispType == '${frontConstants.GOODS_MAIN_DISP_TYPE_RCOM}') {
			hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "petNo");
			hiddenField.setAttribute("value", petNo);
			form.appendChild(hiddenField);
			document.body.appendChild(form);
		}
		form.submit();
	}
	
	function setCateList(dispClsfNo, upDispClsfNo, scateYN) {
		var dispClsfNo2 ='';	
		if('${frontConstants.PETSHOP_DOG_DISP_CLSF_NO}' == upDispClsfNo ) {			// 강아지
			dispClsfNo2 = '${frontConstants.PETSHOP_MAIN_DOG_DISP_CLSF_NO}'
		} else if('${frontConstants.PETSHOP_CAT_DISP_CLSF_NO}' == upDispClsfNo ) {	// 고양이
			dispClsfNo2 = '${frontConstants.PETSHOP_MAIN_CAT_DISP_CLSF_NO}'
		} else if('${frontConstants.PETSHOP_FISH_DISP_CLSF_NO}' == upDispClsfNo ) {	// 관상어
			dispClsfNo2 = '${frontConstants.PETSHOP_MAIN_FISH_DISP_CLSF_NO}'
		} else if('${frontConstants.PETSHOP_ANIMAL_DISP_CLSF_NO}' == upDispClsfNo ) {	// 소동물
			dispClsfNo2 = '${frontConstants.PETSHOP_MAIN_ANIMAL_DISP_CLSF_NO}'
		}
		
		var url = "/shop/indexCategory?dispClsfNo="+dispClsfNo+"&dispClsfNo2="+dispClsfNo2+"&cateCdL="+upDispClsfNo+"&cateCdM="+dispClsfNo;
		var cateCdL = $("#cateCdL").val();
		var cateCdM = $("#cateCdM").val();
		if(scateYN == 'Y') {
// 			if(dispClsfNo == '') {
// 				url = "/shop/indexCategory?dispClsfNo="+dispClsfNo+"&lnbDispClsfNo="+lnbDispClsfNo+"&cateCdL="+cateCdL+"&cateCdM="+cateCdM;
// 			}else {
// 				url = "/shop/indexCategory?dispClsfNo="+dispClsfNo+"&lnbDispClsfNo="+lnbDispClsfNo+"&cateCdL="+cateCdL+"&cateCdM="+cateCdM;
// 			}
			url = "/shop/indexCategory?dispClsfNo="+dispClsfNo+"&dispClsfNo2="+dispClsfNo2+"&cateCdL="+cateCdL+"&cateCdM="+cateCdM;
		}
		location.href = url;
	}
	
	// 분류번호 보내기
	function sendDispClsfNo(dispClsfNo){
		var lnbDispClsfNo = dispClsfNo
		var cateCdL = dispClsfNo
		if('${frontConstants.PETSHOP_DOG_DISP_CLSF_NO}' == dispClsfNo ) {			// 강아지
			lnbDispClsfNo = '${frontConstants.PETSHOP_MAIN_DOG_DISP_CLSF_NO}'
		} else if('${frontConstants.PETSHOP_CAT_DISP_CLSF_NO}' == dispClsfNo ) {	// 고양이
			lnbDispClsfNo = '${frontConstants.PETSHOP_MAIN_CAT_DISP_CLSF_NO}'
		} else if('${frontConstants.PETSHOP_FISH_DISP_CLSF_NO}' == dispClsfNo ) {	// 관상어
			lnbDispClsfNo = '${frontConstants.PETSHOP_MAIN_FISH_DISP_CLSF_NO}'
		} else if('${frontConstants.PETSHOP_ANIMAL_DISP_CLSF_NO}' == dispClsfNo ) {	// 소동물
			lnbDispClsfNo = '${frontConstants.PETSHOP_MAIN_ANIMAL_DISP_CLSF_NO}'
		}
		var form = document.createElement("form");
		document.body.appendChild(form);
		form.setAttribute("method", "POST");
		var url = "/shop/home";
		// 바로가기 영역, 샵홈 상품목록, 펫샵메인 -> 메인으로 이동
		if(thisPath.indexOf("shortCutYn=Y") == -1 && thisPath.indexOf("&dispCornNo=") == -1 && thisPath.indexOf("/shop/home") == -1 && thisPath.indexOf("/event/indexExhibitionZone") == -1 && thisPath.indexOf("/event/indexSpecialExhibitionZone") == -1 && thisPath.indexOf("/shop/indexBestGoodsList")) {
			form.setAttribute("method", "GET");
			url = reqUri;
		}
		
		var hiddenField = document.createElement('input');
		hiddenField.setAttribute('type', 'hidden');
		hiddenField.setAttribute('name', 'lnbDispClsfNo');
		hiddenField.setAttribute('value', lnbDispClsfNo);	// 300000173
		form.appendChild(hiddenField);
		
		if(thisPath.indexOf("/shop/indexCategory") > -1) {
			hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "cateCdL");
			hiddenField.setAttribute("value", cateCdL);	// 12564
			form.appendChild(hiddenField);
			document.body.appendChild(form);
		}else if(thisPath.indexOf("/brand/indexBrandDetail") > -1) { 
			var bndNo = $("input[id=bndNo]").val();
			hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "bndNo");
			hiddenField.setAttribute("value", bndNo);
			form.appendChild(hiddenField);
			document.body.appendChild(form);
		}
		
		form.setAttribute("action", url);
		document.body.appendChild(form);
		form.submit();
	}
	
	// 나의 반려 동물로 LNB 셋팅
	function showMyLnbList(lnbDispClsfNo) {
		$("li[id^=tab_category_]").hide();
		$("#b_tag_"+lnbDispClsfNo).click();
		$("#tab_category_"+lnbDispClsfNo).show();
	}
	
</script>
<nav class="lnb shop" id="lnb">
	<div class="inr">
		<nav class="menushop">
			<button type="button" class="bt st"><span class="t"></span></button>
			<div class="list">
				<ul class="menu">
					<c:forEach var="allCategorylist" items="${view.displayCategoryList}"  varStatus="categoryIndex" >
					<c:if test="${allCategorylist.dispLvl == 1 && allCategorylist.subDispCateList != null}">
					<li id="menu_tab_${allCategorylist.dispClsfNo }" class="${empty so.lnbDispClsfNo ? allCategorylist.dispPriorRank == 1 ? 'active' : '' : allCategorylist.dispClsfNo == so.lnbDispClsfNo ? 'active' : ''}" data-dispClsfNo="${allCategorylist.dispClsfNo }">
						<a class="bt" href="javascript:;"><b id="b_tag_${allCategorylist.dispClsfNo}" class="t">${allCategorylist.dispClsfNm }</b></a>
					</li>
					</c:if>
					</c:forEach>
				</ul>
			</div>
		</nav>
		<div class="shopCate">
			<ul class="menu">
<!-- 				<li id="categoryStart"></li> -->
				<c:forEach items="${view.displayShortCutList}" var="detail"  varStatus="idx">
					<c:if test="${!(fn:indexOf(view.deviceGb eq 'PC' ? detail.bnrLinkUrl :detail.bnrMobileLinkUrl, '/shop/indexCategory?cateCdL') > -1)}">
						<li id="shortCut${idx.count}">
							<a class="bt" href="javascript:void(0);" onclick="goLink('${view.deviceGb eq 'PC' ? detail.bnrLinkUrl :detail.bnrMobileLinkUrl}',true)" data-url = "${view.deviceGb eq 'PC' ? detail.bnrLinkUrl :detail.bnrMobileLinkUrl}";>
								<b class="t">${detail.bnrText}</b>
								<c:if test="${detail.bnrText.toUpperCase() == 'LIVE'}">
								<span id="liveCheck" class="${detail.liveYn == 'Y' ? 'beg_live on' : ''}"></span>
								</c:if>
							</a>
						</li>
					</c:if>
				</c:forEach>
				<c:forEach var="allCategorylist" items="${view.displayCategoryList}"  varStatus="categoryIndex" >
					<c:if test="${allCategorylist.dispLvl == 1 && allCategorylist.subDispCateList != null}">
						<c:set var="categoryCount" value="${categoryCount+1 }"/>
						<c:if test="${allCategorylist.dispClsfNo == so.cateCdL}">
							<c:set var="categoryYn" value="${cookie.categoryYn.value}"/>
							<li class="${categoryYn == 'Y' ? 'open' : categoryYn == 'N' ? '' : 'open'}"id="tab_category_${allCategorylist.dispClsfNo}">
								<a class="bt tog" href="javascript:;"><b class="t">카테고리</b></a>
								<ul class="sm">
									<c:forEach var="subCategorylist" items="${allCategorylist.subDispCateList}"  varStatus="categoryIndex" >
									<c:if test="${subCategorylist.dispLvl == 2 && allCategorylist.dispClsfNo == subCategorylist.upDispClsfNo}">
										<li class="${(fn:indexOf(requestScope['javax.servlet.forward.query_string'] ,'shortCutYn=Y') == -1)? (((session.reqUri ne '/shop/indexNewCategory' && session.reqUri ne '/brand/indexBrandDetail') && subCategorylist.dispClsfNo == so.cateCdM) ? 'active' : '') :''}"><a class="bt" href="javascript:setCateList('${subCategorylist.dispClsfNo}', '${subCategorylist.upDispClsfNo}', 'N');"><b class="t">${subCategorylist.dispClsfNm }</b></a></li>
									</c:if>
									</c:forEach>
								</ul>
							</li>
						</c:if>
					</c:if>
				</c:forEach>
			</ul>
		</div>
		<div class="gdrecent" id="rcntThumbArea">
		</div>
	</div>
</nav>
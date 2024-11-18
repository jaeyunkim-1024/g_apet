<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<tiles:insertDefinition name="common">
<tiles:putAttribute name="script.inline">
<script type="text/javascript" src="/_script/corner.js" ></script>
<script type="text/javascript">

function exhbtChange(dispClsfNo){
	if('${frontConstants.PETSHOP_DOG_DISP_CLSF_NO}' == dispClsfNo ) {			// 강아지
		dispClsfNo = '${frontConstants.PETSHOP_MAIN_DOG_DISP_CLSF_NO}'
	} else if('${frontConstants.PETSHOP_CAT_DISP_CLSF_NO}' == dispClsfNo ) {	// 고양이
		dispClsfNo = '${frontConstants.PETSHOP_MAIN_CAT_DISP_CLSF_NO}'
	} else if('${frontConstants.PETSHOP_FISH_DISP_CLSF_NO}' == dispClsfNo ) {	// 관상어
		dispClsfNo = '${frontConstants.PETSHOP_MAIN_FISH_DISP_CLSF_NO}'
	} else if('${frontConstants.PETSHOP_ANIMAL_DISP_CLSF_NO}' == dispClsfNo ) {	// 소동물
		dispClsfNo = '${frontConstants.PETSHOP_MAIN_ANIMAL_DISP_CLSF_NO}'
	}
	
	 var form = document.createElement("form");
	 document.body.appendChild(form);
	 var url = "/shop/home/";
	 form.setAttribute("method", "POST");
	 form.setAttribute("action", url);
	
	 var hiddenField = document.createElement("input");
	 hiddenField.setAttribute("type", "hidden");
	 hiddenField.setAttribute("name", "lnbDispClsfNo");
	 hiddenField.setAttribute("value", dispClsfNo);
	 form.appendChild(hiddenField);
	 document.body.appendChild(form);
	 form.submit();
}

function tagDetail(tagNm, tagNo){
	var url = "/shop/indexPetShopTagGoods?tagNm="+tagNm+"&tags="+tagNo;
	location.href = url;
}

//공유하기
function shareBtn(url, exhbtNm, exhbtNo){
	userActionLog(exhbtNo, "share");
	
	if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
		toNativeData.func = "onShare";
		toNativeData.link = url;
		toNativeData.image =  $(".pthum .pic .img").eq(0).attr("src");
		toNativeData.subject = exhbtNm
		toNative(toNativeData);
	}else{
		
		var textarea = document.createElement("textarea");
		document.body.appendChild(textarea);
		textarea.value = url;
		textarea.select();
		document.execCommand('copy');
		document.body.removeChild(textarea);
		
		ui.toast($("#exhbtShare").attr("data-message"), {
			cls : "share",
			bot:70,
			sec:  3000 //사라지는 시간
		});
	}
}

function userActionLog(exhbtNo, action){
    var mbrNo = "${session.mbrNo}";
    if (mbrNo != "${frontConstants.NO_MEMBER_NO}") {
        $.ajax({
            type: 'POST'
            , url : "/common/sendSearchEngineEvent"
            , dataType: 'json'
            , data : {
                "logGb" : "ACTION"
                , "mbr_no" : mbrNo
                , "section" : "shop"
                , "content_id" : exhbtNo
                , "action" : action
                , "url" : document.location.href
                , "targetUrl" : document.location.href
            }
        });
    }
}

function goodsDetail(exhbNo, upDispClsfNo){
	var dispClsfNo;
	if('${frontConstants.PETSHOP_DOG_DISP_CLSF_NO}' == upDispClsfNo ) {			// 강아지
			upDispClsfNo = '${frontConstants.PETSHOP_MAIN_DOG_DISP_CLSF_NO}'
		} else if('${frontConstants.PETSHOP_CAT_DISP_CLSF_NO}' == upDispClsfNo ) {	// 고양이
			upDispClsfNo = '${frontConstants.PETSHOP_MAIN_CAT_DISP_CLSF_NO}'
		} else if('${frontConstants.PETSHOP_FISH_DISP_CLSF_NO}' == upDispClsfNo ) {	// 관상어
			upDispClsfNo = '${frontConstants.PETSHOP_MAIN_FISH_DISP_CLSF_NO}'
		} else if('${frontConstants.PETSHOP_ANIMAL_DISP_CLSF_NO}' == upDispClsfNo ) {	// 소동물
			upDispClsfNo = '${frontConstants.PETSHOP_MAIN_ANIMAL_DISP_CLSF_NO}'
		}
	
	var url = "/event/indexExhibitionDetail?exhbtNo="+exhbNo+"&dispClsfNo="+upDispClsfNo;
	location.href = url;
}

</script>
</tiles:putAttribute>
<tiles:putAttribute name="content">
<main class="container page shop dm plans dtl" id="container">
	<div class="inr">
		<!-- 본문 -->
		<div class="contents" id="contents">
			<nav class="location">
				<ul class="loc">
					<li>
						<a href="javascript:;" class="bt st"><spring:message code='front.web.view.common.title.dog' /></a>
						<ul class="menu">
							<c:forEach items="${view.displayCategoryList}" var="category">
								<c:if test="${category.level eq 1}">
									<li class="${category.dispClsfNo eq so.cateCdL ? 'active' : ''}">
										<a class="bt" href="javascript:exhbtChange('${category.dispClsfNo}');">${category.pathNm}</a>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</li>
					<li>
						<a href="javascript:;" class="bt st"><spring:message code='front.web.view.common.title.exhibition' /></a>
						<ul class="menu" id="exhbNmMenu">
							<c:forEach items="${view.displayShortCutList}" var="detail">
								<li class="${fn:indexOf(detail.bnrLinkUrl, '/event/indexExhibitionZone') > -1 ? 'active' : ''}">
									<a class="bt" href="javascript:void(0);" onclick="goLink('${view.deviceGb eq 'PC' ? detail.bnrLinkUrl :detail.bnrMobileLinkUrl}', true)">
										${detail.bnrText}
									</a>
								</li>
							</c:forEach>
						</ul>
					</li>
				</ul>
				<!-- ui.gnb.location.set(); -->
			</nav>
			<section class="sect dm pbanr">
				<div class="pthum">
					<a href="javascript:;" class="pic">
						<img class="img mo" src="${frame:optImagePath(exhbt.bnrMoImgPath, frontConstants.IMG_OPT_QRY_744)}" alt="<spring:message code='front.web.view.common.msg.image' />">
						<img class="img pc" src="${frame:optImagePath(exhbt.bnrImgPath, frontConstants.IMG_OPT_QRY_690)}" alt="<spring:message code='front.web.view.common.msg.image' />">
					</a>
				</div> 
			</section>
			<section class="sect dm plans">
				<div class="tag k0426">
					<div class="tagbox">
						<c:forEach items="${tag}" var="tag">
							<a class="tg" href="javascript:tagDetail('${tag.tagNm}', '${tag.tagNo}');">#${tag.tagNm}</a> 
						</c:forEach>
					</div>
						<div class="share">
							<a href="javascript:shareBtn('${shareUrl}', '${exhbt.exhbtNm}', '${exhbt.exhbtNo}')" data-clipboard-text="${shareUrl}" data-url="${shareUrl}" class="bt shr" id="exhbtShare" data-message="<spring:message code='front.web.view.common.msg.copy.url' />">
								<spring:message code='front.web.view.common.button.share' />
							</a>
						</div>
				</div>
				<div class="selplan">
					<button type="button" class="btn md btPlanMore" onclick="ui.popBot.open('popPlanMore' ,{'pop':'true'});");"><spring:message code='front.web.view.common.button.exhibition.view.more' /></button>
					<article class="popBot popPlanMore pc" id="popPlanMore">
						<div class="pbd">
							<div class="phd">
								<div class="in">
									<h1 class="tit"><spring:message code='front.web.view.common.title.exhibition' /></h1>
									<button type="button" class="btnPopClose"><spring:message code='front.web.view.common.close.btn' /></button>
								</div>
							</div>
							<div class="pct">
								<main class="poptents">
									<ul class="menu">
									<c:forEach items="${exhbtName}" var="exhbtName">
										<c:if test="${exhbtName.exhbtNo !=  so.exhbtNo}">
											<li><a href="javascript:goodsDetail(${exhbtName.exhbtNo}, ${exhbtName.upDispClsfNo});" class="bt" onclick="ui.popBot.close('popPlanMore');">${exhbtName.exhbtNm}</a></li>
										</c:if>
									</c:forEach>
									</ul>
								</main>
							</div>
						</div>
					</article>
				</div>
				<div class="pndtls">
					<ul class="list">
						<c:forEach items="${exhGoods}" var="goods">
						<li>
							<div class="gdset defgd">
								<div class="thum">
									<a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="pic">
									<img class="img" src="${frame:optImagePath(goods.imgPath, frontConstants.IMG_OPT_QRY_510)}" alt="<spring:message code='front.web.view.common.msg.image' />" onerror="this.src='../../_images/common/img_default_thumbnail_2@2x.png'">
										<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_10}">
											<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleStop.title' /></em></div>
										</c:if>
										<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_20}">
											<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleEnd.title' /></em></div>
										</c:if>
										<c:if test="${goods.salePsbCd == frontConstants.SALE_PSB_30}">
											<div class="soldouts"><em class="ts"><spring:message code='front.web.view.common.goods.saleSoldOut.title' /></em></div>
										</c:if>
									</a>
									
									<button type="button" class="bt zzim ${goods.interestYn == 'Y' ? 'on' : ''}" data-target="goods" data-action="interest" data-yn="N" data-goods-id="${goods.goodsId}"><spring:message code='front.web.view.brand.button.wishBrand' /></button>
									
								</div>
								<div class="boxs">
									<div class="tit"><a href="/goods/indexGoodsDetail?goodsId=${goods.goodsId}" class="lk">${goods.goodsNm}</a></div>
									<a href="#" class="inf">
										<span class="prc"><em class="p"><frame:num data="${goods.saleAmt}"/></em><i class="w"><spring:message code='front.web.view.common.moneyUnit.title' /></i></span>
										<c:if test="${goods.orgSaleAmt > goods.saleAmt and ((goods.orgSaleAmt - goods.saleAmt)/goods.orgSaleAmt * 100) >= 1 }">
											<span class="pct"><em class="n"><fmt:parseNumber value="${100-((goods.foSaleAmt * 100) / goods.orgSaleAmt)}" integerOnly="true"/></em><i class="w">%</i></span>
										</c:if>
									</a>
								</div>
							</div>
						</li>
					</c:forEach>
					</ul>
				</div>
			</section>
		</div>
	</div>
</main>

<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
	<jsp:param name="floating" value=""  />
</jsp:include>
		
</tiles:putAttribute>
</tiles:insertDefinition>

<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<style>
    html {overflow:hidden;}
    /*별 Start*/
	.rating[data-rating="5.5"] .rating__item:nth-child(-n+5):after, .rating[data-rating="5.0"] .rating__item:nth-child(-n+5):after, .rating[data-rating="4.5"] .rating__item:nth-child(-n+4):after, .rating[data-rating="4.0"] .rating__item:nth-child(-n+4):after, .rating[data-rating="3.5"] .rating__item:nth-child(-n+3):after, .rating[data-rating="3.0"] .rating__item:nth-child(-n+3):after, .rating[data-rating="2.5"] .rating__item:nth-child(-n+2):after, .rating[data-rating="2.0"] .rating__item:nth-child(-n+2):after, .rating[data-rating="1.5"] .rating__item:nth-child(-n+1):after, .rating[data-rating="1.0"] .rating__item:nth-child(-n+1):after, .rating[data-rating="0.5"] .rating__item:nth-child(-n+0):after, .rating[data-rating="0"] .rating__item:nth-child(-n+0):after {
		content: "";
	}

	.rating[data-rating="5.5"] .rating__item:nth-child(6):after, .rating[data-rating="4.5"] .rating__item:nth-child(5):after, .rating[data-rating="3.5"] .rating__item:nth-child(4):after, .rating[data-rating="2.5"] .rating__item:nth-child(3):after, .rating[data-rating="1.5"] .rating__item:nth-child(2):after, .rating[data-rating="0.5"] .rating__item:nth-child(1):after {
		content: "";
	}

	.rating {
		margin: 0;
		padding: 0;
		display: flex;
		align-items: center;
		justify-content: flex-start;
		color: gold;
	}
	.rating__item {
		font-size: 24px;
		display: block;
		font-family: FontAwesome;
	}
	.rating__item::after {
		content: "";
	}
	/*별 End*/

	/* Slideshow container */
	.slideshow-container {
		max-width: 800px;
		position: relative;
		margin: auto;
		margin-bottom: 20px;
	}

	/* Hide the images by default */
	.mySlides {
		display: none;
	}

	/* Next & previous buttons */
	.prev, .next {
		cursor: pointer;
		position: absolute;
		top: 50%;
		width: auto;
		margin-top: -22px;
		padding: 16px;
		font-weight: bold;
		font-size: 30px;
		transition: 0.6s ease;
		border-radius: 0 3px 3px 0;
		user-select: none;
	}

	/* Position the "next button" to the right */
	.next {
		right: 0;
		border-radius: 3px 0 0 3px;
	}

	/* Caption text */
	.text {
		color: #f2f2f2;
		font-size: 15px;
		padding: 8px 12px;
		position: absolute;
		bottom: 8px;
		width: 100%;
		text-align: center;
	}

	/* Number text (1/3 etc) */
	.numbertext {
		color: #f2f2f2;
		font-size: 12px;
		padding: 8px 12px;
		position: absolute;
		top: 0;
	}

	/* The dots/bullets/indicators */
	.dot {
		cursor: pointer;
		height: 10px;
		width: 10px;
		margin: 0 1px;
		background-color: #bbb;
		border-radius: 50%;
		display: inline-block;
		transition: background-color 0.6s ease;
	}

	.active, .dot:hover {
		background-color: #717171;
	}

	/* Fading animation */
	.fade {
		-webkit-animation-name: fade;
		-webkit-animation-duration: 1.5s;
		animation-name: fade;
		animation-duration: 1.5s;
	}

	.center {text-align: center;}

    .pbt20 {
        padding-bottom: 20px
    }

	.pbt30 {
        padding-bottom: 30px
	}

	.mt10 {
        margin-top:10px;
	}

	.review-content {
        position: relative;
		width: 100%;
		/*height:420px;*/
		height:490px;
	}

	.review-scroll {
        height:100%;
        max-height:100%;
		overflow:auto;
		padding: 2px;
	}
	
	.imgRedius {
		width: 50px;
		height:50px;
		/*border-radius: 50px; !* 이미지 반크기만큼 반경을 잡기*!*/
		border: 1px solid gold;
		border-radius: 50px;
		moz-border-radius: 50px;
		khtml-border-radius: 50px;
		webkit-border-radius: 50px;
	}

</style>
<script type="text/javascript">
	$(document).ready(function() {
		var goodsBestYn = '${DetailPO.goodsBestYn}';
		var snctYn = '${goodsComment.snctYn}';
		console.log("goodsBestYn : " + goodsBestYn + ", snctYn : " + snctYn);
		$("#divBest").hide();
		$("#divDisp").hide();
		$("#divAlertMsg").hide();
		$("#rptpCont").hide();

		if(goodsBestYn == "Y") {
			$("#mngTitle").text("Best 설정 관리");
			$("#divBest").show();
		}else {
			$("#rptpCont").show();
			$("#mngTitle").text("노출관리");
			$("#divDisp").show();
			// $("#divAlertMsg").show(); // 기능 삭제로인해 숨김처리. 2020.01.08.
		}

		$("#snctRsn").attr("disabled", false);
		if(snctYn != "Y"){
			$("#snctRsn").attr("disabled", true);
		}

		$("input[name='popSnctYn']").click(function(){
			if ( $(this).prop('checked') ) {
				$(this).addClass("checked");
				$("#snctYn").val("Y");
				$("#snctRsn").attr("disabled", false);
			} else {
				$(this).removeClass("checked");
				$("#snctYn").val("N");
				$("#snctRsn").attr("disabled", true);
			}
		});
	});

	// 상품후기 저장
	function updateGoodsComment () {
		var sendData = $("#goodsCommentForm").serializeJson();
		
		messager.confirm("<spring:message code='column.common.confirm.update' />",function(r){
			if(r){
				var options = {
					url : "<spring:url value='/goods/goodsCommentDetailUpdate.do' />"
					, data : sendData
					, callBack : function(data ) {
						messager.alert("<spring:message code='column.common.edit.final_msg' />", "Info", "info");
						layer.close("goodsCommentDetailView");
						searchGoodsCommentList();
					}
				};
				ajax.call(options);
			}
		});
	}

	var slideIndex = 1;
	showSlides(slideIndex);

	// Next/previous controls
	function plusSlides(n) {
		showSlides(slideIndex += n);
	}

	// Thumbnail image controls
	function currentSlide(n) {
		showSlides(slideIndex = n);
	}

	function showSlides(n) {
		var i;
		var slides = document.getElementsByClassName("mySlides");
		if(slides.length > 0) {
			var dots = document.getElementsByClassName("dot");
			if (n > slides.length) {slideIndex = 1}
			if (n < 1) {slideIndex = slides.length}
			for (i = 0; i < slides.length; i++) {
				slides[i].style.display = "none";
			}
			for (i = 0; i < dots.length; i++) {
				dots[i].className = dots[i].className.replace(" active", "");
			}
			slides[slideIndex-1].style.display = "block";
			dots[slideIndex-1].className += " active";
		}
	}
</script>

<div>
	<div class="review-content mt10">
		<div class="review-scroll pbt20">
			<c:if test="${not empty goodsComment.goodsCommentImageList and fn:length(goodsComment.goodsCommentImageList) > 0}">
				<div class="slideshow-container">
					<!-- Slideshow container -->
					<div class="slideshow">
						<c:forEach items="${goodsComment.goodsCommentImageList}" var="img" varStatus="st">
							<div class="mySlides fade">
								<div class="numbertext">${st.count} / ${fn:length(goodsComment.goodsCommentImageList)}</div>
								<%-- <img src="<frame:imgUrl/>${img.imgPath}" style="width:100%;height: 350px;"> --%>
								<img src="${fn:indexOf(img.imgPath, 'cdn.ntruss.com') > -1 ? img.imgPath : frame:optImagePath(img.imgPath, adminConstants.IMG_OPT_QRY_560)}" style="width:100%;height: 350px;">									
							</div>
						</c:forEach>
						<br>
						<div class="center">
							<c:forEach items="${goodsComment.goodsCommentImageList}" var="img" varStatus="st">
								<span class="dot" onclick="currentSlide(${st.count})"></span>
							</c:forEach>
						</div>
						<!-- Next and previous buttons -->
						<c:if test="${not empty goodsComment.goodsCommentImageList and fn:length(goodsComment.goodsCommentImageList) > 1 }">
							<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
							<a class="next" onclick="plusSlides(1)">&#10095;</a>
						</c:if>
					</div>
				</div>
			</c:if>
			<div style="margin-left: 10px">
				<c:out value="${goodsComment.content}" />
				<table style="bottom: 5px;">
					<tbody>
					<tr style="height:25px;">
						<th style="vertical-align: center;horiz-align: center;text-align: center;">
							<%-- 아이콘 설정은 아이콘을 받으면 설정 할예정. --%>
							<img class="imgRedius" src="${fn:indexOf(goodsComment.prflImg, 'cdn.ntruss.com') > -1 ? goodsComment.prflImg : frame:optImagePath(goodsComment.prflImg, adminConstants.IMG_OPT_QRY_756)}" onerror="this.src='/images/noimage.png'" >
						</th>
						<td>
							<%-- <p>${goodsComment.estmId} | ${goodsComment.birth} --%>
							<p>${goodsComment.nickNm} / <fmt:formatDate value="${goodsComment.sysRegDtm}" pattern="yyyy.MM.dd"/></p>
							<c:if test="${not empty goodsComment.petNm}">
								<p>${goodsComment.petNm} | ${goodsComment.age} <spring:message code="column.petlog.age"/> | ${goodsComment.weight} <spring:message code="column.petlog.kg"/></p>
							</c:if>
						</td>
					</tr>
					</tbody>
				</table>
				<!-- 평가 -->
				<div class="rep_review mt10">
					<span class="review_point sp_detail">
						<i class="sp_detail point4"></i>
					</span>
					<ul class="rating" data-rating="${goodsComment.estmScore/2}">
						<li class="rating__item"></li>
						<li class="rating__item"></li>
						<li class="rating__item"></li>
						<li class="rating__item"></li>
						<li class="rating__item"></li>
					</ul>
				</div>
				<!-- 맛 만족, 유통기한, 가성비 표출 css 미적용 -->
				<br/>
				<table style="bottom: 5px;">
					<colgroup>
						<col style="width:150px;" />
						<col style="width:150px;" />
						<col style="width:150px;" />
						<col style="width:150px;" />
					</colgroup>
					<tbody>
					<c:forEach items="${goodsComment.goodsEstmQstVOList}" var="reply" varStatus="status">
						<c:if test="${status.index % 2 eq 0 }">
							<tr style="height:25px;">
						</c:if>
						<th>${reply.qstClsf}</th>
						<td>${reply.itemContent}</td>
						<c:if test="${status.count % 2 eq 0 }">
							</tr>
						</c:if>	
					</c:forEach>
					</tbody>
				</table>
				<br/>
			</div>
		</div>
	</div>
	
	<div id="rptpCont">
		<div class="panel-title">신고접수 내역</div>
		<table class="table_type1" >
			<colgroup>
				<col style="width:60px;"  />
				<col style="width:120px;" />
				<col style="width:100px;" />
				<col style="width:150px;" />
				<col />
			</colgroup>
			<thead>
				<tr>
					<th><spring:message code="column.goods.comment.no"/></th>
					<th><spring:message code="column.goods.comment.rptDtm"/></th>
					<th><spring:message code="column.goods.comment.mbrNo"/></th>
					<th><spring:message code="column.goods.comment.rptpRsnNm"/></th>
					<th><spring:message code="column.goods.comment.rptpContent"/></th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${fn:length(rptpRsnInfoListVO) eq 0}">
					<tr>
						<td colspan="5" class="center">접수된 내역이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${rptpRsnInfoListVO}" var="rptrRsnInfoList" varStatus="status">
					<tr>
						<td class="center">${fn:length(rptpRsnInfoListVO) - status.index}</td>
						<td class="center">${rptrRsnInfoList.sysRegDtm }</td>
						<td class="center">${rptrRsnInfoList.loginId }</td>
						<td class="center">${rptrRsnInfoList.rptpRsnNm }</td>
						<td class="center">${rptrRsnInfoList.rptpRsnContent }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<%-- <div class="panel-title">노출관리(${goodsComment.goodsId})</div> --%>
	<div class="panel-title" id="mngTitle">노출관리</div>
	<form id="goodsCommentForm" name="goodsCommentForm" method="post" >
		<input type="hidden" id="goodsEstmNo" name="goodsEstmNo" value="${DetailPO.goodsEstmNo }" />
		<input type="hidden" id="goodsBestYn" name="goodsBestYn" value="${DetailPO.goodsBestYn }" />
		<table class="table_type1" >
			<colgroup>
				<col style="width:100px;" />
				<col />
				<col style="width:100px;" />
				<col />
			</colgroup>
			<tbody>
				<tr id="divDisp">
					<!-- 전시여부 -->
					<th><spring:message code="column.goods.comment.display_used"/></th>
					<td colspan="3">
						<label class="fRadio"><input type="radio" name="dispYn" value="Y" <c:if test="${goodsComment.dispYn == 'Y'}">checked="checked"</c:if>>
							<span>노출</span>
						</label>
						<label class="fRadio"><input type="radio" name="dispYn" value="N" <c:if test="${goodsComment.dispYn == 'N' || empty goodsComment.dispYn}">checked="checked"</c:if>>
							<span>비노출</span>
						</label>
					</td>
					<!-- 제재 -->
					<%-- <th><spring:message code="column.goods.comment.display_snct_used"/></th>
					<td>
						<label class="fCheck"><input type="checkbox" name="popSnctYn" <c:if test="${goodsComment.snctYn == 'Y'}">checked="checked"</c:if>>
							<span>이동(숨김)</span></label>
						<input type="hidden" name="snctYn" id="snctYn" value="${goodsComment.snctYn }" />
					</td> --%>
				</tr>
				<tr id="divAlertMsg">
					<!-- 알림 메시지 -->
					<th scope="row"><spring:message code="column.goods.comment.alert_message" /></th>
					<td colspan="3" >
						<textarea rows="5" style="margin: 0px; width: 98%; height: 40px;" id="snctRsn" name="snctRsn" maxlength="300">${goodsComment.snctRsn}</textarea>
					</td>
				</tr>
				<tr id="divBest" style="bottom: 5px;">
					<!-- 베스트 설정 -->
					<th scope="row"><spring:message code="column.goods.comment.best_yn" /></th>
					<td colspan="3" >
						<label class="fRadio"><input type="radio" name="bestYn" value="Y" <c:if test="${goodsComment.bestYn == 'Y'}">checked="checked"</c:if>>
							<span>설정</span>
						</label>
						<label class="fRadio"><input type="radio" name="bestYn" value="N" <c:if test="${goodsComment.bestYn == 'N' || empty goodsComment.bestYn}">checked="checked"</c:if>>
							<span>해제</span>
						</label>
					</td>
				</tr>
			</tbody>
		</table>
	</form>

</div>
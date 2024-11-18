<script type="text/javascript">
	goodsComment.totalPageCount = ${so.totalPageCount};
	goodsComment.page = ${so.page};
	console.log(goodsComment.totalPageCount);
	console.log(goodsComment.page);
	if(goodsComment.totalPageCount == goodsComment.page){
		$("#cmtMoreDiv").hide();
	}else{
		$("#cmtMoreDiv").show();
	}
<c:if test="${empty vo}">
		//$('#commentListUl').html('<li style="text-align:center;">등록된 후기가 없습니다.</li>');
		//$("div[name=commentArea]").text("등록된 후기가 없습니다.");
		//$("div[name=commentArea]").css("text-align" , "center");
		if(goodsComment.totalPageCount == 1 && goodsComment.page== 1){
			$("#cmtMoreDiv").hide();
			$("#commentSoltArea").hide();
			$('#commentNodata').show();
			
			$(".btn[data-ui-tab-val=tab_rvt_b]").trigger('click');
			goodsComment.selectTab = "PLG";
		}
</c:if>
	
	/* $("span[name=commentAllCnt]").text('${not empty so.totalCount ? so.totalCount : 0} 건');
	$("a[name=pdRevCnt]").text('(${not empty so.totalCount ? so.totalCount : 0})');
	$("i[name=pdRevCnt]").text('${not empty so.totalCount ? so.totalCount : 0}'); */
</script>
<input type="hidden" id="norCommentCnt" value="${so.totalCount}" />
<c:forEach var="dataList" items="${vo}">
	<li>
		<div class="box" name="estmDataArea" data-goods-id="${dataList.goodsId }" data-goods-estm-no="${dataList.goodsEstmNo }" data-ord-no="${dataList.ordNo }" data-ord-dtl-seq="${dataList.ordDtlSeq }" >
			<div class="rhdt">
				<div class="tinfo">
					<span class="pic"><img src="${dataList.prflImg eq null or dataList.prflImg eq '' ? '../../_images/common/img-default-profile@2x.png' : frame:optImagePath( dataList.prflImg , frontConstants.IMG_OPT_QRY_794 )}" alt="사진" class="img" onerror="this.src='../../_images/common/img-default-profile@2x.png'"></span>
					<div class="def">
						<em class="dd ids">${not empty dataList.nickNm ? dataList.nickNm : dataList.loginId}</em>
						<em class="dd date"><fmt:formatDate value="${dataList.sysRegDtm }" pattern="yyyy.MM.dd"/> </em>
						<c:if test="${dataList.bestYn eq 'Y'}"><em class="ds best">BEST</em></c:if>
					<%-- <c:if test="${dataList.estmMbrNo eq session.mbrNo}"><em class="ds me">작성글</em></c:if> --%>
						<nav class="uidropmu dmenu">
							<button type="button" class="bt st gb">메뉴열기</button>
							<div class="list">
								<ul class="menu">
									<c:if test="${dataList.estmMbrNo eq session.mbrNo && dataList.estmMbrNo ne 0}">
										<li><button type="button" class="bt" onclick="goodsComment.reWriteGoodsComment(this)">수정</button></li>
										<c:if test="${not empty dataList.ordNo}">
											<li><button type="button" class="bt" onclick="goodsComment.deleteGoodsComment(this)">삭제</button></li>
										</c:if>
									</c:if>
									<c:if test="${dataList.estmMbrNo ne session.mbrNo || session.loginId eq null}">
										<li><button type="button" class="bt" onclick="goodsComment.commentReportPop(this)">신고</button></li>
									</c:if>
								</ul>
							</div>
						</nav>
					</div>
					<c:if test="${not empty dataList.petNm and dataList.mbrStatCd ne frontConstants.MBR_STAT_50}">
						<div class="spec"><em class="b">${dataList.petNm }
						<i class="g">${not empty dataList.petGdGbCd and dataList.petGdGbCd != "" ? (dataList.petGdGbCd eq frontConstants.PET_GD_GB_10 ? '(수컷)':'(암컷)'): ''}</i>
						</em> <em class="b">
						<c:if test="${not empty dataList.age && dataList.age != '0'}">
						${dataList.age }살
						</c:if>
						<c:if test="${!(not empty dataList.age) or dataList.age == '0'}">
						${dataList.month }개월
						</c:if>
						</em> <em class="b"><fmt:formatNumber value="${dataList.weight}" pattern="##.#"/>kg</em></div>
					</c:if>
				</div>
				<div class="hpset">
					<em class="htxt">도움이돼요</em>
					<button type="button" onclick="goodsComment.likeComment(this)" class="bt hlp ${dataList.rcomYn eq 'Y' ? 'me ' : ''} ${not empty dataList.likeCnt && dataList.likeCnt != 0 ? ' on':'' } ">
						<i class="n">${not empty dataList.likeCnt?dataList.likeCnt:0 }</i><b class="t">도움</b>
					</button>
				</div>
			</div>
			<div class="rcdt">
				<div class="stpnt starpoint">
					<span class='stars sm p_${fn:replace(((dataList.estmScore/2)+""), ".", "_") }'></span>
				</div>
				<ul class="satis">
					<c:forEach var="qstList" items="${dataList.goodsEstmQstVOList }">
					<li><span class="dt">${qstList.qstClsf }</span> <span class="dd">${qstList.itemContent }</span></li>
					</c:forEach>
				</ul>
				<div class="opts">
					${not empty dataList.attrVal ? dataList.attrVal : '' }
				</div>
				<div class="msgs">
<%-- 					${dataList.content } --%>
					${fn:replace(dataList.content,'\\r\\n',"<br/>")}
				</div>
				<div class="addpic">
					<ul class="pics">
						<c:forEach var="imgList" items="${dataList.goodsCommentImageList}">
							<li><a href="javascript:;" class="pic"><img class="img" src="${fn:indexOf(imgList.imgPath,'http') > -1 ? imgList.imgPath : frame:optImagePath(imgList.imgPath, frontConstants.IMG_OPT_QRY_794)}" alt="첨부이미지"></a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</li>
</c:forEach>
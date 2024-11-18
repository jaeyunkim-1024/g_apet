<script>
//펫로그 후기 상세
function petlogReviewDetail(petLogNo , tag){
		var options = {
			url : "<spring:url value='/goods/indexPetLogCommentDetailList' />"
			, type : "POST"
			, dataType : "html"
			, data : {
					index : $(tag).data("idx")
					, dispClsfCornNo : $("#dispClsfCornNo").val()
					, petDetailNo : petLogNo
					, petLogNo : petLogNo
					, totalCount : '${fn:length(cornerList.popPetLogList)}'
			}
			, done : function(result){
				$(".popLogRv").remove();
 				$("#petLogPop").append(result);
				var selectIndex = $("#petLogDetails").children('li[id^=petLogDetails_]').index($("#petLogDetails_"+ petLogNo));
// 				ui.popLayer.open('popLogRv');
				
				/* $.extend(ui.shop.revLogSet.opt, {
					initialSlide : selectIndex,
					pagination: {
						el: '.petLogCommentCount',
						type: 'custom',
						renderCustom : function(swiper , current , total){
							var html = '';
							current = current < 0 ? current : 1;
							html += '<i class="n" id="listIndex">'+current+'</i>/<i class="s">'+total+'</i>';
							$(".petLogCommentCount").html(html);
						}
					}
				}) */
				setTimeout(function(){
	 				ui.shop.revLog.using();
	 				ui.shop.revLogSet.using();
	 				var pagehtml = '<i class="n" id="listIndex">'+$(tag).data("idx")+'</i>/<i class="s">'+$('.mn_reviw_sld ul.list').children('li').length+'</i>';
	 				$(".petLogCommentCount").html(pagehtml);
					ui.popLayer.open('popLogRv');
 					//move_scroll(selectIndex)
 				 },50);
//  				ui.shop.revLogSet.using();
//  				ui.shop.revLog.using();
			}
		};
		ajax.call(options);
	}
</script>
<c:forEach var="cornerList" items="${totalCornerList}"  varStatus="status" >
	<c:if test="${param.dispCornNo == cornerList.dispCornNo }">
		<input type="hidden" id="dispClsfCornNo" value="${cornerList.popPetLogList[0].dispClsfCornNo}"/>
		<!-- 후기 -->
		<section class="sect mn reviw">
			<div class="hdts">
				<span class="tit">생생한 후기 상품</span>
			</div>
			<div class="mn_reviw_sld"><!-- ui.disp.sld.reviw.using(); -->
				<div class="sld-nav">
					<button type="button" class="bt prev">이전</button>
					<button type="button" class="bt next">다음</button>
				</div>
				<div class="swiper-container slide">
					<ul class="swiper-wrapper list">
					<c:forEach var="petLog" items="${cornerList.popPetLogList}" varStatus="idx">
						<li class="swiper-slide">
							<div class="gdset reviw">
								<a class="box" onclick ="petlogReviewDetail(${petLog.petLogNo} , this);return false;" href="javascript:void(0);" data-idx="${idx.count }">
									<span class="thum">
										<span class="photo">
											<c:if test="${petLog.vdPath eq null && petLog.imgPath1 ne null}">
												<img class="img" src="${fn:indexOf(petLog.imgPath1, 'cdn.ntruss.com') > -1 ? petLog.imgPath1 : frame:optImagePath(petLog.imgPath1, frontConstants.IMG_OPT_QRY_640)}" alt="이미지">
											</c:if>
											<c:if test="${petLog.vdPath ne null && petLog.imgPath1 eq null}">
												<img class="img" src="${fn:indexOf(petLog.vdThumPath, 'cdn.ntruss.com')> -1 ? petLog.vdThumPath  : frame:optImagePath(petLog.vdThumPath, frontConstants.IMG_OPT_QRY_640) }">
											</c:if>
										</span>
									</span>
									<div class="inf">
										<div class="pic"><img class="img" src="${fn:indexOf(petLog.prflImg, 'cdn.ntruss.com') > -1 ? petLog.prflImg : frame:optImagePath(petLog.prflImg, frontConstants.IMG_OPT_QRY_640)}" alt="이미지" onerror="this.src='../../_images/_temp/temp_logDogImg02.png'"></div>
										<div class="txt">${petLog.nickNm}</div>
									</div>
								</a>
							</div>
						</li>
					</c:forEach>
					</ul>
				</div>
			</div>
		</section>
	</c:if>
</c:forEach>

<div class="layers" id="petLogPop">
</div>


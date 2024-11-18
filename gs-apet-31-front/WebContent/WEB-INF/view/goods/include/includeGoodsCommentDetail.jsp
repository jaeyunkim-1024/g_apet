<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">
	$(function(){
		/* goodsComment.getGoodsCommentScore(); */
		goodsComment.getGoodsPhotoComment();
		goodsComment.getGoodsCommentList();
		
		petLogList.list();
		
		$("button[name=sortBtn]").on('click', function(){
			goodsComment.page = 1;
			var sidx;
			var sord;
			if($(this).val() == "v_1"){
				sidx = "SYS_REG_DTM";
				sord = "DESC";
			}else if($(this).val() == "v_2"){
				sidx = "ESTM_SCORE";
				sord = "DESC";
			}else if($(this).val() == "v_3"){
				sidx = "ESTM_SCORE";
				sord = "ASC";
			}
			goodsComment.sidx = sidx;
			goodsComment.sord = sord;
			goodsComment.getGoodsCommentList();
		});
		
		$("[name=morePhotoCommentBtn]").on('click', function(){
			getGoodsPhotoCommentPop();
			
		});

		$("#commentMore").on('click', function(){
			goodsComment.page = parseInt(goodsComment.page)+1;
			var param = {
				callback : goodsComment.getGoodsCommentListMore
			}
			goodsComment.getGoodsCommentList(param);
		});
		
		
		$("#commentListUl").on('click', '.pics img', function(){
			goodsComment.detailImgPop(this);
		})
		
		$("#goodsLayers").on('click', '.sld-nav>button', function(){
			var viewIndex = $(".popPhotoRv").find('[id^=photoCommentEstmNo_]').index($(".popPhotoRv").find('[id^=photoCommentEstmNo_].swiper-slide-active'));
			$("i[name=viewPoint]").text(viewIndex+1);
		});
		
		$("#optGoodsId").on('change', function(){
			goodsComment.page = 1;
			goodsComment.optGoodsId = $(this).val();
			
			goodsComment.getGoodsCommentList();
		})
		
		$("#imgListUl").on('click', 'a', function(){
			if($(this).attr('name') != 'morePhotoCommentBtn'){
				goodsComment.getAllGoodsCommentDetail($(this).data('goodsEstmNo'));
			}
		});
		
		$("#goodsLayers").on('click', '#popPhotoRv nav button.st, #popPhotoRv nav', function(){
			$($(this).parents('div.def').find('nav')).removeClass('bot');
		});
	});
	
	//상품평
	var goodsComment = {
		goodsId : "${goods.goodsId}",
		goodsCstrtTpCd : "${goods.goodsCstrtTpCd}",
		totalPageCount : null,
		page : null,
		totalPageCount : null,
		sidx : null,
		sord : null,
		optGoodsId : null,
		/* ajax -> 페이지 들어올때 실행하도록 수정 - ㅔcm 
		getGoodsCommentScore : function(){
			var options = {
				url : "<spring:url value='/goods/getGoodsCommentScore.do' />"
				, type : "POST"
				, dataType : "html"
				, data : {
					goodsId : goodsComment.goodsId
					, goodsCstrtTpCd : goodsComment.goodsCstrtTpCd
				}
				, done : function(result){
					$('#estmArea').html(result);
				}
			};
			ajax.call(options);
		}, */
		getGoodsPhotoComment : function(newData){
			var defaultData = {
				url : "<spring:url value='/goods/getGoodsPhotoComment.do' />"
				, dataType : "Json"
				, done : goodsComment.getgoodsPhotoCommentResult
			}
			$.extend(defaultData, newData);
			var options = {
				url : defaultData.url
				, type : "POST"
				, dataType : defaultData.dataType
				, data : {
						goodsId : goodsComment.goodsId
						, goodsCstrtTpCd : goodsComment.goodsCstrtTpCd
					}
				, done : defaultData.done
			};
			ajax.call(options);
		},
		getgoodsPhotoCommentResult : function(result){
			var data = result.imgList;
			if(data != null && data.length > 0){
				$("#photoTotalCnt").text(result.so.totalCount+'건');
				html = "";
				for(var i = 0; i < data.length; i++){
					html += "<li class=\"swiper-slide\">";
					html += "<div class=\"box\">";
					html += "<div class=\"thum\">";
					html += "<a href=\"javascript:;\" class=\"pic\" data-goods-estm-no=\""+data[i].goodsEstmNo+"\">";
					html += "<img class=\"img\" src=\""+data[i].imgPath+"\" alt=\"이미지\">";
					if(data[i].imgCnt != null && data[i].imgCnt > 1 ){
						html += "<em class=\"n\" style=\"display:block\">"+data[i].imgCnt+"</em>";
					}
					html += "</a>";
					html += "</div></div></li>";
				}
				if(data.length>=10){
					//포토상품평 10개 이상 시 이미지 리스트 10개 출력 후 더보기 버튼 추가
					html += "<li class=\"swiper-slide more\"><div class=\"box\"><a href=\"javascript:;\" onclick=\"getGoodsPhotoCommentPop(); return false;\" class=\"link\" name=\"morePhotoCommentBtn\"><i class=\"t\">더보기</i></a></div></li>";
				}
	
				$("#imgListUl").append(html);
			}else{
				$("div[name^=photoCommentDiv_]").remove();
			}
		},
		getgoodsPhotoCommentPopResult : function(result){
			//$(".popRvPhoto").remove();
			//$("#goodsLayers").append(result);
			$("#goodsLayers").empty();
			$("#goodsLayers").html(result);
			ui.popLayer.open('popRvPhoto');
		},
		getGoodsCommentList : function(param){
			var _this = goodsComment;
			var data = {
				goodsId : _this.goodsId
				, goodsCstrtTpCd : _this.goodsCstrtTpCd
				, page : _this.page==null?1:_this.page
				, sidx : _this.sidx
				, sord : _this.sord
				, optGoodsId : _this.optGoodsId
			}
			
			var done = _this.getGoodsCommentListResult;
			
			if(param != null && param.callback != null){
				done = param.callback;
			}
			
			var options = {
				url : "<spring:url value='/goods/getGoodsCommentList.do' />"
				, type : "POST"
				, dataType : "html"
				, data : data
				, done : done
			};
			ajax.call(options);
		},
		getGoodsCommentListResult : function(result){
			$('#commentListUl').html(result);
		},
		getGoodsCommentListMore : function(result){
			$('#commentListUl').append(result);
		},
		layerPopRemove : function(btn){
			var popId = $(btn).parents('article')[0].id;
			$("#"+popId).remove();
		},
		deleteGoodsComment : function(btn){
			var dataArea = $(btn).parents('div[name=estmDataArea]');
			ui.confirm('후기를 삭제할까요?',{ // 컨펌 창 옵션들
				ycb:function(){
					var options = {
						url : "<spring:url value='/goods/deleteGoodsComment.do' />"
						, type : "POST"
						, data : {
							goodsId : goodsComment.goodsId
							, goodsEstmNo : $(dataArea).data('goodsEstmNo')
							, ordNo : $(dataArea).data('ordNo')
							, ordDtlSeq : $(dataArea).data('ordDtlSeq')
						}
						, done : function(result){
							ui.toast('후기가 삭제 되었어요',{
							    ccb:function(){  // 토스트 닫히면 실행할 함수
									location.reload();
							    }
							});
						}
					};
					ajax.call(options);
				},
				ncb:function(){

				},
				ybt:"예",
				nbt:"아니오"
			});
			
		},
		reWriteGoodsComment : function(btn){
			var dataArea = $(btn).parents('div[name=estmDataArea]');
			var goodsEstmTp = "NOR";
			
			var url = "/mypage/commentWriteView"
			var html = '';
			html += '<input type="hidden" name="goodsId" value="'+ $(dataArea).data('goodsId') +'">';
			html += '<input type="hidden" name="goodsEstmTp" value="'+ goodsEstmTp +'">';
			html += '<input type="hidden" name="ordNo" value="'+$(dataArea).data('ordNo')+'">';
			html += '<input type="hidden" name="ordDtlSeq" value="'+$(dataArea).data('ordDtlSeq')+'">';
			html += '<input type="hidden" name="goodsEstmNo" value="'+ $(dataArea).data('goodsEstmNo') +'">';
			var goform = $("<form>",
				{ method : "post",
				action : url,
				target : "_self",
				html : html
				}).appendTo("body");
			goform.submit();
		},
		likeComment : function(btn){
			var dataArea = $(btn).parents('div[name=estmDataArea]');
			var options = {
				url : "<spring:url value='/goods/likeComment.do' />"
				, type : "POST"
				, data : {goodsEstmNo : $(dataArea).data('goodsEstmNo')}
				, done : function(result){
					var count = result.count;
					$(btn).children('.n').text(count);
					if(count == 0){
						$(btn).removeClass('on');
					}else{
						$(btn).addClass('on');
					}
					/* $(btn).toggleClass('me'); */
				}
			}
			ajax.call(options);
		},
		commentReportPop : function(btn, anotherPop){
			var dataArea = $(btn).parents('div[name=estmDataArea]');
			var options = {
				url : "<spring:url value='/goods/commentReportPop.do' />"
				, type : "POST"
				, data : {goodsEstmNo : $(dataArea).data('goodsEstmNo')}
				, type : "POST"
				, dataType : "html"
				, done : function(result){
					//$("#commentReportPop").remove();
					//$("#goodsLayers").append(result);
					$("#goodsLayers").empty();
					$("#goodsLayers").html(result);
					ui.popLayer.open('commentReportPop');
					
					if(anotherPop != null){
						$("#"+anotherPop).css('z-index', $("#commentReportPop").css('z-index')-1);
					}
				}
			}
			ajax.call(options);
		},
		reportGoodsComment : function(){
			var data = $.extend($("#rptpForm").serializeJson(), {rptpRsnContent : $("textarea[name=rptpRsnContent]").val()});
			
			var options = {
				url : "<spring:url value='/goods/reportGoodsComment.do' />"
				, type : "POST"
				, data : data
				, done : function(result){
					ui.alert('신고가 완료되었어요',{
								ycb:function(){
									ui.popLayer.close("commentReportPop");
									$("#commentReportPop").remove();
								}
							}
						);
				}
			}
			
			ajax.call(options);
		},
		detailImgPop : function(clickImg){
			var clickImgPath = clickImg.src;
			var imgs = $(clickImg).parents('.pics').find('img');
			var selectIndex = imgs.index(clickImg);
			var bigHtml = '';
			var thumbHtml = '';
			for(var i = 0; i < imgs.length; i++){
				var imgPath = imgs[i].src;
				bigHtml += "<li class=\"swiper-slide\">"
				bigHtml += "<div class=\"box swiper-zoom-container\">"
				bigHtml += "<span class=\"pic\">"
				bigHtml += "<img class=\"img\" src=\""+imgPath+"\" alt=\"\">"
				bigHtml += "</span></div></li>"
				
				thumbHtml += "<li class=\"swiper-slide\">"
				thumbHtml += "<a href=\"javascript:;\" class=\"box\">"
				thumbHtml += "<span class=\"pic\">"
				thumbHtml += "<img class=\"img\" src=\""+imgPath+"\" alt=\"\">"
				thumbHtml += "</span></a></li>"
			}
			
			$("#imgViewTitle").text("이미지 보기");
			$("#bigImgArea").html(bigHtml);
			$("#thumbImgArea").html(thumbHtml);
			
			ui.shop.pdPic.galleryTop.slideTo(selectIndex);
			ui.shop.pdPic.using();
			/* ui.shop.rvPics.using(); */
			$(".pdDtThmSld .slide>li .box").eq(selectIndex).click();
			ui.popLayer.open('popPdImgView');
		},
		getAllGoodsCommentDetail : function(goodsEstmNo){
			var options = {
				url : "<spring:url value='/goods/getAllGoodsCommentDetail.do' />"
				, type : "POST"
				, dataType : "html"
				, data : {
						goodsId : goodsComment.goodsId
						, goodsCstrtTpCd : goodsComment.goodsCstrtTpCd
						, imgRegYn : "Y"
					}
				, done : function(result){
					//$(".popPhotoRv").remove();
					//$("#goodsLayers").append(result);
					$("#goodsLayers").empty();
					$("#goodsLayers").html(result);
					
					var commentArea = $("#photoDetailList").children('li');
					var selectIndex = commentArea.index($("#photoCommentEstmNo_"+goodsEstmNo)[0]);
					$.extend(ui.shop.revPicSet.opt,
						{
							initialSlide : selectIndex,
							pagination: {
								el: '.goodsPhotoCommetListCount',
								type: 'custom',
								renderCustom : function(swiper , current , total){
									var html = '';
									html += '<i class="n" name="viewPoint">'+current+'</i>/<i class="s">'+total+'</i>';
									$(".goodsPhotoCommetListCount").html(html);
								}
							}
						}
					);
					ui.shop.revPicSet.using();
					ui.shop.revPic.using();
					$("i[name=viewPoint]").text(selectIndex+1);
					ui.popLayer.open('popPhotoRv');
					
					//$("#photoCommentEstmNo_"+goodsEstmNo).scrollTop($("#photoCommentEstmNo_"+goodsEstmNo));
				}
			};
			ajax.call(options);
		}
	}
	
	
	
	var validateComment = {
		check : function(){
			var _this = validateComment;
			_this.scoreCheck();
			_this.qstCheck();
		},
		scoreCheck : function(){
			var score = $("#commentForm").find('li.f').length;
			if(score == 0){
				alert('별점을 선택해 주세요.');
				return false;
			}
		},
		qstCheck : function(){
			if($("div[name=goodsEstmQstArea]").length != 0){
				for(var i = 0; i < $("div[name=goodsEstmQstArea]").length; i++){
					var area = $("div[name=goodsEstmQstArea]")[i];
					if($(area).find("input[name^=estmQstNo_]:checked").length == 0){
						var msg = $(area).find(".tit").text();
						alert("\""+msg+"\" 항목을 평가 해주세요.");
						return false;
					}
				}
			}
		}
	}
	
	function removePop(btn){
		var popId = $(btn).parents('article')[0].id;
		ui.popLayer.close(popId);
		$("#"+popId).remove();
	}
	
	function getGoodsPhotoCommentPop(){
		var data = {
			url : "<spring:url value='/goods/getGoodsPhotoCommentPop.do' />"
			, dataType : "html"
			, done : goodsComment.getgoodsPhotoCommentPopResult
		}
		goodsComment.getGoodsPhotoComment(data);
	}
	
	///////////////////////////////////////펫로그 후기
	var petLogList = {
			totalCount : null,
			totalPageCount : null,
			page : null,
			list : function(callback){
 				var done = petLogList.result;
				if(callback !=  null){
					done = callback;
				}
				var options = {
					url : "<spring:url value='/goods/indexPetLogCommentList' />"
					, type : "POST"
					, dataType : "html"
					, data : {
							goodsId : goodsComment.goodsId
							, page : petLogList.page == null ? 1 : petLogList.page
							, goodsCstrtTpCd : goodsComment.goodsCstrtTpCd
						}
 					, done : done
			};
				ajax.call(options);
			},
			result : function(result){
 				$('#petLogList').html(result);
 				if(petLogList.totalCount > 0){
 					/* $("span[name=petLogTotal]").text("("+ petLogList.totalCount +"건)"); */
 	 				$("#petLogTotalCnt").text(petLogList.totalCount);	
 				}else{
 					$(".logPicMetric").text("등록된 후기가 없습니다.")
 					$(".logPicMetric").css("text-align" , "center")
 				}
 				
 			},
 			add : function(result){
 				$('#petLogList').append(result);
 			},
 			petLogMore : function(){
 				petLogList.page = petLogList.page*1 + 1;
 				petLogList.list(petLogList.add);
 			}
	}
	
	//펫로그 후기 상세
	function petlogReviewDetail(petLogNo , tag){
		var options = {
			url : "<spring:url value='/goods/indexPetLogCommentDetailList' />"
			, type : "POST"
			, dataType : "html"
			, data : {
					index : $(tag).data("idx")
					, goodsId : goodsComment.goodsId
					, petDetailNo : petLogNo
					, totalCount : petLogList.totalCount
					, goodsCstrtTpCd : goodsComment.goodsCstrtTpCd
			}
			, done : function(result){
				//$(".popLogRv").remove();
 				//$("#goodsLayers").append(result);
 				$("#goodsLayers").empty();
				$("#goodsLayers").html(result);
				
 				var selectIndex = $("#petLogDetails").children('li[id^=petLogDetails_]').index($("#petLogDetails_"+ petLogNo));
				ui.popLayer.open('popLogRv');
				
				$.extend(ui.shop.revLogSet.opt, {
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
				})
				
 				ui.shop.revLogSet.using();
 				ui.shop.revLog.using();
				
			}
		};
		ajax.call(options);
	}
</script>

<div class="hdts"> 
	<span class="tit"><em class="t">후기</em> <i class="i">${not empty commentTotalCnt ? commentTotalCnt : 0}</i></span>
	<div class="bts">
		<!-- <a href="javascript:;" class="btn b btnRev" onclick="ui.popBot.open('popRevSel');">후기작성</a> -->
		<div style="display:none;">
			<form id="writePopDataForm">
				<input type="text" name="goodsId"/>
				<input type="text" name="goodsEstmTp"/>
			</form>
		</div>
	</div>
</div>
<div class="cdts">
	
	<c:choose>
		<c:when test="${(not empty commentTotalCnt ? commentTotalCnt : 0) eq 0}">
			<div class="nodata">등록된 후기가 없습니다.</div><!-- @@ 03.30 추가 -->
		</c:when>
		<c:otherwise>
			<!-- 구매만족도 -->
			<c:if test="${not empty norCommentCnt && norCommentCnt >= 5}">
				<div class="uisatis" id="estmArea">
					<jsp:include page="/WEB-INF/view/goods/include/includeGoodsCommentScoreView.jsp"/>
				</div>
			</c:if>
			<%-- 후기탭 --> --%>
			<div class="uirevtabs">
				<ul class="menu">
					<li class="active">
						<button type="button" class="btn md" data-ui-tab-btn="tab_rvt" data-ui-tab-val="tab_rvt_a">일반 후기</button>
					</li>
					<li>
						<button type="button" class="btn md" data-ui-tab-btn="tab_rvt" data-ui-tab-val="tab_rvt_b">펫로그 후기</button>
					</li>
				</ul>
			</div>
		
			<!-- 일반후기 영역 -->
			<div data-ui-tab-ctn="tab_rvt" data-ui-tab-val="tab_rvt_a" class="tabrev rev_a active">
				<div class="uireviews">
					<div class="rvhdt phto" name="photoCommentDiv_1">
						<a href="javascript:;" class="rht">
						<span class="tit">포토후기</span>
						<span class="num" id="photoTotalCnt">0건</span>
						<em class="bt more" name="morePhotoCommentBtn">더보기</em>
						</a>
					</div>
					<div class="rvphotos"  name="photoCommentDiv_2">
						<div class="ui_rvphoto_slide">
							<div class="swiper-container slide">
								<ul class="swiper-wrapper list" id="imgListUl">
								<!-- 포토 후기 최대 10개 노출, 10개 이상 존재 시 더보기 버튼 노출 -->
								</ul>
							</div>
							<div class="sld-nav">
								<button type="button" class="bt prev">이전</button>
								<button type="button" class="bt next">다음</button>
							</div>
						</div>
					</div>
					<div class="rvhdt all">
						<div class="rht">
							<span class="tit">전체후기</span><span class="num" name="commentAllCnt">${not empty norCommentCnt ? norCommentCnt : 0} 건</span>
						</div>
						<div class="rdt">
							<nav class="uisort dsort">
								<button type="button" class="bt st" value="v_1">최신순</button>
								<div class="list"> 
									<ul class="menu">
										<li class="active"><button type="button" class="bt" name="sortBtn" value="v_1">최신순</button></li>
										<li><button type="button" class="bt" name="sortBtn" value="v_2">평점높은순</button></li>
										<li><button type="button" class="bt" name="sortBtn" value="v_3">평점낮은순</button></li>
									</ul>
								</div>
							</nav>
						</div>
					</div>
					<div class="revalls" name="commentArea">
						<div class="selopts" name="commentOptList">
							<c:if test="${goods.goodsCstrtTpCd eq 'ATTR' or goods.goodsCstrtTpCd eq 'PAK'}">
								<span class="select-pop">
									<select class="sList" id="optGoodsId" name="optGoodsId">
										<option value="">전체 옵션 상품</option>
										<c:forEach var="commentCstrtData" items="${commentCstrtList }">
											<option value="${commentCstrtData.goodsId }">${commentCstrtData.goodsNm }</option>
										</c:forEach>
										<%-- <c:if test="${view.deviceGb ne 'PC'}"><option value=""></option></c:if> --%>
									</select>
								</span>
							</c:if>
						</div>
						<ul class="revlists" id="commentListUl">
							<!-- 상품평 리스트 영역 -->
						</ul>
						<div class="moreload">
							<button type="button" class="bt more" id="commentMore">일반후기 더보기</button>
						</div>
					</div>
				</div>
			</div>
			<div data-ui-tab-ctn="tab_rvt" data-ui-tab-val="tab_rvt_b" class="tabrev rev_b">
				<div class="uilogrevs">
					<div class="rvhdt">
						<a class="rht" href="javascript:;"><span class="tit">펫로그 후기</span><span class="num" name="petLogTotal">(${not empty commentTotalCnt and not empty norCommentCnt? commentTotalCnt - norCommentCnt : 0}건)</span></a>
						<div class="rdt"> <div class="warning">펫로그 후기는 모바일앱에서 작성할 수 있습니다.</div></div>
					</div>
					<div class="logPicMetric on">
						<ul id="petLogList">
						</ul>
						<div class="moreload">
							<button type="button" class="bt more" id= "pegLogMoreBtn" onclick="petLogList.petLogMore();">펫로그 후기 더보기</button>
						</div>
					</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
	
</div>

<script>
	$(document).on("click",".uireviews .bt.hlp",function(){
		$(this).addClass("on"); // 숫자가 있으면 on
		$(this).addClass("me"); // 나가 추천하면 me
	});
	$(document).on("click",".logRvSet .contxt .bt.tog",function(e){
		$(this).closest(".rconbox").toggleClass("active");
	});
	$(document).on("click",".logRvSet .picture .bt.sound",function(e){
		$(this).toggleClass("on");
	});
</script>
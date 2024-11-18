<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

<script type="text/javascript">
	$(document).ready(function(){
   		if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
			toNativeData.func = "onPetLogEncodingCheck";
			toNativeData.callback = "onPetLogEncodingCheckCallback";
   			
			toNative(toNativeData)
		}
	});
	
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
				goodsComment.getAllGoodsCommentDetail($(this).data('goodsEstmNo'), $(this).data('idx'));
			}
		});
		
		$("#goodsLayers").on('click', '#popPhotoRv nav button.st, #popPhotoRv nav', function(){
			$($(this).parents('div.def').find('nav')).removeClass('bot');
		});

		$('#goodsLayers').on('click', '#popPhotoRv button[name=detailClose]', function(){
			ui.popLayer.close("popPhotoRv");
			
			if(!$('article#popRvPhoto').hasClass('on')){
				getGoodsPhotoCommentPop();
			}
		});
		
		$('#goodsLayers').on('click', '#popPhotoRv .btnPopClose', function(){
			ui.popLayer.close("popRvPhoto");
		});
		
		/* $(window).on("scroll , touchmove" , function(){
			var endIndex = $("#petLogDetails").children('li').length;
			
			if(endIndex != 0){
				var endScrollTop = $("#popLogRv .revlists.swiper-wrapper > .swiper-slide:eq("+(endIndex-1)+")").position().top-200;
				var divTop = $("#popLogRv .log_review_sld").closest(".pct").scrollTop();
				
				if(divTop <= 3){
					//이전 페이지 페이징
					petlogReviewDetailPaging("M");
				}else if(divTop >= endScrollTop){
					//다음 페이지 페이징
					petlogReviewDetailPaging("P");
				}
			}
		}); */
	});
	
	//상품평
	var goodsComment = {
		totalCmntsCnt : null,	// 전체 상품평 수
		norCmntsCnt : null,		// 일반 상품평 수
		logCmntsCnt : null,		// 로그 상품평 수
		setWithCnt : function name() {		// 상품평 수에따른 초기화
			if(goodsComment.norCmntsCnt != null){
				$(".norCntArea").html(goodsComment.norCmntsCnt);
			}
			if(goodsComment.logCmntsCnt != null){
				$(".logCntArea").html(goodsComment.logCmntsCnt);
			}
			if(goodsComment.norCmntsCnt != null && goodsComment.logCmntsCnt != null){
				goodsComment.totalCmntsCnt = parseInt(goodsComment.norCmntsCnt) + parseInt(goodsComment.logCmntsCnt);
				$(".totalCntArea").html(goodsComment.totalCmntsCnt);
				/*APET-1121  펫로그 후기만 있는 경우, 펫로그 후기가 선택되어 노출*/
		   		if(goodsComment.norCmntsCnt == 0 && goodsComment.logCmntsCnt != 0){
					$("#logCmntsBtn").click();
				}
				// 전체 후기 nodata
				if(goodsComment.totalCmntsCnt == 0){
					$("#totalCmntsArea").html('<div class="nodata">등록된 후기가 없습니다.</div>');
					$('#plgNodata').show();
 					$('#logCmtTit').hide();
 					$("#plgMoreDiv").hide();
				}
				// 구매 만족도5개 미만 미노출
				if(parseInt(goodsComment.totalCmntsCnt) < 5){
					$("#estmArea").hide();
				}
			}
		},
		goodsId : "${goods.goodsId}",
		goodsCstrtTpCd : "${goods.goodsCstrtTpCd}",
		totalPageCount : null,
		page : null,
		totalPageCount : null,
		sidx : null,
		sord : null,
		optGoodsId : null,
		selectTab : null,
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
				goodsComment.photoTotalCnt = result.so.totalCount;
				html = "";
				for(var i = 0; i < data.length; i++){
					html += "<li class=\"swiper-slide\">";
					html += "<div class=\"box\">";
					html += "<div class=\"thum\">";
					html += "<a href=\"javascript:;\" class=\"pic\" data-goods-estm-no=\""+data[i].goodsEstmNo+"\" data-idx=\""+(i+1)+"\">";
					
					var imgPath = ""
					if(data[i].imgPath.indexOf('http') > -1){
						imgPath = data[i].imgPath;
					}else{
						imgPath = '${frame:optImagePath("'+ data[i].imgPath +'", frontConstants.IMG_OPT_QRY_794)}';
					}
					
					html += "<img class=\"img\" src=\""+imgPath+"\" alt=\"이미지\">";
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
			var norCmntsCnt = $("#norCommentCnt").val();
			goodsComment.norCmntsCnt = norCmntsCnt;
			goodsComment.setWithCnt();
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
							var _this = goodsComment;
							_this.page = 1;
							_this.sidx = "SYS_REG_DTM";
							_this.sord = "DESC"
							
							var param = {
								callback : function(result){
									$('#commentListUl').html(result);
									ui.toast('후기가 삭제 되었어요');
								}
							}
							_this.getGoodsPhotoComment();
							_this.getGoodsCommentList(param);
							
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
			var loginYn = '${session.mbrNo}' != '0' ? 'Y' : 'N';
			if(loginYn == 'Y'){
				var dataArea = $(btn).parents('div[name=estmDataArea]');
				var options = {
					url : "<spring:url value='/goods/likeComment.do' />"
					, type : "POST"
					, data : {goodsEstmNo : $(dataArea).data('goodsEstmNo')}
					, done : function(result){
						var count = result.count;
						var likeCnt = $(btn).children('.n').text();
						if(count == 0){
							$(btn).children('.n').text(parseInt(likeCnt)-1);
							if(likeCnt == '1'){
								$(btn).removeClass('on');
							}
						}else{
							$(btn).children('.n').text(parseInt(likeCnt)+1);
							$(btn).addClass('on');
						}
						$(btn).toggleClass('me');
					}
				}
				ajax.call(options);
			}else{
				ui.confirm('로그인 후 서비스를 이용할 수 있어요<br/>로그인 할까요?',{
					ycb: function () {
						document.location.href = '/indexLogin?returnUrl=' + encodeURIComponent(document.location.href);
					},
					ncb: function () {
						return false;
					},
					ybt: "로그인", // 기본값 "확인"
					nbt: "취소"  // 기본값 "취소"
				});
			}
			
		},
		commentReportPop : function(btn, anotherPop){
			var loginYn = '${session.mbrNo}' != 0 ? 'Y' : 'N';
			if(loginYn == 'Y'){
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
							//$("#"+anotherPop).css('z-index', $("#commentReportPop").css('z-index')-1);
							//APETQA-5573. 2021.06.02
							$("#commentReportPop").css('z-index', $("#"+anotherPop).css('z-index')+1);
						}
					}
				}
				ajax.call(options);
			}else{
				ui.confirm('로그인 후 서비스를 이용할 수 있어요<br/>로그인 할까요?',{
					ycb: function () {
						document.location.href = '/indexLogin?returnUrl=' + encodeURIComponent(document.location.href);
					},
					ncb: function () {
						return false;
					},
					ybt: "로그인", // 기본값 "확인"
					nbt: "취소"  // 기본값 "취소"
				});
			}
		},
		reportGoodsComment : function(){
			if($("input[name=rptpRsnCd]:checked").length != 0){
				var data = $.extend($("#rptpForm").serializeJson(), {rptpRsnContent : $("textarea[name=rptpRsnContent]").val()});
				
				var options = {
					url : "<spring:url value='/goods/reportGoodsComment.do' />"
					, type : "POST"
					, data : data
					, done : function(result){
						ui.toast('신고가 완료되었어요');
						ui.popLayer.close("commentReportPop");
						$("#commentReportPop").remove();
					}
				}
				ajax.call(options);
			}else{
				ui.toast('신고사유를 선택해주세요');
			}
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
			
			var options = {
				url : "<spring:url value='/goods/includeGoodsCommentImgPop' />"
				, type : "POST"
				, dataType : "html"
				, data : {}
				, done : function(result){
					$("#goodsLayers").empty();
	 				$("#goodsLayers").html(result);
	 				
					ui.popLayer.open('popPdImgView');
					
					$("#bigImgArea").html(bigHtml);
					$("#thumbImgArea").html(thumbHtml);
					$("#pdPopFlag").val("COMMENT");
					$("#imgViewTitle").text("이미지 보기");

					ui.shop.pdPic.opt1 = {
						observer : true,
						observeParents : true,
						watchOverflow : true,
						simulateTouch : false,
						spaceBetween : 20,
						navigation : {
							nextEl : '.pdDtPicSld .sld-nav .bt.next',
							prevEl : '.pdDtPicSld .sld-nav .bt.prev',
						},
						initialSlide : selectIndex
					};

					ui.shop.pdPic.galleryTop = new Swiper(ui.shop.pdPic.els1, ui.shop.pdPic.opt1);
					ui.shop.pdPic.galleryThumbs = new Swiper(ui.shop.pdPic.els2, ui.shop.pdPic.opt2);
					
					$(document).on("click",".pdDtThmSld .slide>li .box",function(){
						var my_idx = $(this).closest("li").index();
						$(this).closest("li").addClass("active").siblings("li").removeClass("active");
						ui.shop.pdPic.galleryTop.slideTo(my_idx);
					});
					
					ui.shop.pdPic.galleryTop.on('slideChangeTransitionEnd', function(swiper) {
						// this.galleryThumbs.slideTo(2);
						var idx = this.realIndex + 1 ;
						$(".pdDtThmSld .slide>li:nth-child("+ idx +")").addClass("active").siblings("li").removeClass("active");
						ui.shop.pdPic.galleryThumbs.slideTo(this.realIndex-3 < 0 ? 0 : this.realIndex-3);
					});
					
					if("${view.deviceGb}" != "${frontConstants.DEVICE_GB_10 }"){
						$(".pdDtThmSld .slide>li .box").eq(selectIndex).click();
					}else{
						if(selectIndex == 0){
							$(".pdDtThmSld .slide>li").eq(selectIndex).addClass("active");
						}else{
							$(".pdDtThmSld .slide>li .box").eq(selectIndex).click();
						}
					}
					
				}
			};
			ajax.call(options);
		},
		getAllGoodsCommentDetail : function(goodsEstmNo, idx){
			var options = {
				url : "<spring:url value='/goods/getAllGoodsCommentDetail' />"
				, type : "POST"
				, dataType : "html"
				, data : {
						goodsId : goodsComment.goodsId
						, goodsEstmNo : goodsEstmNo
						, goodsCstrtTpCd : goodsComment.goodsCstrtTpCd
						, imgRegYn : "Y"
					}
				, done : function(result){
					//$(".popPhotoRv").remove();
					//$("#goodsLayers").append(result);
					$("#goodsLayers").empty();
					$("#goodsLayers").html(result);
					
					$(".popPhotoRv .phd .nm .s").text($(".photo_review_sld .swiper-container.slide.k0422 .revlists  > li").length)
					/* scroll 이벤트 추가 */
					if(ui.check_brw.mo()){
						$(".photo_review_sld .swiper-container.slide.k0422").scroll(function(){
							var $child = $(this).find(".revlists.swiper-wrapper > .swiper-slide");
							var max = $child.length;
							var position = new Array();
							var st =  $(this).scrollTop();
							var ind = 0;
							var maxPoint = ($(".photo_review_sld .swiper-container.slide.k0422 > .revlists").innerHeight() - $(".photo_review_sld .swiper-container.slide.k0422").innerHeight());
							$child.each(function(i,n){
								position[(max - i - 1)] = $(n).position().top;
							});
							for(var i=0; i<position.length; i++){
								if(st >= maxPoint){
									ind = max;
									break;
								}else if(st >= (position[i]) ){
									ind = max - i;
									break;
								}
							}
							$(".popPhotoRv .phd .nm .n").text(ind);
						})
					}
					
					var commentArea = $("#photoDetailList").children('li');
					var selectIndex = commentArea.index($("#photoCommentEstmNo_"+goodsEstmNo)[0]);
					if(${view.deviceGb eq frontConstants.DEVICE_GB_10}){
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
						$("i[name=viewPoint]").text(selectIndex+1);
						ui.shop.revPicSet.using();
					}
					ui.shop.revPic.using();

					var pageHtml = '<i class="n" name="viewPoint">'+idx+'</i>/<i class="s">'+goodsComment.photoTotalCnt+'</i>';
					$(".goodsPhotoCommetListCount").html(pageHtml);
					ui.popLayer.open('popPhotoRv');
					$(".photo_review_sld .swiper-container.slide.k0422").scrollTop($("#photoCommentEstmNo_"+goodsEstmNo).position().top+2);
					
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
			detailPage : null,
			detailPageM : null,
			detailPageP : null,
			detailPaging : true,
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
 				var logCmntsCnt = $("#petLogCommentCnt").val();
 				goodsComment.logCmntsCnt = logCmntsCnt;
 				goodsComment.setWithCnt();
 			},
 			add : function(result){
 				$('#petLogList').append(result);
 			},
 			petLogMore : function(){
 				petLogList.page = petLogList.page*1 + 1;
 				petLogList.list(petLogList.add);
 			},
 			reload : function(reloadGb){
 				if(reloadGb == 'delete'){
 					$('#pdRevCnt').text(Number($('#pdRevCnt').text())-1);
 					$('.rev[data-sid=pd-rev]').find('.tit>i').text(Number($('.rev[data-sid=pd-rev]').find('.tit>i').text())-1);
 					$('button[data-ui-tab-val="tab_rvt_b"]').text('로그 후기 ' + (Number($('button[data-ui-tab-val="tab_rvt_b"]').text().split(' ')[2])-1))
 					$('div[data-ui-tab-val="tab_rvt_b"] [name="petLogTotal"]').text((Number($('div[data-ui-tab-val="tab_rvt_b"] [name="petLogTotal"]').text().split('건')[0])-1) + '건');
 				}
 				
 				var done = petLogList.result;
 				petLogList.page == null
				var options = {
					url : "<spring:url value='/goods/indexPetLogCommentList' />"
					, type : "POST"
					, dataType : "html"
					, data : {
							goodsId : goodsComment.goodsId
							, page : 1
							, goodsCstrtTpCd : goodsComment.goodsCstrtTpCd
						}
 					, done : done
				};
				ajax.call(options);
 			}
	}
	
	//인코딩check callBack
		function onPetLogEncodingCheckCallback(vdId){
			if(vdId){ updateEncCpltYn(vdId , 'Y') }
		}
		
		
		//인코딩 완료 시 인코딩 여부 컬럼 업데이트
		function updateEncCpltYn(vdId , reload){
			var options = {
					url : "${view.stDomain}/log/encCpltYnUpdate"
					, data : {
						vdPath : vdId
						, encCpltYn : "Y"
					}
					, done : function(result){
						if(reload == "Y"){
							location.reload();	
						}
//	 					if(result > 0){
//	 						$(".uimoreview.refresh").removeClass("onWeb_b");
//	 						toastCallBack();
//	 						$(".vthumbs[video_id='"+vdId+"']").data("enchk" , "Y");
//	 						$(".vthumbs[video_id='"+vdId+"']").parents("section").find(".logVodLoadingMsg").remove();
//	 					}
					}
			}
			//혹시라도 중복으로 업데이트 안되게
//	 		if($(".vthumbs[video_id='"+vdId+"']").data("enchk") == "N"){
				ajax.call(options);				
//	 		}
		}
		
	document.addEventListener("DOMContentLoaded", function() {
		var lazyloadImages = document.querySelectorAll("img[name=lazyImg]"); 
		var lazyloadThrottleTimeout;
		
		function lazyload () {
			if(lazyloadThrottleTimeout) {
				clearTimeout(lazyloadThrottleTimeout);
			}
			
			lazyloadThrottleTimeout = setTimeout(function() {
				lazyloadImages.forEach(function(img) {
					if($(img).parents('#petLogDetails').length != 0) {
						img.src = img.dataset.src;
						img.classList.remove('lazy');
					}
				});
				if(lazyloadImages.length == 0) { 
					document.removeEventListener("scroll", lazyload);
					window.removeEventListener("resize", lazyload);
					window.removeEventListener("orientationChange", lazyload);
				}
			}, 20);
		}
	});
	
	//펫로그 후기 상세
	function petlogReviewDetail(petLogNo , tag){
		/* if($("#petlogDetailData").find('li').length == 0){ */
			var options = {
				url : "<spring:url value='/goods/indexPetLogCommentDetailListPaging' />"
				, type : "POST"
				, dataType : "html"
				, data : {
					index : $(tag).data("idx")
					, goodsId : goodsComment.goodsId
					, petDetailNo : petLogNo
					, petLogNo : petLogNo
					, totalCount : petLogList.totalCount
					, goodsCstrtTpCd : goodsComment.goodsCstrtTpCd
				}
				, done : function(result){
					$("#petlogDetailData").html(result);
					
	 				var selectIndex = $(tag).data("idx")-1;
	 				/* setTimeout(function(){
						$.extend(ui.shop.revLogSet.opt, {
							initialSlide : selectIndex == 0 ? 0 : 1,
							pagination: {
								el: '.petLogCommentCount',
								type: 'custom',
								renderCustom : function(swiper , current , total){
									
									var html = '';
									current = current > 0 ? current : 1;
									
									current = $('#petLogDetails li.swiper-slide-active[name=petLogDetail]').data('idx')+1;
									html += '<i class="n" id="listIndex">'+current+'</i>/<i class="s">'+petLogList.totalCount+'</i>';
									$(".petLogCommentCount").html(html);
								}
							}
						}); */
						
		 				petlogDetailSet(selectIndex);
	 				/* }, 100); */
				}
			};
			ajax.call(options);
		/* }else{
			petlogDetailSet($(tag).data("idx")-1);
		} */
	}
	
	var swiperBox = new Array();
	
	function petlogDetailSet(selectIndex){
		/* var maxIndex = $("#petlogDetailData").children('li').length;
		var liList = new Array();
		
		if(selectIndex == 0){
			if(maxIndex-1 > 0){
				liList.push($($("#petlogDetailData").children('li')[selectIndex]).clone());
				liList.push($($("#petlogDetailData").children('li')[selectIndex+1]).clone());
			}else{
				liList = $("#petlogDetailData").children('li').clone();
			}
		}else if(selectIndex == maxIndex-1){
			liList.push($($("#petlogDetailData").children('li')[selectIndex-1]).clone());
			liList.push($($("#petlogDetailData").children('li')[selectIndex]).clone());
		}else{
			liList.push($($("#petlogDetailData").children('li')[selectIndex-1]).clone());
			liList.push($($("#petlogDetailData").children('li')[selectIndex]).clone());
			liList.push($($("#petlogDetailData").children('li')[selectIndex+1]).clone());
		}
		
		$('#petLogDetails').html(liList);
		ui.shop.revLogSet.opt.initialSlide = selectIndex == 0 ? 0 : 1; */

		$('#petLogDetails').html($("#petlogDetailData").children('li').clone());

		var pagehtml = '<i class="n" id="listIndex">'+(selectIndex+1)+'</i>/<i class="s">'+petLogList.totalCount+'</i>';
		$(".petLogCommentCount").html(pagehtml);
		
		ui.shop.revLog.using();
		ui.shop.revLogSet.using();
		ui.popLayer.open('popLogRv');
		
		logImgSet();
		
	}
	
	function logImgSet(){
		swiperBox = new Array();
		
		if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_10}"){
				//PC
				/* 메인 스와이프 */
				swiperBox.push(new Swiper("#petLogDetails .swiper-container.logMain", {
					slidesPerView: 1,
					slidesPerGroup: 1,
					freeMode: false,
					navigation: {
						nextEl: '#petLogDetails .swiper-container.logMain .swiper-button-next',
						prevEl: '#petLogDetails .swiper-container.logMain .swiper-button-prev',
					},
					pagination: {
						el: '#petLogDetails .swiper-container.logMain .swiper-pagination',
						type: 'fraction',
					},
					on: {
						slideResetTransitionStart: function() {
							if ((this.snapIndex + 1) == this.imagesLoaded) {
								$(this.wrapperEl).find(".swiper-slide-active").removeClass("swiper-slide-active").addClass("si_last");
							} else {
								$(this.wrapperEl).find(".si_last").removeClass("si_last");
							}
						}
					}
				}));
		}else{
			//MOBILE
			/* 메인 스와이프 */
			swiperBox.push(new Swiper("#petLogDetails .swiper-container.logMain", {
				slidesPerView: 1.11,
				slidesPerGroup: 1,
				spaceBetween: 10,
				centeredSlides: true,
				freeMode: false,
				navigation: {
					nextEl: '#petLogDetails .swiper-container.logMain .swiper-button-next',
					prevEl: '#petLogDetails .swiper-container.logMain .swiper-button-prev',
				},
				pagination: {
					el: '#petLogDetails .swiper-container.logMain .swiper-pagination',
					type: 'fraction',
				},
			}));
		}
		
		//펫로그 후기 이미지 페이징 업데이트 처리
		for(var i=0; i<swiperBox[0].length; i++){
			if(swiperBox[0][i].$el.find('.swiper-slide').length > 1){
				swiperBox[0][i].pagination.update();
			}
		};
		
		var imgList = $('#petLogDetails').find('img[name=lazeImg]');
		for(var i = 0; i < imgList.length; i++){
			$(imgList[i]).attr('src', $(imgList[i]).data('src'));
		}
		
	    var vdList = $('#petLogDetails').find('div.vthumbs');
	    for(var i = 0; i < vdList.length; i++){
	      $(vdList[i]).attr('video_id', $(vdList[i]).data('video_id'));
	    }
	    if(vdList.length > 0){
	      onThumbAPIReady();
	    }
		
	}
	
	
	$(function(){
		//pc버전 로그후기 상세 이전/다음 개시물 불러오기
		if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_10 }"){
			$("#petLogLayers").on('click', '.popLogRv #prevBtn', function(){
				setTimeout(function(){
					var log = $("#petLogLayers #petLogDetails .swiper-slide-active[name=petLogDetail]");
					if(log.data('idx') > 0){
						ui.shop.revLogSet.slide.pagination.update();
						setTimeout(function(){
							var cont = $($("#petlogDetailData").children('li')[log.data('idx')-1]).data('petLogNo');
							if($('#popLogRv li[name=petLogDetail][data-pet-log-no='+cont+']').length == 0){
								ui.shop.revLogSet.slide.prependSlide($($("#petlogDetailData").children('li')[log.data('idx')-1]).clone());
								ui.shop.revLogSet.slide.pagination.update();
								logImgSet();
							}
							$('#prevBtn').removeClass('swiper-button-disabled');
						},200);
					}
				},10);
			});
			$("#petLogLayers").on('click', '.popLogRv #nextBtn', function(){
				setTimeout(function(){
					var log = $("#petLogLayers #petLogDetails .swiper-slide-active[name=petLogDetail]");
					if(log.data('idx') < $("#petlogDetailData").children('li').length-1){
					$('#nextBtn').removeClass('swiper-button-disabled');
						setTimeout(function(){
							var cont = $($("#petlogDetailData").children('li')[log.data('idx')+1]).data('petLogNo');
							if($('#popLogRv li[name=petLogDetail][data-pet-log-no='+cont+']').length == 0){
								ui.shop.revLogSet.slide.appendSlide($($("#petlogDetailData").children('li')[log.data('idx')+1]).clone());
								logImgSet();
							}
						},50);
					}
				},10);
			});
		}
	})
	
</script>

<div class="hdts"> 
	<span class="tit"><em class="t">후기</em> <i class="i totalCntArea" ></i></span>
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
<div class="cdts" id="totalCmntsArea">
	<!-- 구매만족도 -->
	<div class="uisatis" id="estmArea">
		<jsp:include page="/WEB-INF/view/goods/includeNew/includeGoodsCommentScoreView.jsp"/>
	</div>
	<%-- 후기탭 --> --%>
	<div class="uirevtabs">
		<ul class="menu">
			<li class="active">
				<button type="button" class="btn md" data-ui-tab-btn="tab_rvt" data-ui-tab-val="tab_rvt_a">일반 후기 &nbsp;<span class="norCntArea"></span></button>
			</li>
			<li>  <!-- APET-1250 210728 kjh02  -->
				<button type="button" class="btn md" data-ui-tab-btn="tab_rvt" data-ui-tab-val="tab_rvt_b" id="logCmntsBtn"><spring:message code='front.web.view.new.menu.log'/> 후기 &nbsp;<span class="logCntArea"></span></button>
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
			<div class="rvhdt all" id="commentSoltArea">
				<div class="rht">
					<span class="tit">일반 후기</span><span class="num" name="commentAllCnt"><span class="norCntArea"> </span>건</span>
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
				<div class="moreload" id="cmtMoreDiv">
					<button type="button" class="bt more" id="commentMore">일반후기 더보기</button>
				</div>
				<div class="nodata" id="commentNodata" style="display: none;">등록된 후기가 없습니다.</div>
			</div>
		</div>
	</div>
	<div data-ui-tab-ctn="tab_rvt" data-ui-tab-val="tab_rvt_b" class="tabrev rev_b">
		<div class="uilogrevs">
			<div class="rvhdt" id="logCmtTit">  <!-- APET-1250 210728 kjh02  -->
				<a class="rht" href="javascript:;"><span class="tit"><spring:message code='front.web.view.new.menu.log'/> 후기</span><span class="num" name="petLogTotal"><span class="logCntArea"> </span>건</span></a>
				<div class="rdt"> <div class="warning"><spring:message code='front.web.view.new.menu.log'/> 후기는 모바일앱에서 작성할 수 있습니다.</div></div> <!-- APET-1250 210728 kjh02  -->
			</div>
			<div class="logPicMetric on">
				<ul id="petLogList">
				</ul>
				<div class="moreload" id="plgMoreDiv">
					<button type="button" class="bt more" id= "pegLogMoreBtn" onclick="petLogList.petLogMore();"><spring:message code='front.web.view.new.menu.log'/> 후기 더보기</button> <!-- APET-1250 210728 kjh02  -->
				</div>
				<div class="nodata" id="plgNodata" style="display:none;">등록된 후기가 없습니다.</div>
			</div>
		</div>
		<div style="display:none;">
			<ui id="petlogDetailData">
			</ui>
		</div>
	</div>
</div>

<script>
	/* $(document).on("click",".uireviews .bt.hlp",function(){
		$(this).addClass("on"); // 숫자가 있으면 on
		$(this).addClass("me"); // 나가 추천하면 me
	}); */
	$(document).on("click",".logRvSet .contxt .bt.tog",function(e){
		$(this).closest(".rconbox").toggleClass("active");
	});
	$(document).on("click",".logRvSet .picture .bt.sound",function(e){
		$(this).toggleClass("on");
	});
</script>
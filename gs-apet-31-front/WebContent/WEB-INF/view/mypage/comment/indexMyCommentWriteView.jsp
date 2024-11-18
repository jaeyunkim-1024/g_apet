<tiles:insertDefinition name="mypage" >
	<tiles:putAttribute name="script.include" value="script.member"/>
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript" 	src="/_script/file.js"></script>
		<script type="text/javascript">
/*  		$(document).ready(function(){
			if(commentContArea.text().val() != null){
				 pc-tit>#asd.text("후기수정");
				}
		})*/
		
				//로그 후기 이전 버튼 클릭 시,  [ios bfCache] '다음' 버튼 재 활성화
				$(window).bind('pageshow', function(event){
				  if(event.originalEvent && event.originalEvent.persisted){
					  writeFnc.btnCtrl = true;
				 }
				});
				/* 수정하기 시 실행 */	
			var starClickYn = false;		
			$(function(){
				if(commentData.petNo != null && commentData.petNo != ''){
					$("input[name=petNo]:input[value="+commentData.petNo+"]").trigger('click');
				}else{
					$("#noPet").trigger('click');
				}
				if(commentData.estmScore != null && commentData.estmScore != ''){
					var sScore = (parseInt(commentData.estmScore)/2+"").split('.');
					for(var i = 0; i < sScore[0]; i++){
						$($('.st').parents('li')[4-i]).addClass('f');
					}
					if(sScore.length > 1 && sScore[1] == '5'){
						$(".st").parents('ul').find('li:not(.f):first').addClass('h');
					}

					/* $($('.st')[commentData.estmScore-1]).trigger('click'); */
				}
				if(estmList != null && estmList.length > 0){
					for(var i = 0; i < estmList.length; i++){
						$("input[name=estmQstNo_"+estmList[i].estmQstNo+"]:input[value="+estmList[i].estmItemNo+"]").trigger('click');
						var html = "<input type=\"hidden\" name=\"estmRplNos\" value=\""+estmList[i].estmRplNo+"\">";
						$("input[name=estmQstNos]:input[value="+estmList[i].estmQstNo+"]").parent('.hdt').append(html);
					}
				}

			});

			<c:if test="${not empty InheritYn && InheritYn eq 'Y'}">
			$(function(){
				ui.alert('이전에 작성한 정보를 불러와서 노출합니다.',{
					ycb:function(){
						$("a[name=okbtn], button[name=okbtn]").removeClass('disabled');
						/* $("a[name=okbtn], button[name=okbtn]").removeAttr('disabled'); */
					}
				});

			})
			</c:if>

			/* 수정하기 시 필요 데이터 세팅 */
			var commentData = {
				estmScore : '${commentVO.estmScore}'
				, petNo : '${commentVO.petNo}'
			}

			<c:if test="${view.deviceGb ne 'PC'}">
			$(function(){
				var title;
				$("#header_pc").removeClass('mode0');
				$("#header_pc").addClass('mode7-1 logHeaderAc');
				<c:if test="${gso.goodsEstmTp eq 'PLG'}">
				title = "<spring:message code='front.web.view.new.menu.log'/> 후기 작성" 
				// APET-1250 210728 kjh02  
				</c:if>
				<c:if test="${gso.goodsEstmTp ne 'PLG'}">
				title = "후기 작성"
				</c:if>
				$($("#header_pc").find('.tit')).text(title);
				$("footer").remove();
				$(".menubar").remove();
			});
			</c:if>
			var estmList = new Array();
			<c:if test="${not empty commentVO.goodsEstmQstVOList}">
			<c:forEach var="data" items="${commentVO.goodsEstmQstVOList}">
			var estmData = {
				estmRplNo : '${data.estmRplNo}'
				, estmQstNo : '${data.estmQstNo}'
				, estmItemNo : '${data.estmItemNo}'
			}
			estmList.push(estmData);
			</c:forEach>
			</c:if>
			/* =============== */

			$(function(){
				commentImgCheck();
				//이미지 삭제
				$(".flex-box").on('click', 'button[name=delImg]', function(){
					delImage(this);
				});

				//헤더영역 뒤로가기버튼 onclick function 변경
				$(".mo-header-backNtn").attr('onclick', 'backPage(); return false;');

				//뒤로가기
				$("button[name=writeCancel], a[name=writeCancel]").on('click', function(){
					backPage();
					/* ui.confirm('후기 작성을 취소하시겠습니까?',{
						ycb:function(){
							window.history.back();
						},
						ncb:function(){
							return false;
						},
					    ybt:"네",
					    nbt:"아니오"
					}); */
				});

				//100글자 이상 입력 시 제한
				$('textarea[name=commentContArea]').on('propertychange keyup input change paste ', function(){
					if($(this).val().length > 100){
						$(this).val($(this).val().substring(0,100));
						ui.toast("내용은 100자까지 입력할 수 있어요.");
					}
				});

				//유효성체크
				$("input[name^=estmQstNo_], textarea[name=commentContArea], button.st").on('propertychange keyup input change paste click', function(){
					result = true;
					if($("input[name^=estmQstNo_]:checked").length != $("input[name=estmQstNos]").length){
						result = false;
					}

					<c:if test="${gso.goodsEstmTp ne frontConstants.GOODS_ESTM_TP_PLG}">
					if($("textarea[name=commentContArea]").val().length < 10){
						result = false;
					}
					</c:if>
					if($(this).hasClass('st')){
						starClickYn = true;
					}
					var score = $("#commentForm").find('li.f, li.h').length;
					if(!starClickYn && score == 0){
						result = false;
					}

					if(result){
						$("a[name=okbtn], button[name=okbtn]").removeClass('disabled');
						/* $("a[name=okbtn], button[name=okbtn]").removeAttr('disabled'); */
					}else{
						$("a[name=okbtn], button[name=okbtn]").addClass('disabled');
						$("a[name=okbtn], button[name=okbtn]").css("pointer-events", "all");
						/* $("a[name=okbtn], button[name=okbtn]").attr('disabled', 'disabled'); */
					}
				});

				$("input[name^=estmQstNo_]").on('click', function(){
					if($("input[name^=estmQstNo_]:checked").length == $("input[name=estmQstNos]").length){
						$("a[name=okbtn], button[name=okbtn]").removeClass('disabled');
						/* $("a[name=okbtn], button[name=okbtn]").removeAttr('disabled'); */
					}else{
						$("a[name=okbtn], button[name=okbtn]").addClass('disabled');
						$("a[name=okbtn], button[name=okbtn]").css("pointer-events", "all");
						/* $("a[name=okbtn], button[name=okbtn]").attr('disabled', 'disabled'); */
					}
				});

				$($("input[name^=estmQstNo_]:checked")[0]).trigger('click');
				var $findStar = $(".uiStar");
				if($($findStar.find('li.h')).length > 0){
					$($findStar.find('li.h')).last().trigger('click');
				}else if($($findStar.find('li.f')).length > 0){
					$($findStar.find('li.f')).last().trigger('click');
				}
			})

			//뒤로가기 버튼 시 실행
			function backPage(){
				var goodsEstmTp = $("#commentForm").data('goodsEstmTp');
				var msg;
				msg = "후기 작성을 취소할까요?";
				/* if(goodsEstmTp == '${frontConstants.GOODS_ESTM_TP_NOR}'){
					msg = "후기 작성을 취소하시겠습니까?";
				}else{
					msg = "작성중인 펫로그를 등록하지 않고 나가시겠습니까?";
				} */
				ui.confirm(msg ,{
					ycb:function(){
						window.history.back();
					},
					ncb:function(){
						return false;
					},
					ybt:"예",
					nbt:"아니오"
				});
			}

			var writeFnc = {
				goodsId : '${gso.goodsId}',
				ordNo : '${gso.ordNo}',
				ordDtlSeq : '${gso.ordDtlSeq}',
				petLogNo : '${gso.petLogNo}',
				deviceGb : '${view.deviceGb}',
				btnCtrl : true,
				//상품 후기 작성
				writeComment : function(){
					if(validateComment.check()){
						
						if("${gso.goodsEstmTp}"=="${frontConstants.GOODS_ESTM_TP_NOR}"){
							if($("textArea[name=commentContArea]").val().length < 10){
								ui.alert("내용을 10자 이상 입력해주세요.");
								return false;
							}							
						}
						
						var score = $("#commentForm").find('li.f').length;
						if($("#commentForm").find('li.h').length >= 1 && score != 5){
							score = parseInt(score)+0.5;
						}
						score = score*2;
						var estmItemNo = $("#commentForm").find('input[name^=estmQstNo_]:checked');
						var estmItemNos = "";
						if(estmItemNo != null && estmItemNo.length != 0){
							for(var i = 0; i < estmItemNo.length; i++){
								if(i != estmItemNo.length-1){
									estmItemNos += $(estmItemNo[i]).val() + ",";
								}else{
									estmItemNos += $(estmItemNo[i]).val();
								}
							}
						}

						var imgRegYn = $("#commentImgArea").children('li').length != 0?'Y':'N';
						var goodsEstmTp = $("#commentForm").data('goodsEstmTp');
						var addData = {
							goodsId : writeFnc.goodsId
							, content : $("textarea[name=commentContArea]").val()
							, estmScore : score
							, estmItemNos : estmItemNos
							, goodsEstmTp : goodsEstmTp
							, ordNo : writeFnc.ordNo
							, ordDtlSeq : writeFnc.ordDtlSeq
							, imgRegYn : imgRegYn
						}
						var data = $.extend($("#commentForm").serializeJson(), addData);

						var url = "<spring:url value='/mypage/insertGoodsComment.do' />";

						if($("#commentForm").data('goodsEstmNo') != null && $("#commentForm").data('goodsEstmNo') != ''){
							url = "<spring:url value='/mypage/updateGoodsComment.do' />";
							data = $.extend(data, {goodsEstmNo : $("#commentForm").data('goodsEstmNo')});
						}
						data.petNo = (data.petNo == '' ? null : data.petNo);

						if("${view.deviceGb}" == "APP"){
							data.imgPath = null;
						}

						var options = {
							url : url
							, type : "POST"
							, data : data
							, done : function(result){
								if(goodsEstmTp == '${frontConstants.GOODS_ESTM_TP_NOR}'){
									if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}" && $("#commentImgArea").find('span:not([name=orgImg])').length > 0) {
										$("#commentForm").data('goodsEstmNo', result.goodsEstmNo);
										onFileUpload(result.goodsEstmNo);
									} else {
										ui.toast("후기가 등록되었어요",{
											bot:70, //바닥에서 띄울 간격
										});
										
										setTimeout("location.href='/mypage/goodsCommentList?selectTab=aftTab'",1500);
									}
									/* location.href = "/mypage/goodsCommentList"; */
								}else{
									var html = '';
									var url = '';
									if(writeFnc.petLogNo != null && writeFnc.petLogNo != ''){
										if(document.referrer.indexOf("/goods/indexGoodsDetail") > -1){
											url = "/log/indexPetLogUpdateView?commentYn=Y&&goodsYn=Y"
										}else{
											url = "/log/indexPetLogUpdateView?commentYn=Y"
										}
									}else{
										//url = "${view.stDomain}/log/indexPetLogInsertView";
										url = "/log/indexPetLogInsertView";
									}

									var ordNo = data.ordNo + data.ordDtlSeq;

									html += '<input type="hidden" name="goodsEstmNo" value="'+result.goodsEstmNo+'">';
									html += '<input type="hidden" name="rltId" value="'+result.goodsId+'">';
									html += '<input type="hidden" name="petLogNo" value="'+writeFnc.petLogNo+'">';
									html += '<input type="hidden" name="petLogChnlCd" value="${frontConstants.PETLOG_CHNL_20}">';
									html += '<input type="hidden" name="rtnUrl" value="/mypage/goodsCommentList?selectTab=aftTab">';
									html += '<input type="hidden" name="ordNo" value="'+ordNo+'">';

									var goform = $("<form>",{
										method : "post",
										action : url,
										target : "_self",
										html : html
									}).appendTo("body");
									goform.submit();
								}
							}
							, fail : function(){
								writeFnc.btnCtrl = true;
							}
						};
						if(writeFnc.btnCtrl){
							writeFnc.btnCtrl = false;
							ajax.call(options);
						}
					}else{
						ui.toast("후기 작성 항목을 모두 선택해주세요");
					}
				},
				imageUpload : function(){
					if ($('li[id^="commentImgArea_"]').length >= 5) {
						ui.alert("파일 첨부는 최대 5개까지 가능합니다");
						return false;
					}
					// 파일 추가
					/* fileUpload.inquiry(writeFnc.resultImage); */
					fileUpload.callBack = writeFnc.resultImage;
					$("#fileUploadForm").remove();
					var html = [];
					html.push("<form name=\"fileUploadForm\" id=\"fileUploadForm\" method=\"post\" enctype=\"multipart/form-data\">");
					html.push("	<div style=\"display:none;\">");
					html.push("		<input type=\"file\" name=\"uploadFile\" id=\"uploadFile\"  accept=\"image/*\"/>");
					html.push("		<input type=\"hidden\" name=\"uploadType\" value=\"inquiry\">");
					html.push("	</div>");
					html.push("</form>");
					$("body").append(html.join(''));
					$("#uploadFile").click();


				},
				resultImage : function(file){
					var area = "";
					var count = "1";
					area = $("li[id^=commentImgArea_]").length!=0?$("li[id^=commentImgArea_]").last()[0]:null;
					if(area != null && area != ""){
						count = parseInt(area.id.split('_')[1])+1;
					}

					var html = "";
					html += "<li id=\"commentImgArea_"+ count +"\">";
					html += "<input type=\"hidden\" name=\"imgPath\" value=\""+file.filePath+"\"/>";
					html += "<span class=\"pic\">";
					html += "<img class=\"img\" src=\"/common/imageView.do?filePath="+file.filePath+"\" alt=\"사진\">";
					html += "<button type=\"button\" class=\"bt del\" name=\"delImg\" >삭제</button>";
					html += "</span>";
					html += "</li>";
					$("#commentImgArea").append(html);

					commentImgCheck();
				},
				appResultImage : function(result){
					imageResult = JSON.parse(result);
					var area = "";
					var count = "1";
					area = $("li[id^=commentImgArea_]").length!=0?$("li[id^=commentImgArea_]").last()[0]:null;
					if(area != null && area != ""){
						count = parseInt(area.id.split('_')[1])+1;
					}

					var html = "";
					html += "<li id=\"commentImgArea_"+ count +"\">";
					html += "	<input type=\"hidden\" name=\"imgPath\" value=\""+imageResult.imageToBase64+"\"/>";
					html += "	<span class=\"pic\">";
					html += "		<img class=\"img\" name=\"goodsCommentImg\" id=\"" + imageResult.fileId + "\" src=\"" + imageResult.imageToBase64 + "\" alt=\""+imageResult.mediaType +"\">";
					html += "		<button type=\"button\" onclick=\"callAppFunc(\"onDeleteImage\",this);\" class=\"bt del\" name=\"delImg\" >삭제</button>";
					html += "	</span>";
					html += "</li>";
					$("#commentImgArea").append(html);

					commentImgCheck();
				},
				appDeleteResultImage : function(resultJson){
					var imageResult = $.parseJSON(resultJson);
					$("#"+imageResult.fileId).parents("li").remove();

					commentImgCheck();
				}
			}

			function onFileUpload(estmNo){
				callAppFunc('onFileUpload', estmNo);
			}

			function callAppFunc(funcNm, obj) {
				toNativeData.func = funcNm;
				if(funcNm == 'onOpenGallery'){ // 갤러리 열기
					// 데이터 세팅
					toNativeData.useCamera = "P";
					toNativeData.usePhotoEdit = "N";
					toNativeData.galleryType = "P"
					//미리보기 영역에 선택된 이미지가 있을 경우.------------//
					let fileIds = new Array();
					let fileIdDivs = $("img[name=goodsCommentImg]");
					fileIdDivs.each(function(i, v) {
						fileIds[i] = $(this).attr("id");
					})
					toNativeData.fileIds = fileIds;
					//---------------------------------------//
					var orgImgCnt = $($("#commentImgArea").find('span[name=orgImg]')).length;
					toNativeData.maxCount = (5 - orgImgCnt)+"";
					/* toNativeData.previewWidth = 188;
					toNativeData.previewHeight = 250; */
					toNativeData.callback = "writeFnc.appResultImage";
					toNativeData.callbackDelete = "writeFnc.appDeleteResultImage";
				}else if(funcNm == 'onDeleteImage'){ // 미리보기 썸네일 삭제
					// 데이터 세팅
					var fileId = $(obj).parent().find("img").attr("id");
					// 화면에서 이미지 삭제
					if($(obj).parent().data('imgSeq') != null){
						html += "<input type=\"hidden\" name=\"delImgSeq\" value=\""+$(obj).parent().data('imgSeq')+"\">";
						$("#commentImgArea").append(html);
					}

					$(obj).parents('li').remove();



					// 데이터 세팅
					toNativeData.func = "onDeleteImage";
					toNativeData.fileId = fileId;
					toNativeData.callback = "commentImgCheck";

				}else if(funcNm == 'onFileUpload'){ // 파일 업로드
					// 데이터 세팅
					toNativeData.func = funcNm;
					toNativeData.prefixPath = "/goods_comment/"+obj;
					toNativeData.callback = "onFileUploadCallBack";

				}else if(funcNm == 'onClose'){ // 화면 닫기
					// 데이터 세팅
					toNativeData.func = funcNm;

				}
				// 호출
				toNative(toNativeData);
			}

			function onFileUploadCallBack(result) {
				var file = JSON.parse(result);
				var goodsEstmNo = $("#commentForm").data('goodsEstmNo');
				var imgPath = new Array();
				/* file.images[0].filePath */
				if(file.images.length != 0){
					for(var i = 0; i < file.images.length; i++){
						imgPath.push(file.images[i].filePath);
					}
				}

				var options = {
					url : "<spring:url value='/mypage/appCommentImageUpdate' />"
					, data : { goodsEstmNo : goodsEstmNo, imgPath : imgPath }
					, done : function(result) {
						ui.toast("후기가 등록되었어요",{
							bot: 74, //바닥에서 띄울 간격
						});
						
						setTimeout("location.href='/mypage/goodsCommentList'",1500);
					}
				}
				ajax.call(options);
			}

			var validateComment = {
				check : function(){
					var _this = validateComment;
					var result = false;
					if(_this.scoreCheck() && _this.qstCheck() && _this.contentCheck()){
						result = true;
					}
					return result;
				},
				scoreCheck : function(){
					var score = $("#commentForm").find('li.f').length+$("#commentForm").find('li.h').length;
					if(score == 0){
						/* ui.alert('별점을 선택해주세요.'); */
						return false;
					}
					return true;
				},
				qstCheck : function(){
					if($("div[name=goodsEstmQstArea]").length != 0){
						for(var i = 0; i < $("div[name=goodsEstmQstArea]").length; i++){
							var area = $("div[name=goodsEstmQstArea]")[i];
							if($(area).find("input[name^=estmQstNo_]:checked").length == 0){
								var msg = $(area).find(".tit").text();
								/* ui.alert("\""+msg+"\" 항목을 평가해주세요."); */
								return false;
							}
						}
					}
					return true;
				},
				contentCheck : function(){
					if($("textArea[name=commentContArea]").length != 0){
						if($("textArea[name=commentContArea]").val().length == 0){
							return false;
						}
						/* if($("textArea[name=commentContArea]").val().length < 10){
							ui.alert("내용을 10자 이상 입력해주세요.");
							return false;
						} */
					}
					return true;
				}
			}

			function delImage(btn){
				var html = '';
				if($(btn).parent().data('imgSeq') != null){
					html += "<input type=\"hidden\" name=\"delImgSeq\" value=\""+$(btn).parent().data('imgSeq')+"\">";
					$("#commentImgArea").append(html);
				}

				$(btn).parents('li').remove();

				commentImgCheck();
			}

			//이미지 갯수 체크
			function commentImgCheck(){
				if($("#commentImgArea").children('li').length >= 5){
					$("#imgAddBtn-comment").attr('disabled', 'disabled');
					$("#imgAddBtn-comment").css('opacity', '0.5');
					$("#imgAddBtn-comment").addClass('disabled');
				}else{
					$("#imgAddBtn-comment").removeAttr('disabled');
					$("#imgAddBtn-comment").css('opacity', '');
					$("#imgAddBtn-comment").removeClass('disabled');
				}

			}

		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<main class="container lnb page my" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<div class="pc-tit">
						<h2 id="asd">후기 작성</h2>
					</div>
					<form id="commentForm" data-goods-estm-tp="${gso.goodsEstmTp }" data-goods-estm-no="${gso.goodsEstmNo }">
						<div class="uirevset-my">
							<div class="set gods line-n">
								<div class="cdt">
									<div class="tops">
										<div class="pic"><img src="${frame:imagePath(vo.imgPath)}" alt="상품" class="img"></div>
										<div class="name">
											<div class="tit k0423">${vo.goodsNm }</div>
											<div class="stt k0423">${vo.cstrtShowNm}</div>
										</div>
									</div>
								</div>
							</div>
							<div class="flex-box">
									<%-- 지종근 차장님이 주석 요청. 2021-04-30
                                    <c:if test="${gso.goodsEstmTp eq frontConstants.GOODS_ESTM_TP_PLG }">
                                        <div class="g-text h_auto">
                                            펫로그 후기를 작성하시면 <span>500P가 지급됩니다.</span>
                                        </div>
                                    </c:if>
                                    --%>
								<div class="set star">
									<div class="hdt">
										<span class="tit">구매하신 상품이 만족스러운가요?</span>
									</div>
									<div class="cdt">

										<div class="uiStar">
											<ul>
												<li><button type="button" class="st">별</button></li>
												<li><button type="button" class="st">별</button></li>
												<li><button type="button" class="st">별</button></li>
												<li><button type="button" class="st">별</button></li>
												<li><button type="button" class="st">별</button></li>
											</ul>
										</div>
										<div class="msg">별을 선택하여 만족도를 알려주세요.</div>
									</div>
								</div>
								<div class="right">
									<c:forEach var="estmList" items="${vo.goodsEstmQstVOList}" varStatus="status">
										<div class="set rdos" name="goodsEstmQstArea">
											<div class="hdt">
												<span class="tit">${estmList.qstContent }</span>
												<input type="hidden" name="estmQstNos" value="${estmList.estmQstNo }"/>
											</div>
											<div class="cdt">
												<c:forEach var="estmDetail" items="${estmList.estmQstVOList }">
													<label class="radio">
														<input type="radio" name="estmQstNo_${estmList.estmQstNo }" value="${estmDetail.estmItemNo }">
														<span class="txt"><em class="tt">${estmDetail.itemContent }</em></span>
													</label>
												</c:forEach>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
							<c:if test="${not empty vo.petBaseVOList}">
								<div class="set rdos">
									<div class="hdt">
										<span class="tit">어느 펫을 위해 구매하셨나요?</span>
									</div>
									<div class="cdt" >
										<c:if test="${view.deviceGb ne 'PC' }">
										<div class="swiper-container whopet">
											<!-- Additional required wrapper -->
											<div class="swiper-wrapper">
												</c:if>
												<c:forEach var="petData" items="${vo.petBaseVOList }">
													<c:if test="${view.deviceGb ne 'PC' }">
														<div class="swiper-slide" style="margin-right:30px;">
													</c:if>
													<label class="radio"><input type="radio" name="petNo" value="${petData.petNo }"><span class="txt"><span class="pic"><img src="${frame:imagePath(petData.imgPath)}" alt="이미지" class="img"></span><em class="tt">${petData.petNm }</em></span></label>
													<c:if test="${view.deviceGb ne 'PC' }">
														</div>
													</c:if>
												</c:forEach>
												<div class="swiper-slide"><label class="radio"><input type="radio" id="noPet" name="petNo" value=""><span class="txt"><em class="tt no">선택안함</em></span></label></div>
												<c:if test="${view.deviceGb ne 'PC' }">
											</div>
										</div>
										</c:if>
									</div>
								</div>
								<!-- 2021.03.25 : 추가 -->
								<script>
									var totalWidth = 0;
									for(var i = 0 ; i < $(".swiper-container.whopet").find(".swiper-slide").length ; i++){
										var width = $(".swiper-container.whopet").find(".swiper-slide").eq(i).width();
										totalWidth = totalWidth + width +30;
									}
									if(totalWidth-30 > $(".swiper-container.whopet").width()){
										var whopet =  new Swiper(".swiper-container.whopet", {
											slidesPerView: 'auto',
											slidesPerGroup:1,
											spaceBetween: 30,
										});
									}
								</script>
								<!-- // 2021.03.25 : 추가 -->

							</c:if>
							<c:if test="${gso.goodsEstmTp eq frontConstants.GOODS_ESTM_TP_NOR}">
								<div class="set memo">
									<div class="hdt">
										<span class="tit">후기 내용 입력</span>
									</div>
									<div class="textarea">
										<textarea name="commentContArea" placeholder="다른 고객님들에게 도움이 되는 후기를 입력해주세요. 후기 내용은 최소 10자 이상 입력해주세요.">${commentVO.content}</textarea>
									</div>
								</div>
								<div class="set file">
									<div class="flex-box">
										<div class="btnSet">
											<button type="button" class="btn lg btnAddPic" id="imgAddBtn-comment" onclick="${view.deviceGb ne 'APP'?"$('#imgAdd-comment').trigger('click')":"callAppFunc('onOpenGallery', this)"}">사진 첨부하기</button>
											<input type="file" id="imgAdd-comment" onclick="writeFnc.imageUpload(); return false;" style="display: none;" accept="image/*"/>
										</div>
										<div class="addfile">
											<ul class="photo" id="commentImgArea">
												<c:forEach var="imgData" items="${commentVO.goodsCommentImageList }">
													<li>
													<span class="pic" name="orgImg" data-img-seq="${imgData.imgSeq }">
														<img class="img" src="${fn:indexOf(imgData.imgPath,'http') > -1 ? imgData.imgPath : frame:optImagePath(imgData.imgPath, frontConstants.IMG_OPT_QRY_794)}" alt="사진">
														<button type="button" class="bt del" name="delImg">삭제</button>
													</span>
													</li>
												</c:forEach>
											</ul>
										</div>
									</div>
									<div class="gmsgListWrap onWeb_b">
										<p class="gmsg info-t1"><spring:message code='front.web.view.new.menu.log'/> 후기는 모바일앱에서 작성할 수 있습니다. </p> <!-- APET-1250 210728 kjh02  -->
										<p class="gmsg info-t1">20MB 미만의 JPG, PNG 파일만 등록 가능합니다.</p>
									</div>
								</div>
							</c:if>
							<div class="set btts">
								<div class="btnSet">
									<button type="button" class="btn lg d" name="writeCancel">취소</button>
									<c:choose>
										<c:when test="${gso.goodsEstmTp ne frontConstants.GOODS_ESTM_TP_PLG}">
											<button type="button" class="btn lg a disabled" name="okbtn" onclick="writeFnc.writeComment(); return false;" style="pointer-events:all;">등록</button>
										</c:when>
										<c:otherwise>
											<button type="button" class="btn lg a disabled" name="okbtn" onclick="writeFnc.writeComment(); return false;" style="pointer-events:all;">다음</button>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div class="set gud onWeb_b on-pc-design">
								<div class="hdt">
									<span class="tit">유의사항</span>
								</div>
								<div class="cdt info-txt" data-ui-tog="ctn open" data-ui-tog-val="tog_guds_1">
									<ul>
										<li>상품과 무관한 내용이나 동일 문자의 반복 등 부적합한 후기는 사전 경고 없이 삭제될 수 있습니다. 후기가 삭제될 경우에는 적립 혜택이 회수됩니다.</li>
									</ul>
								</div>
							</div>
							<div class="btnSet pc pc-bottom-s1 mo-margin-s1">
								<a href="javascript:;" class="btn lg d onWeb_if" name="writeCancel">취소</a>
								<c:choose>
									<c:when test="${gso.goodsEstmTp ne frontConstants.GOODS_ESTM_TP_PLG}">
										<a href="javascript:;" class="btn lg a ${empty gso.goodsEstmNo ? 'disabled' : ''}" name="okbtn" onclick="writeFnc.writeComment(); return false;" style="pointer-events:all;">등록</a>
									</c:when>
									<c:otherwise>
										<a href="javascript:;" class="btn lg a ${empty gso.goodsEstmNo ? 'disabled' : ''}" name="okbtn" onclick="writeFnc.writeComment(); return false;" style="pointer-events:all;">다음</a>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="set gud none_bb">
								<div class="hdt">
									<span class="tit">유의사항</span>
								</div>
								<div class="cdt info-txt" data-ui-tog="ctn open" data-ui-tog-val="tog_guds_1">
									<ul>
										<li>상품과 무관한 내용이나 동일 문자의 반복 등 부적합한 후기는 사전 경고 없이 삭제될 수 있습니다. 후기가 삭제될 경우에는 적립 혜택이 회수됩니다.</li>
									</ul>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</main>
		<div class="layers">
			<!-- 레이어팝업 넣을 자리 -->
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ page import="front.web.config.constants.FrontWebConstants" %>
<tiles:insertDefinition name="mypage">
	<tiles:putAttribute name="script.include" value="script.member"/>
	<tiles:putAttribute name="script.inline">
		<script type="text/javascript" 	src="/_script/file.js"></script>
		<script type="text/javascript">
			<c:if test="${view.deviceGb ne 'PC'}">
				$(function(){
					$("#header_pc").removeClass('mode0');
					$("#header_pc").addClass('mode7-1 logHeaderAc');
					//$("#header_pc").addClass('noneAc');
					/* $("#header_pc").addClass('mode7-1 noneAc'); */
					$($("#header_pc").find('.tit')).text('상품 후기');
					$(".menubar").remove();
					$("footer").remove();
					$('.mo-header-backNtn').attr("onclick", "location.href='/mypage/indexMyPage/'");
					
					if("${view.deviceGb}" == "${frontConstants.DEVICE_GB_30}"){
						toNativeData.func = "onPetLogEncodingCheck";
						toNativeData.callback = "onPetLogEncodingCheckCallback";
						toNative(toNativeData);
					}
				});
			</c:if>
			$(function(){
				var popYn="${popYn}";
				
				/* if(popYn){
					ui.popLayer.open("popRevCom")		
				} */

				//썸네일, 상품명 클릭 시  상품 상세 페이지로 이동
				$(".pic, .t1").on('click', function(){
					var goodsId = $(this).parents(".item").data('goodsId');
					var pakGoodsId = $(this).parents(".item").data('pakGoodsId');
					if(pakGoodsId != null && pakGoodsId != ""){
						goodsId = pakGoodsId;
					} 
					location.href = "/goods/indexGoodsDetail?goodsId="+goodsId;
				});
				
// 				$("div[name=myEstmResult]").on('click', function(){
// 					myComment.updateMyComment(this);
// 				})

			});
			
			function onPetLogEncodingCheckCallback(vdId){
				if(vdId){ updateEncCpltYn(vdId , 'N') }
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
						}
				}
					ajax.call(options);				
			}
			
			var myComment = {
				deviceGb : '${view.deviceGb}',
				goodsId : '',
				ordNo : '',
				ordDtlSeq : '',
				goodsEstmNo : '',
				bfSize : '${bfVOList.size() }',
				aftSize : '${aftVOList.size() }',
				petRegYn : "${session.petNos != null ? 'Y' : 'N'}",
				//펫로그 사용 회원 여부 : 회원 = 'Y', 비회원 = 'N' 
				plgYn : "${session.petLogUrl != null && session.petLogUrl != '' ? 'Y':'N'}",
				//상품평 작성 페이지 이동
				CommentWriteView : function(btn){
					var goodsEstmTp = $(btn).data('goodsEstmTp');
					var goodsEstmNo = "";
					
					if(goodsEstmTp == "PLG"){
						var goodsEstmNo = myComment.goodsEstmNo;
					}
						
					/* if(goodsEstmNo != null && goodsEstmNo != "" && myComment.deviceGb != "APP"){
						ui.alert('작성중이던 펫로그 후기가 있습니다. 펫로그 후기는 모바일 앱에서 작성 가능합니다.');
						return false;
					}else{ */
					var url = "/mypage/commentWriteView"
					var html = '';
					html += '<input type="hidden" name="goodsId" value="'+myComment.goodsId+'">';
					html += '<input type="hidden" name="ordNo" value="'+myComment.ordNo+'">';
					html += '<input type="hidden" name="ordDtlSeq" value="'+myComment.ordDtlSeq+'">';
					html += '<input type="hidden" name="goodsEstmTp" value="'+goodsEstmTp+'">';
					if(goodsEstmNo != null && goodsEstmNo != ""){
						html += '<input type="hidden" name="goodsEstmNo" value="'+goodsEstmNo+'">';
					} 
					var goform = $("<form>",
						{ method : "post",
						action : url,
						target : "_self",
						html : html
						}).appendTo("body");
					goform.submit();
					/* } */
				},
				//상품평 작성 선택 팝업(상품 후기, 펫로그 후기)
				writePop : function(btn){
					var dataDiv = $(btn).parents('div[name=orderGoods]');
					myComment.goodsId = dataDiv.data('goodsId');
					myComment.ordNo = dataDiv.data('ordNo');
					myComment.ordDtlSeq = dataDiv.data('ordDtlSeq');
					myComment.goodsEstmNo = dataDiv.data('goodsEstmNo');
					/* if(dataDiv.data('goodsEstmNo') != null && dataDiv.data('goodsEstmNo') != ""){
						myComment.CommentWriteView(norBtn, dataDiv.data('goodsEstmNo'));
					}else */ 
					if(myComment.deviceGb == 'APP' && myComment.plgYn == 'Y' && myComment.petRegYn =='Y') {
						ui.selAc.open('#acSelect');
					}else{
						var norBtn = $("li[name=norBtn]")[0];
						myComment.CommentWriteView(norBtn);
					}
				},
				getMyCommentList : function(bfAftCheck){
					
					var options = {
						url : "<spring:url value='/mypage/myCommentList.do' />"
						, type : "POST"
						, dataType : "html"
						, data : {
							bfAftCheck : bfAftCheck
						}
						, done : function(result){
							console.log(bfAftCheck);
							if(bfAftCheck == 'bf'){
								$("div[name=bfList]").html(result);
							}else if(bfAftCheck == 'aft'){
								$("div[name=aftList]").html(result);
							}
						}
					};
					ajax.call(options);
				},
				//상품 후기 삭제
				deleteMyComment : function(btn){
					var _this = myComment;
					var estmData = $(btn).parents('div[name=estmData]');
					ui.confirm('후기를 삭제할까요?',{
						ycb:function(){
							var options = {
							// APETQA-6430 펫로그 중복 삭제 로직으로 url 변경 /mypage/deleteMyComment.do -> /goods/petLogCmtDelete.do
								url : "<spring:url value='/goods/petLogCmtDelete.do' />"
								, type : "POST"
								, data : {
									goodsEstmNo : estmData.data('goodsEstmNo')
									,goodsId : estmData.data('goodsId')
									,ordNo : estmData.data('ordNo')
									,ordDtlSeq : estmData.data('ordDtlSeq')
									,petLogNo : estmData.data('petLogNo')
									,goodsEstmTp : estmData.data('goodsEstmTp')
								}
								, done : function(result){
									/* location.reload(); */
									//목록에서 상품평 삭제 후 토스트 알림
									_this.getMyCommentList('bf');
									$(estmData).remove();
									_this.bfSize = parseInt(_this.bfSize)+1;
									_this.aftSize = parseInt(_this.aftSize)-1;
									$("a[name=bfTab]").html('<span>작성 가능한 후기 '+ _this.bfSize + '</span>');
									$("a[name=aftTab]").html('<span>내가 작성한 후기 '+ _this.aftSize + '</span>');
									$("[name=bfNoComment]").hide();
									ui.toast('후기가 삭제 되었어요');
								}
							};
							ajax.call(options);
						},
						ncb:function(){
							return false;
						},
					    ybt:"예", // 기본값 "확인"
					    nbt:"아니오"
					});
				},
				//상품 후기 수정
				updateMyComment : function(btn){
					var estmData = $(btn).parents('div[name=estmData]');
					if(estmData.data('goodsEstmTp') == "PLG" && myComment.deviceGb != "APP"){
						ui.alert('펫로그 후기는 <br>모바일 앱에서 수정 가능합니다.');
						return false;
					}else{
						var url = "/mypage/commentWriteView"
						var html = '';
						html += '<input type="hidden" name="goodsId" value="'+estmData.data('goodsId')+'">';
						html += '<input type="hidden" name="ordNo" value="'+estmData.data('ordNo')+'">';
						html += '<input type="hidden" name="ordDtlSeq" value="'+estmData.data('ordDtlSeq')+'">';
						html += '<input type="hidden" name="goodsEstmTp" value="'+estmData.data('goodsEstmTp')+'">';
						html += '<input type="hidden" name="goodsEstmNo" value="'+estmData.data('goodsEstmNo')+'">';
						if(estmData.data('goodsEstmTp') != null && estmData.data('goodsEstmTp') == "PLG"){
							html += '<input type="hidden" name="petLogNo" value="'+estmData.data('petLogNo')+'">';
						}
						var goform = $("<form>",
							{ method : "post",
							action : url,
							target : "_self",
							html : html
							}).appendTo("body");
						goform.submit();
					}
				}
			}
			
		</script>
	</tiles:putAttribute>
	<tiles:putAttribute name="content">
		<!-- 바디 - 여기위로 템플릿 -->
		<main class="container lnb page my" id="container">
			<div class="inr">
				<!-- 본문 -->
				<div class="contents" id="contents">
					<!-- PC 타이틀 모바일에서 제거  -->
					<div class="pc-tit">
						<h2>상품후기</h2>
					</div>
					<!-- // PC 타이틀 모바일에서 제거  -->
					<div class="petTabContent leftTab mode_fixed hmode_auto">
					<!-- 2021.03.15 : mode_fixed, hmode_auto 클래스 추가 -->
						<ul class="uiTab a line">
							<li class="${empty selectTab ? 'active':''}">
								<a class="bt" name="bfTab" href="javascript:;"><span>작성 가능한 후기 ${bfVOList.size() }</span></a>
							</li>
							<li class="${not empty selectTab and selectTab eq 'aftTab' ? 'active':''}">
								<a class="bt" name="aftTab" href="javascript:;"><span>내가 작성한 후기 ${aftVOList.size() }</span></a>
							</li>
						</ul>
						<!-- tab content -->
						<div class="uiTab_content">
							<ul>
								<li>
									<div class="inr-box noneBoxPoint" name="bfNoComment" style="${not empty bfVOList ?'display:none;':'' }"> <!-- 내역 없을 경우 style block-->
										<section class="no_data i1 auto_h">
											<div class="inr">
												<div class="msg">작성 가능한 상품 후기가 없습니다.</div>
											</div>
										</section>
									</div>
									<!-- 리뷰 -->
									<div class="review-area" name="bfList">
										<jsp:include page="/WEB-INF/view/mypage/comment/include/includeMyBfComment.jsp" />
									</div>
									<!-- 리뷰 -->
								</li>
								<li>
									<div class="inr-box noneBoxPoint" style="${not empty aftVOList ?'display:none;':'' }"> <!-- 내역 없을 경우 style block-->
										<section class="no_data i1 auto_h">
											<div class="inr">
												<div class="msg">작성하신 후기가 없습니다.</div>
											</div>
										</section>
									</div>
									<!-- 리뷰 -->
									<div class="review-area t2" name="aftList" style="${empty aftVOList ?'display:none;':'' }">
										<jsp:include page="/WEB-INF/view/mypage/comment/include/includeMyAftComment.jsp" />
									</div>
									<!-- 리뷰 -->
								</li>
								
							</ul>
						</div>
					</div>	
					<!-- <include class="uibanners" data-include-html="../inc/banner.html"></include> -->
				</div>
			</div>
		</main>

<div id ="layer">
<article class="popBot popRevCom on noClickClose" id="popRevCom" style="display:none;">
	<div class="pbd">
		<div class="pct">
			<main class="poptents">
				<section class="rvcoms">
					<div class="ben"></div>
					<div class="tit">후기를 작성해 주셔서 감사합니다</div>
					<div class="msg"><!-- 500p가 지급되었어요! --></div>
					<div class="btnSet">
						<button type="button" class="btn lg a" id="confirmBtn" onclick="ui.popLayer.close('popRevCom')">확인</button>
					</div>
				</section>
			</main>
		</div>
	</div>
</article>
</div>

		<!-- select 레이어 팝업 -->
		<div class="acSelect t2 k0429" id="acSelect">
			<input type="text" class="acSelInput" readonly />
			<div class="head ">
				<div class="con">
					<div class="tit">후기작성</div>
					<a href="javascript:;" class="close" onClick="ui.selAc.close(this)"></a>
				</div>
			</div>
			<div class="con">
				<ul class="selReview">
					<li onClick="ui.selAc.liClick(this);myComment.CommentWriteView(this);" data-goods-estm-tp="NOR" name='norBtn'>
						<img src="../../_images/my/icon-review-normal@2x.png">
						<span>일반 후기 작성</span> 
					</li>
					<li onClick="ui.selAc.liClick(this);myComment.CommentWriteView(this);" data-goods-estm-tp="PLG" name='plgBtn'>
						<img src="../../_images/my/icon-review-log@2x.png">
						<span><spring:message code='front.web.view.new.menu.log'/> 후기 작성</span> <!-- APET-1250 210728 kjh02  -->
					</li>
				</ul>
			</div>
		</div>
		
		<c:if test="${view.deviceGb eq frontConstants.DEVICE_GB_10}" >
			<jsp:include page="/WEB-INF/tiles/include/floating.jsp">
	        	<jsp:param name="floating" value="talk" />
	        </jsp:include>
        </c:if>
		
		
		
		<!-- //select 레이어 팝업 -->
		<!-- 바디 - 여기 밑으로 템플릿 -->
	</tiles:putAttribute>
</tiles:insertDefinition>
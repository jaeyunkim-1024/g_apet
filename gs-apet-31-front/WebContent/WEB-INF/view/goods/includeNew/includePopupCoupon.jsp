<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<style>
	li.disabled button {
		cursor: default;
	}
</style>
<script type="text/javascript">
	//쿠폰 목록 세팅
	var cpNos = [];
	var couponList = [];
	var limit = 20;

	$(function(){
		fnGetCoupons('<c:out value="${goods.goodsId}"/>', '<c:out value="${goods.goodsCstrtTpCd}"/>');
	});

	/**
	 * 쿠폰 목록 조회
	 */
	function fnGetCoupons(goodsId, goodsCstrtTpCd, goodsNm) {
		//묶음/옵션 상품 목록 클릭하였을 경우
		
		//묶음/옵션 상품 목록 콤보 박스 닫기
		if($("#popCouponOptPdSel").is(":visible")){
			ui.popBot.close('popCouponOptPdSel');
		}
		
		if(goodsNm) {
			//묶음/옵션 상품 목록 선택 상품명 세팅
			$('#goodsNm').text(goodsNm);
		}

		//화면 초기화
		couponList = [];
		$('#couponUl').html('');

		// 쿠폰 템플릿
		var template = document.querySelector("#templateCouponli").innerHTML;

		var options = {
			url : '<spring:url value="/goods/getGoodsCoupon"/>'
			, data : {goodsId:goodsId, goodsCstrtTpCd:goodsCstrtTpCd}
			, done : function(result){
				if(result.goodsCoupon) {
					var list = result.goodsCoupon;

					//쿠폰 전체받기 버튼 비활성화 체크
					var isDisbled = true;

					$.each(list, function(i, v) {
						var disabled = (v.cpUseYn == 'Y') ? 'disabled':'';

						// 하나라도 다운로드 받을 쿠폰이 있다면 전체다운받기 활성화 시키기
						if((v.cpUseYn == 'N')) {
							isDisbled = false;
						}

						var aplVal = numberWithCommas(v.aplVal);
						var aplTxt = aplVal + (v.cpAplCd == '10' ? ' % 할인' : '원 할인');
						var vldPrdCd = v.vldPrdCd;
						//10	발급일
						//20	일자지정
						var vldPrdPeriod = '';
						if(vldPrdCd == '10') {
							var vldPrdDay = v.vldPrdDay;
							vldPrdPeriod = '발급일로부터 ' +vldPrdDay+ '일까지';
						} else if(vldPrdCd == '20') {
							vldPrdPeriod = new Date(v.vldPrdStrtDtm).dateFormat('yyyy.MM.dd HH:mm:ss') + ' ~ ' + new Date(v.vldPrdEndDtm).dateFormat('yyyy.MM.dd HH:mm:ss');
							//var aplPeriod = new Date(v.vldPrdStrtDtm).dateFormat('yyyy.MM.dd HH:mm:ss') + ' ~ ' + new Date(v.vldPrdEndDtm).dateFormat('yyyy.MM.dd HH:mm:ss');
						}


						var maxDcTxt = new Array();
						if(v.minBuyAmt && v.minBuyAmt > 0) {
							maxDcTxt.push(numberWithCommas(v.minBuyAmt) + '원 이상 구매 시');
						}
						if(v.maxDcAmt && v.maxDcAmt > 0) {
							maxDcTxt.push('최대' + numberWithCommas(v.maxDcAmt) + '원 할인');
						}

						var notice = '';
						var none = 'none';
						if(v.notice != null){
							v.notice = v.notice.replace(/[*<br>|*&nbsp;|*\s|*</br>|*<p>|*</p>]/gi,'');
							if(v.notice != '' && v.notice != null && v.notice) {
								notice = v.notice;
								none = 'block';
							}
						}

						var coupon = template
								.replace(/{{disabled}}/gi, disabled)
								.replace(/{{aplTxt}}/gi, aplTxt)
								.replace(/{{notice}}/gi, notice)
								.replace(/{{none}}/gi, none)
								.replace(/{{cpNo}}/gi, v.cpNo)
								.replace(/{{cpNm}}/gi, v.cpNm)
								.replace(/{{maxDcTxt}}/gi, maxDcTxt.join('/'))
								.replace(/{{vldPrdPeriod}}/gi, vldPrdPeriod);

						couponList.push(coupon);
						cpNos.push({cpNo : v.cpNo, cpUseYn:v.cpUseYn});
					});

					//전체 쿠폰 다운로드 버튼 비활성화
					$('#downloadAllBtn').prop('disabled', isDisbled);

					if(couponList.length > 0) {
						$('#isCoupon').show();
					} 
					fnCouponList();
				}
			}
		};
		ajax.call(options);
	}
	/**
	 * 쿠폰 목록 조회
	 */
	function fnCouponList(page) {
		//console.log('쿠폰 목록 조회:' + page);
		if(!page) {
			page = 0;
		}

		var pageStrt = page * limit;
		var pageEnd = pageStrt + limit;
		$.each(couponList, function(i, v){
			if(i >= pageStrt && i < pageEnd) {
				$('#couponUl').append(v);
			}
		});

		// 상품 상세 쿠폰받기 버튼 활성화
		/* if(page == 0) {
			$('#isCoupon').show();
		} */
	}

	function fnCheckLogin(cpNo, obj) {

		if('${session.isLogin()}' == 'true') {
			if(cpNo == null) {
				fnDownloadGoodsCouponAll();
			} else {
				fnDownloadGoodsCoupon(cpNo);
			}
		} else {
			ui.confirm('로그인 후 서비스를 이용할 수 있어요.<br>로그인 할까요?',{ // 컨펌 창 옵션들
				ycb:function(){
					var url = encodeURIComponent(document.location.href);
					//App일때 영상상세에서 다른화면으로 이동시 화면 닫고 이동해야함
					if("${view.deviceGb eq frontConstants.DEVICE_GB_30}" == "true" && document.location.href.indexOf("/tv/series/indexTvDetail") > -1){
						// 데이터 세팅
						toNativeData.func = "onCloseMovePage";
						toNativeData.moveUrl = "${view.stDomain}/indexLogin?returnUrl="+url;
						// APP 호출
						toNative(toNativeData);
					}else{
						document.location.href = '/indexLogin?returnUrl='+url;
					}
				},
				ncb:function(){
					return false;
				},
				ybt:"로그인", // 기본값 "확인"
				nbt:"취소"  // 기본값 "취소"
			});
		}
	}

	/**
	 * 쿠폰 다운로드
	 * @param cpNo
	 * @param obj
	 */
	async function fnDownloadGoodsCoupon(cpNo) {

		var option = {
			url : '<c:url value="/goods/downloadGoodsCoupon"/>'
			,   data : { cpNo : cpNo }
			,   done : function(data){

				if(data.result > 0) {
					//성공한 쿠폰 다운로드 버튼 비활성화
					$('#li_'+ cpNo).addClass('disabled');
					ui.toast("쿠폰 다운로드가 완료되었어요.")
				} else {
					if(data.message) {
						ui.toast(data.message);
					}
				}
			}
		};
		await ajax.call(option);
	}

	/**
	 * 쿠폰 다운로드
	 * @param cpNo
	 * @param obj
	 */
	async function fnDownloadGoodsCouponAll() {

		if('${session.isLogin()}' == 'true') {

			var size = cpNos.length;
			var noCpNos = [];

			//다운로드 받지 않은 쿠폰 세팅
			$.each(cpNos, function(i,v) {
				if(v.cpUseYn == 'N') {
					noCpNos.push(v.cpNo);
				}
			});

			var option = {
				url : '<c:url value="/goods/downloadGoodsCouponAll"/>'
				, data : JSON.stringify(noCpNos)
				, contentType : 'application/json'
				, done : function(data){

					if(data.result > 0) {
						var i = 1;
						//성공한 쿠폰 개별 다운로드 버튼 비활성화
						$.each(data.successList, function(index, value){
							//기존 쿠폰 array 에 cpUseYn 업데이트
							$.each(cpNos, function(i,v) {
								if(v.cpNo == value){
									v.cpUseYn = 'Y';
								}
							});
							$('#li_'+ value).addClass('disabled');
							i+=1;
						});

						//전체 다운받기 비활성화 - 모두 성공하였을 경우,
						$('#downloadAllBtn').prop('disabled', true);
						ui.toast("쿠폰 다운로드가 완료되었어요.");
					} else {
						ui.toast('쿠폰 다운로드가 실패되었습니다.');
					}
				}
			};
			await ajax.call(option);

		} else {
			if(confirm('로그인 후 다운로드 가능합니다. 로그인 하시겠습니까?')) {
				window.open("/indexLogin?returnUrl="+encodeURIComponent(document.location));
			}
		}
	}

	function openCouponNotic(cpNo) {
		/*if('${svcGbCd}' == '10') {
			$('#popCpnGudNotice').html('');
			$('#popCpnGudNotice').html($('#notice_'+ cpNo).text());
			ui.popBot.open('popCpnGud');
		}*/
		$('#popCpnGudNotice').html('');
		$('#popCpnGudNotice').html($('#notice_'+ cpNo).text());
		//ui.popBot.open('popCpnGud');
		// 쿠폰이용안내 바텀시트가 iOS에서 가려지는 현상이 있어서 zIndex를 높임.
		ui.popBot.open('popCpnGud', {'zIndex':999999});
	}
</script>
<article class="popLayer a popCpnGet" id="popCpnGet">
	<div class="pbd">
		<div class="phd">
			<div class="in">
				<h1 class="tit">쿠폰받기</h1>
				<button type="button" class="btnPopClose inpop">닫기</button>
			</div>
		</div>
		<div class="pct">
			<main class="poptents">
				<div class="btstop">
					<form:form name="couponForm">
					<c:if test="${goods.goodsCstrtTpCd eq 'ATTR' || goods.goodsCstrtTpCd eq 'PAK'}">
						<button type="button" class="bt cpnall" onclick="ui.popBot.open('popCouponOptPdSel',{'pop':true});">
							<span id="goodsNm">
								전체 상품 쿠폰
							</span>
						</button>
						<article class="popBot popOptPdSel" id="popCouponOptPdSel" style="display:none;">
							<div class="pbd">
								<div class="phd">
									<div class="in">
										<h1 class="tit">상품선택</h1>
										<button type="button" class="btnPopInClose" onclick="ui.popBot.close('popCouponOptPdSel');">닫기</button>
									</div>
								</div>
								<div class="pct">
									<main class="poptents">
										<div class="ugdoptlist">
											<ul class="gdtlist">
												<li>
													<div class="unitSel">
														<div class="box">
															<div class="infs">
																<a href="javascript:fnGetCoupons('${goods.goodsId}', '${goods.goodsCstrtTpCd}', '전체 상품 쿠폰');" class="lk">전체 상품 쿠폰</a>
															</div>
														</div>
													</div>
												</li>
												<c:if test="${not empty goodsCstrtList}">
													<c:forEach items="${goodsCstrtList}" var="cstrt">
														<li>
															<div class="unitSel gpic">
																<div class="box">
																	<div class="thum">
																		<div class="pic">
																			<!--직사각형을 정사각형으로 변경함. frontConstants.IMG_OPT_QRY_210 >>>> frontConstants.IMG_OPT_QRY_756-->
																			<img class="img" src="${frame:optImagePath( cstrt.imgPath , frontConstants.IMG_OPT_QRY_756 )}"  />
																		</div>
																	</div>
																	<div class="infs">
																		<div class="cate">상품<c:out value="${cstrt.dispPriorRank}"/></div>
																		<a href="javascript:fnGetCoupons('<c:out value="${cstrt.goodsId}"/>', null, '<c:out value="${cstrt.goodsNm}"/>');" class="lk"><c:out value="${cstrt.goodsNm}"/></a>
																	</div>
																	<div class="price"><em class="p"><frame:num data="${cstrt.saleAmt}" /></em><i class="w">원</i></div>
																</div>
															</div>
														</li>
													</c:forEach>
												</c:if>
											</ul>
										</div>
									</main>
								</div>
							</div>
						</article>
					</c:if>
					</form:form>
				</div>
				<div class="cupon-wrap">
					<div class="cupon-area t2 setAutoh" data-dh="60"><ul class="cupon-list" id="couponUl"></ul></div>
				</div>
			</main>
		</div>
		<div class="pbt">
			<div class="bts">
				<button type="button" id="downloadAllBtn" class="btn xl a btnGet" onclick="fnCheckLogin(null, this);">쿠폰 모두 받기</button>
			</div>
		</div>
	</div>
</article>

<!-- 쿠폰이용안내 -->
<article class="popBot popCpnGud k0427" id="popCpnGud">
	<div class="pbd">
		<div class="phd">
			<div class="in">
				<h1 class="tit">이용안내</h1>
				<button type="button" class="btnPopClose">닫기</button>
			</div>
		</div>
		<div class="pct">
			<main class="poptents">
				<ul class="tplist" id="popCpnGudNotice"></ul>
			</main>
		</div>
	</div>
</article>


<script type="text/template" id="templateCouponli">
	<li class="{{disabled}}" id="li_{{cpNo}}" >
		<div class="sale">
			{{aplTxt}}
			<div class="uitooltip" style="display: {{none}}">
				<button type="button" class="btn i btnTooltop" onclick="openCouponNotic('{{cpNo}}')">이용안내</button>
				<div class="toolctn">
					<div class="tptit">이용안내</div>
					<ul class="tplist" id="notice_{{cpNo}}">{{notice}}</ul>
				</div>
			</div>
		</div>
		<p class="tit">[상품쿠폰]{{cpNm}}</p>
		<div class="bottom-item">
			<div class="txt">
				<p>{{maxDcTxt}}</p>
				<p>{{vldPrdPeriod}}</p>
			</div>
		</div>
		<button type="button" class="btn-down" onclick="fnCheckLogin('{{cpNo}}', this);">쿠폰 다운로드</button>
	</li>
</script>

<script>
	var isScrBot = true ;
	var page = 1;
	$("#popCpnGet .pct").on("scroll resize",function(){
		var scTop = $(this).scrollTop();
		var scBox = $(this).outerHeight();
		var scCtn = $(this).prop("scrollHeight");
		if (scCtn <= scTop + scBox && isScrBot == true) {
			isScrBot = false;
			setTimeout(function(){
				fnCouponList(page ++);
				isScrBot = true;
			},500);
		}
	});
</script>
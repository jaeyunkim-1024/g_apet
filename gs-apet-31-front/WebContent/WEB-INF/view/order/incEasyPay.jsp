<div class="cardsel_slide payM_slide" id="cardSelDiv"><!-- ui.order.cardsld.using();  -->
	<div class="swiper-container slide" data-ind="0">
		<ul class="swiper-wrapper list">
			<c:choose>
				<c:when test="${!empty cardBillInfo}">
					<c:forEach var="cardBill" items="${cardBillInfo}" varStatus="status">
						<li class="swiper-slide" id="cardBill_${cardBill.prsnCardBillNo}" data-num="${cardBill.prsnCardBillNo}" data-cardc="${cardBill.pgCardCode}" onclick="clickEv(this)">
							<div class="untcard ${cardBill.cardColor}" id="selBillCard${cardBill.prsnCardBillNo}" data-index="${status.index}">
								<div class="inf">
									<div class="name">${cardBill.cardcNm}</div>
									<div class="nums">${cardBill.cardNo}</div>
								</div>
								<div class="mont">
									<span class="selmon select">
										<select class="sList" disabled name="select_mont_1" id="order_payment_halbu${cardBill.prsnCardBillNo}" onchange="selHalbu2(this.value, ${cardBill.prsnCardBillNo});">
											<option value="00" selected>일시불</option>
										</select>
									</span>
								</div>
							</div>
						</li>
					</c:forEach>
					<li class="swiper-slide cardRegibox" id="cardBill_cardRegibox" data-cardc="" data-num="">
						<div class="untcard def">
							<div class="txt">자주 사용하는 카드를 등록하세요 <br>최초 1회 등록 후, 바로 사용 가능합니다.</div>
							<div class="bts"><button type="button" class="btCdReg" onclick="registBillingCard('N');" data-content="layerAlert" data-url="/pay/nicepay/registBillingCard">카드 등록하기</button></div>
						</div>
					</li>
				</c:when>
				<c:otherwise>
					<li class="swiper-slide cardRegibox" id="cardBill_cardRegibox" data-cardc="" data-num="">
						<div class="untcard def">
							<div class="txt">자주 사용하는 카드를 등록하세요 <br>최초 1회 등록 후, 바로 사용 가능합니다.</div>
							<div class="bts"><button type="button" class="btCdReg" onclick="selectCertType('registCardBill');" data-content="layerAlert" data-url="/pay/nicepay/registBillingCard">카드 등록하기</button></div>
						</div>
					</li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
	<div class="sld-nav">
		<button type="button" class="dummy_btn" onclick="btnClickEv(this)">이전</button><!-- 04.30 -->
		<button type="button" class="bt prev" onclick="btnClickEv(this)">이전</button><!-- 04.30 -->
		<button type="button" class="bt next" onclick="btnClickEv(this)">다음</button><!-- 04.30 -->
	</div>
</div>
<script>
	var els =  ".cardsel_slide  .swiper-container";
	var opt =  {
		slideToClickedSlide: true,	//2021.06.03 수정함
		observer: false,
		observeParents: false,
		watchOverflow:true,
		//freeMode: true,
		centeredSlides: false,		//false로 변경함 2021.04.29 수정
		slidesPerView: "auto",
		slidesPerGroup:1,
		simulateTouch:false,
		navigation: {
			nextEl: '.cardsel_slide .sld-nav .bt.next',
			prevEl: '.cardsel_slide .sld-nav .bt.prev',
		},
		// 추가 2021.06.02 수정함 start
		pagination: {
			el: ".swiper-pagination",
			type: "fraction",
		},
		on: { 		// 2021.06.07 수정함!
			slideChange: function () {
				if($("link[href*='style.mo.css']").length > 0 == true){
					$(".payM_slide .swiper-slide").removeClass("payM_choiceCard");
						
					setTimeout(function() {
						$(".payM_slide .swiper-slide-active").addClass("payM_choiceCard");
						if ($(".payM_slide .swiper-slide-active")[0].dataset.num != $("#prsnCardBillNo").val()){
							selectDefBillCard();
						}
					}, 10);		
				}
			}
		},
		breakpoints: {
			850: {
				centeredSlides: true,
				slidesPerView: "auto",
				slidesPerGroup:1,
				spaceBetween: 10,
			}
		}
		// 추가 2021.06.02 수정함 start
	}
	var cardsld;
	var index11 = ($(els).attr("data-ind") !== undefined)?$(this.els).attr("data-ind"):1;
	/*
	setTimeout(function(){
		if(ui.check_brw.pc()) cardsld.slideTo(ind);
	},500);
	*/
	var len11 = $(".cardsel_slide.payM_slide .swiper-slide").length;
	if(len11 > 1){ // 2021.05.31 슬라이드 문제 수정
		cardsld = new Swiper(els, opt);
	}else{
		$(".cardsel_slide.payM_slide .sld-nav").addClass("none")
	}
	function clickEv(el){
		ac(el,true);
	}
	function btnClickEv(el){
		let check = $(el).hasClass("next");
		var len12 = $(".cardsel_slide.payM_slide .swiper-slide").length - 2;
		var ind12 = (check)?$(".cardsel_slide.payM_slide .swiper-slide-active").index() + 1:(($(".cardsel_slide.payM_slide .swiper-slide-active").index() - 1) < 0)?0:$(".cardsel_slide.payM_slide .swiper-slide-active").index() - 1;
		if(ind12 >= len12) ind12 = len12;
		let max12 = $(".cardsel_slide.payM_slide .swiper-slide").length - 4;
		if(ind12 > max12){
			ac($(".cardsel_slide.payM_slide .swiper-slide").eq(ind12),false);
		}
	}
	$(".sList").click(function(e){
		e.stopPropagation();
	});
	function selChange(el){
		let $el = $(el).closest(".swiper-slide");
		ac($el,true)
	}
	function ac(el,sw){
		if(ui.check_brw.pc()){
			setTimeout(function(){
				var ind13 = $(el).index();
				let max13 = $(".cardsel_slide.payM_slide .swiper-slide").length - 2;
				if(sw && (ind13 == max13)){
					cardsld.slideTo(ind13-1);
				}else if(sw && (ind13 < max13)){
					cardsld.slideTo(ind13);
				}
				$(".swiper-slide-next").removeClass("swiper-slide-next");
				$(".swiper-slide-prev").removeClass("swiper-slide-prev");
				$(".swiper-slide-active").removeClass("swiper-slide-active");
				$(el).addClass("swiper-slide-active");
				$(el).next().addClass("swiper-slide-next");
				$(el).prev().addClass("swiper-slide-prev");
				if(ind13 >= max13){
					$(".dummy_btn").addClass("b");
				}else{
					$(".dummy_btn").removeClass("b");
				}
				if(ind13 == max13){
					$(".cardsel_slide.payM_slide .sld-nav .bt.next").addClass("none");
				}else{
					$(".cardsel_slide.payM_slide .sld-nav .bt.next").removeClass("none");
				}
				if (sw) {
					if ($(".payM_slide .swiper-slide-active")[0].dataset.num != $("#prsnCardBillNo").val()){
						selectDefBillCard();
					}
				}
			},10)
		}
	}
	// 2021.06.07 수정함 start
	$(".cardsel_slide.payM_slide .swiper-slide .untcard .inf").on("click",function(e){

		if($("link[href*='style.pc.css']").length > 0 == true){
			$(".cardsel_slide.payM_slide .swiper-slide.payM_choiceCard").removeClass("payM_choiceCard");
			$(this).parent().parent().addClass("payM_choiceCard");
		}
	});
	
	$(".cardsel_slide .swiper-slide").on("click",function(){
		if($("link[href*='style.mo.css']").length > 0 == true){
			$(".payM_slide .swiper-slide").removeClass("payM_choiceCard");
			setTimeout(function() {
				$(".payM_slide .swiper-slide-active").addClass("payM_choiceCard");
				if ($(".payM_slide .swiper-slide-active")[0].dataset.num != $("#prsnCardBillNo").val()){
					selectDefBillCard();
				}
			}, 10);
		}
	});
</script>

function urlOpen(url, width, height, scrollbars) {
	window.open(url, '', 'width=' + width + ', height=' + height + ', left=0, top=0, statusbar=0, scrollbars=' +
		scrollbars);
}

function fnToggle(targetId) {
	$("#" + targetId).toggle();
	$("#" + targetId).parent().siblings().children("dd").hide();
}
$(document).ready(function(){
	
	//tr active 생성
	$(document).on('click','tr', function () {
		$(this).toggleClass('active');
	});
	$('#toTop').click(function () {
		$('body,html').animate({
			scrollTop: 0
		}, 600);
		return false;
	});


});
var IAset = function(){
	// console.log("sdffds");
	// data-end속성 자동 추가
	$("[data-complete]").each(function (i) {
			$(this).find('>span').text() == '' ? $(this).find('>span').attr('data-end', false) : $(this)
				.find('>span').attr('data-end', true);
	});
	$("[data-mod]").each(function (i) {
		$(this).text() == '' ? $(this).attr('data-mod', false) : $(this).attr('data-mod', true);
		if( $(this).text() == "ing" ){
			$(this).addClass("ing");	
		}
		if( $(this).text() == "new" ){
			$(this).addClass("new");	
		}
		if( $(this).text() == "mod" ){
			$(this).addClass("mod");	
		}
	});

	// 전체페이지 및 수정완료 수량 체크
	var TotalBtn1 = $("[data-complete]").length;
	var TotalBtn2 = $("td").find("[data-mod=true]").length;
	var TotalEnd = $("[data-complete]").find("[data-end=true]").length;
	var TotalStand = TotalBtn1 - TotalEnd;
	var TotalRate = (TotalEnd / TotalBtn1) * 100;
		TotalRate = TotalRate.toFixed(2) + " %";
	
	var $tbTit = $('[class^=tm]:not(.tm)');
	$tbTit.each(function () {
		var capTit = $(this).find('a').text();
		$(this).next().find('table > caption').text(capTit);

	});

	$(".cntadd").html(TotalBtn1);
	$(".cntadd2").html(TotalBtn2);
	$(".count1").html(TotalEnd);
	$(".count2").html(TotalStand);
	$(".tcount").html(TotalRate);

	$('.hisList li:first-child').addClass('on');

	$('.hisList').each(function () {
		$(this).wrap('<div class="hisWrap" />');
		var nodes = $(this).children();
		if (nodes.length > 1) {
			$('<a class="btn off btnHis" />').prependTo($(this).parent('div')).text('수정이력');
		}
	});
	$('.menu>dt').each(function (idx) {
		// console.log(idx);
		$(this).addClass("tm"+idx);
	});

	
	$('.menu>dt a:not(tm)').click(function () {
		var curTotalBtn1 = $(this).parent().next().find("[data-complete]").length;
		var curEnd = $(this).parent().next().find("[data-complete]").find("[data-end=true]").length;
		var curRate = (curEnd / curTotalBtn1) * 100;
			curRate = curRate.toFixed(2) + " %";

		$(".count3").html(curRate);


		$('.menu').removeClass('allview');
		$('.tm').removeClass('selected');
		$(this).addClass('selected').parent('dt').siblings('dt').children('a').removeClass(
			'selected');
		$(this).parent('dt').next('dd').show().siblings('dd').hide();
		
		var idx = parseInt( $(this).closest('dt').attr("class").replace("tm","") );
		window.localStorage.setItem("iaMenuSet",idx);

		return false;
	});
	
	// 전체보기
	$('.tm').click(function () {
		$(this).closest('.menu').addClass('allview').end().addClass('selected');
		$('.menu>dd').show().siblings('dt').children('a').removeClass('selected');
		window.localStorage.setItem("iaMenuSet",0);
		$(this).addClass('selected');
		return false;
	});

	var iaMenuAct = function(num){
		
		num = JSON.parse( window.localStorage.getItem("iaMenuSet") )  ;
		if ( num == 0 ) {
			$(".menu>dt.viewAll a.tm").trigger("click");
		} else {
			if ( !num ) {num = 1;} 
			$(".menu>dt.tm"+num+" a").trigger("click");

			
		}
	};
	iaMenuAct();

	$('.btnHis').click(function () {
		$(this).toggleClass('off');
		$(this).next('.hisList').children('li:not(.on)').toggle();
		return false;
	});
	$('.tip').hover(function () {
		$(this).children('span').toggle();
	});
	// to top
	//a 링크 text 생성
	$('table a').each(function () {
		if($(this).attr('href').indexOf("javascript:") < 0) $(this).text($(this).attr('href'));
	});
	//a 링크 text 생성
	$('table td.url').each(function (i) {
		var url = $(this).find("a:first-child").attr("href");
		$(this).next("td.pc.lk").html('<a href="'+url+'?ui=pc" class="btnPc" target="_blank">PC화면>></a>');
		
	});


	//Created By: Brij Mohan
	//Website: http://techbrij.com
	function groupTable($rows, startIndex, total) {
		if (total === 0) {
			return;
		}
		var i, currentIndex = startIndex,
			count = 1,
			lst = [];
		var tds = $rows.find('td:eq(' + currentIndex + ')');
		var ctrl = $(tds[0]);
		lst.push($rows[0]);
		for (i = 1; i <= tds.length; i++) {
			if ( $.trim( ctrl.text() )== $.trim( $(tds[i]).text() ) && $.trim( ctrl.text() ) !== '' ) {
				count++;
				$(tds[i]).addClass('deleted');
				lst.push($rows[i]);
			} else {
				if (count > 1) {
					ctrl.attr('rowspan', count);
					groupTable($(lst), startIndex + 1, total - 1);
				}
				count = 1;
				lst = [];
				ctrl = $(tds[i]);
				lst.push($rows[i]);
			}
		}
	}

	$('table').each(function (i) {
		groupTable($(this).find('tr:has(td)'), 0, 3);

	});
	$('table .deleted').remove();


};
$(document).ready(function(){
	incHtml.include();
	incHtml.load(function(){
		IAset();
	});
});


var	incHtml={ // Html 인클루드
	incCom:false,
	load:function(paramCallback){
		if (paramCallback) {
			this.loadCallback = paramCallback;
		}
	},
	include:function(){
		var _this = this;
		var $inc_html = $("[data-include-html]");
		var incAmt = 0;
		if ($inc_html.length) {
			$inc_html.each(function(idx){
				var inc = $(this).data("include-html");
				var incNums = $inc_html.length ;
				// $(this).before('<!-- data-include-html="'+inc+'"-->');
				var cls = $(this).attr("class");
				$(this).load( inc ,function(response, status, xhr){
					// console.log( inc, idx+1 , incNums,  status, xhr);
					$(this).find(">*").unwrap();
					incAmt ++;
					if( status == "success" ){
						// console.log(incAmt , inc );
					}else if( status == "error"){
						_this.incCom = false ;
						console.log("include 실패" , inc );
					}
					if( incAmt == incNums ) {
						_this.incCom = true ;
						if( typeof _this.loadCallback == "function") _this.loadCallback();
					}
				});
			});
		}else{
			_this.incCom = true ;
			if ( typeof _this.loadCallback == "function") _this.loadCallback();
		}
		//console.log("완료" + _this.incCom);
	}
};


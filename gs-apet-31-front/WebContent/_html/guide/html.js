var uiHtml = {
	init: function () {
		
		this.tit();
		this.menu.init();
		this.uimenu.init();
		$(window).on("load scroll",function(){
			var winH = $(window).height();
			var docH = $(document).height();
			var scrT = $(window).scrollTop();
			var pct =  scrT / ( docH - winH ) * 100 ;
			// console.log( winH , docH , scrT ,  pct );
			$("#barH>i").css({"width":pct+"%"});
		});
		if( location.host == "localhost:8000") {
			var css =   '<style>'+
							'*:focus, '+
							'.checkbox>input:focus + .txt::before, '+
							'.radio>input:focus + .txt::before, '+
							'.uiChk input:focus + .txt{outline: rgb(0 114 255 / 20%) 3px auto;} '+
						'</style>';
			$("head").append(css);
		}

        // console.log( uiHtml.param.ui );

		if ( uiHtml.param.ui == "pc" ) {
			$("head > link[href='../../_css/style.mo.css']").attr("href","../../_css/style.pc.css");
			setTimeout(function(){
				window.resizeBy(1, 1);
			},500);
		}
		if ( uiHtml.param.ui == "mo" ) {
			$("head > link[href='../../_css/style.pc.css']").attr("href","../../_css/style.mo.css");
		}

		// console.log( uiHtml.isMo() ); 
	},
	isMo:function(){
		var mobileKeyWords = new Array('iPhone', 'iPod', 'BlackBerry', 'Android', 'Windows CE', 'Windows CE;', 'LG', 'MOT', 'SAMSUNG', 'SonyEricsson', 'Mobile', 'Symbian', 'Opera Mobi', 'Opera Mini', 'IEmobile');
		for (var word in mobileKeyWords) {
			if (navigator.userAgent.match(mobileKeyWords[word]) != null) {
				return true;
			}
		}
	},
	param:(function(a) { // URL에서 파라미터 읽어오기  ui.param.***
		if (a == "") return {};
		var b = {};
		for (var i = 0; i < a.length; i++){
			var p=a[i].split('=');
			if (p.length != 2) continue;
			b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "));
		}
		return b;
	})(window.location.search.substr(1).split('&')),
	tit:function(){
		var tit = window.location.pathname.split("/");
		if ( !$("#contain").hasClass("ui") ) {
			// document.title = "/" + tit[tit.length - 2] + "/" + tit[tit.length - 1];
			document.title = tit[tit.length - 1];
		}
		if ( $("body>article .pbd>.phd .tit").length &&  !$("#container").hasClass("ui") ) {
			document.title = $(".pbd>.phd .tit").text();
		}
		// if ( $("#container").data("html-title").length ) {
		// 	document.title = $("#container").data("html-title");
		// }

	},
	uimenu: { // uimenu 
		init: function() {
			//ui.gnb.using("open");
			var _this = this;
			$(document).on("click", ".bt.uimenu:not(.ing)", function(){
				if ($("body").hasClass("uimenuOn")) {
					_this.using("close");
				} else {
					_this.using("open");
				}
			});
			$(document).on("click", ".uiScreen , nav.uimenu>.close", function() {
				_this.using("close");
			});

			$(document).on("click", "nav.uimenu .cate .menu>li>a", function() { // 1Depth
				$(this).parent("li").addClass("active").siblings("li").removeClass("active");
				var t = $(this).closest("li").index() + 1;
				$(this).closest(".nav").find(".panel:nth-child(" + t + ")").addClass("active").siblings().removeClass("active");
			});

			$(document).on("click", "nav.uimenu .cate .menu>li>a.tog", function() { // 2Depth
				if ($(this).next("ul").is(":visible")) {
					$(this).next("ul").slideUp(200);
					$(this).parent("li").removeClass("active");
				} else {
					$(this).closest("ul").find("li ul").slideUp(200);
					$(this).next("ul").slideDown(200);
					$(this).parent("li").addClass("active").siblings("li").removeClass("active");
				}
			});
			// this.menu();
			this.list();
		},
		using: function(opt) {
			if( opt === "open" ){
				ui.lock.using(true);
				$(".bt.uimenu").addClass("ing");
				$("nav.uimenu").after('<div class="uiScreen" tabindex="-1"></div>');
				$("nav.uimenu").show().animate({"right": 0}, 300,function(){
					$(".bt.uimenu").removeClass("ing");
				});
				$(".uiScreen").show();
				$("body").addClass("uimenuOn");
			}
			if( opt === "close" ){
				$(".bt.uimenu").addClass("ing");
				$("body").removeClass("uimenuOn");
				$(".uiScreen").hide().remove();
				$("nav.uimenu").animate({"right": "-100%"}, 300,function(){
					$(".bt.uimenu").removeClass("ing");
					$("nav.uimenu").hide();
				});
				ui.lock.using(false);
			}
		},
		list:function(){
			var _this = this;
			$(".contain.ui .sect h3.hdt").each(function(idx){
				// console.log( $(this).text() );
				var mtxt = $(this).text();
				var msid = $(this).closest(".sect").data("sid");
				$("nav.uimenu .menu .list").append('<li><a data-btn-sid="'+msid+'" href="javascript:;">'+mtxt+'</a></li>');
			});
			$(document).on("click","nav.uimenu .menu .list>li>a",function(e){
				var $this = $(this);
				if ($("body").hasClass("lock")) {
					_this.using("close");
				}
				setTimeout(function(){
					var sc_msid = $this.data("btn-sid");
					var sc_msid_top = $("[data-sid="+sc_msid+"]").offset().top - 10 - $("#header").outerHeight() || 0 ;
					// console.log(sc_msid,sc_msid_top);

					$("body,html").animate({ scrollTop: sc_msid_top }, 100, function() {
						// els.removeClass("disabled");
					});
				},50);
			});

		},
		menu: function() {
			$("nav.uimenu .cate .menu>li").find("a").each(function() {
				if(!$(this).next("ul").length) {
					$(this).addClass("link");
				} else {
					$(this).addClass("tog");
				}
			});
			$("nav.uimenu .cate .menu li>ul").hide();

			$(window).on("load resize", function() {
				$("nav.uimenu .nav").css({
					"height": $(window).height()
				});
			});
			$("nav.uimenu .nav>.ctn .panel>ul>li.active>a").next("ul").show();

		}
	},
	menu: {
		init: function () {
			this.addEvent();
		},
		addEvent: function () {
			var _this = this;
			var keyM = this.togMenu;
			var keyF2 = this.togUrl;
			var keyF7 = this.togMobile;
			var keyF4 = this.togDev;
			var keyBack = this.keyBack;
			var fStat = true;
			$(document).on({
				focus: function () {
					fStat = false;
					// console.log("f");
				},
				blur: function () {
					fStat = true;
					// console.log("t");
				}
			}, "textarea , input:not([type=radio],[type=checkbox])");

			// $(document).ready(function(){
			// 	$("body:not(.link)").append('<button type="button" class="btnLinkHtml">링크열기</button>');
			// });


			// $(document).on("click", ".btnLinkHtml", this.togMenu);

			$(document).on("keydown mousedown", function (event) {
				if (fStat === true) {
					if (event.keyCode == 77 && $("body:not('.link')").length) { keyM();	} // M 키 이벤트
					if (event.keyCode == 113) { keyF2(); } //F2 키 이벤트
					if (event.keyCode == 118) { keyF7(); } //F7 키 이벤트
					if (event.keyCode == 115) { keyF4(); } //F4 키 이벤트
					if (event.keyCode == 8  ) { keyBack(); } //Back 키 이벤트
				}
			}).on("mousedown", function () {
				$(".tempLink").remove();
			});


			
			// $(document).on("click", ".linkHtml .cont>ul>li>h3>a", function () {
			// 	_this.linkSet(this);
			// });
				

			// if ( !window.localStorage.getItem("linkMenu") ) {
			// }
				

		},
		linkSet:function(my){
			var ckidObj = {};
			var els = $(my).closest("li");

			//var linkData = $.cookie("linkMenu");
			var linkData = window.localStorage.getItem("linkMenu");
			if (linkData) {
				ckidObj = JSON.parse(linkData);
			}
			var ckid = els.attr("id").replace("linkID", "");

			// ckidObj["linkID" + ckid] = true;

			if (els.hasClass("open")) {
				els.find("ul").slideUp(200,function(){
					els.removeClass("open");
				});
				JSON.parse(linkData);
				ckidObj["linkID" + ckid] = false;
				//console.log(ckidObj["linkID"+ckid])
			} else {
				els.find("ul").slideDown(200,function(){
					els.addClass("open");
				});
				ckidObj["linkID" + ckid] = true;
				//console.log(  "linkID"+ckid ,  ckidObj["linkID"+ckid]);
			}
			ckidObj = JSON.stringify(ckidObj);
			window.localStorage.setItem("linkMenu", ckidObj);			
		},
		linkStat: function () {
			$(".linkHtml .cont>ul>li:not(.open)").addClass("open");
			$(".linkHtml .cont>ul>li").each(function (i) {
				$(this).attr("id", "linkID" + i);
			});

			var linkData = window.localStorage.getItem("linkMenu");
			if (linkData) {
				var linkObj = JSON.parse(linkData); //console.log( linkObj );
				for (var key in linkObj) { //console.log( key );
					if (linkObj[key]) {
						$("#" + key).addClass("open").find(">ul").show();
					}else{
						$("#" + key).removeClass("open").find(">ul").hide();
					}
				}
			}
			var thisPg = window.location.pathname.replace("/html/","../../html/");

			$(".linkHtml .cont ul ul>li").each(function () {
				var text = $(this).find("em").text();
				$(this).find("em").addClass(text);
				//if (text == "ing") {
				//$(this).wrapInner('<span></span>' );
				//}else{
				var link = $(this).find(">mark").text();
				if (link) {
					$(this).find(">mark").wrapInner('<a href="' + link + '"></a>');
					var lk = link.replace("../../html/", "./");
					$(this).find("mark>a").text(lk);
				} else {
					$(this).wrapInner('<a href="javascript:;"></a>');
				}
				//}
				$(this).find("em").wrapInner('<a href="' + link + '" target="_blank"></a>');

				if ( link == thisPg ) {
					$(this).closest("li").addClass("active");
					$(this).closest("li").closest("ul").show();
					$(this).closest("li").closest("ul").closest("li:not(.open)").find("h3 a").trigger("click");
				}

			});

			$(".linkHtml .cont").on("scroll",function(){
				linkScr = $(".linkHtml .cont").scrollTop();
				window.localStorage.setItem("linkScr", linkScr);
			});
			setTimeout(function(){
				
				var $active = $(".linkHtml .cont>ul>li>ul>li.active");
				if ( $active.length ) {
					var linkTxtTop = $active.offset().top - $(window).height()*0.5;
					$(".linkHtml .cont").scrollTop(linkTxtTop );
				}else{
					var linkScr = window.localStorage.getItem("linkScr");
					$(".linkHtml .cont").scrollTop(linkScr);
				}
				// console.log(linkTxtTop,linkScr);

			},10);

		},
		keyBack: function () {
			console.log("뒤로");
			window.history.back();
		},
		togMenu: function () {
			if ($(".tempLink").length) {
				$(".tempLink").remove();
			} else {
				var list =
					'<article class="tempLink">' +
						'<div class="pan"></div>' +
					'</article>';
				$("body").append(list);

				$(".tempLink>.pan").load("../../html/guide/link.html .linkHtml", function () {
					uiHtml.menu.linkStat();
				});

				$(".tempLink , .btnLinkHtml").on("mousedown", function (e) {
					e.stopPropagation();
				});
			}

		},
		togUrl: function () { // F2 키
			// console.log( $("head > link[rel='stylesheet']").attr("href") ); 
			if( $("head > link[rel='stylesheet']").attr("href") == "../../_css/style.pc.css" ) {
				location.replace( location.origin+location.pathname+"?ui=mo");
			}
			if( $("head > link[rel='stylesheet']").attr("href") == "../../_css/style.mo.css" ) {
				
				location.replace( location.origin+location.pathname+"?ui=pc");
			}

		},
		togMobile: function () { // F7 키


		},
		togDev: function () { // F4 키
			var tUrl = window.location.href;
			var tPort = window.location.port;
			var tHost = window.location.host;
			var tOrg = window.location.origin;
			var tIp = window.location.hostname;
			//console.log(tPort, tUrl);
			if(tPort == "8082" || tPort == "5500"){
				location.href = tUrl.replace(tOrg,"https://dev.aboutpet.co.kr");
			}
			if(tHost == "dev.aboutpet.co.kr"){
				location.href = tUrl.replace(tOrg,"http://localhost:5500");
			}

		}
	},
	html:{ // Html 인클루드
		incCom:false,
		load:function(paramCallback){
			if (paramCallback) {
				this.loadCallback = paramCallback;
			}
		},
		head_opt:"",
		include:function(){
			var _this = this;
			var $inc_html = $("[data-include-html]");
			var incAmt = 0;
			if ($inc_html.length) {
				$inc_html.each(function(idx){
					var inc = $(this).data("include-html");
					var head_option = $(this).attr("data-include-opt");
					var footer_option = $(this).attr("data-footer-opt");
					var soldout = $(this).attr("data-soldout");
					var subactive = $(this).attr("data-subnav");
					var btn_r_txt = ($(this).attr("data-btn-rname") !== undefined)?$(this).attr("data-btn-rname"):false;
					var btn_l_txt = ($(this).attr("data-btn-lname") !== undefined)?$(this).attr("data-btn-lname"):false;
					
					
					var incNums = $inc_html.length ;
					// $(this).before('<!-- data-include-html="'+inc+'"-->');
					var cls = $(this).attr("class");
					$(this).load( inc ,function(response, status, xhr){
						// console.log( inc, idx+1 , incNums,  status, xhr);
						
						if (soldout) { // 품절상품표시
							// console.log(soldout , $(this).html() );
							$(this).find(".thum .pic").prepend('<div class="soldouts"><em class="ts">품절</em></div>');
						}
						if (subactive) { // active 표시
							// console.log(subactive);
							$(this).find(".box .menu>li:nth-child("+subactive+")").addClass("active");
						}
						
						if (footer_option) {
							_this.footer_option = JSON.parse(footer_option);
							let moCheck = ($("link[href*='style.mo.css']").length)?true:false;
							if( _this.footer_option.foot_mo == "hide" && moCheck ) {
								$("#footer").remove();
							}
							if( _this.footer_option.talk_mo == "hide" && moCheck ) {
								$(".floatNav>.inr .pd.tk").remove();
							}
							if( _this.footer_option.foot_pc == "hide" && !moCheck ) {
								$("#footer").remove();
							}
							if( _this.footer_option.talk_pc == "hide" && !moCheck ) {
								$(".floatNav>.inr .pd.tk").remove();
							}
							if(_this.footer_option.zindex !== undefined){
								$("#footer").css("z-index",_this.footer_option.zindex);
							}
						}
						try{
							if($(this).attr("class").indexOf("footer") > -1){
								let css = String($(this).attr("class")).replace(/footer ?/g,'');
								css = String(css).split(" ");
								for(var i=0; i<css.length; i++){
									$(".footer").addClass(css[i]);
								}
							}
						}catch(e){
							console.log(e.message);
						}
						$(this).find(">*").unwrap();
						incAmt ++;
						if( status == "success" ){
							// console.log(incAmt , inc );
						}else if( status == "error"){
							_this.incCom = false ;
							console.log("include 실패" , inc );
						}
						if( head_option ) {
							_this.head_opt = JSON.parse(head_option);
							console.log(_this.head_opt);

							$("[data-header='"+_this.head_opt.header+"']").addClass("show");
							$("[data-header].header:not(.show)").remove();
							// console.log(_this.head_opt.btl);
							// console.log(_this.head_opt.btr);
							// console.log($(".header .mo-header-btnType02 .txt").text());
							// console.log($(".header .mo-header-btnType01 .txt").text());
							$(".header .mo-heade-tit .tit").html(_this.head_opt.tit);
							$(".header .mo-header-btnType02 .txt").html(_this.head_opt.btl); //왼쪽버튼 텍스트
							$(".header .mo-header-btnType01 .txt").html(_this.head_opt.btr); //오른쪽버튼 텍스트

							$(".header").addClass(_this.head_opt.class);
							$(".header>.hdr .hdt .logo").addClass(_this.head_opt.logo);
							$(".header>.hdr .cdt .form").addClass(_this.head_opt.formCss);   // form 크기 조절
						}

						
						if( incAmt == incNums ) {
							_this.incCom = true ;
							if( typeof _this.loadCallback == "function") _this.loadCallback();

						}
						// console.log(_this.head_opt.header + ":" + btn_r_txt);
						if(btn_r_txt !== false){
							if(_this.head_opt.header == "set8"){
								$(".header>.hdr .hdt .mo-header-btnType01 > .txt").text(btn_r_txt);

							}else{
								$(".header>.hdr .hdt .mo-header-btnType01").text(btn_r_txt);
							}
						}
						if(btn_l_txt !== false) $(".header>.hdr .hdt .mo-header-btnType02").text(btn_l_txt);
					
					});
				});
			}else{
				_this.incCom = true ;
				if ( typeof _this.loadCallback == "function") _this.loadCallback();
				

			}
			//console.log("완료" + _this.incCom);
		}
	}

};

$(document).ready(function(){
	uiHtml.html.include();
	uiHtml.init();
});



uiHtml.html.load(function() {
	// console.log("html-include 로드 완료");
	$(".page .sect.bests .ranklist .list>li").each(function(i){
		$(this).find(".gdset.bests .num .b").html(i+1);
		if ( ui.isMo() && i >= 5 ) {
			$(this).remove();
		}
	});

	$(document).on("contextmenu",".floatNav>.inr .bts .bt.talk",function(e){
		window.sessionStorage.flotMent = "";
		console.log("flotMent = ''");
		e.preventDefault();
		return false;
	});

	$(document).on("click",".btZZim , .bt.zzim ",function(e){
		$(this).toggleClass("on");
	});

	$(document).on("click",".header>.hdr .mo-header-backNtn",function(e){
		history.back();
	});

	$(document).on("click",".header>.hdr .cdt .menu .bt.cart",function(e){
		location.href = "../../_html/shop/Shop_04_01.html";
	});
	$(".gdset .thum a.pic").attr("href","../../_html/shop/Shop_03_01.html");
	
	
	// var imgdef =   ".gdset .thum a.pic img , " + 
	// 				".ui_cartrcm_slide .boxset .thum .pic .img ," +
	// 				".untcart .box .tops .pic .img ," +
	// 				".gdset.reviw .box .thum .photo .img" ;
	// $(imgdef).each(function(){
	// 	var imgsrc = Math.floor(Math.random() * 2); 
	// 	if( imgsrc != 0 ) {
	// 		$(this).attr("src","../../_images/_temp/goods_1.jpg");
	// 	}
	// });

	$("body.ui .header.cu").each(function(i){
		var set = $(this).data("header");
		var cls = $(this).attr("class").replace(/header pc cu/g,'');
		$(this).before('<h2 class="gdtit"><em>'+cls+'</em><em>data-header="'+set+'"</em></h2>');
	});

	
	var menubarset = location.pathname.split("/")[2];
	// console.log(menubarset);
	$("nav.menubar>.inr .menu>li."+menubarset+"").addClass("active").siblings("li").removeClass("active");
	$("nav.gnb .cdt .menu .list>li."+menubarset+"").addClass("active").siblings("li").removeClass("active");
	$(".header.pc>.hdr .hdt .tmenu .list>li."+menubarset+"").addClass("active").siblings("li").removeClass("active");
	
	if( uiHtml.param.ui == "pc" ){
		$("a[href]").each(function(){
			var vhref = $(this).attr("href");
			if ( vhref.indexOf(".html") > -1 ){
				// console.log( vhref );
				$(this).attr("href",vhref+"?ui=pc");
			}
		});
	}

});
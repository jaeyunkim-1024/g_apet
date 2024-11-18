"use strict";

/* swipe free관련 ui 길이 */
function SwipeListW(selector) {
	this.set(selector);
}

SwipeListW.prototype.set = function(selector) {
	var list = selector.children("ul");
	var item = list.children("li");
	var marginR = 15;
	var sum = (item.outerWidth(true) * item.length) + marginR;

	list.css("width", sum + "px");
}

var toggleMenu = function(target) {
	var parent = target.parent();
	// var parentIdx = parent.index();
	var subList = target.siblings("ul");

	if (!subList) {
		e.preventDefault();
	}

	if (parent.attr("data-role") && parent.attr("data-role") === "brand") {
		var options = {
			url : "/brand/indexBrand",
			params : {},
			width : 900,
			height : 470,
			callBackFnc : "",
			modal : true
		};
		pop.open("indexBrand", options);
		catePanel.removeClass("show");
		catePanel.trigger("hide", [ 'cate' ]);
	} else {
		parent.siblings().removeClass("active");
		parent.siblings().find("ul").slideUp(200);

		if (parent.hasClass("active")) {
			parent.removeClass("active");
			subList.slideUp(200);
		} else {
			parent.addClass("active");
			subList.slideDown(200);
		}
	}
}// toggleMenu

/* 카테고리 관련 */
var allMenuShow = function() {
	var catePanel = $(".category_wrap");
	var brand = $(".blank_wrap").filter(".brand");
	// var brandFirst = true;

	var eventDefine = (function() {
		var showCateBtn = $(".show_category");
		var closeCateBtn = catePanel.find(".cate_top_container .close");
		// var body = $("body");
		var cateBtn = catePanel.find(".dep_box a").not(".all");

		showCateBtn.on("click", function(e) {
			catePanel.addClass("show");
			catePanel.trigger("show", [ 'cate' ]);
			return false;
		});// showCateBtn

		closeCateBtn.on("click", function(e) {
			catePanel.removeClass("show");
			catePanel.trigger("hide", [ 'cate' ]);

			return false;
		});// closeCateBtn

		cateBtn.on("click", function() {
			toggleMenu($(this));
			return false;
		})
	})()// eventDefine

	var brandEvent = function() {
		var brandClose = brand.find(".close");
		var brandCateBtn = brand.find(".accordion_list > li > a");
		var tab = brand.find(".tab > li");
		var changeBtn = brand.find(".change_btn");

		brandClose.on("click", function() {
			brand.removeClass("show");
			brand.trigger("hide", [ 'brand' ]);
			brand.find(".accordion_list ul").hide();
			return false;
		});

		brand.on('transitionend', function() {
			tab.removeClass("active");
			tab.eq(0).addClass("active");
			$(".brand_box").hide();
			$(".brand_box").eq(0).show();
			$(".init_box").hide();
			$(".init_box").eq(0).show();
		});

		tab.on("click", function() {
			var id = $(this).index();
			var tabBox = brand.find(".brand_box");

			tab.removeClass("active");
			$(this).addClass("active");
			tabBox.hide();
			tabBox.eq(id).show();

			return false;
		});

		changeBtn.on("click", function() {
			var parent = $(this).parent();

			parent.hide();
			parent.siblings(".init_box").show();
			return false;
		});

		brandCateBtn.on("click", function() {
			toggleMenu($(this).parent().index());
			return false;
		})
	}// brandEvent

}// allMenuShow

// 최근본 상품 관련 함수
var recentView = function() {
	var eventDefine = (function() {
		$(".recent_view").on("click", function() {
			$(this).parent().toggleClass("show");
			if ($(this).parent().hasClass("show"))
				$(this).trigger("show", [ 'recent' ]);
			return false;
		})
	})()// eventDefine
}

// header scroll관련
var headerScroll = function() {
	var scrollVal = {
		top : 0,
		left : 0
	}
	var headerMenu = $(".header_menu");
	var headerH = $(".dcg_header").outerHeight(true);

	var scrollCheck = function() {
		scrollVal.top = $(window).scrollTop();
		scrollVal.left = $(window).scrollLeft();
		if (scrollVal.top > headerH) {
			headerMenu.addClass("fixed");
			headerMenu.css("left", -scrollVal.left + "px")
		} else {
			headerMenu.removeClass("fixed");
			headerMenu.removeAttr("style");
		}
	}

	var eventDefine = (function() {
		$(window).scroll(function() {
			scrollCheck();
		})
	})()// eventDefine
}// headerScroll

// 카테고리 메인, 서브메인
function ThatFixed(selector, obj) {
	this.selector;
	this.init(selector, obj);
}

ThatFixed.prototype.init = function(selector, obj) {
	this.selector = $(selector);
	this.eventDefine(obj);
}// init

ThatFixed.prototype.eventDefine = function(obj) {
	var header = $(".header_menu");
	var eventPosY = this.selector.offset().top;
	var headerMenuH = header.outerHeight();
	var headerMenuY = (header.hasClass("fixed")) ? Number(header.css("top")
			.replace("px", "")) : 0;
	var defaultOption = {
		posY : headerMenuH + headerMenuY
	};
	var option = $.extend({}, defaultOption, obj);
	var scrollGoal = Math.abs(eventPosY - option.posY);

	var objThis = this;
	var scrollTop = 0;
	var firstFix = true;

	$(window).scroll(function() {
		scrollTop = $(window).scrollTop();

		if (header.hasClass("fixed") && firstFix) {
			headerMenuY = Number(header.css("top").replace("px", ""))
			defaultOption = {
				posY : (headerMenuH + headerMenuY)
			};
			option = $.extend({}, defaultOption, obj);
			scrollGoal = Math.abs(eventPosY - option.posY);
			firstFix = false;
		}

		if (scrollTop >= scrollGoal) {
			objThis.selector.addClass("fixed").css({
				"top" : option.posY + "px"
			});
		} else {
			objThis.selector.removeClass("fixed").removeAttr("style");
			firstFix = true;
		}
	})
}// eventDefine

$(document).ready(function() {
	allMenuShow();
	recentView();
	headerScroll();
	$(".go_top").on("click", function() {
		$("html body").scrollTop(0);
		$(document).scrollTop(0);
		return false;
	})
})

// swiper_최근본상품 영역
/*
 * var mainSwiperRecent = new Swiper('.swiper-container.recent_inner', {
 * slidesPerView: 1, // autoplay: 2000, pagination: '.swiper-pagination',
 * paginationClickable: true, nextButton: '.recent_pro_container
 * .swiper-button-next', prevButton: '.recent_pro_container
 * .swiper-button-prev', spaceBetween: 0 });
 *
 * //swiper_위시리스트 영역 var mainSwiperWish = new
 * Swiper('.swiper-container.wish_inner', { slidesPerView: 1, // autoplay: 2000,
 * pagination: '.swiper-pagination', paginationClickable: true, nextButton:
 * '.wish_pro_container .swiper-button-next', prevButton: '.wish_pro_container
 * .swiper-button-prev', spaceBetween: 0 });
 */
// fnTab
$.fn.fnTab = function(options) {
	var opts = $.extend({}, $.fn.fnTab.defaults, options);
	return this.each(function() {
		var obj = this;
		$(obj).find('a').addClass('ui-tab-trigger');
		$(obj).find('a').each(function() {
			$($(this).attr('href')).addClass($(obj).attr('id') + '-content');
		});
		var $trigger = $(obj).find('.ui-tab-trigger');
		$trigger.bind(opts.event, function() {
			var $targetElm = $(this).attr('href');
			$trigger.removeClass(opts.activeClass);
			$(this).addClass(opts.activeClass);
			$($targetElm).show().siblings('.' + $(obj).attr('id') + '-content')
					.hide();
			if (opts.callback) {
				opts.callback.call();
			}
			return false;
		});
		$trigger.eq(opts.firstView).trigger(opts.event);
	});
};
// fnTab.option
$.fn.fnTab.defaults = {
	event : 'click',
	firstView : 0,
	activeClass : 'on',
	callback : function() {
		if ($('.img_hover_view').is(':visible')) {
			$('.img_hover_view').mouseenter(function() {
				if ($(this).find('img').length > 1) {
					$(this).find('img').eq(0).hide();
				}
			});
			$('.img_hover_view').mouseleave(function() {
				if ($(this).find('img').length > 1) {
					$(this).find('img').eq(0).show();
				}
			});
		}
		$('.list_type1').find('.img_sec a').mouseenter(function() {
			if ($('.list_type1').hasClass('active')) {
				$(this).parents('.item').siblings().find('.u_util').hide();
				$(this).parents('.item').find('.u_util').show();
			}
		});
		$('.list_type1').find('.item').mouseleave(function() {
			if ($('.list_type1').hasClass('active')) {
				$('.list_type1 .u_util').hide();
			}
		});
		$('.list_type1').find('.sold_out_layer').mouseenter(function() {
			if ($('.list_type1').hasClass('active')) {
				$(this).parents('.item').siblings().find('.u_util').hide();
				$(this).parents('.item').find('.u_util').show();
			}
		});

		if ($('.ui_select_box').is(':visible')) {
			$('.ui_select_box').each(
					function() {
						$(this).find('.ui_current_option a').click(
								function() {
									$(this).parents('.ui_select_box').addClass(
											'active').find('.ui_option_list')
											.show();

									return false;
								});
						$(this).mouseleave(
								function() {
									$(this).removeClass('active').find(
											'.ui_option_list').hide();
								});
						$(this).find('.ui_option_list a').click(
								function() {
									$('.ui_option_list a').removeClass(
											'current');
									$(this).addClass('current');
									$(this).parents('.ui_select_box').find(
											'.ui_current_option a').text(
											$(this).text());
									$(this).parents('.ui_select_box')
											.removeClass('active').find(
													'.ui_option_list').hide();
									return false;
								});
					});
		}
	}
};
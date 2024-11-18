var list_more = true;
var parent = undefined;

function setListInit(name) {
	list_more = true;
	parent = $(name);

	parent.find("#curr_page").val(0);
	parent.find("#total_page").val('');
}

/**
 * 스크롤 페이지 처리
 */
$(window).scroll(
		function() {
			if (parent === undefined)
				return;

			var scrollTop = $(window).scrollTop();
			var height = $(document).height() - $(window).height()
					- ($('footer').height() / 2);

			if ((scrollTop >= height) && list_more) {
				if (parseInt(parent.find("#curr_page").val()) < parseInt(parent
						.find("#total_page").val())) {
					moreList();
				}
				list_more = false;
			}

			if ((scrollTop < height) && !list_more) {
				list_more = true;
			}
		});

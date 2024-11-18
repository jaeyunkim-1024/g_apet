//side treemenu
$(function(){
	$('.lnb_tree .tree_depth1').click(function(){
		if($(this).hasClass('on')){
			$(this).removeClass('on').next('.tree_depth2').slideUp(300);
		}else{
			$('.lnb_tree .tree_depth1').removeClass('on');
			$('.lnb_tree .tree_depth2').slideUp(300);
			$(this).addClass('on').next('.tree_depth2').slideDown(300);
		}
	});
});

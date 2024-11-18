////////////////////////////////////////
// 퍼블 UI 공통 스크립트
////////////////////////////////////////

ui.mo = {
	init:function() {
		console.log("ui.mo.init();");
	},
};

$(document).ready(function(){
	if( typeof uiHtml == "undefined" ){
		ui.mo.init();
	}else{
		ui.mo.times = setInterval(function(){
			if( uiHtml.html.incCom ){
				clearInterval(ui.mo.times);
				ui.mo.init();
			}
		});
	}
});

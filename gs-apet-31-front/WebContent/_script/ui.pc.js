////////////////////////////////////////
// 퍼블 UI 공통 스크립트
////////////////////////////////////////

ui.pc = {
	init:function() {
		console.log("ui.pc.init();");
	},
};

$(document).ready(function(){
	if( typeof uiHtml == "undefined" ){
		ui.pc.init();
	}else{
		ui.pc.times = setInterval(function(){
			if( uiHtml.html.incCom ){
				clearInterval(ui.pc.times);
				ui.pc.init();
			}
		});
	}
});
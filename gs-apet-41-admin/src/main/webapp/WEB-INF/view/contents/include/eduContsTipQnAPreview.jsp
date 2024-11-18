<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<style>
.schoolDetail .popup-layer {
  overflow: hidden;
  z-index: 200;
  background-color: #fff;
  border: 1px solid #000;
  border-radius: 6px;
  line-height: 1.6;
}
.schoolDetail .popup-layer .popup-wrap {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-orient: vertical;
  -webkit-box-direction: normal;
      -ms-flex-direction: column;
          flex-direction: column;
  height: 100%;
  min-height: 450px;
  background-color: #fff;
}
.schoolDetail .popup-layer .top {
  position: relative;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-pack: justify;
      -ms-flex-pack: justify;
          justify-content: space-between;
  -webkit-box-align: center;
      -ms-flex-align: center;
          align-items: center;
  font-weight: 700;
  color: #000;
  padding: 15px 20px 0;
}
.schoolDetail .popup-layer .top h2 {
  -webkit-box-flex: 1;
      -ms-flex: 1;
          flex: 1;
  font-size: 15px;
  font-weight: bold;
  text-align: center;
}
.schoolDetail .popup-layer .content {
  -webkit-box-flex: 1;
      -ms-flex: 1;
          flex: 1;
  overflow: hidden;
  padding: 20px;
}
.schoolDetail .popup-layer .content main {
  overflow: auto;
  height: 100%;
  max-height: 360px;
}
.schoolDetail .popup-layer img {
  display: block;
  width: 100%;
}

.schoolDetail .popup-layer.typeB { 
  top: auto;
  width: 100% !important;
  height: 100% !important;
}

.schoolDetail .popup-layer .tip-list li {
  color: #666;
  font-size: 14px;
  white-space: pre-line;
}
.schoolDetail .popup-layer .tip-list li + li {
  margin-top: 20px;
}

.schoolDetail .popup-layer .qna-list li + li {
  margin-top: 20px;
}
.schoolDetail .popup-layer .qna-list li.open .btnTog {
  background-image: url(/images/icon_list_more_black_close@2x.png);
}
.schoolDetail .popup-layer .qna-list .hBox {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  padding: 5px 10px 5px 5px;
  -webkit-box-pack: justify;
      -ms-flex-pack: justify;
          justify-content: space-between;
  -webkit-box-align: start;
      -ms-flex-align: start;
          align-items: flex-start;
}
.schoolDetail .popup-layer .qna-list .hBox .tit {
  position: relative;
  padding-left: 28px;
  font-size: 14px;
  line-height: 20px;
  color: #000;
  white-space: pre-line;
  -webkit-box-flex: 1;
      -ms-flex: 1;
          flex: 1;
}
.schoolDetail .popup-layer .qna-list .hBox .tit::before {
  content: '';
  width: 20px;
  height: 20px;
  position: absolute;
  left: 0;
  top: 2px;
  background: url(/images/icon_list_qna_q@2x.png) no-repeat 50%;
  background-size: 100%;
}
.schoolDetail .popup-layer .qna-list .hBox .btnTog {
  width: 20px;
  height: 20px;
  background: url(/images/icon_list_more_black@2x.png) no-repeat 50%;
  background-size: 13px 12px;
}
.schoolDetail .popup-layer .qna-list .cBox {
  margin-top: 10px;
  border-radius: 6px;
  padding: 15px;
  background-color: #f7f7f7;
}
.schoolDetail .popup-layer .qna-list .cBox p {
  position: relative;
  padding-left: 28px;
  font-size: 14px;
  line-height: 22px;
  color: #333;
  white-space: pre-line;
}
.schoolDetail .popup-layer .qna-list .cBox p::before {
  content: '';
  width: 20px;
  height: 20px;
  position: absolute;
  left: 0;
  top: 2px;
  background: url(/images/icon_list_qna_a@2x.png) no-repeat 50%;
  background-size: 100%;
}
</style>
<script type="text/javascript">
	//Tip and QnA 미리보기 팝업 아코디언 ui
	var accd = {
		set:function(){
			$(".uiAccd>li>.cBox").hide();
			$(".uiAccd>li.open>.cBox").show();
			$(".uiAccd>li.except>.cBox").show();
		},
		evt: function() {
			$(document).on("click", ".uiAccd>li:not(.except)>.hBox>.btnTog", function() {
				var type = $(this).closest(".uiAccd").attr("data-accd");
				var $pnt = $(this).closest("li");
				if (type === "tog") {
					if( $pnt.is(".open") ) {
						$pnt.find(".cBox").slideUp(100,function(){
							$pnt.removeClass("open");
						});
					} else {
						$pnt.find(".cBox").slideDown(100,function(){
							$pnt.addClass("open");
						});
					}
				}
				if (type === "accd") {
					$(this).closest(".uiAccd").find(">li").removeClass("open").not("li.except").find(".cBox").slideUp(100);
					if ($pnt.find(".cBox").is(":hidden")) {
						$pnt.addClass("open").find(".cBox").slideDown(100);
					}
				}
	
			});
		}
	}
	
	$(document).ready(function(){
		// Tip and QnA 미리보기 팝업 아코디언 ui 관련 함수
		accd.evt();
	});
</script>

<script type="text/javascript">
	$(document).ready(function () {
		var thisPagePath = "${requestScope['javax.servlet.forward.servlet_path']}";
		if(thisPagePath == "/tv/home/" || thisPagePath == "/shop/home/" || thisPagePath == "/log/home/" ){
			var cookieData = document.cookie;
			if(cookieData.indexOf("popError=done") === -1){
				ui.popLayer.open("noticePopup");
			}
		}
	});
	
	//오늘 하루 보지않기
	function fncNoticeTodayClose(){
		setCookiePopLayerNotice("popError", "done", 1);
		ui.popLayer.close('noticePopup');
	}
	
	function setCookiePopLayerNotice(name, value, expire){
		var todayDate = new Date();
		var newDate = new Date(todayDate.getFullYear(), todayDate.getMonth(), todayDate.getDate(), "23", "59", "59"); //당일 자정으로 셋팅
		document.cookie = escape(name) + "=" + escape( value ) + "; path=/; expires=" + newDate.toUTCString() + ";"
	}
</script>	


<!-- 팝업레이어 A 전체 덮는크기 -->
<article class="popLayer a popEventLayer" id="noticePopup">
	<div class="pbd">
		<div class="pct">
			<main class="poptents">
				<!--  갈아끼기 -->
				<img src="../../_images/common/noticePopup.jpg" alt="접속장애 공지 안내" >
				<!--  //갈아끼기 -->
			</main>
		</div>
		<div class="pbt">
			<div class="bts">
				<button type="button" class="btn bd_n" onclick="fncNoticeTodayClose();">오늘 하루 보지않기</button> <!-- bd_n 클래스는 버튼에 보더 없앨 때 사용 -->
				<button type="button" class="btn bd_n d" onclick="ui.popLayer.close('noticePopup');">닫기</button>
			</div>
		</div>
	</div>
</article>

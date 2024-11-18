
<tiles:insertDefinition name="common_my_mo">
	<tiles:putAttribute name="script.inline">
		<script>
		$(document).ready(function(){
			
			if("${view.deviceGb}" == "PC"){
				$("popRevCom").addClass("on")
			} 
			
			$("#confirmBtn").click(function(){
				location.href = "/mypage/goodsCommentList?selectTab=aftTab";
			})
		})
		</script>
	</tiles:putAttribute>
<!-- 팝레이어 바닥에서 올라오는 리뷰작성완료 -->
<tiles:putAttribute name="content">
<article class="popBot popRevCom on noClickClose" id="popRevCom">
	<div class="pbd">
		<div class="pct">
			<main class="poptents">
				<section class="rvcoms">
					<div class="ben"></div>
					<div class="tit">후기를 작성해 주셔서 감사해요!</div>
 					<div class="msg"></div>보다 나은 쇼핑 혜택을 드리고자 <br> 500p를 드릴게요:-)
					<div class="btnSet">
						<button type="button" class="btn lg a" id="confirmBtn">확인</button>
					</div>
				</section>
			</main>
		</div>
	</div>
</article>
</tiles:putAttribute>
</tiles:insertDefinition>

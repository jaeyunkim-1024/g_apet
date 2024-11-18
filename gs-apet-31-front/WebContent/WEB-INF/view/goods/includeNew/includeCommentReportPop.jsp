<article class="popLayer a popSample1 pc_popSize_500" id="commentReportPop">
	<div class="pbd">
		<div class="phd">
			<div class="in">
				<h1 class="tit">후기 신고<button type="button" class="btnPopClose" onclick="removePop(this)">닫기</button></h1>
			</div>
		</div>
		<form id="rptpForm">
			<input type="hidden" name="goodsEstmNo" value="${so.goodsEstmNo }" />
			<div class="pct h_auto_p">
				<!-- 03.19 수정 -->
				<main class="poptents report"> 
					<div class="lay-gray-box">
						신고접수 시 운영정책에 따라 검토 후 해당글이 삭제됩니다.<br />
						신고 관련된 자세한 사항은 고객센터로 연락주세요.
					</div>
					<div class="member-input">
						<strong class="tit mb18">신고 사유</strong>
						<ul class="list">
							<%-- <c:forEach var="rptpRsnCd" items="${rptpRsnCdList }">
								<li><label class="radio"><input type="radio" name="rptpRsnCd" value="${rptpRsnCd.dtlCd }"><span class="txt">${rptpRsnCd.dtlNm }</span></label></li>
							</c:forEach> --%>
								<li><label class="radio"><input type="radio" name="rptpRsnCd" value="10"><span class="txt">혐오 콘텐츠</span></label></li>
								<li><label class="radio"><input type="radio" name="rptpRsnCd" value="20"><span class="txt">지적 재산권 위반</span></label></li>
								<li><label class="radio"><input type="radio" name="rptpRsnCd" value="30"><span class="txt">기타</span></label></li>
						</ul>
					</div>
					<div class="textarea m"><textarea name="rptpRsnContent" placeholder="신고사유를 입력해주세요. 선택사항입니다." style="height:260px;"></textarea></div>
					<div class="log_btnWrap">
						<a href="javascript:;" class="btn lg onWeb_if" onclick="removePop(this)">취소</a>
						<a href="javascript:;" class="btn a lg disabled" name="okBtn" onclick="goodsComment.reportGoodsComment()" style="pointer-events: all;">완료</a>
					</div>
				</main>
				<!-- // 03.19 수정 -->
			</div>
		</form>
		<!-- 하단 고정 버튼 있을때 쓰세요
		<div class="pbt">
			<div class="bts">
				<button type="button" class="btn xl d" onclick="ui.popLayer.close('popSample1');">취소</button>
				<button type="button" class="btn xl a">등록</button>
			</div>
		</div>
		-->
		
		
	</div>
	<script>
		$(function(){
			$("input[name=rptpRsnCd]").on('click', function(){
				$('a[name=okBtn]').removeClass('disabled');
				$('a[name=okBtn]').removeAttr('disabled');
				
			})
		})
	</script>
</article>
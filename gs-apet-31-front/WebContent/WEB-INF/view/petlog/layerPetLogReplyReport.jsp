		<!-- 팝업레이어 A 전체 덮는크기 -->
		<article class="popLayer a popSample1 pc_popSize_500" id="popReport">
			<div class="pbd">
				<div class="phd">
					<div class="in">
						<!-- <button type="button" class="btnPopTxt left" onclick="ui.popLayer.close('popReport');">취소</button> -->
						<h1 class="tit">신고 접수
						</h1>
						<button type="button" class="btnPopClose" onclick="$('#commitBtn').addClass('disabled')">닫기</button>
						<!-- <button type="button" class="btnPopTxt right c_b" onclick="insertPetLogReplyRptp('popReport');">완료</button> -->
					</div>
				</div>
				<div class="pct">
					<main class="poptents report">
					<form id="petLogRptpForm" name="petLogRptpForm" method="post" onSubmit="return false;">
 					<input type="hidden" name="petLogAplySeq"/><!-- 댓글 순번 -->
 					<input type="hidden" name="petLogNo"/><!-- 펫로그번호 -->
					<input type="hidden" name="mbrNo" /><!-- 회원번호		 -->
					<input type="hidden" name="listNo" /><!-- 회원번호		 -->
					<input type="hidden" name="rvwYn" /><!-- 리뷰여부	 -->
						<div class="lay-gray-box">
							신고접수 시 운영정책에 따라 검토 후 해당글이 삭제됩니다.<br />
							신고 관련된 자세한 사항은 고객센터로 연락주세요.
						</div>
						<div class="member-input">
							<strong class="tit mb18">신고 사유</strong>
							<ul class="list">
								<li><label class="radio"><input type="radio" name="rptpRsnCd" value="10"><span class="txt">혐오 콘텐츠</span></label></li>
								<li><label class="radio"><input type="radio" name="rptpRsnCd" value="20"><span class="txt">지적 재산권 위반</span></label></li>
								<li><label class="radio"><input type="radio" name="rptpRsnCd" value="30"><span class="txt">기타</span></label></li>
							</ul>
						</div>
						<div class="textarea m"><textarea name="rptpContent" placeholder="신고사유를 입력해주세요." style="height:260px;"></textarea></div>
						<div class="log_btnWrap">
							<button class="btn lg onWeb_if" onclick="ui.popLayer.close('popReport');$('#commitBtn').addClass('disabled')">취소</button>
							<button class="btn a lg disabled" onclick="insertPetLogRptp('popReport');" id="commitBtn">완료</button>
						</div>
					</form>	
					</main>
				</div>
				
				<!-- 하단 고정 버튼 있을때 쓰세요
				<div class="pbt">
					<div class="bts">
						<button type="button" class="btn xl d" onclick="ui.popLayer.close('popReport');">취소</button>
						<button type="button" class="btn xl a" onclick="insertPetLogRptp('popReport');">등록</button>
					</div>
				</div>	-->	
				
			</div>
		</article>
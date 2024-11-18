<!-- 팝업레이어 A 전체 덮는크기 -->
<article class="popLayer a dn popSample1" id="popGsPoint">
	<div class="pbd width562">
		<div class="phd">
			<div class="in">
				<h1 class="tit">이용약관 동의</h1>
				<button type="button" class="btnPopClose" id="gsrPointTermsCloseBtn">닫기</button>
			</div>
		</div>
		<div class="pct" data-h="517">
			<main class="poptents">

				<div class="fake-wrap">
					<div class="result">
						<span class="blue">GS&POINT</span>사용을 위해<br>
						<span class="blue">이용약관에 동의</span>해주세요.
					</div>
					<div class="chk-wrap">
						<dl>
							<dt class="allchk mt10">
								<label  class="checkbox">
									<input id="allCheck" type="checkbox">
									<span class="txt">약관 전체동의</span>
								</label>
							</dt>
							<dd>
								<ul>
									<c:forEach items="${termsList}" var="item">
										<li class="terms-item">
											<label class="checkbox">
												<input name="termsChk" type="checkbox" class="${item.rqidYn eq frontConstants.COMM_YN_Y ? 'required' : ''}">
												<span class="txt">
															<c:choose>
																<c:when test="${item.rqidYn eq frontConstants.COMM_YN_Y}">
																	[필수]
																</c:when>
																<c:otherwise>
																	[선택]
																</c:otherwise>
															</c:choose>
															${item.termsNm}
														</span>
											</label>
											<a href="javascript:;" title="내용보기" onclick="openTermsSetting('${item.termsCd}', '${item.rqidYn}')"></a>
										</li>
									</c:forEach>
								</ul>
							</dd>
						</dl>
					</div>
					<div class="info-txt pd">
						<ul>
							<li>
								이용자는 위 약관에 대한 동의를 거부할 권리가 있으나, 미동의시 GS&POINT 사용이 불가합니다.
							</li>
						</ul>
					</div>
				</div>
			</main>
		</div>
		<div class="pbt fx">
			<!-- 버튼 활성화시 -->
			<div class="bts">
				<button type="button" class="btn xl a" id="termsAgreeBtn" disabled>동의</button>
			</div>
		</div>
	</div>
</article>

<div id="termsLayers">
	<article class="popLayer a popSample1" id="termsContentPop">
		<div class="pbd">
			<div class="phd">
				<div class="in">
					<h1 id="termsNm" class="tit"></h1>
					<button type="button" class="btnPopClose">닫기</button>
				</div>
			</div>
			<div class="pct">
				<main class="poptents">

					<!-- // PC 타이틀 모바일에서 제거  -->
					<div class="">
						<div class="select">
							<select id="selectTermsNm">
							</select>
						</div>
						<section id="termsContents" class="exlist">
						</section>
					</div>

				</main>
			</div>
		</div>
	</article>
</div>
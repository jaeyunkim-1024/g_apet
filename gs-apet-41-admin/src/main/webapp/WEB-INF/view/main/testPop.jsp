<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="popupLayout">
	<t:putAttribute name="title">관리자 메인 목록</t:putAttribute>
	<t:putAttribute name="script">
	</t:putAttribute>
	<t:putAttribute name="content">
		<div class="popTitle">새창 팝업</div>
			<div class="popContent">
				<!-- 코드 적용부 -->

				<!-- Title -->
				<div class="mTitle">
					<h1>거래처 기본정보 관리거래처 기본정보 관리</h1>
				</div>
				<!-- //Title -->

				<div>
					<table  class="table_type1">
						<caption>정보 검색</caption>
						<colgroup>
							<col style="width:15%;">
							<col style="width:35%;">
							<col style="width:auto;">
							<col style="width:35%;">
						</colgroup>
						<tbody>
							<tr>
								<th>몰 명 <strong>*</strong></th>
								<td>
									<input type="text" title="입력" />
								</td>
								<th>몰 번호</th>
								<td>1234</td>
							</tr>
							<tr>
								<th>전시여부</th>
								<td>
									<label class="fRadio"><input type="radio" /> <span>전시</span></label>
									<label class="fRadio"><input type="radio" /> <span>전시안함</span></label>
								</td>
								<th>사용여부</th>
								<td>
									<label class="fRadio"><input type="radio" /> <span>사용</span></label>
									<label class="fRadio"><input type="radio" /> <span>사용안함</span></label>
								</td>
							</tr>
							<tr>
								<th>출력유형</th>
								<td>
									<select class="input_select">
										<option selected="selected">선택</option>
										<option>의료비용</option>
										<option>비용상담</option>
										<option>전화상담</option>
										<option>예약</option>
									</select>
								</td>
								<th>전시코너</th>
								<td>5개</td>
							</tr>
							<tr>
								<th>출력유형</th>
								<td colspan="3">
									<input type="text" title="입력" class="input_text w121" />
									<input type="text" title="입력" class="input_text w246 mgl7" />
									<a href="#" class="btn_h25_type1 mgl7">검색</a>
								</td>
							</tr>
						</tbody>
					</table>
				</div>

				<hr />

				<!-- 스크롤 생성시 -->
				<div class="scroll_y_content" style="height:100px;">
					<table  class="table_type1 border_top_none">
						<caption>정보 검색</caption>
						<colgroup>
							<col style="width:15%;">
							<col style="width:35%;">
							<col style="width:auto;">
							<col style="width:35%;">
						</colgroup>
						<tbody>
							<tr>
								<th>몰 명 <strong>*</strong></th>
								<td>
									<input type="text" title="입력" />
								</td>
								<th>몰 번호</th>
								<td>1234</td>
							</tr>
							<tr>
								<th>전시여부</th>
								<td>
									<label class="fRadio"><input type="radio" /> <span>전시</span></label>
									<label class="fRadio"><input type="radio" /> <span>전시안함</span></label>
								</td>
								<th>사용여부</th>
								<td>
									<label class="fRadio"><input type="radio" /> <span>사용</span></label>
									<label class="fRadio"><input type="radio" /> <span>사용안함</span></label>
								</td>
							</tr>
							<tr>
								<th>출력유형</th>
								<td>
									<select class="input_select">
										<option selected="selected">선택</option>
										<option>의료비용</option>
										<option>비용상담</option>
										<option>전화상담</option>
										<option>예약</option>
									</select>
								</td>
								<th>전시코너</th>
								<td>5개</td>
							</tr>
							<tr>
								<th>출력유형</th>
								<td colspan="3">
									<input type="text" title="입력" class="input_text w121" />
									<input type="text" title="입력" class="input_text w246 mgl7" />
									<a href="#" class="btn_h25_type1 mgl7">검색</a>
								</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="btn_area_center">
					<a href="#" class="btn_type1">저장</a>
				</div>

				<div class="closeBtn"><button type="button" >팝업 닫기</button></div>
			</div>
	</t:putAttribute>
</t:insertDefinition>
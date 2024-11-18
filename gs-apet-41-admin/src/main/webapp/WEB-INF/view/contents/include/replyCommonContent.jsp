<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
	<form name="contsReplyListForm" id="contsReplyListForm" method="post">
		<div class="easyui-accordion search-accordion" data-options="onUnselect:accordion.onUnselect, onSelect:accordion.onSelect" style="width:100%">
			<div title="<spring:message code='admin.web.view.common.search' />" style="padding:10px">
				<table class="table_type1">
					<colgroup>
						<col width="20%"/>
						<col width="80%"/>
						<col width="20%"/>
						<col width="80%"/>
					</colgroup>
					<caption>공통 댓글 검색 목록</caption>
					<tbody>
						<tr>
							<th><spring:message code="column.reply.reg_dtm" /></th>
							<td colspan="3">
								<!-- 등록일 -->
								<frame:datepicker startDate="strtDate" startValue="${frame:toDate('yyyy-MM-dd') }" endDate="endDate" endValue="${frame:toDate('yyyy-MM-dd') }" />&nbsp;&nbsp;
								<select id="checkOptDate" name="checkOptDate" onchange="searchDateChange();">
									<frame:select grpCd="${adminConstants.SELECT_PERIOD}" selectKey="${adminConstants.SELECT_PERIOD_40 }"
									defaultName="기간선택" />
								</select>
							</td>
						</tr>
					<c:if test="${replyGb eq 'apet' }">
						<tr>
							<th><spring:message code="column.reply.vd_search"/></th>
							<td>
								<!-- 영상별 -->
								<select id="vdSearchGb" name="vdSearchGb">
									<option value="" selected="selected">전체</option>
									<option value="10">영상 ID</option>
									<option value="20">제목</option>
								</select>
								<input type="text" name="vdSearchTxt" value="" />
							</td>
	                        <th><spring:message code="column.reply.service_gb"/></th>
	                        <td>
	                            <!-- 서비스 구분 -->
	                            <frame:radio name="contsStatCd" grpCd="${adminConstants.CONTS_STAT}" defaultName="전체" />
	                        </td>
						</tr>
						<tr>
							<th><spring:message code="column.reply.regr_nm"/></th>
							<td>
								<!-- 등록자 -->
								<input type="text" name="loginId" value="" />
							</td>
							<th><spring:message code="column.reply.rpl_regr_nm"/></th>
							<td>
								<!-- 답변자 -->
								<input type="text" name="usrNm" value="" />
							</td>
						</tr>
					</c:if>
					<c:if test="${replyGb eq 'apetRptp' or replyGb eq 'petLogRptp' }">
						<tr>
							<th><spring:message code="column.rptp_cnt"/></th>
							<td>
								<!-- 신고 접수 건수 -->
								<select id="rptpCnt" name="rptpCnt" onchange="">
									<option value="" data-usrdfn1="" selected="selected">전체</option>
									<option value="5" data-usrdfn1="" title="5">5</option>
									<option value="4" data-usrdfn1="" title="4">4</option>
									<option value="3" data-usrdfn1="" title="3">3</option>
									<option value="2" data-usrdfn1="" title="2">2</option>
									<option value="1" data-usrdfn1="" title="1">1</option>
								</select>
							</td>
	                        <th><spring:message code="column.reply.rptp_type"/></th>
	                        <td>
	                            <!-- 신고 사유 -->
	                            <frame:radio name="rptpRsnCd" grpCd="${adminConstants.RPTP_RSN}" defaultName="전체" />
	                        </td>
						</tr>
						<tr>
	                        <th><spring:message code="column.reply.service_gb"/></th>
	                        <td>
	                            <!-- 서비스 구분 -->
	                            <frame:radio name="contsStatCd" grpCd="${adminConstants.CONTS_STAT}" defaultName="전체" />
	                        </td>
							<th><spring:message code="column.reply.regr_nm"/></th>
							<td>
								<!-- 등록자 -->
								<input type="text" name="loginId" value="" />
							</td>
						</tr>
					</c:if>
						<tr>
							<th><spring:message code="column.reply.content"/></th>
							<td colspan="3">
								<!-- 댓글 내용 -->
								<input type="text" name="aply" class="w800" />
							</td>
						</tr>
					</tbody>
				</table>
	
				<div class="btn_area_center">
					<button type="button" onclick="searchReplyList();" class="btn btn-ok">검색</button>
					<button type="button" onclick="searchReset('contsReplyListForm');" class="btn btn-cancel">초기화</button>
				</div>
			</div>
		</div>
		<div class="mModule">
		<c:if test="${replyGb eq 'apetRptp' or replyGb eq 'petLogRptp' }">
			<div align="right">
				<select class="w175" id="contsStat" name="contsStat">
					<frame:select grpCd="${adminConstants.CONTS_STAT}" defaultName="선택" showValue="false" usrDfn1Val="Y" />
				</select>
				<button type="button" onclick="updateSelectAllReply();" class="btn btn-add" style="margin-right:0px;">일괄 변경</button>
			</div>
		</c:if>
			
			<table id="contsReplyList"></table>
			<div id="contsReplyListPage"></div>
		</div>
	</form>
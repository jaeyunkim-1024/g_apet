<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>

					<table class="table_type1 border_top_none">
						<caption>회원 기본 정보</caption>
						<colgroup>
							<col style="width:125px;">
							<col />
							<col style="width:125px;">
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><spring:message code="column.mbr_no"/></th>
								<td id="counselMemberInfoMbrNo" class="counselMemberInfo">
								</td>
								<th><spring:message code="column.mbr_nm"/></th>
								<td id="counselMemberInfoMbrNm" class="counselMemberInfo">
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.st_id"/></th>
								<td id="counselMemberInfoStNm" class="counselMemberInfo">
								</td>
								<th><spring:message code="column.join_dtm"/></th>
								<td id="counselMemberInfoJoinDtm" class="counselMemberInfo">
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.mbr_grd_cd"/></th>
								<td>
									<!-- 회원 등급 코드-->
									<select class="counselMemberInfoVal" id="counselMemberInfoMbrGrdCd" title="<spring:message code="column.mbr_grd_cd"/>" disabled="disabled">
										<option value="">--선택--</option>
										<frame:select grpCd="${adminConstants.MBR_GRD}" selectKey="" />
									</select>
								</td>
								<th><spring:message code="column.mbr_stat_cd"/></th>
								<td>
									<!-- 회원 상태 코드-->
									<select class="counselMemberInfoVal" id="counselMemberInfoMbrStatCd" title="<spring:message code="column.mbr_stat_cd"/>" disabled="disabled">
										<option value="">--선택--</option>
										<frame:select grpCd="${adminConstants.MBR_STAT}" selectKey="" />
									</select>
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.gd_gb_cd"/></th>
								<td>
									<!-- 성별 구분 코드-->
									<select class="counselMemberInfoVal" id="counselMemberInfoGdGbCd" title="<spring:message code="column.gd_gb_cd"/>" disabled="disabled">
										<option value="">--선택--</option>
										<frame:select grpCd="${adminConstants.GD_GB}" selectKey="" />
									</select>
								</td>
								<th><spring:message code="column.birth"/></th>
								<td id="counselMemberInfoBirth" class="counselMemberInfo">
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.email"/></th>
								<td  id="counselMemberInfoEmail" class="counselMemberInfo">
								</td>
								<th><spring:message code="column.email_rcv_yn"/></th>
								<td>
									<!-- 이메일 수신 여부-->
									<select class="counselMemberInfoVal" id="counselMemberInfoEmailRcvYn" title="<spring:message code="column.email_rcv_yn"/>" disabled="disabled">
										<option value="">--선택--</option>
										<frame:select grpCd="${adminConstants.EMAIL_RCV_YN}" selectKey="" />
									</select>
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.mobile"/></th>
								<td  id="counselMemberInfoMobile" class="counselMemberInfo">
								</td>
								<th><spring:message code="column.sms_rcv_yn"/></th>
								<td>
									<!-- SMS 수신 여부-->
									<select class="counselMemberInfoVal" id="counselMemberInfoSmsRcvYn" title="<spring:message code="column.sms_rcv_yn"/>" disabled="disabled">
										<option value="">--선택--</option>
										<frame:select grpCd="${adminConstants.SMS_RCV_YN}" selectKey="" />
									</select>
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.tel"/></th>
								<td  id="counselMemberInfoTel" class="counselMemberInfo">
								</td>
								<th><spring:message code="column.join_path_cd"/></th>
								<td>
									<!-- 가입 경로 코드-->
									<select class="counselMemberInfoVal" id="counselMemberInfoJonPathCd" title="<spring:message code="column.join_path_cd"/>" disabled="disabled">
										<option value="">--선택--</option>
										<frame:select grpCd="${adminConstants.JOIN_PATH}" selectKey="" />
									</select>
								</td>
							</tr>
							<tr>
								<th><spring:message code="column.member_view.svmn_rmn_amt"/></th>
								<td id="counselMemberInfoSvmnRmnAmt" class="counselMemberInfo">
								</td>
								<th><spring:message code="column.ntn_gb_cd"/></th>
								<td>
									<!-- 국적 -->
									<select class="counselMemberInfoVal" id="counselMemberInfoNtnGbCd" title="<spring:message code="column.ntn_gb_cd"/>" disabled="disabled">
										<option value="">--선택--</option>
										<frame:select grpCd="${adminConstants.NTN_GB}" selectKey="${member.ntnGbCd }" />
									</select>
								</td>
							</tr>
						</tbody>
					</table>
					
					<div class="btn_area_center">
						<button type="button" id="counselMemberInfoDetailView" onclick="counselInfoMember.detailView();" class="btn btn-add">상세조회</button>
					</div>
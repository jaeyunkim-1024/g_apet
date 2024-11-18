<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
		<form name="userInfoLayerForm" id="userInfoLayerForm" method="post">
		<table class="table_type1 popup">
			<caption>나의 정보</caption>
			<tbody>
				<tr>
					<th><spring:message code="column.user_id" /></th>
					<td style="display:flex;padding-top: 7px;">
						<input type="text" readonly="readonly" style="width:unset;padding: 0 0 0 10px;" title="<spring:message code="column.user_id" />" value="${user.loginId }"/>
						<button type="button" onclick="layerUserInfo.updatePwd();" class="btn btn-add">비밀번호 변경</button>
					</td>
					<th><spring:message code="column.user_name" /></th>
					<td>
						<input type="text" readonly="readonly"   title="<spring:message code="column.usr_nm" />" value="${user.usrNm }"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.user_group" /></th>
					<td>
						<input type="text" readonly="readonly" title="<spring:message code="column.user_group" />" value="${user.dpNm}" maxlength="50"/>
					</td>
					<th><spring:message code="column.user_auth" /></th>
					<td>
						<input type="text" readonly="readonly"  title="<spring:message code="column.user_auth" />" value="${user.authNm }" maxlength="50"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.user_tel" /></th>
					<td>
						<%-- <input type="text" readonly="readonly" class="phoneNumber" title="<spring:message code="column.user_tel" />" value="${user.tel}"/> --%>
						<input type="text" id="inputColumn" class="phoneNumber" name="tel" title="<spring:message code="column.user_tel" />" value="${user.tel}"/>
					</td>
					<th><spring:message code="column.user_phone" /></th>
					<td>
						<%-- <input type="text" readonly="readonly" class="phoneNumber"  title="<spring:message code="column.user_phone" />" value="${user.mobile}"/> --%>
						<input type="text" id="inputColumn" class="phoneNumber" name="mobile" title="<spring:message code="column.user_phone" />" value="${user.mobile}"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="column.user_email" /><strong class="red">*</strong></th>
					<td colspan="3">
						<input type="text" id="inputColumn" class="validate[required, custom[email]]" name="email" title="<spring:message code="column.user_email" />" value="${user.email}"/>
					</td>
					<%-- <th><spring:message code="column.usr_ip" /></th>
					<td>
						<input type="text" class="validate[custom[mobile]]" name="usrIp" title="<spring:message code="column.usr_ip" />" value="${user.usrIp}"/>
					</td> --%>
				</tr>
				<tr>
					<th><spring:message code="column.user_valid_dtm" /></th>
					<td>
						<input type="text"  readonly="readonly"  title="<spring:message code="column.user_valid_dtm" />" value="${user.validStDtm} ~ ${user.validEnDtm}"  ${ user.validStDtm == null ?'style="display:none;"' :'' }/>
					</td>
					<th><spring:message code="column.user_last_login" /></th>
					<td>
						<input type="text"  readonly="readonly"  title="<spring:message code="column.user_last_login" />" value="${user.lastLoginDtm}"/>
					</td>
				</tr>
			</tbody>
		</table>
		</form>
		<style>
		input[type=text] {
			border : 0px; 
			width : 95%;
		} 
		#inputColumn {
			width: 230px;
		    height: 26px;
		    line-height: 26px;
		    border: 1px solid #d5d5d5;
		    padding: 0px 10px;
		}
		tr > th {
			width : 90px !important;
		}
		.btn-add{
			padding: 0px 10px;
    		height: 30px;
		}
		</style>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<t:insertDefinition name="contentsLayout">
	<t:putAttribute name="script">
		<script type="text/javascript">
			function dataCenterBtn(){
				var options = {
					url : "<spring:url value='/solution/goDataCenter.do' />"
					,data : {
						loginId : "${session.loginId}",
						userNo : "${session.usrNo}"
					}
					,callBack : function(data) {
						let loginId = data.loginId.replaceAll("+", "%2B");
						let userNo = data.userNo.replaceAll("+", "%2B");
						window.open(data.dataCenterUrl + "?loginId=" + loginId + "&userNo=" + userNo);
					}
				}
				ajax.call(options);
			}
			
			function searchCenterBtn(){
			}
		</script>
	</t:putAttribute>
	<t:putAttribute name="content">
		<table class="table_type1">
				<tbody>
					<tr>
						<th>데이터 관리 센터</th>
						<td>
						<button class = "btn" onclick = "dataCenterBtn();">
							이동
						</button>
						<storng class ="red">*</storng> 데이터 관리 센터 이동 버튼입니다.
						</td>
					</tr>
					<tr>
						<th>검색 관리 센터 </th>
						<td>
						<button class = "btn" onclick = "window.open('${searchCenterUrl}');">
							이동
						</button>
						<storng class ="red">*</storng> 검색 관리 센터 이동 버튼입니다.
						</td>
					</tr>
					<tr>
						<th>영상 관리 센터</th>
						<td>
						<button class = "btn" onclick = "window.open('${videoCenterUrl}');">
							이동
						</button>
						<storng class ="red">*</storng> 영상 관리 센터 이동 버튼입니다.
						</td>
					</tr>
				</tbody>
			</table>
	</t:putAttribute>
</t:insertDefinition>

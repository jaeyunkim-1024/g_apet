<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">

</script>
<form name="pushSuccessDetailPopForm" id="pushSuccessDetailPopForm">
	<input type="hidden" name="dispClsfNo" id="dispClsfNo" value="">
	<input type="hidden" name="dispCornNo" id="dispCornNo" value="">

	<table class="table_type1 popup">
		<caption>알림 메시지 상세 정보</caption>
		<tbody>
			<tr>
				<th>구분</th>
				<td>
					<!-- 구분 -->
					${pushMessageInfo.title }
				</td>
				<th>발송방식</th>
				<td>
					<!-- 발송방식 -->
					${pushMessageInfo.title }
				</td>
			</tr>
			<tr>
				<th>발송일자</th>
				<td>
					<!-- 발송일자 -->
					${pushMessageInfo.title }
				</td>
				<th>발송 건수</th>
				<td>
					<!-- 발송 건수 -->
					${pushMessageInfo.title }
				</td>
			</tr>
			<tr>
				<th>전송방식</th>
				<td>
					<!-- 전송방식 -->
					${pushMessageInfo.title }
				</td>
				<th>OS 구분</th>
				<td>
					<!-- OS 구분 -->
					${pushMessageInfo.title }
				</td>
			</tr>
			<tr>
				<th>메시지 타이틀</th>
				<td colspan="3">
					<!-- 메시지 타이틀 -->
					${pushMessageInfo.title }
				</td>
			</tr>
		</tbody>
	</table>
</form>

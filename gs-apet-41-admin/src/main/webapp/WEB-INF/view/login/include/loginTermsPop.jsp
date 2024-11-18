<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
	$(document).ready(function(){	
		initPanelHeight();
	});
	
	function initPanelHeight() {
		var loginTermsLayerHeight = parseInt($("#loginTermsLayer").css("height"));
		var termsLabelHeight = parseInt($("#termsLabel").css("height"));
		var termsDivHeight = loginTermsLayerHeight - termsLabelHeight - 10;
		
		$("#termsDiv").css("height", termsDivHeight);		
	}
</script>

<div class="modal fade" id="popupTermsLayer"    title="약관동의">
	<!-- TODO 조은지 : value 임시 값 -->
	<label id="termsLabel"><input type="checkbox" name="termsNo" id="termsYn" value="999"><span>제 3자 정보제공 동의 약관에 동의합니다</span></label>
	<div id="termsDiv" style="border: 1px lightgray solid;overflow: auto;">
		약관내용 입니다
		<br>
		약관내용
		<br>
		약관내용
		약관내용 입니다
		<br>
		약관내용
		<br>
		약관내용
		약관내용 입니다
		<br>
		약관내용
		<br>
		약관내용
		약관내용 입니다
		<br>
		약관내용
		<br>
		약관내용
		약관내용 입니다
		<br>
		약관내용
		<br>
		약관내용
		약관내용 입니다
		<br>
		약관내용
		<br>
		약관내용
		약관내용 입니다
		<br>
		약관내용
		<br>
		약관내용
		약관내용 입니다
		<br>
		약관내용
		<br>
		약관내용
		약관내용 입니다
		<br>
		약관내용
		<br>
		약관내용
		약관내용 입니다
		<br>
		약관내용
		<br>
		약관내용
		약관내용 입니다
		<br>
		약관내용
		<br>
		약관내용
	</div>
</div>

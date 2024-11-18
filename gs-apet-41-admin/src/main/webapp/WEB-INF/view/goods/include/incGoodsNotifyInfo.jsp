<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<script type="text/javascript">
$(function(){
	//공정위품목군 기타일 때 전체자동입력 선택 시
	$("#autoWriteAll").on('click', function(){
		if($(this)[0].checked){
			var checkBox = $("input[name=autoWrite]")
			for(var i = 0; i < checkBox.length; i++){
				if(!checkBox[i].checked){
					$(checkBox[i]).trigger('click');
				}
			}
		}else{
			var checkBox = $("input[name=autoWrite]:checked")
			for(var i = 0; i < checkBox.length; i++){
				$(checkBox[i]).trigger('click');
			}
		}
	});
	
	//공정위품목군 기타일 때 자동입력 선택 시
	$("#notifyItem").on('click', 'input[name=autoWrite]', function(){
		var notifyItemNo = $(this).val();
		if($(this)[0].checked && notifyItemNo == 320){
			$("#itemVal"+notifyItemNo).val($('input[name=goodsNm]').val());
		}else if($(this)[0].checked && notifyItemNo == 322){
			$("#itemVal"+notifyItemNo).val($('#ctrOrg').val());
		}else if($(this)[0].checked && notifyItemNo == 323){
			$("#itemVal"+notifyItemNo).val($('input[name=mmft]').val());
		}else if(!$(this)[0].checked){
			$('#autoWriteAll')[0].checked = false;
		}
		
		if($("input[name=autoWrite]").length == $("input[name=autoWrite]:checked").length){
			$('#autoWriteAll')[0].checked = true;
		}
	});
	
	//자동입력 선택 후 내용 변경 시 체크박스 해제
	$("[name=itemVal]").on('change', function(){
		var notifyItemNo = $(this)[0].id.replace('itemVal', '');
		if($("#autoWrite"+notifyItemNo).length != 0 && $("#autoWrite"+notifyItemNo)[0].checked){
			$("#autoWrite"+notifyItemNo).trigger('click');
		} 
	});
	
	//자동입력 체크된 상태에서 기본정보 변경 시
	$('input[name=goodsNm]').on('change', function(){
		if($("#ntfId").val() == '35' && $("#autoWrite320")[0].checked){
			$("#itemVal320").val($(this).val());
		}
	});
	$('#ctrOrg').on('change', function(){
		if($("#ntfId").val() == '35' && $("#autoWrite322")[0].checked){
			$("#itemVal322").val($(this).val());
		}
	});
	$('input[name=mmft]').on('change', function(){
		if($("#ntfId").val() == '35' && $("#autoWrite323")[0].checked){
			$("#itemVal323").val($(this).val());
		}
	});
	
})
// 공정위 품목군 선택시 하단 표 변경
function notifyItemView (obj ) {
	var ntfId = $(obj).children("option:selected").val();
	
	if($(obj).children("option:selected").text() == "기타"){
		$("span[name=autoSpan]").show();
	}else{
		$("span[name=autoSpan]").hide();
	}
	var config = {
		url : "<spring:url value='/goods/notifyItemView.do' />"
		, data : { ntfId : ntfId }
		, dataType : "html"
		, callBack : function (data ) {
			$('#autoWriteAll')[0].checked = false;
			$("#notifyItem").html ('');
			$("#notifyItem").append (data );
		}
	};
	ajax.call(config );
}

// 공정위 품목군 상품상세설명 참조 넣기
function fillDescThis(){
	var fillSentence = "<spring:message code='column.goods.ntf.desc' />";

	$("input[name=ntfItemId]").each (function () {
		$(this).siblings("#itemVal" + $(this).val()).val(fillSentence);
	});
	
	$("input[name=autoWrite]").each(function(){
		if($(this)[0].checked){
			$(this).trigger('click');
		}
	});
}

function fnByteChk(obj){
	var conts = obj.value;

	var cnt = 0;
	var ch = '';

	for (var j=0; j<conts.length; j++) {
		ch = conts.charAt(j);
		if (escape(ch).length > 4) {
			cnt += 2;
		} else {
			cnt += 1;
		}
	}
	
	if(cnt > 200){
		messager.alert("상품 필수 정보는 200바이트를 넘을 수 없습니다.", "Info", "info", function(){	
			
			var tcnt = 0;
			var xcnt = 0;
			for (var i=0; i<conts.length; i++) {
				ch = conts.charAt(i);
				if (escape(ch).length > 4) {
					tcnt += 2;
				} else {
					tcnt += 1;
				}

				if (tcnt > 200) {
					$('#' + obj.id).val(conts.substring(0,i));;
					break;
				} else {
					xcnt = tcnt;
				}
			}
		});
	}
}
</script>
	<div title="<spring:message code="column.goods.notifyInfo" />" data-options="" style="padding:10px">
	
		<table class="table_type1">
			<caption></caption>
			<tbody>
				<tr>
					<th scope="row"><spring:message code="column.goods.ntf_id" /><strong class="red">*</strong></th>	<!--공정위 품목군-->
					<td>
						<select class="w400 validate[required]" name="ntfId" id="ntfId" onchange="notifyItemView (this); return false;"  title="<spring:message code="column.goods.ntf_id" />">
<%-- 										<option value="" selected="${empty notiInfo.ntfId ? 'selected' : '' }" >선택하세요</option> --%>
							<c:forEach items="${notifyInfo }" var="notiInfo" >
								<option value="${notiInfo.ntfId }" <c:if test="${notiInfo.ntfId eq goodsBase.ntfId or (empty goodsBase and notiInfo.ntfNm eq '기타')}"><c:out value=" selected='selected'" escapeXml="false" /></c:if> >${notiInfo.ntfNm }</option>
							</c:forEach>
						</select>
						<button type="button" class="btn" onclick="fillDescThis( );" ><spring:message code="column.goods.ntf.desc" /><!-- 상품상세설명참조 버튼 --></button>
						<span name="autoSpan"><input type="checkbox" id="autoWriteAll" name="autoWriteAll"/><spring:message code="column.goods.auto_write_all"/></span>
					</td>
				</tr>
			</tbody>
		</table>
	
		<div id="notifyItem" >
			<jsp:include page="/WEB-INF/view/goods/include/notifyItemView.jsp" />
		</div>
	
	</div>
	<hr />
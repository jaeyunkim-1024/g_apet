<%@ page pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<style type="text/css">
	table {
  		border: 1px solid #ecedef;
  		border-collapse: collapse;
	}
	th, td {
		  border: 1px solid #ecedef;
		  padding: 10px;
	}
</style>
</head>
<body>
<script type="text/javascript">
var list = JSON.parse ('${jsonText}');

function setData() {
	$("#result").html("");
	let thisVal = $("#list").val();
	if(thisVal != ""){
		for(let idx in list){
			if(thisVal ==  list[idx].dtlCd){
				$("#dtlCd").html(list[idx].dtlCd);
				$("#dtlNm").html(list[idx].dtlNm);
				$("#usrDfn1Val").html(list[idx].usrDfn1Val);
				$("#usrDfn2Val").html(list[idx].usrDfn2Val);
				$("#usrDfn3Val").html(list[idx].usrDfn3Val);
				$("#usrDfn4Val").html(list[idx].usrDfn4Val);
				$("#useYn").html(list[idx].useYn);
				let addHtml ='<button type="button" onclick="executeBatch();">실행</button>';
				$("#btnArea").html(addHtml);
				$("#list").data("useyn",list[idx].useYn);
			}			
		}
	}
}
function executeBatch() {
	if($("#list").data("useyn") != "Y"){
		alert("공통코드 'BATCH'에 해당하는 코드 상세의 사용 여부를 변경하여주세요.");
		return;
	}
	let thisVal = $("#list").val();
	$.ajax({
	    url: "/batch/executeBatch",
	    data: { dtlCd: thisVal },
	    type: "POST",                             
	    dataType: "json",
	    success:function(data){
			$("#result").html(data.result);
        }
	});
}
</script>
	배치 선택 : 
	<select id="list" onchange="setData();">
		<option value="">선택하세요</option>
		<c:forEach items="${codeList}" var="thisItem" varStatus="idx">
			<option value="${thisItem.dtlCd}">${thisItem.dtlNm}</option>
		</c:forEach>
	</select>
	<table style="border: #ecedef solid 1px; border-collapse: collapse;">
		<colgroup>
			<col style="text-align: center;">
			<col>
			<col>
			<col>
			<col>
			<col>
			<col style="text-align: center;">
			<col style="text-align: center;">
		</colgroup>
		<tr>
			<th>코드</th>
			<th>상세명</th>
			<th>배치명</th>
			<th>패키지</th>
			<th>클래스</th>
			<th>메서드</th>
			<th>가능</th>
			<th>실행</th>
			<th>결과</th>
		</tr>
		<tr>
			<td id="dtlCd"></td>
			<td id="dtlNm"></td>
			<td id="usrDfn1Val"></td>
			<td id="usrDfn2Val"></td>
			<td id="usrDfn3Val"></td>
			<td id="usrDfn4Val"></td>
			<td id="useYn"></td>
			<td id="btnArea"></td>
			<td id="result"></td>
		</tr>
	</table>
</body>
</html>


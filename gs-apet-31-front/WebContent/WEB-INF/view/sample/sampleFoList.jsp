<%--	
 - Class Name	: /sample/sampleFoList.jsp
 - Description	: FO 개발 목록
 - Since		: 2020.12.22
 - Author		: KKB
--%>

<!DOCTYPE HTML>
<html lang="ko">
<head>
	<jsp:include page="/WEB-INF/tiles/include/meta.jsp" />
	<style type="text/css">
		.btn {
		  border: 2px solid black;
		  margin: 3px;
		  background-color: white;
		  color: black;
		  padding: 7px 28px;
		  font-size: 16px;
		  cursor: pointer;
		  border-color: #e7e7e7;
  		  color: black;
		}
	</style>
</head>
<body>
	<button onclick="location.href='/sample/sampleList/'" class="btn"> FO </button>
	<button onclick="location.href='/sample/sampleList/?gb=bo'" class="btn"> BO </button>
	<button onclick="location.href='/sample/sampleList/?gb=common'" class="btn"> 공통 </button>
	<p style="color: red"> 개발URL 작성시 a태그에 도메인은 $ {view.stDomain} 을 사용하여 주세요. 예)$ {view.stDomain}/sample/sampleList/. local의 port는 설정상 BO 8080, FO 8180입니다.</p>
	
<table class="__se_tbl_ext" border="0" cellpadding="0" cellspacing="0" width="1610" style="border-collapse: collapse;width:1210pt">
<colgroup><col width="41" style="mso-width-source:userset;mso-width-alt:1301;width:31pt">
<col width="43" style="mso-width-source:userset;mso-width-alt:1386;width:33pt">
<col width="147" span="5" style="mso-width-source:userset;mso-width-alt:4693; width:110pt">
<col width="45" style="mso-width-source:userset;mso-width-alt:1450;width:34pt">
<col width="173" style="mso-width-source:userset;mso-width-alt:5546;width:130pt">
<col width="50" span="3" style="mso-width-source:userset;mso-width-alt:1600; width:38pt">
<col width="173" style="mso-width-source:userset;mso-width-alt:5546;width:130pt">
<col width="77" style="mso-width-source:userset;mso-width-alt:2474;width:58pt">
<col width="173" style="mso-width-source:userset;mso-width-alt:5546;width:130pt">
</colgroup>
<tbody>
<tr height="46" style="height:34.5pt">
	<td height="46" class="xl79" width="41" style="font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; height:34.5pt;width:31pt">
		NO
	</td>
	<td class="xl79" width="43" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; border-left:none;width:33pt">
		Task
	</td>
	<td class="xl79" width="147" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; border-left:none;width:110pt">
		L1
	</td>
	<td class="xl79" width="147" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; border-left:none;width:110pt">
		L2
	</td>
	<td class="xl79" width="147" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; border-left:none;width:110pt">
		L3
	</td>
	<td class="xl79" width="147" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; border-left:none;width:110pt">
		L4
	</td>
	<td class="xl79" width="147" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; border-left:none;width:110pt">
		L5
	</td>
	<td class="xl76" width="45" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; width:34pt">
		<br>
		 유형
	</td>
	<td class="xl76" width="173" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; border-left:none;width:130pt">
		<br>
		 퍼블 URL
	</td>
	<td class="xl76" width="50" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; border-left:none;width:38pt">
		<br>
		 퍼블<br>
		 담당자
	</td>
	<td class="xl76" width="50" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; border-left:none;width:38pt">
		<br>
		 담당<br>
		 PL
	</td>
	<td class="xl75" width="50" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; white-space:normal; border-left:none;width:38pt">
		<br>
		 담당<br>
		 개발자
	</td>
	<td class="xl80" width="173" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; white-space:normal; width:130pt">
		<br>
		 개발URL
	</td>
	<td class="xl82" width="77" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; white-space:normal; border-left:none;width:58pt">
		개발 완료일
	</td>
	<td class="xl81" width="173" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; border-left:none;width:130pt">
		비고
	</td>
</tr>


<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
팝업(FO)  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  필터 pop
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤정유
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
팝업(FO)  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 연관상품 (팝업)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연관 상품 목록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
팝업(FO)  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상품 요약
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  요약정보
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
팝업(FO)  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  옵션선택
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
팝업(FO)  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  미니 장바구니
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상품목록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김진홍
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
팝업(FO)  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  주문하기
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김진홍
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
팝업(FO)  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  쿠폰 적용(팝업)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
팝업(FO)  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  재입고 알림 신청
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  TBD04
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  통합 메인
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤정유
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (Header, Footer)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤정유
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (GNB, LNB)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤정유
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫TV 홈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  천지안
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫스쿨
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  목록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  천지안
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  관심태그/오리지널 시리즈 배너
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  천지안
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 시리즈 홈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  목록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  양경운
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 영상 List
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  양경운
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 펫TV 영상 상세
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이동식
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  	<a href="${view.stDomain}/tv/series/indexTvDetail?vdId=N2021012100018&sortCd=20">http://localhost:8180/tv/series/indexTvDetail?vdId=N2021012100018&sortCd=20</a>
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  	2021-01-22
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
	vdId : 영상ID<br>
	sortCd : 정렬기준(10:최신순, 20:인기순)<br>
	listGb : 진입목록 구분값(HOME:펫TV홈, SRIS:시리즈목록, VDO_F_N:영상목록(F:맞춤, N:신규, P:인기), VDO_F_R:영상목록(댓글팝업), VDO_F_T:영상목록(연관상품팝업), RECENT:최근 시청한 영상)<br>
	<%--vdoListGb : 영상목록 구분(OP:TV 맞춤형 영상, TAG:TV 관심태그, RE:TV 연관상품)--%>
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  시청이력 플레이어 연동저장
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이동식
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  	<a href="${view.stDomain}/tv/series/indexTvDetail?vdId=N2021012100018&sortCd=20">http://localhost:8180/tv/series/indexTvDetail?vdId=N2021012100018&sortCd=20</a>
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  	2021-01-29
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 좋아요
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  한정호
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
	http://localhost:8180/tv/series/indexTvDetail?vdId=N2021012100018  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
	2021-02-16  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 댓글 입력(팝업)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  한정호
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
	http://localhost:8180/tv/series/indexTvDetail?vdId=N2021012100018  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
 	2021-02-23 
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 신고(팝업)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  한정호
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
	http://localhost:8180/tv/series/indexTvDetail?vdId=N2021012100018  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
	2021-02-26
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 찜
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  강기복
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상세세부영상 List
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이동식
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
	<a href="${view.stDomain}/tv/series/indexTvDetail?vdId=N2021012100018&sortCd=20">http://localhost:8180/tv/series/indexTvDetail?vdId=N2021012100018&sortCd=20</a>
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
 	2021-01-22
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫스쿨 홈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  천지안
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫스쿨 교육영상 상세
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김우진
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  <a href="${view.stDomain}/tv/school/indexTvDetail?vdId=E2021011300011">http://localhost:8180/tv/school/indexTvDetail?vdId=E2021011300011</a>
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  2021-01-29
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   하위작업:연관상품
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫스쿨 따라잡기
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김우진
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  <a href="${view.stDomain}/tv/school/indexTvComplete?vdId=E2021011300011">http://localhost:8180/tv/school/indexTvComplete?vdId=E2021011300011</a>
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  2021-01-29
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  Tip(팝업)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김우진
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  <a href="${view.stDomain}/tv/school/indexTvDetail?vdId=E2021011300011">http://localhost:8180/tv/school/indexTvDetail?vdId=E2021011300011</a>
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  2021-02-22
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  Q&A(팝업)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김우진
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  <a href="${view.stDomain}/tv/school/indexTvDetail?vdId=E2021011300011">http://localhost:8180/tv/school/indexTvDetail?vdId=E2021011300011</a>
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  2021-02-18
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  웹툰(팝업)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김우진
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  <a href="${view.stDomain}/tv/school/indexTvDetail?vdId=E2021011300011">http://localhost:8180/tv/school/indexTvDetail?vdId=E2021011300011</a>
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  2021-02-16
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상세교육영상리스트
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김우진
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  <a href="${view.stDomain}/tv/school/indexTvComplete?vdId=E2021011300011">http://localhost:8180/tv/school/indexTvComplete?vdId=E2021011300011</a>
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  2021-02-26
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫스쿨 교육완료 상세
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김우진
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  <a href="${view.stDomain}/tv/school/indexTvComplete?vdId=E2021011300011">http://localhost:8180/tv/school/indexTvComplete?vdId=E2021011300011</a>
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  2021-02-05
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   하위작업:회원프로필,펫등록 화면 이동
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫스쿨 펫로그연동
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김우진
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  <a href="${view.stDomain}/tv/school/indexTvComplete?vdId=E2021011300011">http://localhost:8180/tv/school/indexTvComplete?vdId=E2021011300011</a>
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  2021-02-10
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  찜 보관
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김우진
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  광고 배너
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김우진
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫TV 해시태그 모아보기 
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫로그 홈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  목록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지연
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 댓글 입력(팝업)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지연
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  게시글 등록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  사진&동영상, 게시글&태그 등록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지연
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  위치, 연관 상품 등록, 등록완료
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지연
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  좋아할만한 펫로그
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지연
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  회원맞춤 추천
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지연
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  인기 태그
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지연
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  태그 선택
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지연
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  My 펫로그
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지연
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  다른계정 펫로그
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지연
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  태그 List
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지연
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 검색
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  어바웃 Shop 홈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤정유
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
 <a href="${view.stDomain}/shop/home">${view.stDomain}/shop/home</a>
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  생생한 후기
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 펫로그후기 상세
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  타임 Deal
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤정유
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  세일 진행중 더보기
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤정유
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상품준비중 더보기
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤정유
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  폭풍할인 상품
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤정유
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  더보기
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤정유
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  정렬기준 pop 
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤정유
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  LIVE
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤정유
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 라이브영상 상세
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 하트쏘기
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  한정호
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 채팅 입력 pop
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  한정호
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  라이브예고 알림 pop
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김우진
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  라이브신고 pop
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김우진
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  라이브 방송 소개 화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김우진
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  카테고리 List
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤정유
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  브랜드관
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤정유
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기획전
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기획전 목록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  양경운
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  카테고리별 기획전 목록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  양경운
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기획전 상세
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  양경운
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 상품 상세
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상품이미지 더보기
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기획전 정보 노출 및 기획전 링크 연결
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 쿠폰다운받기(팝업)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 태그 모아보기
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 할인혜택 pop
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 배송정보 pop
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 사은품 정보 pop
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 상품 기본정보/노출정보/상세설명/주의사항
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 고시정보
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 연관상품
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 단품정보
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 세트정보
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 묶음정보
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 가격정보
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 관련영상
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 후기
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  일반 후기 등록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  신선희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫로그 후기 등록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  신선희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  옵션 pop
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  신선희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  일반후기 더보기
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  신선희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  일반후기 상세
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  신선희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  일반후기 수정/삭제
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  신선희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫로그후기 더보기
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  양경운
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫로그후기 상세
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  양경운
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫로그후기 수정/삭제
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  양경운
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) Q&A
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상품문의 작성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이하정
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상품문의 상세
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이하정
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상품문의 수정/삭제
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이하정
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 배송/환불/교환/반품/취소
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 옵션 선택
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  최근 본 상품
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  최근 본 상품 List
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  신선희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  삭제
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  신선희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통)장바구니
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  장바구니 메인
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김진홍
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  장바구니 상품
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김진홍
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상품 옵션/수량 변경(팝업)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김진홍
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  할인내역
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김진홍
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  바로구매/선택주문/전체주문
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김진홍
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 주문서 화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  주문 고객 / 배송지 정보
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  주문고객 회원정보 수정
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  회원정보 수정 목록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  베송지 등록/조회
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  　
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  새벽/당일 배송 불가 상품 안내(팝업)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  주문 상품 정보
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  새벽배송/당일배송/택배배송
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  택배배송 요청사항
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  할인 혜택
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  GS&POINT
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  본인인증
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  	http://localhost:8180/login/loginView/ ,	http://localhost:8180/join/indexTerms		
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  2021-02-01
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  사은품 영역
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  사은품 선택(팝업)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  팝업
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  결제수단 선택
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  일반결재
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  신용카드
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  카드 결재 할부 선택
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  무이자 할부 안내(팝업)
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  실시간 계좌 이체
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  가상 계좌
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  간편결재
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  PAYCO
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  NPay
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  결재 금액
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  약관보기
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  결재하기
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  주문완료
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  일반결재
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  신용카드
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  실시간 계좌 이체
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  가상 계좌
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  간편결재
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  PAYCO/NPay
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김사무엘
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫TV
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  목록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  한정호
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫로그
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  마이 펫로그
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  조은지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫샵
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  강아지, 고양이, 관상어, 소동물, 브랜드관
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤정유
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  마이페이지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  내정보 관리
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  마이펫 관리
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  조은지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  찜 리스트
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이하정
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이벤트
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김재윤
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  고객센터
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  천지안
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  공지사항
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김재윤
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  설정
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이벤트
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  진행중인 이벤트 (List)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김재윤
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이벤트 상세
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김재윤
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  나의 참여내역 (List)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김재윤
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  당첨자발표
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김재윤
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  고객센터
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  항목 List
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  자주묻는 질문 List
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  천지안
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상세
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  천지안
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  1:1 상담
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  등록, 완료, 실패
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  천지안
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  1:1 상담내역
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  목록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  천지안
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상세
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  천지안
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  공지사항
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  공지사항 게시글 List
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김재윤
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상세
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김재윤
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  설정
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (비로그인 상태이면)로그인
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  천지안
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (로그인 상태이이면)로그아웃 (표시)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  로그인
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  메인 설정
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이동식
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
 	<a href="${view.stDomain}/setting/indexSettingMain">http://localhost:8180/setting/indexSettingMain</a> 
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  	2021-02-23
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  알림 설정
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  동영상 자동재생 설정
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이동식
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
 	<a href="${view.stDomain}/setting/indexSettingAutoPlay">http://localhost:8180/setting/indexSettingAutoPlay</a> 
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  	2021-02-23
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  서비스 이용약관
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이동식
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  개인정보 취급방침
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이동식
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이용 안내
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  천지안
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  탈퇴 안내
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  APP 버전업데이트 
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  강현진
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  로그인
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  http://localhost:8180/indexLogin
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  2021-02-04
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   하루/펫츠비 기존회원인 경우 퍼블/OTP 구현해야함.
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  id 찾기
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  	http://localhost:8180/login/indexFindId	
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  2021-02-08
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  비밀번호 찾기
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  http://localhost:8180/login/indexFindPswd	
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  2021-02-08
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  SNS 계정으로 로그인하기
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  네이버 로그인
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  카카오 로그인
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  애플 로그인
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  구글 로그인
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 회원가입
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  정회원 가입
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  http://localhost:8180/join/indexTerms , http://localhost:8180/join/indexJoin
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  2021-01-13
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   이미지 업로드 관련 rework 필요
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  SNS회원가입
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  네이버/카카오
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  http://localhost:8180/indexLogin, http://localhost:8180/indexJoin
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  2021-01-20
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  애플/구글
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  http://localhost:8180/indexLogin, http://localhost:8180/indexJoin
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  2021-01-27
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  관심 태그 정보 입력
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  http://localhost:8180/join/indexTag
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  2021-02-01
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (통합회원 인증) 본인인증
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  http://localhost:8180/indexJoin
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  2021-02-01
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 내 정보 변경
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  비밀번호 변경
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  비밀번호 확인
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  비밀번호 변경
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이지희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  회원정보 변경
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김재윤
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  THE POP포인트조회(본인인증)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김재윤
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  탈퇴
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김재윤
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  배송지 관리
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  조은지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 검색
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  검색키워드창 선택
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  최근 검색어
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  사용자 맞춤 태그
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  인기 검색어
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  검색결과 List
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫TV
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  시리즈 검색결과
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫로그
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫로그 계정 검색결과
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  게시글 검색결과
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫샵
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  브랜드관 검색결과
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상품 검색결과
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  펫톡
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  한정호
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
	http://localhost:8180/tv/home/
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
 	2021-03-09
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 회원정보 변경
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김재윤
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  알림
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  알림 List
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김재윤
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  마이펫 관리
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  반려동물 List
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  조은지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  반려동물 정보변경
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  조은지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  프로필 정보 수정
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  조은지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  건강정보 수정
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  조은지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  추가 등록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  조은지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 펫 등록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  조은지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  Step1)반려동물 등록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  조은지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  Step2)반려동물 프로필 등록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  조은지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  Step3)반려동물 건강정보 등록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  조은지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 강아지 건강수첩
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  접종 안내
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  조은지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  예방접종 내역
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  조은지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  예방접종 기록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  조은지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  투약 기록(앱만 진입)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  조은지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  접종 상세
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  조은지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 고양이 건강수첩
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  접종안내
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  조은지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  예방접종 내역
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  현병훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  조은지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  마이찜리스트
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  찜 콘텐츠 List/전체보기
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  천지안
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 최근 시청한 영상
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이동식
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
 	<a href="${view.stDomain}/tv/series/indexTvRecentVideo?listGb=TV">http://localhost:8180/tv/series/indexTvRecentVideo?listGb=TV</a>
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  	2021-02-16
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
	listGb : 진입목록 구분(TV:펫TV 메인, MY:마이페이지 메인)
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  쿠폰
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  쿠폰 내역
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  TBD04
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  쿠폰존
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  쿠폰 다운로드
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  TBD04
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  쿠폰 모두 다운로드
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  TBD04
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  쿠폰 발급 (팝업)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  TBD04
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  최근 본 상품
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  최근 본 상품 목록/ 삭제
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  신선희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  찜 상품
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  찜 상품 목록 /해제
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이하정
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  (공통) 주문/결제 내역
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  오경목
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  전체 주문내역 확인
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  오경목
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상세
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  오경목
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  http://localhost:8180/mypage/order/indexDeliveryDetail?ordNo=C202102230001238
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  2021-02-10
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  거래명세서 출력
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  오경목
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  주문내역서 출력
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  오경목
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  취소신청
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  오경목
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  http://localhost:8180/mypage/order/indexCancelRequest
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  2021-02-19
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  반품신청
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  오경목
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  http://localhost:8180/mypage/order/indexReturnRequest
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  2021-02-24
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  교환신청
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  오경목
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
 
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
 
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  현금영수증신청
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  기타
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  오경목
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   http://localhost:8180/mypage/order/popupCashReceiptRequest
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
 2021-02-16
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  주문목록/배송조회
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  입금대기/결제완료/배송준비/배송중/배송완료
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  오경목
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
 http://localhost:8180/mypage/order/indexDeliveryList
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
 2021-02-05 
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  취소/반품/교환내역
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  오경목
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>

<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  재입고 알림내역
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  윤종성
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상품 문의
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  문의 List
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상품문의 목록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이하정
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  수정/삭제
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  이하정
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상품 후기
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  후기 List
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상품 후기 모아보기 목록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  신선희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23" class="xl66" style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
FO  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상품 후기 등록/상세/수정/삭제
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  화면
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  최용훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  신선희
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>




</tbody>
</table>
<p>
	<br>
</p>

</body>
</html>
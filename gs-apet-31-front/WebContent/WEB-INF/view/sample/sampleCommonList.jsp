<%--	
 - Class Name	: /sample/sampleCommonList.jsp
 - Description	: 공통 개발 목록
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
	<td height="46" class="xl80" width="41" style="font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; height:34.5pt;width:31pt">
		NO
	</td>
	<td class="xl80" width="43" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; border-left:none;width:33pt">
		Task
	</td>
	<td class="xl80" width="147" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; border-left:none;width:110pt">
		L1
	</td>
	<td class="xl80" width="147" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; border-left:none;width:110pt">
		L2
	</td>
	<td class="xl80" width="147" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; border-left:none;width:110pt">
		L3
	</td>
	<td class="xl80" width="147" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; border-left:none;width:110pt">
		L4
	</td>
	<td class="xl80" width="147" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; border-left:none;width:110pt">
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
	<td class="xl81" width="173" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; white-space:normal; width:130pt">
		<br>
		 개발URL
	</td>
	<td class="xl83" width="77" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; white-space:normal; border-left:none;width:58pt">
		개발 완료일
	</td>
	<td class="xl82" width="173" style="height:34.5pt; font-size:8.0pt; font-weight:700; text-align:center; border:1px solid windowtext; background:#D9E1F2; mso-pattern:black none; border-left:none;width:130pt">
		비고
	</td>
</tr>

<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  GS리테일, 통합포인트 조회
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  ARS(080) 서비스
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김상훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  TWC 내부운영자 SSO 연동
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  TWC API 연계 서비스(상담원등록/수정/삭제, 문의 처리이력, 정상 상담원 체크)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  카카오, 간편 로그인 연동
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <a href="http://localhost:8180/sample/sampleLogin/">http://localhost:8180/sample/sampleLogin/</a> 
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  20-12-24
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  네이버, 간편 로그인 연동
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <a href="http://localhost:8180/sample/sampleLogin/">http://localhost:8180/sample/sampleLogin/</a> 
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
 20-12-18 
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  Email 서비스
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
  개발가이드 > 네이버 이메일
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  21-01-25	
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  공통 REST API
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김상훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  20-12-23
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  개인정보 마스킹 유틸
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  인터페이스 로그 이력
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  문자(SMS/LMS/MMS)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김상훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  21-02-05
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  카카오 알림톡
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김상훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  21-02-22
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  푸시(PUSH)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
  개발가이드 > PUSH / 디바이스 토큰
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
 21-02-08
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  항목별 Excel 다운로드(팝업)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김상훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  네이버Map 연동
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 	<a href="http://localhost:8180/sample/sampleNaverMap/">http://localhost:8180/sample/sampleNaverMap/</a>
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  	2021-01-04
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  URL 공유하기
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김상훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  20-12-15
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  구글 간편 로그인 연동
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
  http://localhost:8180/sample/sampleLogin/
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  21-01-19
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  애플 간편 로그인 연동
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
  http://localhost:8180/sample/sampleLogin/
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  21-01-19
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  영상 업로드 솔루션 연동
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김상훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  21-01-19
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  영상 그룹핑 처리
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김상훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  21-01-21
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  썸네일 자동추출
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김상훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  21-01-22
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  우편번호 조회 API
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 	<a href="http://localhost:8180/sample/sampleMoisPost/">http://localhost:8180/sample/sampleMoisPost/</a>
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  	2021-01-08
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  동영상 프리롤 광고 연동
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
  취소
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  구글, IGAworks 관련 처리
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  본인인증 연동
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
  http://localhost:8180/sample/sampleCheckView/
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  21-01-27
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  FO 액션 로그 이력
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
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  강기복
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  개발가이드 > [검색]클릭 이벤트 전송
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  21-01-29
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  Petra 유틸
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  이재찬
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김상훈
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  20-12-22
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  라이브 연동
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  네이버 클라우드 플랫폼 API
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  CIS 단품등록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  CIS 단품수정
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  CIS 단품조회
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  CIS 세트상품등록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  CIS 세트상품수정
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  CIS 세트상품조회
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  CIS 묶음상품등록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  CIS 묶음상품수정
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  CIS 묶음상품조회
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  CIS 옵션상품등록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  CIS 옵션상품수정
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  CIS 옵션상품조회
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  CIS 전체재고조회/단품재고조회/재고변동증분조회
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  CIS 주문등록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  CIS 주문조회
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  CIS 주문취소
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  CIS 반품등록
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
I/F 개발  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  CIS 반품조회
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  연계
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
배치  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  배송 완료 배치
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  배치
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
배치  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  배송 지시 배치
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  배치
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
배치  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  입금 완료 배치
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  배치
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  서성민
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
배치  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상품 재고 배치
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  배치
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
배치  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  상품 가격 배치
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  배치
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
배치  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  탈퇴회원 정보 삭제
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  배치
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
배치  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  회원 등급업/다운
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  배치
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
배치  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  미로그인(1년) 정지처리
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  배치
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
배치  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  공지사항 발송
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  배치
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
배치  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  개인정보 이용내역 통지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  배치
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
배치  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  마케팅 정보 동의 통지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  배치
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
배치  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  데이터 3법 발송 통지
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  배치
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
배치  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  반려동물 예방접종 알림
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  배치
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
배치  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  반려동물 정보관리
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  배치
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
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
배치  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  태그 수신(TWC Daily Batch)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  배치
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김민호
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
배치  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  금칙어 수신(TWC Daily Batch)
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  배치
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">

 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none"> 
  박규태
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  김민호
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td> <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
   
 </td>
</tr>
<tr height="23" style="height:17.0pt">
 <td height="23"  style="width:31pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:none; border-bottom:none; border-left:1px solid windowtext;  mso-pattern:black none; height:17.0pt"></td>
 
 <td class="xl78" style="height:17.0pt; width:33pt; font-size:8.0pt; text-align:center; border:1px solid windowtext;  mso-pattern:black none; border-top:none">
알림발송  
 </td><td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  알림유형 및 필요 TASK정의후 추가예정(EX:회원가입완료 메일발송)
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
  
 </td>
 <td class="xl67" style="height:17.0pt; width:110pt; font-size:8.0pt; text-align:center; border-top:1px solid windowtext; border-right:1px solid windowtext; border-bottom:1px solid windowtext; border-left:none;  mso-pattern:black none; border-top:none">
  
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
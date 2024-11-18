<%-----------------------------------------------------
 * INIrepay.jsp
 *
 * 이미 정상 승인된 거래에서 취소를 원하는 금액을 입력하여 다시 승인을 득하도록 요청한다.
 * 
 * [주의] 부분취소 요청 때마다  새 거래아이디가 반환되나, 부분취소 요청은 반드시 원거래 TID로 가능함에 유의
 * [주의] 원거래가 신용카드 지불인 경우에만 가능
 * (OK 캐쉬백 적립 등이 포함되어 있어도 불가)
 * [주의] 반드시 취소할 금액을 입력하도록 함
 *  
 * Date : 2007/09
 * Author : ts@inicis.com
 * Project : INIpay V5.0 for JAVA(JSP)
 * 
 * http://www.inicis.com
 * Copyright (C) 2007 Inicis, Co. All rights reserved.
-------------------------------------------------------%>
<%@ page language = "java" 
         contentType = "text/html; charset=euc-kr" 
         import ="com.inicis.inipay.INIpay50" %>
<%-- 
     ***************************************
     * 1. INIpay 라이브러리                                    * 
     *************************************** 
--%>
<%
    request.setCharacterEncoding("euc-kr");
	/***************************************
	 * 2. INIpay 클래스의 인스턴스 생성                 *
	 ***************************************/
	INIpay50 inipay = new INIpay50();	
	
	/***********************
	 * 3. 재승인 정보 설정 *
	 ***********************/
  inipay.SetField("inipayhome", "/usr/local/INIpay50" );				   // 이니페이 홈디렉터리(상점수정 필요)
  inipay.SetField("type"         , "repay");							   // 고정 (절대 수정 불가)
  inipay.SetField("debug"        , "false");								   // 로그모드("true"로 설정하면 상세로그가 생성됨.)
  inipay.SetField("admin"        , "1111");								   // 비대칭 사용키 키패스워드    
  inipay.SetField("mid"          , request.getParameter("mid"));		   // 상점아이디
  inipay.SetField("oldtid"       , request.getParameter("oldtid"));		   // 취소할 거래의 거래아이디
  inipay.SetField("currency"     , request.getParameter("currency"));	   // 화폐단위
  inipay.SetField("price"        , request.getParameter("price"));         // 취소금액
  inipay.SetField("confirm_price", request.getParameter("confirm_price")); // 승인요청금액
  inipay.SetField("buyeremail"   , request.getParameter("buyeremail"));    // 구매자 이메일 주소

  inipay.SetField("no_acct"      , request.getParameter("no_acct"));       // 국민은행 부분취소 환불계좌번호
  inipay.SetField("nm_acct"      , request.getParameter("nm_acct"));       // 국민은행 부분취소 환불계좌주명

  inipay.SetField("tax"			 , request.getParameter("tax"));		    // 부가세
  inipay.SetField("tax_free"     , request.getParameter("tax_free"));       // 비과세

  // ExecureCrypto_v1.0_jdk14.jar 모듈이 설치 되어 있어 있지 않은 상태라면
  // 익스트러스 암복호화 모듈 설정을 주석 처리 해주시기 바랍니다.
  inipay.SetField("crypto","execure");//익스트러스 암복호화 모듈 설정


  /******************
   * 4. 재승인 요청 *
   ******************/
  inipay.startAction();
	
	
	/********************************************************************
	 * 5. 재승인 결과                                                   *
	 *                                                                  *
	 * 신거래번호 : inipay.GetResult("TID")                             *
	 * 결과코드 : inipay.GetResult("ResultCode") ("00"이면 부분취소성공)*
	 * 결과내용 : inipay.GetResult("ResultMsg") (결과에 대한 설명)      *
	 * 원거래 번호 : inipay.GetResult("PRTC_TID")                       *
	 * 최종결제 금액 : inipay.GetResult("PRTC_Remains")                 *
	 * 부분취소 금액 : inipay.GetResult("PRTC_Price")                   *
	 * 부분취소,재승인 구분값 : inipay.GetResult("PRTC_Type")           *
	 *                          ("0" : 재승인, "1" : 부분취소)          *
	 * 부분취소 요청횟수 : inipay.GetResult("PRTC_Cnt")                 *
	 ********************************************************************/
%>

<html>
<head>
<title>INIpay50 부분취소 데모</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="css/group.css" type="text/css">
<style>
body, tr, td {font-size:10pt; font-family:굴림,verdana; color:#433F37; line-height:19px;}
table, img {border:none}

/* Padding ******/ 
.pl_01 {padding:1 10 0 10; line-height:19px;}
.pl_03 {font-size:20pt; font-family:굴림,verdana; color:#FFFFFF; line-height:29px;}

/* Link ******/ 
.a:link  {font-size:9pt; color:#333333; text-decoration:none}
.a:visited { font-size:9pt; color:#333333; text-decoration:none}
.a:hover  {font-size:9pt; color:#0174CD; text-decoration:underline}

.txt_03a:link  {font-size: 8pt;line-height:18px;color:#333333; text-decoration:none}
.txt_03a:visited {font-size: 8pt;line-height:18px;color:#333333; text-decoration:none}
.txt_03a:hover  {font-size: 8pt;line-height:18px;color:#EC5900; text-decoration:underline}
</style>

<script>
	var openwin=window.open("childwin.html","childwin","width=299,height=149");
	openwin.close();
	
</script>

<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#242424" leftmargin=0 topmargin=15 marginwidth=0 marginheight=0 bottommargin=0 rightmargin=0><center> 
<table width="632" border="0" cellspacing="0" cellpadding="0">
  <tr> 
  <%
    // 지불 수단에 따라 상단 이미지가 변경된다.
   	String background_img = "img/spool_top.gif";    //default image
   	if ("01".equals(inipay.GetResult("ResultCode") ) )
   	{
   	    background_img = "img/card.gif";
   	}
%>
    <td height="83" background="<%=background_img%>"style="padding:0 0 0 64">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="3%" valign="top"><img src="img/title_01.gif" width="8" height="27" vspace="5"></td>
          <td width="97%" height="40" class="pl_03"><font color="#FFFFFF"><b>부분취소 결과</b></font></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td align="center" bgcolor="6095BC">
      <table width="620" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td bgcolor="#FFFFFF" style="padding:0 0 0 56">
		  <table width="510" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="7"><img src="img/life.gif" width="7" height="30"></td>
                <td background="img/center.gif"><img src="img/icon03.gif" width="12" height="10">
                 <b><% if("00".equals(inipay.GetResult("ResultCode"))){ out.write("고객님의 부분취소 요청이 성공되었습니다."); }
                           else{ out.write("고객님의 부분취소 요청이 실패되었습니다."); } %> </b></td>
                <td width="8"><img src="img/right.gif" width="8" height="30"></td>
              </tr>
            </table>
            <br>
            <table width="510" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="407"  style="padding:0 0 0 9"><img src="img/icon.gif" width="10" height="11"> 
                  <strong><font color="433F37">결 제 내 역</font></strong></td>
                <td width="103">&nbsp;</td>                
              </tr>
              <tr> 
                <td colspan="2"  style="padding:0 0 0 23">
		  <table width="470" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="26">결 과 코 드</td>
                      <td width="343"><%=inipay.GetResult("ResultCode")%></td>
                    </tr>
                
                <!-------------------------------------------------------------------------------------------------------
                 * 1. inipay.GetResult("ResultMsg") 										*
                 *    - 결과 내용을 보여 준다 실패시에는 "[에러코드] 실패 메세지" 형태로 보여 준다.                     *
                 *		예> [9121]서명확인오류									*
                 -------------------------------------------------------------------------------------------------------->
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="25">결 과 내 용</td>
                      <td width="343"><%=inipay.GetResult("ResultMsg")%></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    </tr>
                    
                <!-------------------------------------------------------------------------------------------------------
                 * 1. inipay.GetResult("TID")											*
                 *    - 이니시스가 부여한 거래 번호 -모든 거래를 구분할 수 있는 키가 되는 값			        *
                 -------------------------------------------------------------------------------------------------------->
                    <tr> 
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="25">원거래 번호</td>
                      <td width="343"><%=inipay.GetResult("PRTC_TID")%></td>
                    </tr>
                    <tr> 
                      <td height='1' colspan='3' align='center'  background='img/line.gif'></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="25">거 래 번 호</td>
                      <td width="343"><%=inipay.GetResult("TID")%></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
                      <td width='109' height='25'>최종결제금액 </td>
                      <td width='343'><%=inipay.GetResult("PRTC_Remains")%></td>
                    </tr>
                    <tr> 
                      <td height='1' colspan='3' align='center'  background='img/line.gif'></td>
                    </tr>
                    <tr> 
                      <td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
                      <td width='109' height='25'>취 소 금 액</td>
                      <td width='343'><%=inipay.GetResult("PRTC_Price")%></td>
                    </tr>
                    <tr> 
                      <td height='1' colspan='3' align='center'  background='img/line.gif'></td>
                    </tr>
                    <tr> 
                      <td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
                      <td width='109' height='25'>부분취소(재승인) 구분 </td>
                      <td width='343'><b><font color=blue>(<%
                      					if("0".equals(inipay.GetResult("PRTC_Type"))){
                      						out.write("재승인");
                      					}
                      					else{
                      						out.write("부분취소");
                      					} 
                      					%>)</font></b></td>
                    </tr>
                    <tr> 
                      <td height='1' colspan='3' align='center'  background='img/line.gif'></td>
                    </tr>
                    <tr> 
                      <td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
                      <td width='109' height='25'>부분취소 요청 횟수 </td>
                      <td width='343'><%=inipay.GetResult("PRTC_Cnt")%></td>
                    </tr>
                    <tr> 
                      <td height='1' colspan='3' align='center'  background='img/line.gif'></td>
                    </tr>
                   </table></td>
              </tr>
            </table>
            <br>
	    <table width='510' border='0' cellspacing='0' cellpadding='0'>
               <tr> 
                   <td height='25'  style='padding:0 0 0 9'><img src='img/icon.gif' width='10' height='11'> 
                     <strong><font color='433F37'>이용안내</font></strong></td>
                 </tr>
                 <tr> 
                   <td  style='padding:0 0 0 23'> 
                     <table width='470' border='0' cellspacing='0' cellpadding='0'>
                       <tr>          					          
                         <td height='25'>(1)카드 세이브 결제건 외에는 부분취소가 가능합니다. <br>
                         (2)국민, BC, 신한, 외환, 삼성, 현대, 롯데 카드사 부분취소 가능합니다. <br>
                         (3)부분취소 최대금액과 가능횟수은 각 카드사마다 다를수 있습니다. </td>
                       </tr>
                       <tr> 
                         <td height='1' colspan='2' align='center'  background='img/line.gif'></td>
                       </tr>
                       
                     </table></td>
                 </tr>
            </table>
            
          </td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td><img src="img/bottom01.gif" width="632" height="13"></td>
  </tr>
</table>
</center></body>
</html>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 

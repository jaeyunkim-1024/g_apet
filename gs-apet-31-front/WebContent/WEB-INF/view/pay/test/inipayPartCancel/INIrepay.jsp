<%-----------------------------------------------------
 * INIrepay.jsp
 *
 * �̹� ���� ���ε� �ŷ����� ��Ҹ� ���ϴ� �ݾ��� �Է��Ͽ� �ٽ� ������ ���ϵ��� ��û�Ѵ�.
 * 
 * [����] �κ���� ��û ������  �� �ŷ����̵� ��ȯ�ǳ�, �κ���� ��û�� �ݵ�� ���ŷ� TID�� �����Կ� ����
 * [����] ���ŷ��� �ſ�ī�� ������ ��쿡�� ����
 * (OK ĳ���� ���� ���� ���ԵǾ� �־ �Ұ�)
 * [����] �ݵ�� ����� �ݾ��� �Է��ϵ��� ��
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
     * 1. INIpay ���̺귯��                                    * 
     *************************************** 
--%>
<%
    request.setCharacterEncoding("euc-kr");
	/***************************************
	 * 2. INIpay Ŭ������ �ν��Ͻ� ����                 *
	 ***************************************/
	INIpay50 inipay = new INIpay50();	
	
	/***********************
	 * 3. ����� ���� ���� *
	 ***********************/
  inipay.SetField("inipayhome", "/usr/local/INIpay50" );				   // �̴����� Ȩ���͸�(�������� �ʿ�)
  inipay.SetField("type"         , "repay");							   // ���� (���� ���� �Ұ�)
  inipay.SetField("debug"        , "false");								   // �α׸��("true"�� �����ϸ� �󼼷αװ� ������.)
  inipay.SetField("admin"        , "1111");								   // ���Ī ���Ű Ű�н�����    
  inipay.SetField("mid"          , request.getParameter("mid"));		   // �������̵�
  inipay.SetField("oldtid"       , request.getParameter("oldtid"));		   // ����� �ŷ��� �ŷ����̵�
  inipay.SetField("currency"     , request.getParameter("currency"));	   // ȭ�����
  inipay.SetField("price"        , request.getParameter("price"));         // ��ұݾ�
  inipay.SetField("confirm_price", request.getParameter("confirm_price")); // ���ο�û�ݾ�
  inipay.SetField("buyeremail"   , request.getParameter("buyeremail"));    // ������ �̸��� �ּ�

  inipay.SetField("no_acct"      , request.getParameter("no_acct"));       // �������� �κ���� ȯ�Ұ��¹�ȣ
  inipay.SetField("nm_acct"      , request.getParameter("nm_acct"));       // �������� �κ���� ȯ�Ұ����ָ�

  inipay.SetField("tax"			 , request.getParameter("tax"));		    // �ΰ���
  inipay.SetField("tax_free"     , request.getParameter("tax_free"));       // �����

  // ExecureCrypto_v1.0_jdk14.jar ����� ��ġ �Ǿ� �־� ���� ���� ���¶��
  // �ͽ�Ʈ���� �Ϻ�ȣȭ ��� ������ �ּ� ó�� ���ֽñ� �ٶ��ϴ�.
  inipay.SetField("crypto","execure");//�ͽ�Ʈ���� �Ϻ�ȣȭ ��� ����


  /******************
   * 4. ����� ��û *
   ******************/
  inipay.startAction();
	
	
	/********************************************************************
	 * 5. ����� ���                                                   *
	 *                                                                  *
	 * �Űŷ���ȣ : inipay.GetResult("TID")                             *
	 * ����ڵ� : inipay.GetResult("ResultCode") ("00"�̸� �κ���Ҽ���)*
	 * ������� : inipay.GetResult("ResultMsg") (����� ���� ����)      *
	 * ���ŷ� ��ȣ : inipay.GetResult("PRTC_TID")                       *
	 * �������� �ݾ� : inipay.GetResult("PRTC_Remains")                 *
	 * �κ���� �ݾ� : inipay.GetResult("PRTC_Price")                   *
	 * �κ����,����� ���а� : inipay.GetResult("PRTC_Type")           *
	 *                          ("0" : �����, "1" : �κ����)          *
	 * �κ���� ��ûȽ�� : inipay.GetResult("PRTC_Cnt")                 *
	 ********************************************************************/
%>

<html>
<head>
<title>INIpay50 �κ���� ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="css/group.css" type="text/css">
<style>
body, tr, td {font-size:10pt; font-family:����,verdana; color:#433F37; line-height:19px;}
table, img {border:none}

/* Padding ******/ 
.pl_01 {padding:1 10 0 10; line-height:19px;}
.pl_03 {font-size:20pt; font-family:����,verdana; color:#FFFFFF; line-height:29px;}

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
    // ���� ���ܿ� ���� ��� �̹����� ����ȴ�.
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
          <td width="97%" height="40" class="pl_03"><font color="#FFFFFF"><b>�κ���� ���</b></font></td>
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
                 <b><% if("00".equals(inipay.GetResult("ResultCode"))){ out.write("������ �κ���� ��û�� �����Ǿ����ϴ�."); }
                           else{ out.write("������ �κ���� ��û�� ���еǾ����ϴ�."); } %> </b></td>
                <td width="8"><img src="img/right.gif" width="8" height="30"></td>
              </tr>
            </table>
            <br>
            <table width="510" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="407"  style="padding:0 0 0 9"><img src="img/icon.gif" width="10" height="11"> 
                  <strong><font color="433F37">�� �� �� ��</font></strong></td>
                <td width="103">&nbsp;</td>                
              </tr>
              <tr> 
                <td colspan="2"  style="padding:0 0 0 23">
		  <table width="470" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="26">�� �� �� ��</td>
                      <td width="343"><%=inipay.GetResult("ResultCode")%></td>
                    </tr>
                
                <!-------------------------------------------------------------------------------------------------------
                 * 1. inipay.GetResult("ResultMsg") 										*
                 *    - ��� ������ ���� �ش� ���нÿ��� "[�����ڵ�] ���� �޼���" ���·� ���� �ش�.                     *
                 *		��> [9121]����Ȯ�ο���									*
                 -------------------------------------------------------------------------------------------------------->
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="25">�� �� �� ��</td>
                      <td width="343"><%=inipay.GetResult("ResultMsg")%></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    </tr>
                    
                <!-------------------------------------------------------------------------------------------------------
                 * 1. inipay.GetResult("TID")											*
                 *    - �̴Ͻý��� �ο��� �ŷ� ��ȣ -��� �ŷ��� ������ �� �ִ� Ű�� �Ǵ� ��			        *
                 -------------------------------------------------------------------------------------------------------->
                    <tr> 
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="25">���ŷ� ��ȣ</td>
                      <td width="343"><%=inipay.GetResult("PRTC_TID")%></td>
                    </tr>
                    <tr> 
                      <td height='1' colspan='3' align='center'  background='img/line.gif'></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="25">�� �� �� ȣ</td>
                      <td width="343"><%=inipay.GetResult("TID")%></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
                      <td width='109' height='25'>���������ݾ� </td>
                      <td width='343'><%=inipay.GetResult("PRTC_Remains")%></td>
                    </tr>
                    <tr> 
                      <td height='1' colspan='3' align='center'  background='img/line.gif'></td>
                    </tr>
                    <tr> 
                      <td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
                      <td width='109' height='25'>�� �� �� ��</td>
                      <td width='343'><%=inipay.GetResult("PRTC_Price")%></td>
                    </tr>
                    <tr> 
                      <td height='1' colspan='3' align='center'  background='img/line.gif'></td>
                    </tr>
                    <tr> 
                      <td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
                      <td width='109' height='25'>�κ����(�����) ���� </td>
                      <td width='343'><b><font color=blue>(<%
                      					if("0".equals(inipay.GetResult("PRTC_Type"))){
                      						out.write("�����");
                      					}
                      					else{
                      						out.write("�κ����");
                      					} 
                      					%>)</font></b></td>
                    </tr>
                    <tr> 
                      <td height='1' colspan='3' align='center'  background='img/line.gif'></td>
                    </tr>
                    <tr> 
                      <td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
                      <td width='109' height='25'>�κ���� ��û Ƚ�� </td>
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
                     <strong><font color='433F37'>�̿�ȳ�</font></strong></td>
                 </tr>
                 <tr> 
                   <td  style='padding:0 0 0 23'> 
                     <table width='470' border='0' cellspacing='0' cellpadding='0'>
                       <tr>          					          
                         <td height='25'>(1)ī�� ���̺� ������ �ܿ��� �κ���Ұ� �����մϴ�. <br>
                         (2)����, BC, ����, ��ȯ, �Ｚ, ����, �Ե� ī��� �κ���� �����մϴ�. <br>
                         (3)�κ���� �ִ�ݾװ� ����Ƚ���� �� ī��縶�� �ٸ��� �ֽ��ϴ�. </td>
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

<%@ page  contentType="text/html; charset=euc-kr" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.util.Calendar" %>
<%
/*******************************************************************************
 * FILE NAME : vacctinput.jsp
 * DATE : 2009.07
 * �̴Ͻý� ������� �Աݳ��� ó��demon���� �Ѿ���� �Ķ���͸� control �ϴ� �κ� �Դϴ�.
 * [��������] �ڼ��� ������ �޴��� ����
 * ������           �ѱ۸�                           
 * no_tid           �ŷ���ȣ                         
 * no_oid           �ֹ���ȣ                         
 * cd_bank          �ŷ��߻� ����ڵ�                
 * cd_deal          ��ޱ���ڵ�                     
 * dt_trans         �ŷ�����                         
 * tm_trans         �ŷ��ð�                         
 * no_vacct         ���¹�ȣ                         
 * amt_input        �Աݱݾ�                         
 * amt_check        �̰���Ÿ���Ǳݾ�                 
 * flg_close        ��������                         
 * type_msg         �ŷ�����                         
 * nm_inputbank     �Ա������                       
 * nm_input         �Ա��ڸ�                         
 * dt_inputstd      �Աݱ�������                     
 * dt_calculstd     �����������                     
 * dt_transbase     �ŷ���������                     
 * cl_trans         �ŷ������ڵ� "1100"              
 * cl_close         �������� ����,  0:������, 1������
 * cl_kor           �ѱ۱����ڵ�, 2:KSC5601          
 *
 * (�������ä���� ���ݿ����� �ڵ��߱޽�û�ÿ��� ����)
 * dt_cshr          ���ݿ����� �߱�����              
 * tm_cshr          ���ݿ����� �߱޽ð�              
 * no_cshr_appl     ���ݿ����� �߱޹�ȣ              
 * no_cshr_tid      ���ݿ����� �߱�TID               
 *******************************************************************************/

/***********************************************************************************
 * �̴Ͻý��� �����ϴ� ���������ü�� ����� �����Ͽ� DB ó�� �ϴ� �κ� �Դϴ�.	
 * �ʿ��� �Ķ���Ϳ� ���� DB �۾��� �����Ͻʽÿ�.
 ***********************************************************************************/	




	String file_path = "/home/was/INIpayJAVA/vacct";

    id_merchant = request.getParameter("id_merchant");
    no_tid 		= request.getParameter("no_tid");
    no_oid 		= request.getParameter("no_oid");
    no_vacct 	= request.getParameter("no_vacct");
    amt_input 	= request.getParameter("amt_input");
    nm_inputbank = request.getParameter("nm_inputbank");
    nm_input 	= request.getParameter("nm_input");

    // �Ŵ����� ���ð� �߰��Ͻ� �Ķ���Ͱ� �����ø� �Ʒ��� ���� ������� �߰��Ͽ� ����Ͻñ� �ٶ��ϴ�.

    // String value = reqeust.getParameter("������ �ʵ��");

	try
	{
        writeLog(file_path);

//***********************************************************************************
//
//	������ ���� �����ͺ��̽��� ��� ���������� ���� �����ÿ��� "OK"�� �̴Ͻý���
//	�����ϼž��մϴ�. �Ʒ� ���ǿ� �����ͺ��̽� ������ �޴� FLAG ������ ��������
//	(����) OK�� �������� �����ø� �̴Ͻý� ���� ������ "OK"�� �����Ҷ����� ��� �������� �õ��մϴ�
//	��Ÿ �ٸ� ������ out.println(response.write)�� ���� �����ñ� �ٶ��ϴ�
	
//	if (�����ͺ��̽� ��� ���� ���� ���Ǻ��� = true) 
//  {
        	out.print("OK"); // ����� ������ ������

//  }

	}
	catch(Exception e)
	{
		// ���ȼ� ����. �����޽����� ���� ��������
		out.print("exception when writelog");
	}

%>
<%!

    private String id_merchant;
    private String no_tid;
    private String no_oid;
    private String no_vacct;
    private String amt_input;
    private String nm_inputbank;
    private String nm_input;
    private StringBuffer times;

    private String getDate()
    {
    	Calendar calendar = Calendar.getInstance();
    	
    	times = new StringBuffer();
        times.append(Integer.toString(calendar.get(Calendar.YEAR)));
		if((calendar.get(Calendar.MONTH)+1)<10)
        { 
            times.append("0"); 
        }
		times.append(Integer.toString(calendar.get(Calendar.MONTH)+1));
		if((calendar.get(Calendar.DATE))<10) 
        { 
            times.append("0");	
        } 
		times.append(Integer.toString(calendar.get(Calendar.DATE)));
    	
    	return times.toString();
    }
    
    private String getTime()
    {
    	Calendar calendar = Calendar.getInstance();
    	
    	times = new StringBuffer();

    	times.append("[");
    	if((calendar.get(Calendar.HOUR_OF_DAY))<10) 
        { 
            times.append("0"); 
        } 
 		times.append(Integer.toString(calendar.get(Calendar.HOUR_OF_DAY)));
 		times.append(":");
 		if((calendar.get(Calendar.MINUTE))<10) 
        { 
            times.append("0"); 
        }
 		times.append(Integer.toString(calendar.get(Calendar.MINUTE)));
 		times.append(":");
 		if((calendar.get(Calendar.SECOND))<10) 
        { 
            times.append("0"); 
        }
 		times.append(Integer.toString(calendar.get(Calendar.SECOND)));
 		times.append("]");
 		
 		return times.toString();
    }

    private void writeLog(String file_path) throws Exception
    {

        File file = new File(file_path);
        file.createNewFile();

        FileWriter file2 = new FileWriter(file_path+"/vacctinput_"+getDate()+".log", true);
        //���� ����. �������� �ڿ� ���� (IO)
        try{
       	     file2.write("\n************************************************\n");
             file2.write("PageCall time : " + getTime());
             file2.write("\nID_MERCHANT : " + id_merchant);
             file2.write("\nNO_TID : " + no_tid);
             file2.write("\nNO_OID : " + no_oid);
             file2.write("\nNO_VACCT : " + no_vacct);
             file2.write("\nAMT_INPUT : " + amt_input);
             file2.write("\nNM_INPUTBANK : " + nm_inputbank);
             file2.write("\nNM_INPUT : " + nm_input);
             file2.write("\n************************************************\n");

             file2.close();
        }catch (Exception e){
        	// ���ȼ� ����. �����޽����� ���� ��������
        	out.print("exception when file write");
        }finally{
        	if(file2 != null){
        		file2.close();
        	}
        }


      

    }
%>

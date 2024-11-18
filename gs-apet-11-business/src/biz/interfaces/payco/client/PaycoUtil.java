package biz.interfaces.payco.client;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.fasterxml.jackson.databind.ObjectMapper;

import framework.common.constants.CommonConstants;
import lombok.extern.slf4j.Slf4j;

/**-----------------------------------------------------------------------
 * 페이코 연동 유틸리티
 *------------------------------------------------------------------------
 * @Class PaycoUtil
 * @author PAYCO기술지원<dl_payco_ts@nhnent.com>
 * @since 2015.03.24.
 * @version 1.0
 * @Description 
 */

@Slf4j
public class PaycoUtil {
	
	//private static final String FILE_PATH   = "C:/logs";
	
	private Properties bizConfig;
	
	private String RESERVE_URI    			= "";
	private String APPROVAL_URI				= "";
	private String CANCEL_URI      			= "";
	private String CANCEL_CHECK_URI   		= "";
	private String UPDATE_STATUS_URI		= ""; 
	private String CANCEL_MILEAGE_URI		= "";
	private String CHECK_USABILITY_URI		= "";
	private String VARIFY_PAYMENT_URI		= "";
	
	//생성자
	public PaycoUtil(String serverType){
		
		if(serverType.equals("DEV")){
			RESERVE_URI 		= "https://alpha-api-bill.payco.com/outseller/order/reserve";
			APPROVAL_URI		= "https://alpha-api-bill.payco.com/outseller/payment/approval";
			CANCEL_URI 			= "https://alpha-api-bill.payco.com/outseller/order/cancel";
			CANCEL_CHECK_URI 	= "https://alpha-api-bill.payco.com/outseller/order/cancel/checkAvailability";
			UPDATE_STATUS_URI 	= "https://alpha-api-bill.payco.com/outseller/order/updateOrderProductStatus";
			CANCEL_MILEAGE_URI 	= "https://alpha-api-bill.payco.com/outseller/order/cancel/partMileage";
			CHECK_USABILITY_URI = "https://alpha-api-bill.payco.com/outseller/code/checkUsability";
			VARIFY_PAYMENT_URI  = "https://alpha-api-bill.payco.com/outseller/payment/approval/getDetailForVerify";
		} else {
			RESERVE_URI 		= "https://api-bill.payco.com/outseller/order/reserve";
			APPROVAL_URI		= "https://api-bill.payco.com/outseller/payment/approval";
			CANCEL_URI 			= "https://api-bill.payco.com/outseller/order/cancel";
			CANCEL_CHECK_URI 	= "https://api-bill.payco.com/outseller/order/cancel/checkAvailability";
			UPDATE_STATUS_URI 	= "https://api-bill.payco.com/outseller/order/updateOrderProductStatus";
			CANCEL_MILEAGE_URI 	= "https://api-bill.payco.com/outseller/order/cancel/partMileage";
			CHECK_USABILITY_URI = "https://api-bill.payco.com/outseller/code/checkUsability";
			VARIFY_PAYMENT_URI  = "https://api-bill.payco.com/outseller/payment/approval/getDetailForVerify";
		}
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		ServletContext context = request.getSession().getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);

		this.bizConfig = (Properties) wContext.getBean("bizConfig");
		
	}
	
	ObjectMapper mapper = new ObjectMapper();
	java.text.SimpleDateFormat dateformat = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss");
	
	/**
	 * 주문예약
	 * @param map
	 * @param logYn : Y/N
	 * @return
	 */
	public String payco_reserve(Map<String, Object> map, String logYn){ 
		
	    String returnStr = "";
	    
	    try {
	    	
	    	returnStr = getSSLConnection( RESERVE_URI, mapper.writeValueAsString(map));
	    	
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][주문예약요청] " +"[callUrl :" + RESERVE_URI +" ] " + mapper.writeValueAsString(map), logYn);
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][주문예약결과] " + returnStr, logYn);
	    	
	    } catch (Exception e){
	    	log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
	    	// 보안성 진단. 오류메시지를 통한 정보노출
	    	//returnStr = "{\"code\":\"9999\",\"message\":\""+e.getMessage()+"\"}";
	    	returnStr = "{\"code\":\"9999\",\"message\":\""+e.getClass()+"\"}";
	    	
	    }
	    return returnStr;
	}
	
	/**
	 * 결제승인
	 * @param map
	 * @param logYn : Y/N
	 * @return
	 */
	public String payco_approval(Map<String, Object> map, String logYn){
		
	    String returnStr = "";
	    
	    try {
	    	
	    	returnStr = getSSLConnection( APPROVAL_URI, mapper.writeValueAsString(map));
    		
	    	makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][주문결제 승인요청] " +"[callUrl :" + APPROVAL_URI +" ] " + mapper.writeValueAsString(map), logYn);
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][주문결제 승인결과] " + returnStr, logYn);
	    } catch (Exception e){
	    	log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
	    	// 보안성 진단. 오류메시지를 통한 정보노출
	    	//returnStr = "{\"code\":\"9999\",\"message\":\""+e.getMessage()+"\"}";
	    	returnStr = "{\"code\":\"9999\",\"message\":\""+e.getClass()+"\"}";
	    }
	    return returnStr;
	}
	
	/**
	 * 주문취소
	 * @param map
	 * @param logYn : Y/N
	 * @return
	 */
	public String payco_cancel(Map<String, Object> map, String logYn){
		String returnStr = "";
		
		try {
	    	returnStr = getSSLConnection( CANCEL_URI, mapper.writeValueAsString(map));
	    	
	    	makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][주문취소요청] " +"[callUrl :" + CANCEL_URI +" ] " + mapper.writeValueAsString(map), logYn);
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][주문취소결과] " + returnStr, logYn);
	    } catch (Exception e){
	    	log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
	    	// 보안성 진단. 오류메시지를 통한 정보노출
	    	//returnStr = "{\"code\":\"9999\",\"message\":\""+e.getMessage()+"\"}";
	    	returnStr = "{\"code\":\"9999\",\"message\":\""+e.getClass()+"\"}";
	    }
		
		return returnStr;
	}
	
	/**
	 * 주문취소검사
	 * @param map
	 * @param logYn : Y/N
	 * @return
	 */
	public String payco_cancel_check(Map<String, Object> map, String logYn){
		String returnStr = "";
		
		try {
	    	returnStr = getSSLConnection( CANCEL_CHECK_URI, mapper.writeValueAsString(map));
    		
	    	makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][주문취소검사결과] " +"[callUrl :" + CANCEL_CHECK_URI +" ] " + returnStr, logYn);
	    } catch (Exception e){
	    	log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
	    	// 보안성 진단. 오류메시지를 통한 정보노출
	    	//returnStr = "{\"code\":\"9999\",\"message\":\""+e.getMessage()+"\"}";
	    	returnStr = "{\"code\":\"9999\",\"message\":\""+e.getClass()+"\"}";
	    }
		
		return returnStr;
	}
	
	/**
	 * 주문상태 변경
	 * @param map
	 * @param logYn : Y/N
	 * @return
	 */
	public String payco_upstatus(Map<String, Object> map, String logYn){
		String returnStr = "";
		
		try {
			returnStr = getSSLConnection( UPDATE_STATUS_URI, mapper.writeValueAsString(map));
    		
			makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][주문상태변경결과] " +"[callUrl :" + UPDATE_STATUS_URI +" ] " + returnStr, logYn);
	    } catch (Exception e){
	    	log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
	    	// 보안성 진단. 오류메시지를 통한 정보노출
	    	//returnStr = "{\"code\":\"9999\",\"message\":\""+e.getMessage()+"\"}";
	    	returnStr = "{\"code\":\"9999\",\"message\":\""+e.getClass()+"\"}";
	    }
		
		return returnStr;
	}
	
	/**
	 * 마일리지 적립취소
	 * @param map
	 * @param logYn : Y/N
	 * @return
	 */
	public String payco_cancelmileage(Map<String, Object> map, String logYn){
		String returnStr = "";
		
		try {
	    	returnStr = getSSLConnection( CANCEL_MILEAGE_URI, mapper.writeValueAsString(map));
    		
	    	makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][마일리지적립취소결과] " +"[callUrl :" + CANCEL_MILEAGE_URI +" ] " + returnStr, logYn);
	    } catch (Exception e){
	    	log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
	    	// 보안성 진단. 오류메시지를 통한 정보노출
	    	//returnStr = "{\"code\":\"9999\",\"message\":\""+e.getMessage()+"\"}";
	    	returnStr = "{\"code\":\"9999\",\"message\":\""+e.getClass()+"\"}";
	    }
		
		return returnStr;
	}
	
	/**
	 * 가맹점별 연동키 유효성 체크
	 * @param map
	 * @param logYn : Y/N
	 * @return
	 */
	public String payco_keycheck(Map<String, Object> map, String logYn){
		String returnStr = "";
		
		try {
	    	returnStr = getSSLConnection( CHECK_USABILITY_URI, mapper.writeValueAsString(map));
    		
	    	makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][가맹점별연동키유효성체크결과] " +"[callUrl :" + CHECK_USABILITY_URI +" ] " + returnStr, logYn);
	    } catch (Exception e){
	    	log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
	    	// 보안성 진단. 오류메시지를 통한 정보노출
	    	//returnStr = "{\"code\":\"9999\",\"message\":\""+e.getMessage()+"\"}";
	    	returnStr = "{\"code\":\"9999\",\"message\":\""+e.getClass()+"\"}";
	    }
		
		return returnStr;
	}
	
	/**
	 * 결제상세 조회(검증용)
	 * @param map
	 * @param logYn : Y/N
	 * @return
	 */
	public String payco_verifyPayment(Map<String, Object> map, String logYn){
		
	    String returnStr = "";
	    
	    try {
	    	returnStr = getSSLConnection( VARIFY_PAYMENT_URI, mapper.writeValueAsString(map));
    		
	    	makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][결제상세 조회 요청] " +"[callUrl :" + VARIFY_PAYMENT_URI +" ] " + mapper.writeValueAsString(map), logYn);
    		makeServiceCheckApiLogFile("[" +dateformat.format(new java.util.Date()) + "][결제상세 조회 결과] " + returnStr, logYn);
	    } catch (Exception e){
	    	log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
	    	// 보안성 진단. 오류메시지를 통한 정보노출
	    	//returnStr = "{\"code\":\"9999\",\"message\":\""+e.getMessage()+"\"}";
	    	returnStr = "{\"code\":\"9999\",\"message\":\""+e.getClass()+"\"}";
	    }
	    return returnStr;
	}
	
	
	public String getConnection(String apiUrl, String arrayObj) throws IOException {
		
		URL url 			  = new URL(apiUrl); 	// 요청을 보낸 URL
		String sendData 	  = arrayObj;
		
		StringBuilder buf 	  = new StringBuilder();
		String returnStr 	  = "";
		
		HttpURLConnection con = (HttpURLConnection)url.openConnection();
		
		try(AutoCloseable a = () -> con.disconnect()) {
			con.setConnectTimeout(30000);		//서버통신 timeout 설정. 페이코 권장 30초
			con.setReadTimeout(30000);			//스트림읽기 timeout 설정. 페이코 권장 30초
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
		    con.setDoOutput(true);
		    con.setRequestMethod("POST");
		    con.connect();
			
		    try(DataOutputStream dos = new DataOutputStream(con.getOutputStream())){
		    	dos.write(sendData.getBytes(StandardCharsets.UTF_8));
			    dos.flush();
		    }
		    
		    int resCode = con.getResponseCode();
		    if(resCode != HttpURLConnection.HTTP_OK) {
		    	return "{ \"code\" : 9999, \"message\" : \"Connection Error\" }";
		    }
		    
		    try(BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), StandardCharsets.UTF_8))){
		    	int c;
			    
			    while ((c = br.read()) != -1) {
			    	buf.append((char)c);
			    }
			    
			    returnStr = buf.toString();
		    }
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		}
		
		return returnStr;
	}
	
	public String getSSLConnection(String apiUrl, String arrayObj) throws IOException{
		
		URL url 			   = new URL(apiUrl); 	// 요청을 보낸 URL
		String sendData 	   = arrayObj;
		StringBuilder buf 	   = new StringBuilder();
		String returnStr 	   = "";
		
		HttpURLConnection con = (HttpURLConnection)url.openConnection();
		
		try(AutoCloseable a = () -> con.disconnect()) {
			con.setConnectTimeout(30000);		//서버통신 timeout 설정. 페이코 권장 30초
			con.setReadTimeout(30000);			//스트림읽기 timeout 설정. 페이코 권장 30초
			con.setRequestProperty("Content-Type", "application/json;charset=UTF-8");
			con.setDoOutput(true);
		    con.setRequestMethod("POST");
		    con.connect();
		    
		    // 송신할 데이터 전송.
		    try(DataOutputStream dos = new DataOutputStream(con.getOutputStream())){
			    dos.write(sendData.getBytes(StandardCharsets.UTF_8));
			    dos.flush();
		    }
		    
		    int resCode = con.getResponseCode();
		    if(resCode != HttpURLConnection.HTTP_OK) {
		    	return "{ \"code\" : 9999, \"message\" : \"Connection Error\" }";
		    }
		    
		    try(BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), StandardCharsets.UTF_8))){
		    	int c;
			    
			    while ((c = br.read()) != -1) {
			    	buf.append((char)c);
			    }
			    returnStr = buf.toString();
		    }
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		}
		
		return returnStr;
	}
	
	public void makeServiceCheckApiLogFile(String logText, String logYn) {
		
		if(logYn.equals("Y")){
			String filePath   = this.bizConfig.getProperty("payco.home.path");
			filePath = filePath.replaceAll("\\.{2,}[/\\\\]", "");
			log.debug(">>>>>>>>>>>>>>>>>>>>>>>>>>>filePath= "+filePath);
		  	String nowTotDate = dateformat.format(new java.util.Date());
		  	Integer nowdate = Integer.parseInt( nowTotDate.substring(0, 8) );
		    
			String fileName = "payco_service_check_log_" + nowdate + ".txt"; //생성할 파일명
		  	String logPath = filePath + File.separator + fileName; 
		  	
		  	File folder = new File(filePath); //로그저장폴더
		  	File f 		= new File(logPath);  //파일을 생성할 전체경로
		  	
		  	 //파일쓰기객체생성
		  	try(FileWriter fw = new FileWriter(logPath, true)){
		  	
		  		if(!folder.exists()) {
		   			folder.setExecutable(false);
		   			folder.setReadable(true);
		   			folder.setWritable(false);
		  			folder.mkdirs();
				}

		   		if (!f.exists() 
	   				&& !f.createNewFile()){
	   				log.error("Fail to create of file");
		   		}

		   		// 파일쓰기
	   			fw.write(logText +"\n"); //파일에다 작성

		  	}catch (IOException e) { 
		  		log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		   		//System.out.println(e.toString()); //에러 발생시 메시지 출력
		  	}	
		}
	}
		
}

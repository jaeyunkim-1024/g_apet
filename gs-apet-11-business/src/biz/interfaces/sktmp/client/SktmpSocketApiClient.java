package biz.interfaces.sktmp.client;


import java.io.IOException;
import java.net.Socket;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import biz.interfaces.sktmp.constants.SktmpConstants;
import biz.interfaces.sktmp.util.SktmpConvertUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class SktmpSocketApiClient{
	
	private Properties bizConfig;
	
    @SuppressWarnings({"rawtypes"})
	public String getResponse(String msgStr) throws IOException {
    	HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		ServletContext context = request.getSession().getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);

		this.bizConfig = (Properties) wContext.getBean("bizConfig");
		
    	SktmpConvertUtil util = new SktmpConvertUtil();
    	
    	String result = "";
    	
		Socket socket = null;
		Boolean isOpend = false;

		int chkCount = 0;
		/*if(SktmpConstants.MSG_TYPE_0500.equals(msgStr.substring(0, 4))){
			chkCount = 192;
		}else if(SktmpConstants.MSG_TYPE_0620.equals(msgStr.substring(0, 4))) {
			chkCount = 126;
		}*/
		
		//msg 확인
		String reqStr = SktmpConstants.PRTNR_CODE + util.encrypt(msgStr) + "\n";

		log.info("##### 송신 전문 #####");
		log.info("\n"+reqStr + "\n");
		log.info("##### ##### #####");
		
		try{
			String host = bizConfig.getProperty("skt.membership.socket.host");
			Integer port = Integer.parseInt(bizConfig.getProperty("skt.membership.socket.port"));

			socket= new Socket(host,port);
			log.info("#### Socket Opened!!!\n\n");
			isOpend = socket.isConnected();

			
			//정상적으로 열렸을 때만
			if(isOpend){
				byte[] buf = new byte[600];
				byte[] ret_buf = new byte[600];

				int resCount = 0;
				
				for(int i=0; i<5; i++){
					Integer n = i+1;
					log.info("### {} 회 호출 ",n);
					//메세지 전송
					buf = reqStr.getBytes();
					socket.getOutputStream().write(buf,0,buf.length);
					socket.setSoTimeout(30000);	// 30초 동안 응답 없으면 Timeout

					/*---------------------------------------------------------------------
					서버 전송 메시지 수신
					---------------------------------------------------------------------*/
					int count=0;
					count = socket.getInputStream().read(ret_buf, 0, ret_buf.length);
					log.info("### ret_buf : {}", ret_buf);
					log.info("### Return Code : {}", count);
					
					String retStr = new String(ret_buf).trim();
					
					String decStr = util.decrypt(retStr);
					log.info("### decStr : {}", decStr);
					
					result = decStr;
					resCount = result.length();
					log.info("### decStr.length : {}", result.length());
					
					// 정상 수신인 경우 for loop를 빠져나간다
					if(resCount >= chkCount){
					 	socket.close();
						break;
					}

					// 수신 오류인 경우 소켓 닫고 for loop 처음으로 돌아간다
					log.info("### Receive Error,,, Retry !!!!!");
					if( i == 4){
						log.info("### ERROR ,,, PLZ Parameter Check Or Server Check");
						throw new CustomException(ExceptionConstants.ERROR_R3K_SOCKET_RECEIVE);
					}
				} // end for loop

				log.info("### result length : {}", result.length());
				
				log.info("########## receive : {}",result);
			}
		}catch(Exception e){
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
			result = e.getMessage();
		}finally {
			if(socket != null && isOpend){
				log.info("#### Socket close");
				socket.close();
			}
		}
		return result;

	}
}

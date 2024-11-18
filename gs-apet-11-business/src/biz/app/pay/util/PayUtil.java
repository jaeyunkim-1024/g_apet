package biz.app.pay.util;

import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.pay.util
* - 파일명		: PayUtil.java
* - 작성일		: 2017. 4. 26.
* - 작성자		: Administrator
* - 설명			: 결제 관련 Util
* </pre>
*/
@Slf4j
public class PayUtil {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayUtil.java
	* - 작성일		: 2017. 4. 26.
	* - 작성자		: Administrator
	* - 설명			: 입금 예정 만료 일자
	* </pre>
	* @return
	*/
	public static String getSchdDt(){
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
		Properties bizConfig = (Properties)wContext.getBean("bizConfig");
	
		int dpstSchdPeriod = Integer.parseInt(bizConfig.getProperty("order.dpst.schd.period"));	//입금대기 기간(가상계좌, 무통장)
		//입금 대기 일자
		return DateUtil.addDays(DateUtil.getNowDate() , dpstSchdPeriod);
	}
	
}

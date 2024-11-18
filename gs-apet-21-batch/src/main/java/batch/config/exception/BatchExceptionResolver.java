package batch.config.exception;

import batch.config.constants.BatchConstants;
import biz.app.member.model.MemberBasePO;
import biz.interfaces.gsr.dao.GsrLogDao;
import biz.interfaces.gsr.model.GsrException;
import biz.interfaces.gsr.model.GsrLnkHistPO;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import lombok.extern.slf4j.Slf4j;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;
import java.util.Properties;

/**
* <pre>
* - 프로젝트명	: 21.batch
* - 패키지명	: batch.config.exception
* - 파일명		: BatchExceptionResolver.java
* - 작성일		: 2016. 5. 23.
* - 작성자		: snw
* - 설명		: Batch Exception Resolver
* </pre>
*/
@Slf4j
public class BatchExceptionResolver implements HandlerExceptionResolver {

	@Autowired
	private MessageSourceAccessor message;

	@Autowired private GsrLogDao gsrLogDao;

	@Autowired private Properties bizConfig;

	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object paramObject, Exception ex) {

		log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, ex);

		ModelAndView mav = new ModelAndView();

		String exCode = null;
		String exMsg = null;
		String[] params = null;
		
		if(ex instanceof CustomException){
			log.debug(">>>>>>>>>>>>> Custom Exception");

			CustomException customEx = (CustomException)ex;
			exCode = customEx.getExCode();
			params = customEx.getParams();
		}else if(ex instanceof GsrException){
			GsrException gsrEx = (GsrException)ex;
			GsrLnkHistPO po = new GsrLnkHistPO();

			String BT_IP_DEV = "10.20.23.9";          //개발계 BT PRIVATE IP
			String BT_IP_STG = "10.20.101.11";        //검증계 BT PRIVATE IP
			String BT_IP_PRD = "10.10.111.10";        //운영계 BT PRIVATE IP
			String BT_IP_LOCAL = "127.0.0.1";

			//개발
			if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_DEV)){
				po.setUpdrIp(BT_IP_DEV);
			}
			//검증
			else if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_STG)){
				po.setUpdrIp(BT_IP_STG);
			}
			//운영
			else if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)){
				po.setUpdrIp(BT_IP_PRD);
			}else{
				po.setUpdrIp(BT_IP_LOCAL);
			}

			po.setReqParam(gsrEx.getReqParam());
			po.setGsrLnkCd(gsrEx.getGsrLnkCd());       // GSR  연동 코드
			po.setReqScssYn("N");           			// 요청 성공 여부
			po.setRstCd(gsrEx.getExCode());            // 결과 코드
			po.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
			po.setSysUpdrNo(CommonConstants.COMMON_BATCH_USR_NO);
			gsrLogDao.insertGsrLnkHist(po);

			exCode = gsrEx.getExCode();
			if(StringUtil.equals(exCode,ExceptionConstants.ERROR_GSR_API_DEL_MEMBER)){
				String reqParam = gsrEx.getReqParam();
				try{
					Map<String,String> m = new ObjectMapper().readValue(reqParam, Map.class);
					String gsptNo = m.get("cust_no");
					MemberBasePO mpo = new MemberBasePO();
					mpo.setGsptNo(gsptNo);
					mpo.setGsptStateCd(FrontConstants.GSPT_STATE_20);
					gsrLogDao.updateMemberGsrState(mpo);
				}catch(Exception e){
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
				}
			}
		}

		else{
			log.debug(">>>>>>>>>>>>> None Custom Exception");
			exCode = ExceptionConstants.ERROR_CODE_DEFAULT;
		}
		
		if(params != null){
			exMsg = message.getMessage(BatchConstants.EXCEPTION_MESSAGE_COMMON + exCode, params);
		}else{
			exMsg = message.getMessage(BatchConstants.EXCEPTION_MESSAGE_COMMON + exCode);
		}
		
		log.error(">>>>>>>>>>>>> exCode=" + exCode);
		log.error(">>>>>>>>>>>>> exMsg=" + exMsg);

		return mav;
	}

}

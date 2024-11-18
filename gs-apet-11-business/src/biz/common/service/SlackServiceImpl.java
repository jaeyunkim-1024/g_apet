package biz.common.service;

import java.util.Properties;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import biz.app.batch.service.BatchService;
import biz.common.model.SlackSO;
import biz.interfaces.wms.constants.WmsInterfaceConstant.WmsDocs;
import framework.common.constants.CommonConstants;
import framework.common.util.ObjectUtil;
import lombok.extern.slf4j.Slf4j;
import net.gpedro.integrations.slack.SlackApi;
import net.gpedro.integrations.slack.SlackException;
import net.gpedro.integrations.slack.SlackMessage;

@Slf4j
//@Transactional
@Service("SlackService")
public class SlackServiceImpl implements SlackService  {

	@Autowired
	private BatchService batchService;

	@Autowired
	protected Properties bizConfig;

	@Transactional(propagation=Propagation.NOT_SUPPORTED)
	@Override
	public void sendSlackMessage(SlackSO so)  {
		
		log.debug("slackSO :: {}", so);
		
		if(!StringUtils.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
			return;
		}
		
		try {
			SlackApi api = new SlackApi("https://hooks.slack.com/services/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");    //웹훅URL
			api.call(new SlackMessage(so.getChlNm(), so.getMsgNm(), so.getMsgCont()));
		} catch(SlackException se) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, se);
		}
	}

//	@Override
//	public void batchSlackMessage(String batchId, long totCnt, long failCnt)  {
//		
//	}
	
	@Override
	public void batchSlackMessage(String batchId, long totCnt, long failCnt, Object... appendData) {
		String batchNm = batchService.selectBatchNm(batchId);
		String msg = "[배치실패] " + batchNm + "(" + batchId + "), " + "실행 대상 수: " + String.valueOf(totCnt) + "실행 실패 수: " + String.valueOf(failCnt);
		
		if(ObjectUtil.isNotEmpty(appendData)) {
			StringBuffer sb = new StringBuffer(" :: ");
			for(Object obj : appendData) {
				sb.append("[")
				  .append(obj !=null ? obj.toString() : "NULL")
				  .append("] ");
			}
			msg += sb.toString();
		}
		
		SlackSO so = new SlackSO();
		so.setChlNm("#application_check");
		so.setMsgNm("배치실패");
		so.setMsgCont(msg);
		this.sendSlackMessage(so);		
	}

	@Override
	public void itfSlackMessage(String sndrcvId, WmsDocs wmsDocs, long totCnt, long succCnt, long failCnt, Object... appendData) {
		String itfTitle = "S".equals(wmsDocs.getDirection().getCode()) ? "WMS송신" : "WMS수신";
		String msg = "[인터페이스실패] " + itfTitle + "- 인터페이스ID(" + wmsDocs.name() + "), 실행 대상 수: " + String.valueOf(totCnt) + " 성공 수: " + String.valueOf(succCnt)+ " 실패 수: " + String.valueOf(failCnt);
		
		if(ObjectUtil.isNotEmpty(appendData)) {
		
			StringBuffer sb = new StringBuffer(" :: ");
			for(Object obj : appendData) {
				sb.append("[")
				  .append(obj !=null ? obj.toString() : "NULL")
				  .append("] ");
			} 
			msg += sb.toString();
		}
		
		SlackSO so = new SlackSO();
		so.setChlNm("#application_check");
		so.setMsgNm("인터페이스실패");
		so.setMsgCont(msg);
		
		this.sendSlackMessage(so);	
		
	}

}

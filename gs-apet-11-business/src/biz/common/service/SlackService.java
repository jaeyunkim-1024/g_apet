package biz.common.service;

import biz.common.model.SlackSO;
import biz.interfaces.wms.constants.WmsInterfaceConstant.WmsDocs;

public interface SlackService {
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: SlackService.java
	 * - 작성일		: 2019. 7. 12.
	 * - 작성자		: SIG
	 * - 설명		: 슬랙 메세지 전송
	 * </pre>
	 * @param slackMsg
	 * @return
	 */
	public void sendSlackMessage(SlackSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: SlackService.java
	 * - 작성일		: 2019. 7. 12.
	 * - 작성자		: SIG
	 * - 설명		: 슬랙 메세지 전송
	 * </pre>
	 * @param failCnt 
	 * @param totCnt 
	 * @param slackMsg
	 * @return
	 */
//	public void batchSlackMessage(String batchId, long totCnt, long failCnt);
	
	public void batchSlackMessage(String batchId, long totCnt, long failCnt, Object... appendData);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: SlackService.java
	 * - 작성일		: 2019. 12. 11.
	 * - 작성자		: jhkim
	 * - 설명		: interface 슬랙 메세지 전송
	 * </pre>
	 * @param failCnt 
	 * @param totCnt 
	 * @param slackMsg
	 * @return
	 */
	public void itfSlackMessage(String sndrcvId, WmsDocs wmsDocs, long totCnt, long succCnt, long failCnt, Object... appendData);
}

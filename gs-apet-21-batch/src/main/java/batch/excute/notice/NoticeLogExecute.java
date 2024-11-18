package batch.excute.notice;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import biz.app.appweb.dao.PushDao;
import biz.app.appweb.model.NoticeSendListDetailVO;
import biz.app.appweb.model.PushDetailPO;
import biz.app.appweb.model.PushSO;
import biz.app.batch.model.BatchLogPO;
import biz.app.batch.service.BatchService;
import biz.app.ssgmessage.dao.SsgDao;
import biz.app.system.model.CodeDetailVO;
import biz.common.model.SsgMessageSendSO;
import biz.common.model.SsgMessageSendVO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class NoticeLogExecute {
	
	@Autowired private BatchService batchService;
	
	@Autowired private PushDao pushDao;	
	
	@Autowired private SsgDao ssgDao;
	
	@Autowired private BizService bizService;
	
	@Autowired private Properties bizConfig;
	
	@Autowired private CacheService cacheService;
	
	/**
	* <pre>
	* - 프로젝트명	: 21.batch
	* - 파일명		: NoticeLogExecute.java
	* - 작성일		: 2021. 03. 05.
	* - 작성자		: KWJ
	* - 설명		: SMS발송 이력 동기화
	* </pre>
	*/
	@SuppressWarnings("unchecked")
//	@Scheduled(fixedDelay=60000)
	public void regLogSms() {
		log.info("=================== regLogSms request ===================START");
		/***********************
		 * Batch Log Start
		 ***********************/
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(CommonConstants.BATCH_SENT_SMS_RST);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
		
		int total = 0;
		int success = 0;	
		int fail = 0;
		
		//발송결과 미확인 데이터 확인(NOTICE_SEND_DETAIL_LIST)
		PushSO pso = new PushSO();
		pso.setSndTypeCd(CommonConstants.SND_TYPE_20);
		pso.setSendReqYn(CommonConstants.COMM_YN_Y);
		pso.setSndRstCdNullYn(CommonConstants.COMM_YN_Y);
		
		List<NoticeSendListDetailVO> listSsgNoticeDetail = pushDao.listSsgNoticeDetail(pso);
		
		//SSG AGENT 로그 적재 확인(ABOUTPET_MSG.SSG_SEND_LOG_SMS_REAL_YYYYMM)
		if(CollectionUtils.isNotEmpty(listSsgNoticeDetail)) {
			String reqDtm;			
			String tableNm;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");			
			total = listSsgNoticeDetail.size();
			
			for(NoticeSendListDetailVO nsldvo : listSsgNoticeDetail) {				
				try {
					if(StringUtil.isNotBlank(nsldvo.getOutsideReqId())){										
						String outId = nsldvo.getOutsideReqId();
						boolean isTarget = false;
						if(outId.indexOf("MMS|") > -1 || outId.indexOf("SMS|") > -1) {
							// 운영환경이 아닌 곳에서 allowList 적용
							if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
								isTarget = true;
							} else {
								CodeDetailVO allowList = cacheService.getCodeCache(CommonConstants.MSG_ALLOW_LIST, CommonConstants.MSG_ALLOW_LIST_10);
								if (allowList.getUsrDfn1Val().indexOf(nsldvo.getRcvrNo()) != -1) {
									isTarget = true;
								}
							}
							if(isTarget) {
								//조회할 로그 테이블의 연월 확인
								SsgMessageSendSO sso = new SsgMessageSendSO();
								//reqDtm = sdf.format(nsldvo.getSendReqDtm());
								Date now = new Date();
								reqDtm = sdf.format(now.getTime());								
								LocalDate dt=LocalDate.now();								
								String gb = "SMS";
															
								tableNm = "ABOUTPET_MSG.SSG_SEND_LOG_SMS_REAL_"+reqDtm;							
								sso.setFmsgtype(CommonConstants.MSG_TP_SMS);
								if(outId.indexOf("MMS") > -1) {
									tableNm = "ABOUTPET_MSG.SSG_SEND_LOG_MMS_REAL_"+reqDtm;							
									sso.setFmsgtype(CommonConstants.MSG_TP_MMS);
									gb = "MMS";
								}
								
								sso.setTableNm(tableNm);							
								outId = outId.replace("SMS|", "");
								outId = outId.replace("MMS|", "");
								sso.setFseq(Long.parseLong(outId));
								SsgMessageSendVO ssvo = ssgDao.selectSmsLog(sso);
								
								if(StringUtil.isEmpty(ssvo) && dt.getDayOfMonth()== 1) {//조회된 값이 없고 매월 1일인 경우 전달 로그 테이블 검색
									Calendar mon = Calendar.getInstance();
									mon.add(Calendar.MONTH , -1);									
									String reqDtmRe = sdf.format(mon.getTime());
									tableNm = "ABOUTPET_MSG.SSG_SEND_LOG_"+gb+"_REAL_"+reqDtmRe;	
									sso.setTableNm(tableNm);
									ssvo = ssgDao.selectSmsLog(sso);									
								}
															
								if(StringUtil.isNotEmpty(ssvo)) {									
									//SSG AGENT 로그 적재된 경우 발송결과 UPDATE(NOTICE_SEND_DETAIL_LIST)
									PushDetailPO pdpo = new PushDetailPO();
									pdpo.setSndRstCd("F");
									pdpo.setSendReqDtm(ssvo.getFrsltdate());//통신사 메시지 처리시간						
									pdpo.setOutsideReqDtlId(gb+"|" + String.valueOf(ssvo.getFseq()));
									pdpo.setNoticeSendNo(nsldvo.getNoticeSendNo());
									if("06".equals(ssvo.getFrsltstat())){//전송처리결과(06성공 , 기타 실패)
										pdpo.setSndRstCd("S");
										success += pushDao.updateNoticeSendDetailList(pdpo);
									}else {
										fail += pushDao.updateNoticeSendDetailList(pdpo);
									}
									 				
								}else {
									//발송되어야 할 날짜가 일주일 이상 지났으면 실패처리. 2021-05-12
									Date sndReqDtmDt = new Date(nsldvo.getSendReqDtm().getTime());
									Calendar calendar = Calendar.getInstance();
									calendar.add(Calendar.DATE, -7);
									Date chkDate = calendar.getTime();									
									
									if(sndReqDtmDt.before(chkDate)) {									
										PushDetailPO pdpo = new PushDetailPO();
										pdpo.setSndRstCd("F");
										//pdpo.setSendReqDtm(ssvo.getFrsltdate());//통신사 메시지 처리시간						
										pdpo.setOutsideReqDtlId(outId);
										pdpo.setNoticeSendNo(nsldvo.getNoticeSendNo());
										fail += pushDao.updateNoticeSendDetailList(pdpo);
									}
								}
							}else {
								PushDetailPO pdpo = new PushDetailPO();
								pdpo.setSndRstCd("F");
								//pdpo.setSendReqDtm(ssvo.getFrsltdate());//통신사 메시지 처리시간						
								pdpo.setOutsideReqDtlId(outId);
								pdpo.setNoticeSendNo(nsldvo.getNoticeSendNo());
								fail += pushDao.updateNoticeSendDetailList(pdpo);
							}
						}else {//outId가 불명확하면 조회가 불가능하므로 fail 처리
							PushDetailPO pdpo = new PushDetailPO();
							pdpo.setSndRstCd("F");
							//pdpo.setSendReqDtm(ssvo.getFrsltdate());//통신사 메시지 처리시간						
							pdpo.setOutsideReqDtlId(outId);
							pdpo.setNoticeSendNo(nsldvo.getNoticeSendNo());
							fail += pushDao.updateNoticeSendDetailList(pdpo);
						}
											
					}
				} catch (Exception e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				}
				
			}			
		}
				
		/***********************
		 * Batch Log End
		 ***********************/
		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
		String RstMsg = "Success["+total+" total, "+success+" success, "+fail+" failed, "+(total-success-fail)+" unidentified]";
		blpo.setBatchRstMsg(RstMsg);		
		batchService.insertBatchLog(blpo);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 21.batch
	* - 파일명		: NoticeLogExecute.java
	* - 작성일		: 2021. 03. 08.
	* - 작성자		: KWJ
	* - 설명		: 알림톡발송 이력 동기화
	* </pre>
	*/
	@SuppressWarnings("unchecked")
//	@Scheduled(fixedDelay=60000)
	public void regLogKko() {
		log.info("=================== regLogKko request ===================START");
		/***********************
		 * Batch Log Start
		 ***********************/
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(CommonConstants.BATCH_SENT_KKO_RST);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
		
		int total = 0;
		int success = 0;		
		int fail = 0;
		
		//발송결과 미확인 데이터 확인(NOTICE_SEND_DETAIL_LIST)
		PushSO pso = new PushSO();
		pso.setSndTypeCd(CommonConstants.SND_TYPE_30);
		pso.setSendReqYn(CommonConstants.COMM_YN_Y);
		pso.setSndRstCdNullYn(CommonConstants.COMM_YN_Y);
		
		List<NoticeSendListDetailVO> listSsgNoticeDetail = pushDao.listSsgNoticeDetail(pso);
		
		//SSG AGENT 로그 적재 확인(ABOUTPET_MSG.SSG_SEND_LOG_SMS_REAL_YYYYMM)
		if(CollectionUtils.isNotEmpty(listSsgNoticeDetail)) {
			String reqDtm;
			String reqDtmRe;
			String tableNm;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			total = listSsgNoticeDetail.size();
			
			for(NoticeSendListDetailVO nsldvo : listSsgNoticeDetail) {				
				try {
					if(StringUtil.isNotBlank(nsldvo.getOutsideReqId())){										
						String outId = nsldvo.getOutsideReqId();
						boolean isTarget = false;
						if(outId.indexOf("KKO|") > -1 ) {
							// 운영환경이 아닌 곳에서 allowList 적용
							if (StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
								isTarget = true;
							} else {
								CodeDetailVO allowList = cacheService.getCodeCache(CommonConstants.MSG_ALLOW_LIST, CommonConstants.MSG_ALLOW_LIST_10);
								if (allowList.getUsrDfn1Val().indexOf(nsldvo.getRcvrNo()) != -1) {
									isTarget = true;
								}
							}
							PushDetailPO pdpo = new PushDetailPO();
							if(isTarget) {
								//조회할 로그 테이블의 연월 확인
								SsgMessageSendSO sso = new SsgMessageSendSO();
								Date now = new Date();
								LocalDate dt=LocalDate.now();
								reqDtm = sdf.format(now.getTime());
								Calendar mon = Calendar.getInstance();
								mon.add(Calendar.MONTH , -1);							
								reqDtmRe = sdf.format(mon.getTime());								
								
								tableNm = "ABOUTPET_MSG.SSG_SEND_LOG_KKO_"+reqDtm;	
								sso.setFmsgtype(CommonConstants.MSG_TP_KKO);							
								sso.setTableNm(tableNm);							
								outId = outId.replace("KKO|", "");							
								sso.setFseq(Long.parseLong(outId));
														
								SsgMessageSendVO ssvo = ssgDao.selectSmsLog(sso);	
								
								if(StringUtil.isEmpty(ssvo) && dt.getDayOfMonth()== 1) {//조회된 값이 없고 매월 1일인 경우 전달 로그 테이블 검색								
									tableNm = "ABOUTPET_MSG.SSG_SEND_LOG_KKO_"+reqDtmRe;	
									sso.setTableNm(tableNm);
									ssvo = ssgDao.selectSmsLog(sso);									
								}
								
								if(StringUtil.isNotEmpty(ssvo)) {
									//SSG AGENT 로그 적재된 경우 발송결과 UPDATE(NOTICE_SEND_DETAIL_LIST)
									
									if(!"06".equals(ssvo.getFrsltstat())) {//발송실패시 문자메세지 테이블 확인									
										SsgMessageSendVO ssvoRe = new SsgMessageSendVO();
										SsgMessageSendSO ssoRe = new SsgMessageSendSO();
										
										String cont = nsldvo.getContents();
										ssoRe.setFmsgtype(CommonConstants.MSG_TP_SMS);
										tableNm = "ABOUTPET_MSG.SSG_SEND_LOG_SMS_REAL_"+reqDtm;
										String gb = "SMS";
										if (StringUtil.getByteLength(cont) > 90) {
											ssoRe.setFmsgtype(CommonConstants.MSG_TP_MMS);
											tableNm = "ABOUTPET_MSG.SSG_SEND_LOG_MMS_REAL_"+reqDtm;
											gb = "MMS";
										} 									
										ssoRe.setTableNm(tableNm);									
										ssoRe.setFresendseq(Long.parseLong(outId));//알림톡의 fseq 가 문자 LOG 테이블 fresendseq로 적재됨
										ssvoRe = ssgDao.selectSmsLog(ssoRe);
										
										if(StringUtil.isEmpty(ssvoRe) && dt.getDayOfMonth()== 1) {//조회된 값이 없고 매월 1일인 경우 전달 로그 테이블 검색										
											tableNm = "ABOUTPET_MSG.SSG_SEND_LOG_"+gb+"_"+reqDtmRe;	
											ssoRe.setTableNm(tableNm);
											ssvoRe = ssgDao.selectSmsLog(ssoRe);									
										}
										
										if(StringUtil.isNotEmpty(ssvoRe)) {										
											if("06".equals(ssvoRe.getFrsltstat())) {
												pdpo.setSndRstCd("S");
												success++;
											}else {
												fail++;
												pdpo.setSndRstCd("F");
											}
											//pdpo.setSndRstCd("06".equals(ssvoRe.getFrsltstat())?"S":"F");//전송처리결과(06성공 , 기타 실패)
											pdpo.setSendReqDtm(ssvoRe.getFrsltdate());//통신사 메시지 처리시간
											pdpo.setOutsideReqDtlId(gb + "|KKO|" + String.valueOf(ssvoRe.getFseq()));
											pdpo.setNoticeSendNo(nsldvo.getNoticeSendNo());
										}else {//문자메세지 테이블에도 없으면 최종 실패
											fail++;
											pdpo.setSndRstCd("F");
											pdpo.setSendReqDtm(ssvo.getFrsltdate());//통신사 메시지 처리시간						
											pdpo.setOutsideReqDtlId("KKO|" + String.valueOf(ssvo.getFseq()));
											pdpo.setNoticeSendNo(nsldvo.getNoticeSendNo());
										}
									}else {
										success++;
										pdpo.setSndRstCd("S");
										pdpo.setSendReqDtm(ssvo.getFrsltdate());//통신사 메시지 처리시간						
										pdpo.setOutsideReqDtlId("KKO|" + String.valueOf(ssvo.getFseq()));
										pdpo.setNoticeSendNo(nsldvo.getNoticeSendNo());
									}								
												
								}else {
									//발송되어야 할 날짜가 일주일 이상 지났으면 실패처리. 2021-05-12
									Date sndReqDtmDt = new Date(nsldvo.getSendReqDtm().getTime());
									Calendar calendar = Calendar.getInstance();
									calendar.add(Calendar.DATE, -7);
									Date chkDate = calendar.getTime();
									if(sndReqDtmDt.before(chkDate)) {									
										fail++;
										pdpo.setSndRstCd("F");
										//pdpo.setSendReqDtm(ssvo.getFrsltdate());//통신사 메시지 처리시간						
										pdpo.setOutsideReqDtlId(outId);
										pdpo.setNoticeSendNo(nsldvo.getNoticeSendNo());
									}
								}
							}else {
								fail++;
								pdpo.setSndRstCd("F");
								//pdpo.setSendReqDtm(ssvo.getFrsltdate());//통신사 메시지 처리시간						
								pdpo.setOutsideReqDtlId(outId);
								pdpo.setNoticeSendNo(nsldvo.getNoticeSendNo());
							}
							pushDao.updateNoticeSendDetailList(pdpo); 	
						}											
					}
				} catch (Exception e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				}				
			}			
		}				
		/***********************
		 * Batch Log End
		 ***********************/
		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
		String RstMsg = "Success["+total+" total, "+success+" success, "+fail+" failed, "+(total-success-fail)+" unidentified]";
		blpo.setBatchRstMsg(RstMsg);
		batchService.insertBatchLog(blpo);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 21.batch
	* - 파일명		: NoticeLogExecute.java
	* - 작성일		: 2021. 03. 11.
	* - 작성자		: KWJ
	* - 설명		: push 발송 이력 동기화
	* </pre>
	*/
	@SuppressWarnings("unchecked")
//	@Scheduled(fixedDelay=60000)
	public void regLogPush() {
		log.info("=================== regLogPush request ===================START");
		/***********************
		 * Batch Log Start
		 ***********************/
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(CommonConstants.BATCH_SENT_PUSH_RST);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
		
		int total = 0;
		int success = 0;
		int fail = 0;
		int processing = 0;
		
		//발송결과 미확인 데이터 확인(NOTICE_SEND_DETAIL_LIST)
		PushSO pso = new PushSO();
		pso.setSndTypeCd(CommonConstants.SND_TYPE_10);
		pso.setSendReqYn(CommonConstants.COMM_YN_Y);
		pso.setSndRstCdNullYn(CommonConstants.COMM_YN_Y);
		
		//List<NoticeSendListDetailVO> listSsgNoticeDetail = pushDao.listSensPushDetail(pso);
		List<NoticeSendListDetailVO> listSsgNoticeDetail = pushDao.listSsgNoticeDetail(pso);
		
		if(CollectionUtils.isNotEmpty(listSsgNoticeDetail)) {			
			total = listSsgNoticeDetail.size();
			Map<String, Long> outsideReqIds = new HashMap<>();	
			for(NoticeSendListDetailVO nsldvo : listSsgNoticeDetail) {
				if(StringUtil.isNotBlank(nsldvo.getOutsideReqId())){
					outsideReqIds.put(nsldvo.getOutsideReqId(), nsldvo.getNoticeSendNo());				
				}
			}
			
			for(String key : outsideReqIds.keySet()){
				try {
					String outId = key;
					String resultCd = "F";
					//sens api 호출
					JsonNode result = bizService.getNaverPushResult(outId);
					
					if(StringUtil.isNotEmpty(result)) {
						String statusCd = result.get("messageStatusCode") != null? result.get("messageStatusCode").asText():null;
						String statusNm = result.get("messageStatusName") != null? result.get("messageStatusName").asText():null;							
						Timestamp completeTime = null;
						String compTime = result.get("completeTime") != null? result.get("completeTime").asText():null;
						if(compTime != null) {								
							//DateFormat  transFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
							DateFormat  transFormat =new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss", Locale.KOREA);
							Date dt = transFormat.parse(compTime);								
							completeTime = new Timestamp(dt.getTime()); 
						}
						
//						JsonNode toListJ = result.get("target");
//						ObjectMapper mapper = new ObjectMapper();
//						List<Long> to_list = Arrays.asList(
//						    mapper.convertValue(mapper.readTree(toListJ.toString()).get("to"),Long[].class)
//						);

						if(!"processing".equals(statusNm)) {//처리중이면 로그 쌓지 않음
							PushDetailPO pdpo = new PushDetailPO();
							pdpo.setSndRstCd(resultCd);
							pdpo.setSendReqDtm(completeTime);//발송 완료 시간				
							pdpo.setOutsideReqDtlId(outId);
							pdpo.setNoticeSendNo(outsideReqIds.get(key));
							pdpo.setSndTypeCd(CommonConstants.SND_TYPE_10);
							if("200".equals(statusCd)) {//성공
								resultCd = "S";
								pdpo.setSndRstCd(resultCd);
								success += pushDao.updateNoticeSendDetailList(pdpo);
							}else {
								fail += pushDao.updateNoticeSendDetailList(pdpo);
							}
						}		
					}
				} catch (Exception e) {
					log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
				}
			}
		}
		
		/***********************
		 * Batch Log End
		 ***********************/
		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
		String RstMsg = "Success["+total+" total, "+success+" success, "+fail+" failed, "+(total-success-fail)+ " processing]";
		blpo.setBatchRstMsg(RstMsg);
		batchService.insertBatchLog(blpo);
	}

	
}

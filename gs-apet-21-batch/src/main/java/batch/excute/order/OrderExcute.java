package batch.excute.order;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Component;

import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.appweb.service.PushService;
import biz.app.batch.model.BatchLogPO;
import biz.app.batch.service.BatchService;
import biz.app.claim.model.ClaimRegist;
import biz.app.claim.service.ClaimAcceptService;
import biz.app.claim.service.ClaimService;
import biz.app.order.model.BatchOrderVO;
import biz.app.order.model.OrderBaseSO;
import biz.app.order.model.OrderBaseVO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.model.OrderMsgVO;
import biz.app.order.model.OrderSO;
import biz.app.order.service.OrderBaseService;
import biz.app.order.service.OrderService;
import biz.app.pay.dao.PayBaseDao;
import biz.app.pay.model.PayBasePO;
import biz.common.model.SsgMessageSendPO;
import biz.common.service.BizService;
import framework.common.constants.CommonConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class OrderExcute {

	@Autowired	private OrderService orderService;
	@Autowired	private OrderBaseService orderBaseService;
	@Autowired	private BatchService batchService;
	@Autowired	private ClaimService claimService;
	@Autowired	private BizService bizService;
	@Autowired	private PushService pushService;
	@Autowired	private PayBaseDao payBaseDao;
	@Autowired private MessageSourceAccessor message;
	@Autowired private ClaimAcceptService claimAcceptService;

	/**
	* <pre>
	* - 프로젝트명	: 21.batch
	* - 파일명		: OrderExcute.java
	* - 작성일		: 2017. 5. 12.
	* - 작성자		: Administrator
	* - 설명			: 결제 미입금 안내 통보
	*                 입금예정일자 3일전에 이메일 안내 통보
	* </pre>
	*/
	//@Scheduled(cron = "0 0 * * * *")
	public void cronPaymentAdviceEmail() {
		List<BatchOrderVO> listBatchOrderVO = orderService.listPaymentAdviceEmail();

		if (CollectionUtils.isNotEmpty(listBatchOrderVO)) {

			for ( BatchOrderVO getBatchOrderVO : listBatchOrderVO ) {

				OrderSO orderSO = new OrderSO();
				orderSO.setOrdNo( getBatchOrderVO.getOrdNo() );

				//=============================================================================
				// 주문정보 추출
				//=============================================================================
				OrderBaseSO orderBaseSO  = new OrderBaseSO();
				orderBaseSO.setOrdNo(getBatchOrderVO.getOrdNo());

				//=============================================================================
				// EMAIL 전송
				//=============================================================================

				// EMAIL Set
//				EmailSendPO emailPO = new EmailSendPO();
//
//				emailPO.setAuthKey( "이메일 템플릿 AUTH KEY 받을것" );
//				emailPO.setNm( orderBaseVO.getOrdNm() );
//				emailPO.setEmail( orderBaseVO.getOrdrEmail() );
//				emailPO.setMobile( orderBaseVO.getOrdrMobile() );
//
//				emailPO.setSysRegrNo( orderBaseVO.getMbrNo() );
//
//				// EMAIL Send
//				this.bizService.sendEmail( emailPO );



			}

		}
	}

	/**
	* <pre>
	* - 프로젝트명	: 21.batch
	* - 파일명		: OrderExcute.java
	* - 작성일		: 2021. 3. 30.
	* - 작성자		: kek01
	* - 설명			: 결제 미입금 주문취소
	*
	* </pre>
	*/
	public void cronCancelOrderUnpaid() {

		String result = "";
		int successCnt = 0;
		int failCnt = 0;
		int totalCnt = 0;

		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(CommonConstants.BATCH_ORD_CANCEL_UNPAID);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);

		// 미입금된 주문 목록 조회. order_no 목록 반환.
		List<OrderDetailVO> ordNoList = orderService.listUnpaidOrder();
		totalCnt = ordNoList.size();
		//log.debug("ordNoList >>>"+ordNoList);
		if(CollectionUtils.isNotEmpty(ordNoList)){

			for ( OrderDetailVO odvo : ordNoList){
				//=============================================================================
				// 주문정보 추출
				//=============================================================================
				OrderBaseSO obso = new OrderBaseSO();
				obso.setOrdNo(odvo.getOrdNo());
				OrderBaseVO obVO = orderBaseService.getOrderBase(obso);

				//=============================================================================
				//  주문 취소 클레임등록 정보 생성
				//=============================================================================
				ClaimRegist clmRegist = new ClaimRegist();
				clmRegist.setClmTpCd(CommonConstants.CLM_TP_10);
				clmRegist.setClmRsnCd(CommonConstants.CLM_RSN_190);
				clmRegist.setOrdNo(odvo.getOrdNo());
				clmRegist.setAcptrNo(CommonConstants.COMMON_BATCH_USR_NO);
				clmRegist.setOrdMdaCd(obVO.getOrdMdaCd());

				try {

					String clmNo = claimAcceptService.acceptClaim(clmRegist);
					successCnt++;

				} catch(CustomException cu){
					log.error("************************************");
					log.error("미입금 주문취소 오류 customException");
					log.error("주문번호 : " + odvo.getOrdNo());
					// 보안성 진단. 오류메시지를 통한 정보노출
					//log.error(this.message.getMessage("business.exception." + cu.getExCode()));
					//cu.printStackTrace();
					failCnt++;
					log.error("************************************");
				} catch(Exception e){
					log.error("************************************");
					log.error("미입금 주문취소 오류 e");
					log.error("주문번호 : " + odvo.getOrdNo());
					log.error("알수 없는 오류가 발생하였습니다.");
					failCnt++;
				}
			}
		}
		//log.debug("successCnt >"+successCnt);
		//log.debug("failCnt >"+failCnt);

		String arg0 = String.valueOf(totalCnt);
		String arg1 = String.valueOf(successCnt);
		String arg2 = String.valueOf(failCnt);
		result = this.message.getMessage("batch.log.result.msg.unpaidOrderCancel", new String[]{arg0, arg1, arg2});

		/***********************
		 * Batch Log End
		 ***********************/
		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
		blpo.setBatchRstMsg(result);

		batchService.insertBatchLog(blpo);

	}
	
	/**
	* <pre>
	* - 프로젝트명	: 21.batch
	* - 파일명		: OrderExcute.java
	* - 작성일		: 2017. 5. 12.
	* - 작성자		: Administrator
	* - 설명			: 가상계좌 결제 후 1시간 경과 > 미입금 시 안내 알림톡 발송
	*
	* </pre>
	*/
	@SuppressWarnings("unchecked")
	public void ndpstMsgSendKko() {
		/***********************
		 * Batch Log Start
		 ***********************/
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(CommonConstants.BATCH_ORD_ALARM_UNPAID);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
		
		int total = 0;
		int fail = 0;
		List<OrderMsgVO> listBatchVirtualAccountVO = orderService.listNdpstMsgSendKko();

		if (CollectionUtils.isNotEmpty(listBatchVirtualAccountVO)) {
			//=============================================================================
			// 알림톡 발송
			//=============================================================================
			for(OrderMsgVO msgInfo : listBatchVirtualAccountVO) {
				PushSO pso = new PushSO();
				pso.setTmplCd("K_M_ord_0013");
				PushVO template = Optional.ofNullable(pushService.getNoticeTemplate(pso)).orElseGet(()->new PushVO());
				
				SimpleDateFormat sDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				SsgMessageSendPO msg = new SsgMessageSendPO();
				
				msg.setFtemplatekey(template.getTmplCd());
				msg.setMbrNo(msgInfo.getMbrNo());
				msg.setUsrNo(CommonConstants.COMMON_BATCH_USR_NO);
				
				String subject = template.getContents().split("\\n")[0];
				subject = StringUtil.cutText(subject, 80, true);
				if (subject != template.getSubject()) {
					msg.setFkkosubject(template.getSubject());
				}
				String message = template.getContents(); //템플릿 내용
				
				message = message.replace("${mbr_nm}", msgInfo.getOrdNm());
				message = message.replace("${ord_acpt_dtm}", msgInfo.getOrdAcptDtm() != null ? sDate.format(msgInfo.getOrdAcptDtm()) : ""); // 주문접수일시
				message = message.replace("${order_no}", msgInfo.getOrdNo());
				message = message.replace("${goods_nm}", msgInfo.getGoodsNm() != null ? msgInfo.getGoodsNm() : "");
				int ordQty = msgInfo.getExtraOrdCnt()-1;
				if(ordQty > 0 ) {
					message = message.replace("${extra_ord_cnt}", "외 "+ordQty+"개");
				} else {
					message = message.replace("${extra_ord_cnt}", "");
				}
				message = message.replace("${pay_amt}", StringUtil.formatMoney(msgInfo.getPayAmt().toString()));
				message = message.replace("${bank_nm}", msgInfo.getBankNm() != null ? msgInfo.getBankNm() : "");
				message = message.replace("${acct_no}", msgInfo.getAcctNo() != null ? msgInfo.getAcctNo().toString() : "");
				if(msgInfo.getDpstSchdDt() != null) {
					SimpleDateFormat dtFormat = new SimpleDateFormat("yyyyMMddHHmmss");
					SimpleDateFormat fDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //같은 형식으로 맞춰줌
					String strNewDtFormat = "";
					try {
						Date dpstSchdDt = dtFormat.parse(msgInfo.getDpstSchdDt());
						strNewDtFormat = fDate.format(dpstSchdDt);	
					} catch (ParseException e) {
						e.printStackTrace();
					}
					message = message.replace("${final_date}", strNewDtFormat);
				}else {
					message = message.replace("${final_date}", "");
				}
				
				msg.setFmessage(message); // 템플릿 내용 replace(데이터 바인딩)
				
				msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_10); // 즉시
				msg.setFdestine(msgInfo.getOrdrMobile()); // 수신자 번호
				msg.setSndTypeCd(CommonConstants.SND_TYPE_30); // 알림톡
				
				int result = bizService.sendMessage(msg);
				total++;
				
				if (result == 0) {
					fail++;
					log.error("************************************");
					log.error("가상계좌 미입금 메세지 알림톡 발송 오류");
					log.error("결제 번호 : " + msgInfo.getPayNo());
					log.error("************************************");
				} else {
					// 알림톡 정상 발송 시 미입금 메세지 전송 여부 'Y'로 수정
					PayBasePO pbpo = new PayBasePO();
					pbpo.setPayNo(msgInfo.getPayNo());
					int updateResult = payBaseDao.updatePayBaseNdpstMsgSendYn(pbpo);
					
					if (updateResult == 0) {
						log.error("************************************");
						log.error("가상계좌 미입금 메세지 전송 여부 수정 오류");
						log.error("결제 번호 : " + msgInfo.getPayNo());
						log.error("************************************");
					}
				}
				
			}

		}
		
		/***********************
		 * Batch Log End
		 ***********************/
		blpo.setBatchEndDtm(DateUtil.getTimestamp());
		blpo.setBatchRstCd(CommonConstants.BATCH_RST_CD_SUCCESS);
		String RstMsg = "Success["+total+" total, "+(total - fail)+" success, "+fail+" failed]";
		blpo.setBatchRstMsg(RstMsg);

		batchService.insertBatchLog(blpo);
	}
}

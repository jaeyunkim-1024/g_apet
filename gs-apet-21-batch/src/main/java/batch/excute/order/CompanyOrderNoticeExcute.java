package batch.excute.order;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.appweb.service.PushService;
import biz.app.batch.model.BatchLogPO;
import biz.app.batch.service.BatchService;
import biz.app.order.model.OrderMsgVO;
import biz.app.order.model.OrderSO;
import biz.app.order.service.OrderService;
import biz.common.model.SsgMessageSendPO;
import biz.common.service.BizService;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class CompanyOrderNoticeExcute {

	@Autowired	private OrderService orderService;
	@Autowired	private PushService pushService;
	@Autowired	private BizService bizService;
	@Autowired	private BatchService batchService;

	/**
	* <pre>
	* - 프로젝트명	: 21.batch
	* - 파일명		: OrderExcute.java
	* - 작성일		: 2017. 5. 12.
	* - 작성자		: Administrator
	* - 설명			: 위탁업체 주문건 수집문자 알림 발송
	* </pre>
	*/
	public void cronCompanyOrderSendMsg() {
		/***********************
		 * Batch Log Start
		 ***********************/
		BatchLogPO blpo = new BatchLogPO();
		blpo.setBatchId(CommonConstants.BATCH_COMPANY_ORD_NOTICE);
		blpo.setBatchStrtDtm(DateUtil.getTimestamp());
		blpo.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
		
		int total = 0;
		int fail = 0;
		
		OrderSO oso = new OrderSO();
		// 배송지시 상태만 조회
		oso.setOrdDtlStatCd(CommonConstants.ORD_DTL_STAT_130);
		oso.setOrdAcptDtmStart(blpo.getBatchStrtDtm());
		oso.setOrdAcptDtmEnd(blpo.getBatchStrtDtm());
		List<OrderMsgVO> listCompanyOrdVO = orderService.listOrderCompInfo(oso);

		if (CollectionUtils.isNotEmpty(listCompanyOrdVO)) {
			//=============================================================================
			// 위탁업체 주문건 수집 문자 발송
			//=============================================================================
			PushSO pso = new PushSO();
			pso.setTmplCd("M_T_ord_0002"); // 업체별 주문건 문자 발송 템플릿 (20210924 템플릿 코드 수정 CSR-1728)
			PushVO pvo = pushService.getNoticeTemplate(pso); // 템플릿 조회
			
			for(OrderMsgVO omvo : listCompanyOrdVO) {
				SsgMessageSendPO msg = new SsgMessageSendPO();
				msg.setSndTypeCd(CommonConstants.SND_TYPE_20); // 무조건 문자 전송 
				
				String compMsg = "";
				if(pvo != null) {
					compMsg = pvo.getContents(); //템플릿 내용
					compMsg = compMsg.replace("${comp_ord_cnt}", omvo.getCompOrdCnt().toString());
				} else {
					log.error("위탁업체 주문건 문자 알림 템플릿 조회 오류");
					log.error("알림 템플릿 코드 : " + pso.getTmplCd());
					break;
				}
				msg.setFmessage(compMsg);// 템플릿 내용 replace(데이터 바인딩)
				msg.setFtemplatekey(null);//템플릿 키
				msg.setFdestine(omvo.getMobile()); //업체 파트너 휴대폰 번호
				
				int result = bizService.sendMessage(msg);
				total++;
				
				if (result == 0) {
					log.error("************************************");
					log.error("위탁업체 주문건 문자 알림 발송 오류");
					log.error("업체번호 : " + omvo.getCompNo());
					log.error("위탁업체 알림 batchStrtDtm : " + DateUtil.getTimestampToString(blpo.getBatchStrtDtm(), "yyyyMMddHHmmss"));
					log.error("************************************");
					fail++;
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

package biz.common.service.ext;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.emma.model.SmtClientPO;
import biz.app.emma.model.SmtTranPO;
import biz.app.emma.service.EmmaService;
import biz.common.model.LmsSendPO;
import biz.common.model.SmsSendPO;
import biz.common.service.BizServiceImpl;
import framework.common.constants.CommonConstants;
import lombok.extern.slf4j.Slf4j;

/**
 * 
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.common.service.ext
* - 파일명		: BizServiceExt.java
* - 작성일		: 
* - 작성자		: WilLee
* - 설명			:
* </pre>
 */

@Slf4j
@Service
@Transactional
public class BizServiceExt extends BizServiceImpl {

	@Autowired
	private EmmaService emmaService;

	@Override
	public int sendSms(SmsSendPO po) {

		String[] recipientNums = po.getReceivePhone().split(",");

		SmtTranPO st = new SmtTranPO();
		st.setServiceType(CommonConstants.SERVICE_TYPE_SMS_MT);
		st.setCallback(StringUtils.defaultIfEmpty(po.getSendPhone(), StringUtils.EMPTY).replaceAll("-", ""));
		st.setContent(po.getMsg());
		st.setDateClientReq(po.getReserveTime());

		if (recipientNums.length > 1) {
			st.setMsgStatus(String.valueOf(CommonConstants.MSG_STATUS_TEMP));
			st.setBroadcastYn(CommonConstants.BROADCAST_YN_Y);
		} else {
			st.setMsgStatus(String.valueOf(CommonConstants.MSG_STATUS_READY));
			st.setBroadcastYn(CommonConstants.BROADCAST_YN_N);
			st.setRecipientNum(recipientNums[0].replaceAll("-", ""));
		}

		
		emmaService.insertSmtTran(st);

		if (recipientNums.length > 1) {

			// MAX(mt_pr)
			st.setMtPr(emmaService.getMaxSmtPr());

			for (int i = 0; i < recipientNums.length; i++) {

				SmtClientPO sc = new SmtClientPO();
				sc.setMtPr(st.getMtPr());
				sc.setMtSeq(i + 1);
				sc.setMsgStatus(String.valueOf(CommonConstants.MSG_STATUS_READY));
				sc.setRecipientNum(recipientNums[i].replaceAll("-", ""));

				emmaService.insertSmtClient(sc);
			}

			// Update em_smt_tran (9->1)
			emmaService.updateSmtTran(st);

		}
		

		return 0;
	}

	@Override
	public int sendLms(LmsSendPO po) {

		/*String[] recipientNums = po.getReceivePhone().split(",");

		SmtTranPO st = new SmtTranPO();
		st.setServiceType(CommonConstants.SERVICE_TYPE_LMS);
		st.setCallback(po.getSendPhone().replaceAll("-", ""));
		st.setSubject(po.getSubject());
		st.setContent(po.getMsg());
		st.setDateClientReq(po.getReserveTime());

		if (recipientNums.length > 1) {
			st.setMsgStatus(CommonConstants.MSG_STATUS_TEMP);
			st.setBroadcastYn(CommonConstants.BROADCAST_YN_Y);
		} else {
			st.setMsgStatus(CommonConstants.MSG_STATUS_READY);
			st.setBroadcastYn(CommonConstants.BROADCAST_YN_N);
			st.setRecipientNum(recipientNums[0].replaceAll("-", ""));
		}

		emmaService.insertMmtTran(st);

		if (recipientNums.length > 1) {

			// MAX(mt_pr)
			st.setMtPr(emmaService.getMaxMmtPr());

			for (int i = 0; i < recipientNums.length; i++) {

				SmtClientPO sc = new SmtClientPO();
				sc.setMtPr(st.getMtPr());
				sc.setMtSeq(i + 1);
				sc.setMsgStatus(CommonConstants.MSG_STATUS_READY);
				sc.setRecipientNum(recipientNums[i].replaceAll("-", ""));

				emmaService.insertMmtClient(sc);
			}

			// Update em_smt_tran (9->1)
			emmaService.updateMmtTran(st);

		}*/

		return 0;
	}

}

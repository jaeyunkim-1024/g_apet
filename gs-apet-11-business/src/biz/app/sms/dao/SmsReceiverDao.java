package biz.app.sms.dao;

import org.springframework.stereotype.Repository;

import biz.app.sms.model.SmsReceiverPO;
import framework.common.dao.MainAbstractDao;

@Repository
public class SmsReceiverDao extends MainAbstractDao {

	public int insertSmsReceiver(SmsReceiverPO po){
		return insert("smsReceiver.insertSmsReceiver", po);
	}

}

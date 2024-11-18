package biz.app.emma.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.emma.dao.EmmaDao;
import biz.app.emma.model.SmtClientPO;
import biz.app.emma.model.SmtTranPO;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.emma.service
* - 파일명		: EmmaServiceImpl.java
* - 작성일		: 2017. 2. 2.
* - 작성자		: WilLee
* - 설명			: SMS 전송 테이블 관련 서비스
 * </pre>
 */
@Slf4j
@Transactional
@Service("emmaService")
public class EmmaServiceImpl implements EmmaService {

	@Autowired
	private EmmaDao emmaDao;

	@Override
	public void insertSmtTran(SmtTranPO st) {
		emmaDao.insertSmtTran(st);
	}

	@Override
	public void insertSmtClient(SmtClientPO sc) {
		emmaDao.insertSmtClient(sc);
	}

	@Override
	public int getMaxSmtPr() {
		return emmaDao.getMaxSmtPr();

	}

	@Override
	public void updateSmtTran(SmtTranPO st) {
		emmaDao.updateSmtTran(st);

	}

	@Override
	public void insertMmtTran(SmtTranPO st) {
		emmaDao.insertMmtTran(st);
	}

	@Override
	public void insertMmtClient(SmtClientPO sc) {
		emmaDao.insertMmtClient(sc);
	}

	@Override
	public int getMaxMmtPr() {
		return emmaDao.getMaxMmtPr();

	}

	@Override
	public void updateMmtTran(SmtTranPO st) {
		emmaDao.updateMmtTran(st);

	}
}
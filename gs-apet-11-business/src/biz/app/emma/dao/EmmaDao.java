package biz.app.emma.dao;

import org.springframework.stereotype.Repository;

import biz.app.emma.model.SmtClientPO;
import biz.app.emma.model.SmtTranPO;
import framework.common.dao.MainAbstractDao;

@Repository
public class EmmaDao extends MainAbstractDao {

	public int insertSmtTran(SmtTranPO st) {
		return insert("emma.insertSmtTran", st);
	}

	public int insertSmtClient(SmtClientPO sc) {
		return update("emma.insertSmtClient", sc);
	}

	public int getMaxSmtPr() {
		return selectOne("emma.getMaxSmtPr");
	}

	public int updateSmtTran(SmtTranPO st) {
		return update("emma.updateSmtTran", st);
	}

	public int insertMmtTran(SmtTranPO st) {
		return insert("emma.insertMmtTran", st);
	}

	public int insertMmtClient(SmtClientPO sc) {
		return update("emma.insertMmtClient", sc);
	}

	public int getMaxMmtPr() {
		return selectOne("emma.getMaxMmtPr");
	}

	public int updateMmtTran(SmtTranPO st) {
		return update("emma.updateMmtTran", st);
	}
}

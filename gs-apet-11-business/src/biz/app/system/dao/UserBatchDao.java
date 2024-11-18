package biz.app.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.system.model.UserBasePO;
import biz.app.system.model.UserBaseSO;
import biz.app.system.model.UserBaseVO;
import framework.common.dao.MainAbstractDao;

@Repository
public class UserBatchDao extends MainAbstractDao {
	
	private static final String BASE_DAO_PACKAGE = "userBatch.";
	
	
	public List<UserBaseVO> listUserStatForUnUsed(UserBaseSO so) {
		return selectList(BASE_DAO_PACKAGE + "listUserStatForUnUsed", so);
	}
	
	public int updateUserStatForUnUsed(List<UserBasePO> poList) {
		return update(BASE_DAO_PACKAGE + "updateUserStatForUnUsed", poList);
	}
}

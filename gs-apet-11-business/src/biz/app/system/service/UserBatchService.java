package biz.app.system.service;

import java.util.List;

import biz.app.system.model.UserBasePO;
import biz.app.system.model.UserBaseSO;
import biz.app.system.model.UserBaseVO;

public interface UserBatchService {
	
	public List<UserBaseVO> listUserStatForUnUsed(UserBaseSO so); 
	
	public int updateUserStatForUnUsed(List<UserBasePO> poList);
}

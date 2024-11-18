package biz.app.system.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.system.dao.UserBatchDao;
import biz.app.system.model.UserBasePO;
import biz.app.system.model.UserBaseSO;
import biz.app.system.model.UserBaseVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class UserBatchServiceImpl implements UserBatchService {
	
	@Autowired private UserBatchDao userBatchDao; 

	@Override
	public List<UserBaseVO> listUserStatForUnUsed(UserBaseSO so) {
		return userBatchDao.listUserStatForUnUsed(so);
	}

	public int updateUserStatForUnUsed(List<UserBasePO> poList) {
		return userBatchDao.updateUserStatForUnUsed(poList);
	}
}

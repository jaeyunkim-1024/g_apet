package biz.app.login.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.login.model.UserLoginHistPO;
import biz.app.system.model.AuthorityVO;
import biz.app.system.model.UserAgreeInfoPO;
import biz.app.system.model.UserAgreeInfoVO;
import biz.app.system.model.UserBasePO;
import biz.app.system.model.UserBaseSO;
import biz.app.system.model.UserBaseVO;
import framework.common.dao.MainAbstractDao;

@Repository
public class AdminLoginDao extends MainAbstractDao {

	public UserBaseVO getUser(UserBaseSO so) {
		return selectOne("adminLogin.getUser", so);
	}


	public int updateUserFailCnt(String id) {
		return update("adminLogin.updateUserFailCnt", id);
	}
	
	public int updateUserLogin(UserBasePO usrPo) {
		return update("adminLogin.updateUserLogin", usrPo);
	}
	
	

	public int insertUserLoginHist(UserLoginHistPO po) {
		return insert("adminLogin.insertUserLoginHist", po);
	}
	
	public List<UserAgreeInfoVO> selectUserAgreeInfoList(UserBaseSO so) {
		return selectList("adminLogin.selectUserAgreeInfoList", so);
	}

	public int insertUserAgreeInfo(UserAgreeInfoPO po) {
		return insert("adminLogin.insertUserAgreeInfo", po);
	}
}

package biz.app.login.service;

import java.util.List;
import java.util.Map;

import biz.app.system.model.AuthorityVO;
import biz.app.system.model.UserAgreeInfoPO;
import biz.app.system.model.UserBasePO;
import biz.app.system.model.UserBaseSO;
import biz.app.system.model.UserBaseVO;
public interface AdminLoginService {

	public Map<String, Object> getLoginCheck(String id, String pwd);

	public void getSessionRefresh(String id);
	
	public UserBaseVO getUser(UserBaseSO so);

	public Map<String, Object> getUserWithCheck(UserBaseSO so);
	
	public int insertUserAgreeInfo(UserBaseSO userSO, UserAgreeInfoPO po);
}
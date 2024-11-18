package biz.app.system.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.system.dao.AuthDao;
import biz.app.system.model.AuthorityPO;
import biz.app.system.model.AuthoritySO;
import biz.app.system.model.AuthorityVO;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

/**
 * 사이트 ServiceImpl
 * @author		snw
 * @since		2015.06.11
 */
@Service
@Transactional
public class AuthServiceImpl implements AuthService {

	@Autowired
	private AuthDao authDao;

	@Override
	@Transactional(readOnly=true)
	public List<AuthorityVO> pageAuth(AuthoritySO so) {
		return authDao.pageAuth(so);
	}

	@Override
	@Transactional(readOnly=true)
	public List<AuthorityVO> listAuth() {
		return authDao.listAuth();
	}

	@Override
	@Transactional(readOnly=true)
	public AuthorityVO getAuth(AuthoritySO so) {
		return authDao.getAuth(so);
	}

	@Override
	public void saveAuth(AuthorityPO po) {

		AuthoritySO so = new AuthoritySO();
		so.setAuthNo(po.getAuthNo());

		AuthorityVO vo = getAuth(so);

		int result = 0;

		if(vo != null) {
			// 권한 메뉴 수정
			result = authDao.updateAuth(po);

			// 권한 메뉴 삭제
			authDao.deleteMenuAuth(po);
		} else {
			// 권한 메뉴 등록
			result = authDao.insertAuth(po);
		}

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		if(po.getArrMenuNo() != null && po.getArrMenuNo().length > 0) {
			for(Long menuNo : po.getArrMenuNo()){
				if(menuNo > 0) {
					po.setMenuNo(menuNo);
					// 권한 메뉴 목록 등록
					result = authDao.insertMenuAuth(po);

					if(result == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}

				}
			}
		}

	}

	@Override
	public void deleteAuth(AuthorityPO po) {
		int cnt = authDao.getCheckAuthDelete(po);

		if(cnt > 0) {
			throw new CustomException(ExceptionConstants.ERROR_AUTH_MENU_FAIL);
		}

		authDao.deleteAuth(po);
		authDao.deleteMenuAuth(po);
	}

	@Override
	@Transactional(readOnly=true)
	public List<AuthorityVO> listAuthMenu(AuthoritySO so) {
		return authDao.listAuthMenu(so);
	}

	@Override
	public List<AuthorityVO> listUserAuth(AuthoritySO so) {
		return authDao.listUserAuth(so);
	}

}
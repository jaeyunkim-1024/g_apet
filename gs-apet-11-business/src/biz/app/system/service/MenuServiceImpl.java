package biz.app.system.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.system.dao.AuthDao;
import biz.app.system.dao.MenuDao;
import biz.app.system.model.AuthorityPO;
import biz.app.system.model.CodeDetailSO;
import biz.app.system.model.CodeDetailVO;
import biz.app.system.model.MenuActionPO;
import biz.app.system.model.MenuActionSO;
import biz.app.system.model.MenuActionVO;
import biz.app.system.model.MenuBasePO;
import biz.app.system.model.MenuBaseVO;
import biz.app.system.model.MenuSO;
import biz.app.system.model.MenuTreeVO;
import framework.admin.constants.AdminConstants;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

/**
 * 사이트 ServiceImpl
 * @author		snw
 * @since		2015.06.11
 */
@Service
@Transactional
public class MenuServiceImpl implements MenuService {

	@Autowired
	private MenuDao menuDao;

	@Autowired
	private AuthDao authDao;

	@Override
	@Transactional(readOnly=true)
	public List<MenuTreeVO> listMenuTree(MenuSO so) {
		List<MenuTreeVO> result = new ArrayList<>();
		MenuTreeVO vo = new MenuTreeVO();
		vo.setId(String.valueOf(AdminConstants.MENU_DEFAULT_NO));
		vo.setText("Back Office");
		vo.setParent("#");
		result.add(vo);
		result.addAll(menuDao.listMenuTree(so));
		return result;
	}

	@Override
	@Transactional(readOnly=true)
	public MenuBaseVO getMenuBase(MenuSO so) {
		return Optional.ofNullable(menuDao.getMenuBase(so)).orElseGet(()->new MenuBaseVO());
	}

	@Override
	public void saveMenuBase(MenuBasePO po) {
		MenuSO so = new MenuSO();
		so.setMenuNo(po.getMenuNo());

		MenuBaseVO vo = getMenuBase(so);

		int result = 0;
		if(Integer.compare(Optional.ofNullable(vo.getMenuNo()).orElseGet(()->0),0) != 0){
			result = menuDao.updateMenuBase(po);
		}else{
			so.setMenuNo(po.getUpMenuNo());
			int cnt = menuDao.getCheckMenuBase(so);

			if(cnt > 0) {
				throw new CustomException(ExceptionConstants.ERROR_MENU_BASE_TREE_FAIL);
			}

			result = menuDao.insertMenuBase(po);
			
			//메뉴와 권한 맵핑
			List<Long> authNos = AdminSessionUtil.getSession().getAuthNos();
			Set<Long> authSet = new HashSet<>(authNos);
			
			CodeDetailSO codeSo = new CodeDetailSO();
			codeSo.setGrpCd(AdminConstants.AUTH_NO);
			codeSo.setDtlCd(AdminConstants.AUTH_NO_10);
			CodeDetailVO codeVo = menuDao.getMenuUserAuth(codeSo);
			codeVo.getUsrDfn1Val();
			
			String[] arrayStr = codeVo.getUsrDfn1Val().split(",");
			for(String str : arrayStr) {
				Long defaultNo = Long.parseLong(str);
				authSet.add(defaultNo);
			}
			
			Long menuNo = po.getMenuNo();
			for(Long authNo : authSet){
				AuthorityPO p = new AuthorityPO();
				p.setMenuNo(menuNo); // 메뉴번호
				p.setAuthNo(authNo); // 권한번호
				if(authDao.insertMenuAuth(p) == 0){
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		}

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void deleteMenuBase(MenuBasePO po) {
		MenuSO so = new MenuSO();
		so.setMenuNo(po.getMenuNo());

		int cnt = menuDao.getCheckMenuBase(so);
		if(cnt > 0) {
			throw new CustomException(ExceptionConstants.ERROR_MENU_BASE_TREE_FAIL);
		}

		MenuActionSO menuActionSO = new MenuActionSO();
		menuActionSO.setMenuNo(po.getMenuNo());
		cnt = menuDao.getCheckMenuAction(menuActionSO);
		if(cnt > 0) {
			throw new CustomException(ExceptionConstants.ERROR_UP_MENU_FAIL);
		}

		int result = menuDao.deleteMenuBase(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		menuDao.deleteMenuAuth(po);
	}


	@Override
	@Transactional(readOnly=true)
	public List<MenuActionVO> listMenuAction(MenuActionSO so) {
		return menuDao.listMenuAction(so);
	}

	@Override
	@Transactional(readOnly=true)
	public MenuActionVO getMenuAction(MenuActionSO so) {
		return menuDao.getMenuAction(so);
	}

	@Override
	public void saveMenuAction(MenuActionPO po) {

		if(0 == po.getMenuNo()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		MenuActionSO so = new MenuActionSO();
		so.setMenuNo(po.getMenuNo());
		so.setActNo(po.getActNo());

		int cnt = menuDao.getCheckMenuAction(so);
		if(cnt > 0) {
			throw new CustomException(ExceptionConstants.ERROR_MENU_ACTION_FAIL);
		}

		MenuActionVO vo = getMenuAction(so);

		int result = 0;

		if(vo != null) {
			result = menuDao.updateMenuAction(po);

			if(AdminConstants.ACT_GB_10.equals(po.getActGbCd())) {
				cnt = menuDao.getCheckMainMenuAction(so);

				if(cnt > 1) {
					throw new CustomException(ExceptionConstants.ERROR_MENU_ACTION_MAIN_FAIL);
				}
			}
		} else {
			if(AdminConstants.ACT_GB_10.equals(po.getActGbCd())) {
				cnt = menuDao.getCheckMainMenuAction(so);

				if(cnt > 0) {
					throw new CustomException(ExceptionConstants.ERROR_MENU_ACTION_MAIN_FAIL);
				}
			}

			result = menuDao.insertMenuAction(po);
		}

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

	}

	@Override
	public void deleteMenuAction(MenuActionPO po) {
		int result = menuDao.deleteMenuAction(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	@Transactional(readOnly=true)
	public List<MenuBaseVO> listCommonMenu(Long usrNo) {
		return menuDao.listCommonMenu(usrNo);
	}

	@Override
	@Transactional(readOnly=true)
	public List<MenuTreeVO> listMenuAuthTree(MenuSO so) {
		return menuDao.listMenuAuthTree(so);
	}

	@Override
	public MenuBaseVO getMastMenuNo(String menuUrl) {
		return menuDao.getMastMenuNo(menuUrl);
	}
}
package biz.app.system.service;

import biz.app.system.dao.CodeDao;
import biz.app.system.model.*;
import biz.common.service.CacheService;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * 사이트 ServiceImpl
 * @author		snw
 * @since		2015.06.11
 */
@Service
@Transactional
public class CodeServiceImpl implements CodeService {

	@Autowired
	private CodeDao codeDao;

	@Autowired
	private CacheService cacheService;


	@Override
	@Transactional(readOnly=true)
	public List<CodeGroupVO> pageCodeGroup(CodeGroupSO so) {
		return codeDao.pageCodeGroup(so);
	}

	@Override
	@Transactional(readOnly=true)
	public CodeGroupVO getCodeGroup(CodeGroupSO so) {
		return codeDao.getCodeGroup(so);
	}

	@Override
	public void insertCodeGroup(CodeGroupPO po) {
		CodeGroupSO so = new CodeGroupSO();
		so.setGrpCd(po.getGrpCd());
		CodeGroupVO vo = getCodeGroup(so);
		if(vo != null) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_GROUP_DUPLICATION_FAIL);
		}

		int result = codeDao.insertCodeGroup(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		cacheService.listCodeCacheRefresh();
	}

	@Override
	public void updateCodeGroup(CodeGroupPO po) {
		int result = codeDao.updateCodeGroup(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		cacheService.listCodeCacheRefresh();
	}

	@Override
	public void deleteCodeGroup(CodeGroupPO po) {
		if(!AdminSessionUtil.isAdminSession()){
			throw new CustomException(ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED);
		}
		po.setSysDelrNo(AdminSessionUtil.getSession().getUsrNo());
		int result = codeDao.deleteCodeGroup(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		cacheService.listCodeCacheRefresh();
	}

	@Override
	@Transactional(readOnly=true)
	public List<CodeDetailVO> pageCodeDetail(CodeDetailSO so) {
		return codeDao.pageCodeDetail(so);
	}
	
	@Override
	@Transactional(readOnly=true)
	public List<biz.app.system.model.interfaces.CodeDetailVO> pageCodeDetailInterface(biz.app.system.model.interfaces.CodeDetailSO so) {
		return codeDao.pageCodeDetailInterface(so);
	}

	@Override
	@Transactional(readOnly=true)
	public CodeDetailVO getCodeDetail(CodeDetailSO so) {
		return codeDao.getCodeDetail(so);
	}

	@Override
	public void insertCodeDetail(CodeDetailPO po) {
		CodeDetailSO so = new CodeDetailSO();
		so.setGrpCd(po.getGrpCd());
		so.setDtlCd(po.getDtlCd());
		CodeDetailVO vo = getCodeDetail(so);
		if(vo != null) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DETAIL_DUPLICATION_FAIL);
		}

		int result = codeDao.insertCodeDetail(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		cacheService.listCodeCacheRefresh();
	}

	@Override
	public void updateCodeDetail(CodeDetailPO po) {
		int result = codeDao.updateCodeDetail(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		cacheService.listCodeCacheRefresh();
	}

	@Override
	public void deleteCodeDetail(CodeDetailPO po) {
		if(!AdminSessionUtil.isAdminSession()){
			throw new CustomException(ExceptionConstants.ERROR_CODE_LOGIN_REQUIRED);
		}
		po.setSysDelrNo(AdminSessionUtil.getSession().getUsrNo());

		int result = codeDao.deleteCodeDetail(po);
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		cacheService.listCodeCacheRefresh();
	}

	@Override
	public Map<String,List<String>> createAutoSearchKeyWord(CodeGroupSO so) {
		List<CodeGroupVO> list = Optional.ofNullable(codeDao.createAutoSearchKeyWord(so)).orElseGet(()->new ArrayList<CodeGroupVO>());
		List<String> grpCds = new ArrayList<String>();
		List<String> grpNms = new ArrayList<String>();
		for(CodeGroupVO v : list){
			grpCds.add(v.getGrpCd());
			grpNms.add(v.getGrpNm());
		}
		Map<String,List<String>> result = new HashMap<>();
		result.put("GRP_CD",grpCds);
		result.put("GRP_NM",grpNms);
		return result;
	}

}
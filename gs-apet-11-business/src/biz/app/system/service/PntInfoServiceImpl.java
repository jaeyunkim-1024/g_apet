package biz.app.system.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.system.dao.PntInfoDao;
import biz.app.system.model.PntInfoPO;
import biz.app.system.model.PntInfoSO;
import biz.app.system.model.PntInfoVO;
import biz.common.service.BizService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.StringUtil;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.system.service
 * - 파일명		: PntInfoServiceImpl.java
 * - 작성일		: 2021. 07. 20.
 * - 작성자		: JinHong
 * - 설명		: 포인트 서비스 구현
 * </pre>
 */
@Service
@Transactional
public class PntInfoServiceImpl implements PntInfoService {

	@Autowired
	private PntInfoDao pntInfoDao;

	@Autowired
	private BizService bizService;



	@Override
	@Transactional(readOnly=true)
	public List<PntInfoVO> pagePntInfo(PntInfoSO so) {
		return pntInfoDao.pagePntInfo(so);
	}


	@Override
	@Transactional(readOnly=true)
	public PntInfoVO getPntInfo(PntInfoSO so) {
		
		PntInfoVO vo = pntInfoDao.getPntInfo(so);
		
		if(vo != null && StringUtil.isNotEmpty(vo.getCardNo())) {
			//TODO : Card NO Format
			vo.setViewCardNo(vo.getCardNo());
		}
		return vo;
	}


	@Override
	@Transactional
	public void insertPntInfo(PntInfoPO po) {
		Long pntNo = bizService.getSequence(CommonConstants.SEQUENCE_PNT_INFO_SEQ);
		po.setPntNo(pntNo);
		int result = pntInfoDao.insertPntInfo(po);
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}


	@Override
	@Transactional
	public void updatePntInfo(PntInfoPO po) {
		int result = pntInfoDao.updatePntInfo(po);
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	@Transactional(readOnly=true)
	public int getValidCount(PntInfoSO so) {
		return pntInfoDao.getValidCount(so);
	}
}
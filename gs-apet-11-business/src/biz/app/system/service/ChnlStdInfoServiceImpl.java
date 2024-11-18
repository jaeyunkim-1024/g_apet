package biz.app.system.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.system.dao.ChnlStdInfoDao;
import biz.app.system.model.ChnlStdInfoPO;
import biz.app.system.model.ChnlStdInfoSO;
import biz.app.system.model.ChnlStdInfoVO;
import biz.common.service.BizService;
import framework.admin.constants.AdminConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

/**
 * 채널 기준 정보 ServiceImpl
 * @author		hongjun
 * @since		2017. 2. 22.
 */
@Service
@Transactional
public class ChnlStdInfoServiceImpl implements ChnlStdInfoService {

	@Autowired
	private ChnlStdInfoDao chnlStdInfoDao;

	@Autowired
	private BizService bizService;

	@Override
	@Transactional(readOnly=true)
	public List<ChnlStdInfoVO> pageChnlStdInfo(ChnlStdInfoSO so) {
		return chnlStdInfoDao.pageChnlStdInfo(so);
	}

	@Override
	public void insertChnlStdInfo(ChnlStdInfoPO po) {
		po.setChnlId(bizService.getSequence(AdminConstants.SEQUENCE_CHNL_STD_INFO_SEQ));

		int result = chnlStdInfoDao.insertChnlStdInfo(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void updateChnlStdInfo(ChnlStdInfoPO po) {
		int result = chnlStdInfoDao.updateChnlStdInfo(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void deleteChnlStdInfo(ChnlStdInfoPO po) {
		int result = chnlStdInfoDao.deleteChnlStdInfo(po);

		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_COUPON_DELETE);
		}
	}
}
package biz.app.system.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.system.dao.DepositAcctInfoDao;
import biz.app.system.model.DepositAcctInfoPO;
import biz.app.system.model.DepositAcctInfoSO;
import biz.app.system.model.DepositAcctInfoVO;

import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.system.service
 * - 파일명		: DepositAcctInfoServiceImpl.java
 * - 작성일		: 2017. 2. 9.
 * - 작성자		: snw
 * - 설명		: 무통장 계좌 정보 서비스
 * </pre>
 */
@Service("depositAcctInfoService")
@Transactional
public class DepositAcctInfoServiceImpl implements DepositAcctInfoService {

	@Autowired
	private DepositAcctInfoDao depositAcctInfoDao;

	/**
	 * <pre>
	 * - 작성일		: 2017. 2. 9.
	 * - 작성자		: snw
	 * - 설명		: 무통장 계좌 페이징 목록 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	@Override
	@Transactional(readOnly = true)
	public List<DepositAcctInfoVO> pageDepositAcctInfo(DepositAcctInfoSO so) {
		return depositAcctInfoDao.pageDepositAcctInfo(so);
	}

	
	/**
	 * <pre>
	 * - 작성일		: 2017. 2. 9.
	 * - 작성자		: snw
	 * - 설명		: 무통장 계좌 목록 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	@Override
	public List<DepositAcctInfoVO> listDepositAcctInfo(DepositAcctInfoSO so) {
		return depositAcctInfoDao.listDepositAcctInfo(so);
	}

	
	/**
	 * <pre>
	 * - 작성일		: 2017. 2. 9.
	 * - 작성자		: snw
	 * - 설명		: 무통장 계좌 상세 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	@Override
	@Transactional(readOnly = true)
	public DepositAcctInfoVO getDepositAcctInfo(DepositAcctInfoSO so) {
		return depositAcctInfoDao.getDepositAcctInfo(so);
	}


	/**
	 * <pre>
	 * - 작성일		: 2017. 2. 9.
	 * - 작성자		: snw
	 * - 설명		: 무통장 계좌 등록
	 * </pre>
	 * 
	 * @param po
	 */
	@Override
	public void insertDepositAcctInfo(DepositAcctInfoPO po) {
		// po.setAcctInfoNo(bizService.getSequence(AdminConstants.SEQUENCE_DEPOSIT_ACCT_INFO_SEQ));
		int result = depositAcctInfoDao.insertDepositAcctInfo(po);

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	
	/**
	 * <pre>
	 * - 작성일		: 2017. 2. 9.
	 * - 작성자		: snw
	 * - 설명		: 무통장 계좌 수정
	 * </pre>
	 * 
	 * @param po
	 */
	@Override
	public void updateDepositAcctInfo(DepositAcctInfoPO po) {

		DepositAcctInfoSO so = new DepositAcctInfoSO();
		so.setAcctInfoNo(po.getAcctInfoNo());

		DepositAcctInfoVO vo = getDepositAcctInfo(so);

		if (vo == null) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_GROUP_DUPLICATION_FAIL);
		}

		int result = depositAcctInfoDao.updateDepositAcctInfo(po);

		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

	}

	
	/**
	 * <pre>
	 * - 작성일		: 2017. 2. 9.
	 * - 작성자		: snw
	 * - 설명		: 무통장 계좌 삭제
	 * </pre>
	 * 
	 * @param po
	 */
	@Override
	public void deleteDepositAcctInfo(DepositAcctInfoPO po) {

		DepositAcctInfoSO so = new DepositAcctInfoSO();
		so.setAcctInfoNo(po.getAcctInfoNo());
		DepositAcctInfoVO vo = getDepositAcctInfo(so);
		if (vo == null) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_GROUP_DUPLICATION_FAIL);
		}
		// 무통장 계좌 베이스 삭제
		int result = depositAcctInfoDao.deleteDepositAcctInfo(po);
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_COUPON_DELETE);
		}
	}
}
package biz.app.claim.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.claim.dao.ClaimDetailDao;
import biz.app.claim.dao.ClmDtlCstrtDao;
import biz.app.claim.model.ClaimDetailPO;
import biz.app.claim.model.ClaimDetailSO;
import biz.app.claim.model.ClaimDetailVO;
import biz.app.claim.model.ClaimSO;
import biz.app.claim.model.ClmDtlCstrtPO;
import biz.app.order.model.OrderBaseVO;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.service
* - 파일명		: ClaimDetailServiceImpl.java
* - 작성일		: 2017. 1. 25.
* - 작성자		: snw
* - 설명			: 클레임 상세 서비스
* </pre>
*/
@Slf4j
@Transactional
@Service("claimDetailService")
public class ClaimDetailServiceImpl implements ClaimDetailService {

	@Autowired
	private ClaimDetailDao claimDetailDao;

	@Autowired
	private ClmDtlCstrtDao clmDtlCstrtDao;
	/*
	 * 클레임 상세 목록 조회
	 * @see biz.app.claim.service.ClaimDetailService#listClaimDetail(biz.app.claim.model.ClaimDetailSO)
	 */
	@Override
	public List<ClaimDetailVO> listClaimDetail(ClaimDetailSO so) {
		return claimDetailDao.listClaimDetail(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: listClaimDetail2ndE
	 * - 작성일		: 2021. 04. 19.
	 * - 작성자		: sorce
	 * - 설명			: 클레임 상태 리스트
	 * </pre>
	 * @param claimSO
	 * @return
	 */
	public OrderBaseVO listClaimDetail2ndE(ClaimSO claimSO) {
		return claimDetailDao.listClaimDetail2ndE(claimSO);
	}
	
	/*
	 * 클레임 상세 교환신청완료 목록 조회
	 * @see biz.app.claim.service.ClaimDetailService#listClaimDetail(biz.app.claim.model.ClaimDetailSO)
	 */
	@Override
	public List<ClaimDetailVO> listClaimExchangeDetail(ClaimDetailSO so) {
		return claimDetailDao.listClaimExchangeDetail(so);
	}

	/*
	 * 클레임 상세 상태 수정
	 * @see biz.app.claim.service.ClaimDetailService#updateClaimDetailStatus(java.lang.String, java.lang.Integer, java.lang.String)
	 */
	@Override
	public void updateClaimDetailStatus(String clmNo, Integer clmDtlSeq, String clmDtlStatCd) {
		ClaimDetailPO cdpo = new ClaimDetailPO();
		cdpo.setClmNo(clmNo);
		cdpo.setClmDtlSeq(clmDtlSeq);
		cdpo.setClmDtlStatCd(clmDtlStatCd);
		int result = this.claimDetailDao.updateClaimDetailStatus(cdpo);

		if(result != 1){
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
	}
	
	/*
	 * 클레임 상세 상태 수정
	 * @see biz.app.claim.service.ClaimDetailService#updateClaimDetailStatus(java.lang.String, java.lang.Integer, java.lang.String)
	 */
	@Override
	public int updateClaimDetailStatusDlvrCplt(String clmNo, Integer clmDtlSeq, String clmDtlStatCd) {
		ClaimDetailPO cdpo = new ClaimDetailPO();
		cdpo.setClmNo(clmNo);
		cdpo.setClmDtlSeq(clmDtlSeq);
		cdpo.setClmDtlStatCd(clmDtlStatCd);
		cdpo.setClmDtlAllDlvrCpltYn("Y");
		int result = this.claimDetailDao.updateClaimDetailStatus(cdpo);
		
		return result;
	}

	 /**
	  *
	 * <pre>
	 * - 프로젝트명  : 11.business
	 * - 패키지명  	: biz.app.order.service
	 * - 파일명      	: ClaimDetailServiceImpl.java
	 * - 작성일      	: 2017. 6. 20.
	 * - 작성자      	: valuefactory hjko
	 * - 설명      	: Interface 클레임 상세 상태 수정
	 * </pre>
	  */
	@Override
	public void updateClaimDetailStatusInf(ClaimDetailPO cpo){
		// 클레임 상태 수정
		int result = this.claimDetailDao.updateClaimDetailStatus(cpo);

		if ( result == 0 ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
	}

	/*
	 * 클레임 단건 조회
	 * @see biz.app.claim.service.ClaimDetailService#getClaimDetail(biz.app.claim.model.ClaimDetailSO)
	 */
	@Override
	public ClaimDetailVO getClaimDetail(ClaimDetailSO so) {
		return claimDetailDao.getClaimDetail(so);
	}
	
	/*
	 * 클레임 상세사유 이미지 목록 조회
	 * @see biz.app.claim.service.ClaimDetailService#listClaimDetailImage(biz.app.claim.model.ClaimDetailSO)
	 */
	@Override
	public List<ClaimDetailVO> listClaimDetailImage(ClaimDetailSO so) {
		return claimDetailDao.listClaimDetailImage(so);
	}
	
	/*
	 * 클레임 상세 간략 정보
	 * @see biz.app.claim.service.ClaimDetailService#listClmDtlCstrt(biz.app.claim.model.ClmDtlCstrtPO)
	 */
	@Override
	public List<ClmDtlCstrtPO> listClmDtlCstrt(ClaimDetailSO so) {
		return clmDtlCstrtDao.listClmDtlCstrt(so);
	}

}

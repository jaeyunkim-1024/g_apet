package biz.app.claim.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.claim.dao.ClaimBaseDao;
import biz.app.claim.model.ClaimBaseSO;
import biz.app.claim.model.ClaimBaseVO;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.service
* - 파일명		: ClaimBaseServiceImpl.java
* - 작성일		: 2017. 1. 25.
* - 작성자		: snw
* - 설명			: 클레임 기본 서비스
* </pre>
*/
@Slf4j
@Transactional
@Service("claimBaseService")
public class ClaimBaseServiceImpl implements ClaimBaseService {

	@Autowired
	private ClaimBaseDao claimBaseDao;

	/*
	 * 클레임 기본 상세 조회
	 * @see biz.app.claim.service.ClaimBaseService#getClaimBase(java.lang.String)
	 */
	@Override
	public ClaimBaseVO getClaimBase(String clmNo) {
		ClaimBaseSO cbso = new ClaimBaseSO();
		cbso.setClmNo(clmNo);
		ClaimBaseVO result = claimBaseDao.getClaimBase(cbso);
		result.setExecSql(cbso.getExecSql());
		return result;
	}



}

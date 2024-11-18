package biz.app.privacy.service;

import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.privacy.dao.PrivacyDao;
import biz.app.privacy.model.PrivacyPolicyPO;
import biz.app.privacy.model.PrivacyPolicySO;
import biz.app.privacy.model.PrivacyPolicyVO;
import biz.common.dao.BizDao;
import framework.admin.constants.AdminConstants;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.privacy.service
* - 파일명		: PrivacyServiceImpl.java
* - 작성일		: 2017. 1. 16.
* - 작성자		: hongjun
* - 설명		: 개인정보처리방침 서비스
* </pre>
*/
@Slf4j
@Transactional
@Service("privacyService")
public class PrivacyServiceImpl implements PrivacyService {

	@Autowired
	private PrivacyDao privacyDao;

	@Autowired
	private BizDao bizDao;
	
	//-------------------------------------------------------------------------------------------------------------------------//
	//- Common area
	//-------------------------------------------------------------------------------------------------------------------------//
	@Override
	@Transactional(readOnly=true)
	public PrivacyPolicyVO getPrivacy(Integer policyNo) {
		PrivacyPolicySO so = new PrivacyPolicySO();
		so.setPolicyNo(policyNo);
		return privacyDao.getSt(so);
	}


	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin area
	//-------------------------------------------------------------------------------------------------------------------------//

	@Override
	public Long insertPrivacy (PrivacyPolicyPO privacyPolicyPO) {
		if(log.isDebugEnabled() ) {
			log.debug("########## : " + "insertst" );
		}
		
		Long policyNo = null;

		if(log.isDebugEnabled() ) {
			log.debug("#################### : " + "개인정보처리방침 등록" );
		}

		if(privacyPolicyPO != null ) {
			policyNo = bizDao.getSequence(AdminConstants.SEQUENCE_PRIVACY_POLICY_SEQ );
			privacyPolicyPO.setPolicyNo(policyNo);
			
			if(log.isDebugEnabled() ) {
				log.debug("########## policyNo : {}", policyNo );
			}
			
			privacyDao.insertPrivacyPolicy(privacyPolicyPO );
		}

		return policyNo;
	}


	@Override
	public PrivacyPolicyVO getPrivacyPolicy (Integer policyNo ) {
		return privacyDao.getPrivacyPolicy(policyNo );
	}

	@Override
	public PrivacyPolicyVO getNewPrivacyPolicy () {
		return privacyDao.getNewPrivacyPolicy();
	}
	
	
	@Override
	public List<PrivacyPolicyVO> pagePrivacyPolicy (PrivacyPolicySO so ) {
		return privacyDao.pagePrivacyPolicy(so );
	}


	@Override
	public Long updatePrivacyPolicy (PrivacyPolicyPO privacyPolicyPO) {
		if(log.isDebugEnabled() ) {
			log.debug("########## : " + "updatePrivacyPolicy" );
		}
		Long policyNo = privacyPolicyPO.getPolicyNo();
		if(!Objects.isNull(privacyPolicyPO)) {
			privacyDao.updatePrivacyPolicy(privacyPolicyPO );
		}

		return policyNo;
	}

}
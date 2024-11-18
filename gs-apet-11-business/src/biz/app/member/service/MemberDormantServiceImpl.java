package biz.app.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.member.dao.MemberDormantDao;
import biz.app.member.model.MemberAddressPO;
import biz.app.member.model.MemberAddressVO;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.model.MemberBizInfoPO;
import biz.app.member.model.MemberBizInfoVO;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 
 * - 패키지명		: biz.app.member.service
 * - 파일명		: MemberDormantServiceImpl.java
 * - 작성일		: 2021. 4. 9.
 * - 작성자		: 조은지
 * - 설명			: 회원 휴면 서비스 
 * </pre>
 */
@Slf4j
@Service
@Transactional(value="dormantTransactionManager")
public class MemberDormantServiceImpl implements MemberDormantService {
	@Autowired private MemberDormantDao dormantDao;
	
	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 02. 04.
	 * - 작성자		: 이지희
	 * - 설명		: 분리보관 된 휴면회원 정보 조회
	 * </pre>
	 * @param  MemberCertifiedLogPO po
	 * @return
	 */

	@Override
	public MemberBasePO selectDormantMemberBase(MemberBaseSO so) {
		return dormantDao.selectDormantMemberBase(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.2. 04.
	 * - 작성자		: 이지희
	 * - 설명			: 분리보관 된 휴면회원 정보 삭제
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public int deleteDormantMemberBase(MemberBaseSO so) {
		return dormantDao.deleteDormantMemberBase(so);
	}
	
	@Override
	public int insertDormantMemberBaseForBatch(List<MemberBasePO> listMemberBaseForDormant) {
		return dormantDao.insertDormantMemberBaseForBatch(listMemberBaseForDormant);
	}
	
	@Override
	public int insertDormantMemberBizInfoForBatch(List<MemberBizInfoPO> listMemberBizInfoForDormant) {
		return dormantDao.insertDormantMemberBizInfoForBatch(listMemberBizInfoForDormant);
	}
	
	@Override
	public int insertDormantMemberAddressForBatch(List<MemberAddressPO> listMemberAddressForDormant) {
		return dormantDao.insertDormantMemberAddressForBatch(listMemberAddressForDormant);
	}
}

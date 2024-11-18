package biz.app.member.service;

import java.util.List;

import biz.app.member.model.MemberAddressPO;
import biz.app.member.model.MemberAddressVO;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.model.MemberBizInfoPO;
import biz.app.member.model.MemberBizInfoVO;

/**
 * <pre>
 * - 프로젝트명	: 
 * - 패키지명		: biz.app.member.service
 * - 파일명		: MemberDormantService.java
 * - 작성일		: 2021. 4. 9.
 * - 작성자		: 조은지
 * - 설명			: 회원 휴면 서비스 
 * </pre>
 */
public interface MemberDormantService {
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
	public MemberBasePO selectDormantMemberBase(MemberBaseSO so);
	

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
	public int deleteDormantMemberBase(MemberBaseSO so) ;
	
	public int insertDormantMemberBaseForBatch(List<MemberBasePO> listMemberBaseForDormant);
	
	public int insertDormantMemberBizInfoForBatch(List<MemberBizInfoPO> listMemberBizInfoForDormant);
	
	public int insertDormantMemberAddressForBatch(List<MemberAddressPO> listMemberAddressForDormant);

}

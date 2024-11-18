package biz.app.member.service;

import java.util.List;

import biz.app.member.model.MemberSavedMoneyDetailPO;
import biz.app.member.model.MemberSavedMoneyPO;
import biz.app.member.model.MemberSavedMoneySO;
import biz.app.member.model.MemberSavedMoneyVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.member.service
* - 파일명		: MemberSavedMoneyService.java
* - 작성일		: 2017. 2. 1.
* - 작성자		: snw
* - 설명			: 회원 적립금 서비스 Interface
* </pre>
*/
public interface MemberSavedMoneyService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberSavedMoneyService.java
	* - 작성일		: 2017. 4. 11.
	* - 작성자		: snw
	* - 설명			: 회원 적립금 상세 조회
	* </pre>
	* @param so
	* @return
	*/
	public MemberSavedMoneyVO getMemberSavedMoney(MemberSavedMoneySO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberSavedMoneyService.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 회원 적립금 등록
	*                    - 회원 기본 잔여 적립금 수정 포함
	*                    - 적립 시 사용
	* </pre>
	* @param po
	*/
	public void insertMemberSavedMoney(MemberSavedMoneyPO po);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberSavedMoneyService.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 회원 적립금 등록 (Multi)
	* </pre>
	* @param po
	*/
	public void insertMemberSavedMoneyList(Long[] arrMbrNo, MemberSavedMoneyPO po);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberSavedMoneyService.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 회원 적립금 내역 등록
	*                    - 사유코드에 따른 회원 적립금 복원 및 차감
	*                    - 회원 기본 잔여 적립금 수정 포함
	* </pre>
	* @param po
	* @return
	*/
	public int insertMemberSavedMoneyDetail(MemberSavedMoneyDetailPO po);
	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberSavedMoneyService.java
	* - 작성일		: 2017. 2. 2.
	* - 작성자		: snw
	* - 설명			: 회원의 사용가능한 적립금 목록 조회
	*                    지정된 금액만큼에 만족하는 목록
	* </pre>
	* @param mbrNo
	* @param saveAmt
	* @return
	*/
	public List<MemberSavedMoneyVO> listMemberSavedMoneyUsedPossible(Long mbrNo, Long saveAmt);	
	
}
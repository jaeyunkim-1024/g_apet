package biz.app.member.service;

import biz.app.contents.model.ContentsReplySO;
import biz.app.contents.model.ContentsReplyVO;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.login.model.SnsMemberInfoPO;
import biz.app.login.model.SnsMemberInfoSO;
import biz.app.login.model.SnsMemberInfoVO;
import biz.app.member.model.*;
import biz.app.pay.model.PrsnCardBillingInfoPO;
import biz.app.pay.model.PrsnCardBillingInfoVO;
import biz.app.pay.model.PrsnPaySaveInfoVO;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.model.TagBaseVO;
import biz.interfaces.sktmp.model.SktmpCardInfoVO;
import framework.front.model.Session;

import java.util.List;
import java.util.Map;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.member.service
* - 파일명		: MemberService.java
* - 작성일		: 2017. 2. 1.
* - 작성자		: snw
* - 설명			: 회원 서비스 Interface
* </pre>
*/
public interface MemberService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 사이트별 회원 인증코드 중복 체크
	* 					 true:중복됨, false:중복되지 않음
	* </pre>
	* @param stId Long
	* @param ctfCd String
	* @return
	*/
	public boolean getMemberCertifyCdDuplicate(Long stId, String ctfCd);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 사이트별 회원 로그인 아이디 중복 체크
	* 					 true:중복됨, false:중복되지 않음
	* </pre>
	* @param stId Long
	* @param loginId String
	* @return
	*/
	public boolean getMemberLoginIdDuplicate(Long stId, String loginId);

	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 1. 26.
	 * - 작성자		: 이지희
	 * - 설명			: 사이트별 회원 닉네임/이메일/핸드폰 중복 체크
	 * 					 true:중복됨, false:중복되지 않음
	 * </pre>
	 * @param so MemberBaseSO
	 * @return
	 */
	public boolean getMemberLoginDuplicate(MemberBaseSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2021. 1. 27.
	* - 작성자		: 이지희
	* - 설명			: 회원 신규 등록
	* </pre>
	* @param po MemberBasePO
	* @param apo MemberAddressPO
	* @param joinPathCd String
	 * @return MemberBasePO
	*/
	public MemberBasePO insertMember(MemberBasePO po, MemberAddressPO apo, String joinPathCd);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2021. 2. 8.
	* - 작성자		: 이지희
	* - 설명			: 회원 비밀번호 수정
	* </pre>
	* @param mbrNo Long
	* @param newPswd String
	*/
	public void updateMemberPassword(Long mbrNo, String newPswd);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 회원 비밀번호 초기화
	* </pre>
	* @param mbrNo Long
	* @param sendMensCd String
	* @return
	*/
	public void updateMemberPasswordInit(Long mbrNo, String sendMensCd);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 회원 기본 정보 수정
	* </pre>
	* @param po MemberBasePO
	*/
	public void updateMemberBase(MemberBasePO po);

	public void updateMemberStatCd(MemberBasePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 
	 * - 작성자		: 
	 * - 설명			: 정보성 / 마케팅 수신 동의 변경
	 * </pre>
	 * @param po MemberBasePO
	 */
	public String updateMemberRcvYn(MemberBasePO po);
	

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2017. 2. 21.
	* - 작성자		: snw
	* - 설명			: 회원 적립금 율 조회
	* </pre>
	* @param mbrNo Long
	* @return
	*/
	public Double getMemberSaveMoneyRate(Long mbrNo);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 회원 비밀번호 동일여부 체크
	*             true:동일함, false:비밀번호오류
	* </pre>
	* @param mbrNo Long
	* @param pswd String
	* @return
	* @throws Exception
	*/
	boolean checkMemberPassword(Long mbrNo, String pswd);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2016. 4. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 회원 페이지 목록
	 * </pre>
	 * @param so MemberBaseSO
	 * @return
	 */
	public List<MemberBaseVO> pageMemberBase(MemberBaseSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2016. 4. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 회원 상세 검색
	 * </pre>
	 * @param so MemberBaseSO
	 * @return
	 */
	public List<MemberBaseVO> listMemberGrid(MemberBaseSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2017. 1. 26.
	* - 작성자		: snw
	* - 설명			: 회원 간단 조회
	* </pre>
	* @param so MemberBaseSO
	* @return
	*/
	public MemberBaseVO getMemberBaseInShort(MemberBaseSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2017. 1. 26.
	* - 작성자		: snw
	* - 설명			: 회원 조회 - FO
	* </pre>
	* @param so MemberBaseSO
	* @return
	*/
	public MemberBaseVO getMemberBase(MemberBaseSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2017. 1. 26.
	* - 작성자		: snw
	* - 설명			: 회원 조회 - BO
	* </pre>
	* @param so MemberBaseSO
	* @return
	*/
	public MemberBaseVO getMemberBaseBO(MemberBaseSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 회원 주소 목록
	 * </pre>
	 * @param so MemberAddressSO
	 * @return
	 */
	public List<MemberAddressVO> listMemberAddress(MemberAddressSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 회원 주소 상세
	 * </pre>
	 * @param so MemberAddressSO
	 * @return
	 */
	public MemberAddressVO getMemberAddress(MemberAddressSO so);



	public void updateMemberHumanCancellation(MemberBasePO po);

	public void updateMemberMbrGrdCd(MemberBasePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 회원 주소 등록 / 수정
	 * </pre>
	 * @param po MemberAddressPO
	 */
	public void saveMemberAddress(MemberAddressPO po);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MemberService.java
	* - 작성일	: 2016. 5. 18.
	* - 작성자	: jangjy
	* - 설명		: 탈퇴 금지 조건 체크
	* </pre>
	* @param mbrNo Long
	* @return
	*/
	public String checkMemberLeave(Long mbrNo);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MemberService.java
	* - 작성일	: 2016. 5. 18.
	* - 작성자	: jangjy
	* - 설명		: 회원의 탈퇴 처리
	* </pre>
	* @param po MemberBasePO
	*/
	public void deleteMember(MemberBasePO po);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MemberService.java
	* - 작성일	: 2016. 5. 24.
	* - 작성자	: jangjy
	* - 설명		: 회원의 적립금 이력 조회
	* </pre>
	* @param so MemberSavedMoneySO
	* @return
	*/
	public List<MemberSavedMoneyVO> pageMemberSavedMoneyHist(MemberSavedMoneySO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MemberService.java
	* - 작성일	: 2016. 5. 24.
	* - 작성자	: jangjy
	* - 설명		: 회원의 1개월 이내의 소멸예정 적립금 취득
	* </pre>
	* @param mbrNo Long
	* @return
	*/
	public Long getLostExpectedMemberSavedMoney(Long mbrNo);

	public List<MemberSavedMoneyVO> pageMemberSavedMoney(MemberSavedMoneySO so);




	public List<MemberSavedMoneyDetailVO> listMemberSavedMoneyDetail(MemberSavedMoneyDetailSO so);






	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MemberService.java
	* - 작성일	: 2016. 7. 13.
	* - 작성자	: jangjy
	* - 설명		: 회원의 본인인증 정보 갱신
	* </pre>
	* @param po MemberBasePO
	*/
	void updateMemberCertification(MemberBasePO po);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2016. 8. 5.
	* - 작성자		: snw
	* - 설명		: 미사용 회원 휴면처리 대상 목록
	* </pre>
	* @return
	*/
	List<MemberBaseVO> listMemberBaseNoUseTart(Integer period);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2016. 9. 27.
	* - 작성자		: hjko
	* - 설명		:  관리자가 회원 적립금 차감
	* </pre>
	* @return
	*/
	public void memberSavedMoneyRemove(MemberSavedMoneyPO po) ;

	public MemberMainVO getMemberMain() ;

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2017. 3. 7.
	* - 작성자		: hjko
	* - 설명		: 마이페이지 > 적립금목록
	* </pre>
	* @param so
	* @return
	 */
	public List<MemberSavedMoneyVO> listMemberSavedMoneyHist(MemberSavedMoneySO so);

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2017. 3. 15.
	* - 작성자		: hjko
	* - 설명		:  회원 환불 예정 금액
	* </pre>
	* @param so
	* @return
	 */
	public Long getMemberRefundSchdAmt(MemberBaseSO so);

	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.member.service
	* - 파일명      : MemberService.java
	* - 작성일      : 2017. 4. 25.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 사용자 이력 히스토리  
	* </pre>
	 */
	public List<MemberBaseVO> listMemberBaseHistory(MemberBaseSO so);
	
	
	public void insertMemberBaseHistory(Long mbrNo );
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2017. 5. 22.
	* - 작성자		: Administrator
	* - 설명			: 회원번호 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<Long> listMemberBaseNo(MemberBaseSO so);
	
	
	public void memberPasswordUpdate(MemberBasePO po);
	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2017. 1. 26.
	* - 작성자		: snw
	* - 설명			: 탈퇴 회원 상세 조회
	* </pre>
	* @param so MemberBaseSO
	* @return
	*/
	public MemberBaseVO getLeaveMemberBase(MemberBaseSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2016. 8. 5.
	* - 작성자		: snw
	* - 설명		: 휴면회원 복원
	* </pre>
	* @param mbrNo Long
	*/
	void saveMemberUse(Long mbrNo);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2021. 02. 01.
	* - 작성자		: 이지희
	* - 설명		:  본인인증코드로 멤버번호 조회
	* </pre>
	* @param ctfCd String
	*/
	public Long getMbrNo(String ctfCd);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2020.12.29
	 * - 작성자		: kjy
	 * - 설명		:  MDN 변경이력
	 * </pre>
	 * @param so MemberBaseSO
	 */
	public List<MemberBaseVO> listMemberMdnChangeHistory(MemberBaseSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2020.12.29
	 * - 작성자		: kjy
	 * - 설명		:  개인정보 마스킹
	 * </pre>
	 * @param vo MemberBaseVO
	 */
	public MemberBaseVO maskingMemberInfo(MemberBaseVO vo);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2020.12.29
	 * - 작성자		: kjy
	 * - 설명		:  회원 댓글 리스트
	 * </pre>
	 * @param so ContentsReplySO
	 */
	public List<ContentsReplyVO> listMemberReply(ContentsReplySO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2020.12.29
	 * - 작성자		: kjy
	 * - 설명		:  반려동물 정보 ( ex : 강아지(3) , 고양이(2) )
	 * </pre>
	 * @param mbrNo Long
	 */
	public String getMemberPetSimpleStrInfo(Long mbrNo);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2020.12.29
	 * - 작성자		: kjy
	 * - 설명		:  관심 태그 ( ex 강아지 , 고양이 )
	 * </pre>
	 * @param mbrNo Long
	 */
	public String getMemberTagStrInfo(Long mbrNo);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2020.12.29
	 * - 작성자		: kjy
	 * - 설명		:  해당 회원 추천 받음/추천 한 리스트
	 * </pre>
	 * @param so MemberBaseSO
	 */
	public List<MemberBaseVO> listRecommandedList(MemberBaseSO so);

	public List<MemberBaseVO> listRecommandingList(MemberBaseSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 01. 07.
	 * - 작성자		: 이지희
	 * - 설명		: 회원목록(팝업)-최신결제일자 순
	 * </pre>
	 * @param so MemberBaseSO
	 */
	public List<MemberBaseVO> listPopupMemberBase(MemberBaseSO so );
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 01. 15.
	 * - 작성자		: 이지희
	 * - 설명		: sns로그인 시 기존 등록된 sns회원인지 체크
	 * </pre>
	 * @param so SnsMemberInfoSO
	 */
	public MemberBaseVO getExistingSnsMemberCheck(SnsMemberInfoSO so );
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 01. 15.
	 * - 작성자		: 이지희
	 * - 설명		: 회원가입 시 기존 회원인가 체크(SnsMemberInfoSO)
	 * </pre>
	 * @param so SnsMemberInfoSO
	 */
	public MemberBaseVO getExistingMemberCheck(SnsMemberInfoSO so );

	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2021. 1. 19.
	* - 작성자		: 이지희
	* - 설명			: 회원가입 시 핸드폰 번호 같은 기존회원 체크
	* </pre>
	* @param mobile String
	* @param mbrNo Long
	* @return
	*/
	public int checkMbrNoFromMobile(String mobile, Long mbrNo);

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 1. 19.
	 * - 작성자		: 이지희
	 * - 설명			: 회원가입 시 핸드폰 번호 같은 기존회원 체크
	 * </pre>
	 * @param so MemberBaseSO
	 * @return
	 */
	public String checkRcomLoginId(MemberBaseSO so);

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 1. 20.
	 * - 작성자		: 이지희
	 * - 설명			: sns 계정 정보 등록
	 * </pre>
	 * @param so
	 * @return
	 */
	public int insertSnsMemberInfo(SnsMemberInfoSO so);

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 2. 23.
	 * - 작성자		: 김재윤
	 * - 설명			: sns 계정 정보 삭제
	 * </pre>
	 * @param po SnsMemberInfoPO
	 * @return
	 */
	public int deleteSnsMemberInfo(SnsMemberInfoPO po);

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 2. 23.
	 * - 작성자		: 김재윤
	 * - 설명			: sns 계정 있으면 update, 없으면 INSERT
	 * </pre>
	 * @param po SnsMemberInfoPO
	 * @return
	 */
	public void upSertSnsMemberInfo(SnsMemberInfoPO po);

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 1. 21.
	 * - 작성자		: 김재윤
	 * - 설명			: 회원 검색 - 회원 주문 정보
	 * </pre>
	 * @param so
	 * @return
	 */
	public Map<Long,MemberBaseVO> listMemberOrderInfo(MemberBaseSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 1. 27.
	 * - 작성자		: 이지희
	 * - 설명			: 회원가입 시 태그정보 매핑
	 * </pre>
	 * @param list List<MbrTagMapPO>
	 * @return
	 */
	public int insertMbrTagMap(List<MbrTagMapPO> list);

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 02. 03.
	 * - 작성자		: 이지희
	 * - 설명		: 회원 인증 이력 저장
	 * </pre>
	 * @param  po MemberCertifiedLogPO
	 * @return
	 */
	public int insertCertifiedLog(MemberCertifiedLogPO po);


	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.2. 05.
	 * - 작성자		: 김재윤
	 * - 설명			: Tag 팔로우 리스트 가져오기
	 * </pre>
	 * @param so TagBaseSO
	 * @return
	 */
	public List<TagBaseVO> listMemberTagFollow(TagBaseSO so);
	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2021.02.08.
	* - 작성자		: 이지희
	* - 설명			: 비번 변경 시 그 전 비번과 비교 위해 조회
	* </pre>
	* @param mbrNo String
	* @return
	*/
	public List<String> listBeforePswd(String mbrNo);

	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2021.02.08.
	* - 작성자		: 김재윤
	* - 설명			: 재입고 알림
	* </pre>
	* @param so GoodsBaseSO
	* @return
	*/
	public List<GoodsBaseVO> listMemberGoodsIoList(GoodsBaseSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021. 02. 05.
	 * - 작성자		: 김재윤
	 * - 설명			: 회원 관리 - 회원 상세 검색 - 신고된 내역
	 * </pre>
	 * @param so MemberBaseSO
	 * @return
	 */
	public List<ContentsReplyVO> listMemberReportList(MemberBaseSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.02.09.
	 * - 작성자		: 이지희
	 * - 설명			: 회원 GSR연동 정보 업데이트
	 * </pre>
	 * @param po MemberBasePO
	 * @return
	 */
	public int updateMemberBaseGspt(MemberBasePO po);
	
	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.02.16.
	 * - 작성자		: 이지희
	 * - 설명			: 회원 등급 로그 저장
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertMemberGrade(MemberBasePO po);



	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.02.16.
	 * - 작성자		: 김재윤
	 * - 설명			: 회원 정보 암호화
	 * </pre>
	 * @param so MemberBaseSO
	 * @return
	 */
	public MemberBaseSO encryptMemberBase(MemberBaseSO so);
	public MemberBasePO encryptMemberBase(MemberBasePO po);

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.02.16.
	 * - 작성자		: 김재윤
	 * - 설명			: 회원 정보 복호화
	 * </pre>
	 * @param vo MemberBaseVO
	 * @return
	 */
	public MemberBaseVO decryptMemberBase(MemberBaseVO vo);

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.02.25.
	 * - 작성자		: 김재윤
	 * - 설명			: 회원 정보 검색 및 복호화 결과 가져오기
	 * </pre>
	 * @param so MemberBaseSO
	 * @return
	 */
	public MemberBaseVO decryptMemberBase(MemberBaseSO so);

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.02.18.
	 * - 작성자		: 김재윤
	 * - 설명			: 소셜 로그인 연동 여부
	 * </pre>
	 * @param mbrNo Long
	 * @return
	 */
	public Map<String, SnsMemberInfoVO> getMemberSnsLoginYn(Long mbrNo);

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.02.22.
	 * - 작성자		: 김재윤
	 * - 설명			: 내 정보 관리 - 회원 정보 UPDATE
	 * </pre>
	 * @param po MemberBasePO
	 * @param memberTags String[]
	 * @return
	 */
	public MemberBaseVO updateMemberInfo(MemberBasePO po,String[] memberTags);
	
	public List<MemberBaseVO> selectPetsbeMig();
	public void updatePetsbeMig(List<MemberBaseVO> list);

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.03.06.
	 * - 작성자		: 김재윤
	 * - 설명			: 내 정보 관리 - 나를 팔로워 한 사람들
	 * </pre>
	 * @param so MemberBaseSO
	 * @return
	 */
	public List<MemberBaseVO> listFollowerMe(MemberBaseSO so);

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.03.06.
	 * - 작성자		: 김재윤
	 * - 설명			: 내 정보 관리 - 내가 팔로잉 한 사람들
	 * </pre>
	 * @param so MemberBaseSO
	 * @return
	 */
	public List<MemberBaseVO> listImFollowing(MemberBaseSO so);

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.03.06.
	 * - 작성자		: 김재윤
	 * - 설명			: 080 수신 거부 및 마케팅 수신 여부 변경
	 * </pre>
	 * @param po MemberBasePO
	 * @return
	 */
	public MemberUnsubscribeVO updateMemberMarketingAgree(MemberBasePO po);
	public MemberUnsubscribeVO updateMemberMarketingAgree(String mkngRcvYn,String mobile,String chgActrCd);
	public MemberUnsubscribeVO updateMemberMarketingAgree(String mkngRcvYn,String[] mobileArr,String chgActrCd);

	public int updateAlmRcvYn(MemberBaseVO vo);

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.03.08.
	 * - 작성자		: KSH
	 * - 설명			: 닉네임 자동완성 검색
	 * </pre>
	 * @param nickNm String
	 * @return
	 */
	public List<MemberBaseVO> getNickNameList(String nickNm);
	
	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.03.12.
	 * - 작성자		: hjh
	 * - 설명			: 닉네임 자동완성 검색
	 * </pre>
	 * @param nickNm String
	 * @return
	 */
	public MemberBaseVO getMentionInfo(String nickNm);
	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2021. 03. 09.
	* - 작성자		: KKB
	* - 설명		: 회원 검색어 등록
	* </pre>
	* @param po MemberSearchWordPO
	* @return int
	*/
	public int insertMemberSearchWord(MemberSearchWordPO po);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2021. 03. 09.
	* - 작성자		: KKB
	* - 설명		: 회원 검색어 리스트
	* </pre>
	* @param so MemberSearchWordSO
	* @return List<MemberSearchWordVO>
	*/
	public List<MemberSearchWordVO> listMemberSearchWord(MemberSearchWordSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberService.java
	* - 작성일		: 2021. 03. 09.
	* - 작성자		: KKB
	* - 설명		: 회원 검색어 삭제
	* </pre>
	* @param po MemberSearchWordPO
	* @return int
	*/
	public int deleteMemberSearchWord(MemberSearchWordPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021.03.10
	 * - 작성자		: 이지희
	 * - 설명			: 내 정보 관리 > 비밀번호 존재 유무 확인
	 * </pre>
	 * @param mbrNo Long
	 * @return
	 */
	public String isPswdForUpdate(Long mbrNo);
	

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.03.10
	 * - 작성자		: valfac
	 * - 설명		: 개인결제정보
	 * </pre>
	 * @param mbrNo Long
	 */
	public PrsnPaySaveInfoVO getMemberPaySaveInfo(Long mbrNo);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.03.10
	 * - 작성자		: valfac
	 * - 설명		: 개인간편결제수단
	 * </pre>
	 * @param mbrNo Long
	 */
	public PrsnCardBillingInfoVO getMemberCardBillInfo(Long mbrNo);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.03.10
	 * - 작성자		: valfac
	 * - 설명		: 회원 기본 정보 수정
	 * </pre>
	 * @param po
	 */
	//public void updateMemberPaySaveInfo(PrsnPaySaveInfoPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.03.10
	 * - 작성자		: valfac
	 * - 설명		: 회원 기본 정보 수정
	 * </pre>
	 * @param po
	 */
	//public void updateMemberCardBillInfo(PrsnCardBillingInfoPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.03.16
	 * - 작성자		: 김재윤
	 * - 설명		: 회원 간편 카드 결제 정보
	 * </pre>
	 * @param so
	 */
	public List<PrsnCardBillingInfoVO> listMemberCardBillingInfo(MemberBaseSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021.08.06
	 * - 작성자		: hjh
	 * - 설명		: 회원 우주멤버십 카드 정보
	 * </pre>
	 * @param so
	 */
	public List<SktmpCardInfoVO> listMemberSktmpCardInfo(MemberBaseSO so);

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021.03.25
	 * - 작성자		: 김재윤
	 * - 설명			: 닉네임 -> jsp에서 중복 위해 가져오는 해당 회원 제외 닉네임..
	 * </pre>
	 * @param so
	 * @return
	 */
	public String getMemberBaseNickNmInJoin(MemberBaseSO so);

	public void updateRcomUrl(MemberBasePO po);
	
	public int updateMemberBaseTermsYn(MemberBasePO po);
	
	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021.04.01
	 * - 작성자		: 이지희
	 * - 설명			: 태그 화면에서 태그정보 더블체크
	 * </pre>
	 * @param mbrNo
	 * @return
	 */
	public Integer getTagCntMember(Long mbrNo) ;

	public PrsnCardBillingInfoVO getBillCardInfo(PrsnCardBillingInfoPO pcbipo);

	public void sendCertLms(Long mbrNo,String mobile,String ctfKey);

	public MemberBaseVO checkIsAlreadyCertification(MemberBaseSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021.04.21
	 * - 작성자		: 이지희
	 * - 설명			: 회원 로그인 이력 조회
	 * </pre>
	 * @param mbrNo
	 * @return
	 */
	public MemberLoginHistVO selectLoginHistory(Long mbrNo);
	
	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021.04.22
	 * - 작성자		: 이지희
	 * - 설명			: 회원 세션 업데이트 & 체크
	 * </pre>
	 * @param session
	 * @param deviceToken
	 * @param deviceTpcd
	 * @return
	 */
	public String updateMemberSession(Session session, String deviceToken, String deviceTpcd);

	public void sendMarketingYnSms(Long mbrNo,String mobile,String mkngRcvYn);

	public void deletePrsnSavePayInfo(Long mbrNo);

	public int getDuplicateChcekWhenBlur(MemberBaseSO so);
	
	public int emailUpdate(MemberBasePO po);
	
	public List<MemberBaseVO> memberPhoneList(MemberBaseSO so);

	public int memberExistenceCheck(MemberBaseVO vo);
}
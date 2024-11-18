package biz.app.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import biz.app.login.model.SnsMemberInfoPO;
import biz.app.member.model.*;
import biz.app.pet.model.PetBaseSO;
import framework.common.model.NaverApiVO;
import org.springframework.stereotype.Repository;

import biz.app.login.model.SnsMemberInfoSO;
import framework.common.constants.CommonConstants;
import framework.common.dao.MainAbstractDao;
import framework.common.util.StringUtil;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.member.dao
* - 파일명		: MemberBaseDao.java
* - 작성일		: 2017. 2. 1.
* - 작성자		: snw
* - 설명			: 회원 기본 DAO
* </pre>
*/
@Repository
public class MemberBaseDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "memberBase.";

	public List<Long> listMemberBaseNo(MemberBaseSO so){
		if(!StringUtil.isBlank(so.getMobile())){
			so.setMobile(so.getMobile().replaceAll("-", ""));
		}
		if(!StringUtil.isBlank(so.getTel())){
			so.setTel(so.getTel().replaceAll("-", ""));
		}
		return selectList(BASE_DAO_PACKAGE + "listMemberBaseNo", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberBaseDao.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 회원 기본 잔여 적립금 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateMemberBaseSavedMoney(MemberBasePO po) {
		return update(BASE_DAO_PACKAGE + "updateMemberBaseSavedMoney", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberBaseDao.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 사이트별 회원 수 조회
	* </pre>
	* @param so
	* @return
	*/
	public Integer getMemberBaseCnt(MemberBaseSO so){
		return selectOne(BASE_DAO_PACKAGE + "getMemberBaseCnt", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021. 4. 22
	 * - 작성자		: leejh
	 * - 설명			: 회원 컬럼 중복체크
	 * </pre>
	 * @param so
	 * @return
	 */
	public String getMemberBaseCheckStr(MemberBaseSO so){
		return selectOne(BASE_DAO_PACKAGE + "getMemberBaseCheckStr", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberBaseDao.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 회원 등록(신규)
	* </pre>
	* @param po
	* @return
	*/
	public int insertMemberBase(MemberBasePO po) {
		//회원 정보 정제
		po.setInfoRcvYn(Optional.ofNullable(po.getInfoRcvYn()).orElseGet(()->CommonConstants.COMM_YN_Y));
		po.setMkngRcvYn(Optional.ofNullable(po.getMkngRcvYn()).orElseGet(()->CommonConstants.COMM_YN_N));
		po.setTel(Optional.ofNullable(po.getTel()).orElseGet(()->"").replaceAll("-",""));
		po.setMobile(Optional.ofNullable(po.getMobile()).orElseGet(()->"").replaceAll("-",""));
		return insert(BASE_DAO_PACKAGE + "insertMemberBase", po);
	}	

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 
	 * - 작성자		: 
	 * - 설명			: 회원등급이력 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertMemberGrade(MemberBasePO po) {
		return insert(BASE_DAO_PACKAGE + "insertMemberGrade", po);
	}	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberBaseDao.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 회원 비밀번호 변경
	* </pre>
	* @param po
	* @return
	*/
	public int updateMemberBasePassword(MemberBasePO po) {
		return update(BASE_DAO_PACKAGE + "updateMemberBasePassword", po);
	}	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberDao.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 회원 정보 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateMemberBase(MemberBasePO po) {
		return update(BASE_DAO_PACKAGE + "updateMemberBase", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberBaseDao.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 회원 상세 조회
	* </pre>
	* @param so
	* @return
	*/
	public MemberBaseVO getMemberBase(MemberBaseSO so) {
		if(StringUtil.isNotEmpty(Optional.ofNullable(so.getMobile()).orElseGet(()->""))){
			so.setMobile(so.getMobile().replaceAll("-",""));
		}
		return selectOne(BASE_DAO_PACKAGE + "getMemberBase", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberBaseDao.java
	* - 작성일		: 2017. 2. 21.
	* - 작성자		: snw
	* - 설명			: 회원 적립율 조회
	* </pre>
	* @param mbrNo
	* @return
	*/
	public Double getMemberSaveMoneyRate(Long mbrNo){
		return selectOne(BASE_DAO_PACKAGE + "getMemberSaveMoneyRate", mbrNo);
	}	

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2017. 2. 21.
	 * - 작성자		: snw
	 * - 설명			: 최종 로그인 일시 업데이트
	 * </pre>
	 * @param mbrNo
	 * @return
	 */
	public int updateMemberBaseLastLoginDtm(MemberBasePO muo){
		return update(BASE_DAO_PACKAGE + "updateMemberBaseLastLoginDtm", muo);
	}	

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021. 02. 08.
	 * - 작성자		: 김재윤
	 * - 설명			: 정보성/마케팅 수신 여부 변경
	 * </pre>
	 * @param mbrNo
	 * @return
	 */
	public int updateMemberRcvYn(MemberBasePO po){
		return update(BASE_DAO_PACKAGE + "updateMemberRcvYn", po);
	}	
	
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.member.dao
	* - 파일명      : MemberBaseDao.java
	* - 작성일      : 2017. 4. 25.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 사용자 이력 등록 
	* </pre>
	 */
	public int insertMemberBaseHistory(MemberBasePO po) {
		return insert(BASE_DAO_PACKAGE + "insertMemberBaseHistory", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: MemberBaseDao.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: snw
	* - 설명			: 탈퇴 회원 상세 조회
	* </pre>
	* @param so
	* @return
	*/
	public MemberBaseVO getLeaveMemberBase(MemberBaseSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getLeaveMemberBase", so);
	}

	public List<MemberBaseVO> listMemberMdnChangeHistory(MemberBaseSO so){
		return selectListPage(BASE_DAO_PACKAGE+"listMemberMdnChangeHistory",so);
	}

	public List<MemberBaseVO> listRecommandedList(MemberBaseSO so){
		return selectListPage(BASE_DAO_PACKAGE+"listRecommandedList",so);
	}

	public List<MemberBaseVO> listRecommandingList(MemberBaseSO so){
		return selectListPage(BASE_DAO_PACKAGE+"listRecommandingList",so);
	}
	
	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: MemberBaseDao.java
	* - 작성일		: 2021. 1. 19.
	* - 작성자		: 이지희
	* - 설명			: 회원가입 시 핸드폰 번호 or 로그인아디 일치하는 기존회원번호 리턴
	* </pre>
	* @param so
	* @return
	*/
	public List<Long> getMbrNoFromMemberInfo(MemberBaseSO so) {
		return selectList(BASE_DAO_PACKAGE + "getMbrNoFromMemberInfo", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021. 1. 19.
	 * - 작성자		: 이지희
	 * - 설명			: 회원가입 시 약관 이력 등록
	 * </pre>
	 * @param list
	 * @return
	 */
	public Integer insertTermsRcvHistory(List<TermsRcvHistoryPO> list) {
		return insert(BASE_DAO_PACKAGE + "insertTermsRcvHistory", list);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021. 1. 20.
	 * - 작성자		: 이지희
	 * - 설명			: sns 로그인 정보 등록
	 * </pre>
	 * @param so
	 * @return
	 */
	public Integer insertSnsMemberInfo(SnsMemberInfoSO so) {
		return insert(BASE_DAO_PACKAGE + "insertSnsMemberInfo", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021. 2. 23.
	 * - 작성자		: 김재윤
	 * - 설명			: sns 정보 삭제
	 * </pre>
	 * @param so
	 * @return
	 */
	public int deleteSnsMemberInfo(SnsMemberInfoPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteSnsMemberInfo", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberDao.java
	 * - 작성일		: 2021. 04. 22.
	 * - 작성자		: 김재윤
	 * - 설명			: sns 계정 있으면 update, 없으면 INSERT
	 * </pre>
	 * @param so
	 * @return
	 */
	public void upSertSnsMemberInfo(SnsMemberInfoPO po){
		insert(BASE_DAO_PACKAGE + "upSertSnsMemberInfo",po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberDao.java
	 * - 작성일		: 2021. 01. 15.
	 * - 작성자		: 이지희
	 * - 설명		: 회원가입 시 기존 회원인지 체크
	 * </pre>
	 * @param so
	 */
	public MemberBaseVO getExistingMemberCheck(SnsMemberInfoSO so ){
		return selectOne(BASE_DAO_PACKAGE + "getExistingMemberCheck", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberDao.java
	 * - 작성일		: 2021. 01. 27.
	 * - 작성자		: 이지희
	 * - 설명		: 회원가입 시 태그정보 매핑
	 * </pre>
	 * @param MbrTagMapPo List
	 */
	public int insertMbrTagMap(List<MbrTagMapPO> list ){
		return insert(BASE_DAO_PACKAGE + "insertMbrTagMap", list);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberDao.java
	 * - 작성일		: 2021. 02. 22.
	 * - 작성자		: 김재윤
	 * - 설명		: 회원정보 수정 시 태그정보 삭제
	 * </pre>
	 * @param MbrTagMapPo List
	 */
	public int deleteMbrTagMap(Long mbrNo){
		return delete(BASE_DAO_PACKAGE + "deleteMbrTagMap", mbrNo);
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberDao.java
	 * - 작성일		: 2021. 01. 28.
	 * - 작성자		: 이지희
	 * - 설명		: 회원 비밀번호 이력 저장
	 * </pre>
	 * @param MemberBasePO po
	 */
	public int insertMemberPswdHist(MemberBasePO po ){
		return insert(BASE_DAO_PACKAGE + "insertMemberPswdHist", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberDao.java
	 * - 작성일		: 2021. 02. 03.
	 * - 작성자		: 이지희
	 * - 설명		: 회원 인증 이력 저장
	 * </pre>
	 * @param MemberCertifiedLogPO po
	 */
	public int insertCertifiedLog(MemberCertifiedLogPO po ){
		return insert(BASE_DAO_PACKAGE + "insertCertifiedLog", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberDao.java
	 * - 작성일		: 2021. 02. 03.
	 * - 작성자		: 이지희
	 * - 설명		: 회원 인증 이력 회원번호 저장
	 * </pre>
	 * @param MemberCertifiedLogPO po
	 */
	public int updateCertifiedLogMbrNo(MemberCertifiedLogPO po ){
		return update(BASE_DAO_PACKAGE + "updateCertifiedLogMbrNo", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberDao.java
	 * - 작성일		: 2021. 02. 08.
	 * - 작성자		: 이지희
	 * - 설명		: 회원 인증 이력 삭제(회원아닌경우)
	 * </pre>
	 * @param MemberCertifiedLogPO po
	 */
	public int deleteCertifiedLogNotMem(MemberCertifiedLogPO po ){
		return delete(BASE_DAO_PACKAGE + "deleteCertifiedLogNotMem", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명		: 11.business
	* - 파일명		: MemberBaseDao.java
	* - 작성일		: 2021.02.08.
	* - 작성자		: 이지희
	* - 설명			: 비번 변경 시 그 전 비번과 비교 위해 조회
	* </pre>
	* @param mbrNo
	* @return
	*/
	public List<String> listBeforePswd(String mbrNo) {
		return selectList(BASE_DAO_PACKAGE + "listBeforePswd", mbrNo);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021.02.09.
	 * - 작성자		: 이지희
	 * - 설명			: 회원 GSR연동 정보 업데이트
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateMemberBaseGspt(MemberBasePO po) {
		return update(BASE_DAO_PACKAGE + "updateMemberBaseGspt", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021.02.18
	 * - 작성자		: 이지희
	 * - 설명			: 회원가입 시 추천인 아디에 해당하는 추천인 코드 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public String getRcomURLFromMemberInfo(MemberBaseSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getRcomURLFromMemberInfo", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021.04.13
	 * - 작성자		: kek01
	 * - 설명		: 추천인 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public Long getRecommanderInfo(MemberBaseSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getRecommanderInfo", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021.02.22
	 * - 작성자		: 김재윤
	 * - 설명			: 내 정보 관리 - 수정 시, 중복 유효성 확인
	 * </pre>
	 * @param so
	 * @return
	 */
	public Map<String,Long> validateCheckMemberInfoWhenUpdate(MemberBasePO po){
		return selectOne(BASE_DAO_PACKAGE + "validateCheckMemberInfoWhenUpdate", po);
	}
	
	
	public List<MemberBaseVO> selectPetsbeMig() {
		return selectList(BASE_DAO_PACKAGE + "selectPetsbeMig");
	}
	public void updatePetsbeMig(List<MemberBaseVO> list) {
		update(BASE_DAO_PACKAGE + "updatePetsbeMig",list);
	}

	public int updateInfoRcvYn(MemberBasePO po) {
		return update(BASE_DAO_PACKAGE + "updateInfoRcvYn", po);
	}
	

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021.03.10
	 * - 작성자		: 이지희
	 * - 설명			: 내 정보 관리 > 비밀번호 존재 유무 확인
	 * </pre>
	 * @param so
	 * @return
	 */
	public String isPswdForUpdate(Long mbrNo){
		return selectOne(BASE_DAO_PACKAGE + "isPswdForUpdate", mbrNo);
	}

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
	public String getMemberBaseNickNmInJoin(MemberBaseSO so){
		return selectOne(BASE_DAO_PACKAGE + "getMemberBaseNickNmInJoin",so);
	}

	public void updateRcomUrl(MemberBasePO po){
		update(BASE_DAO_PACKAGE + "updateRcomUrl",po);
	}
	
	public int updateMemberBaseTermsYn(MemberBasePO po) {
		return update(BASE_DAO_PACKAGE + "updateMemberBaseTermsYn", po);
	}
	
	public int insertMemberMarketingAgreeHist(MemberBasePO po) {
		return insert(BASE_DAO_PACKAGE + "insertMemberMarketingAgreeHist", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021.03.31
	 * - 작성자		: 이지희
	 * - 설명			: 로그인 시 회원 디바이스토큰 조회
	 * </pre>
	 * @param mbrNo
	 * @return
	 */
	public String getMemberDeviceToken(Long mbrNo) {
		return selectOne(BASE_DAO_PACKAGE + "getMemberDeviceToken", mbrNo);
	}

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
	public Integer getTagCntMember(Long mbrNo) {
		return selectOne(BASE_DAO_PACKAGE + "getTagCntMember", mbrNo);
	}

	public MemberBaseVO getMemberBaseGsrRequiredParam(Long mbrNo){
		return selectOne(BASE_DAO_PACKAGE + "getMemberBaseGsrRequiredParam",mbrNo);
	}

	public MemberBasePO getSaveGsrMemberBaseInfoByGsptNo(String gsptNo){
		return selectOne(BASE_DAO_PACKAGE + "getSaveGsrMemberBaseInfoByGsptNo",gsptNo);
	}

	public MemberBaseVO checkIsAlreadyCertification(MemberBaseSO so){
		return selectOne(BASE_DAO_PACKAGE + "checkIsAlreadyCertification",so);
	}
	
	public MemberBizInfoVO getMemberBizInfo(MemberBaseSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getMemberBizInfo", so);
	}
	
	public int emailUpdate(MemberBasePO po) {
		return update(BASE_DAO_PACKAGE + "emailUpdate", po);
	}
	
	public void updateMemberBizInfo(MemberBizInfoPO po) {
		update(BASE_DAO_PACKAGE + "updateMemberBizInfo", po);
	}

	/**
	 * 회원연동 여부 조회 ( member_base, sns_member_info, member_prtnr_intrck )
	 * @param vo
	 * @return
	 */
	public HashMap<String, Object> checkInterlock(NaverApiVO vo) {
		return selectOne(BASE_DAO_PACKAGE + "checkInterlock", vo);
	}

	/**
	 * 회원연동 저장
	 * @param vo
	 * @return
	 */
	public Integer insertMemberPrtnIntlk(NaverApiVO vo) {
		return insert(BASE_DAO_PACKAGE + "insertMemberPrtnIntlk", vo);
	}

	/**
	 * 회원연동 저장
	 * @param vo
	 * @return
	 */
	public Integer updateMemberPrtnIntlk(NaverApiVO vo) {
		return update(BASE_DAO_PACKAGE + "updateMemberPrtnIntlk", vo);
	}

	public int deleteInterlockSnsMemberInfo(NaverApiVO vo) {
		return delete(BASE_DAO_PACKAGE + "deleteInterlockSnsMemberInfo", vo);
	}

	public int deleteMemberPrtnIntlk(NaverApiVO vo) {
		return delete(BASE_DAO_PACKAGE + "deleteMemberPrtnIntlk", vo);
	}

	public List<Map<String, Object>> listPetBaseByPartner(PetBaseSO so){
		return selectList(BASE_DAO_PACKAGE + "listPetBaseByPartnerByMap",so);
	}

	/**
	 * 펫 기본 파트너사 등록
	 * @param po
	 * @return
	 */
	public int insertPetBasePartner(MemberPetVO po){
		return insert(BASE_DAO_PACKAGE + "insertPetBasePartner", po);
	}

	/**
	 * 파트너사 펫 질병 등록
	 * @param list
	 * @return
	 */
	public int insertPetDaPartner(List<MemberPetSubVO> list){
		return insert(BASE_DAO_PACKAGE + "insertPetDaPartner", list);
	}

	public Integer getMemberPetHasCnt(NaverApiVO vo) {
		return selectOne(BASE_DAO_PACKAGE + "getMemberPetHasCnt", vo);
	}

}

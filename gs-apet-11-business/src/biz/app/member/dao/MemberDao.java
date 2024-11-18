package biz.app.member.dao;

import biz.app.contents.model.ContentsReplyVO;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.login.model.SnsMemberInfoSO;
import biz.app.login.model.SnsMemberInfoVO;
import biz.app.member.model.*;
import biz.app.pay.model.PrsnCardBillingInfoPO;
import biz.app.pay.model.PrsnCardBillingInfoVO;
import biz.app.pay.model.PrsnPaySaveInfoVO;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.model.TagBaseVO;
import biz.interfaces.sktmp.model.SktmpCardInfoVO;
import framework.common.dao.MainAbstractDao;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.member.dao
* - 파일명		: MemberDao.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 회원 DAO
* </pre>
*/
@Slf4j
@Repository
public class MemberDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "member.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberDao.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 회원 비밀번호 실패 증가
	* </pre>
	* @param po
	* @return
	*/
	public int updateMemberLoginFailCnt(MemberBasePO po) {
		return update(BASE_DAO_PACKAGE + "updateMemberLoginFailCnt", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberDao.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 회원 페이지 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MemberBaseVO> pageMemberBase(MemberBaseSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageMemberBase", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberDao.java
	 * - 작성일		: 2021.04.15
	 * - 작성자		: 김재윤
	 * - 설명		: 회원 상세 검색
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MemberBaseVO> listMemberGrid(MemberBaseSO so){
		return selectListPage(BASE_DAO_PACKAGE + "listMemberGrid",so);
	}
	
	public List<MemberBaseVO> listMemberExcelDown(MemberBaseSO so){
		return selectList(BASE_DAO_PACKAGE + "listMemberExcelDown",so);
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberDao.java
	* - 작성일		: 2017. 8. 4.
	* - 작성자		: Administrator
	* - 설명			: 회원의 등급 정보 조회
	* </pre>
	* @param so
	* @return
	*/
	public MemberGradeVO getMemberGradeInfo(MemberBaseSO so){
		return selectOne(BASE_DAO_PACKAGE + "getMemberGradeInfo", so);
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberDao.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 회원 주소 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MemberAddressVO> listMemberAddress(MemberAddressSO so) {
		return selectList(BASE_DAO_PACKAGE + "listMemberAddress", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberDao.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 회원 주소 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public MemberAddressVO getMemberAddress(MemberAddressSO so) {
		return (MemberAddressVO) selectOne(BASE_DAO_PACKAGE + "getMemberAddress", so);
	}



	public int updateMemberHumanCancellation(MemberBasePO po) {
		return update(BASE_DAO_PACKAGE + "updateMemberHumanCancellation", po);
	}

	public int updateMemberMbrGrdCd(MemberBasePO po) {
		return update(BASE_DAO_PACKAGE + "updateMemberMbrGrdCd", po);
	}

	public int insertMemberAddress(MemberAddressPO po) {
		return insert(BASE_DAO_PACKAGE + "insertMemberAddress", po);
	}

	public int updateMemberAddress(MemberAddressPO po) {
		return update(BASE_DAO_PACKAGE + "updateMemberAddress", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MemberDao.java
	* - 작성일	: 2016. 5. 18.
	* - 작성자	: jangjy
	* - 설명		: 현재 진행중인 주문(구매확정이 되지 않은)이 있는지 체크.
	* </pre>
	* @param so
	* @return
	*/
	public String getCheckMemberOrderComplete(MemberBaseSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getCheckMemberOrderComplete", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명	: MemberDao.java
	 * - 작성일	: 2016. 5. 18.
	 * - 작성자	: jangjy
	 * - 설명		: 현재 진행중인 클래임(구매확정이 되지 않은)이 있는지 체크.
	 * </pre>
	 * @param so
	 * @return
	 */
	public String getCheckMemberClaimComplete(MemberBaseSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getCheckMemberClaimComplete", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MemberDao.java
	* - 작성일	: 2016. 5. 18.
	* - 작성자	: jangjy
	* - 설명		: 회원기본의 회원번호, 상태(탈퇴) 로그인 아이디만 남기고 다른정보는 전부 삭제한다.
	* </pre>
	* @param po
	* @return
	*/
	public int updateMemberLeave(MemberBasePO po) {
		return update(BASE_DAO_PACKAGE + "updateMemberLeave", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MemberDao.java
	* - 작성일	: 2016. 5. 18.
	* - 작성자	: jangjy
	* - 설명		: 회원배송지 삭제.
	* </pre>
	* @param po
	* @return
	*/
	public void deleteMemberAddress(MemberBasePO po) {
		delete(BASE_DAO_PACKAGE + "deleteMemberAddress", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MemberDao.java
	* - 작성일	: 2016. 5. 18.
	* - 작성자	: jangjy
	* - 설명		: 회원등급이력 삭제.
	* </pre>
	* @param po
	* @return
	*/
	public void deleteMemberGradeHistory(MemberBasePO po) {
		delete(BASE_DAO_PACKAGE + "deleteMemberGradeHistory", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MemberDao.java
	* - 작성일	: 2016. 5. 18.
	* - 작성자	: jangjy
	* - 설명		: 회원등급포인트이력 삭제.
	* </pre>
	* @param po
	* @return
	*/
	public void deleteMemberGradePointHist(MemberBasePO po) {
		delete(BASE_DAO_PACKAGE + "deleteMemberGradePointHist", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MemberDao.java
	* - 작성일	: 2016. 5. 18.
	* - 작성자	: jangjy
	* - 설명		: 회원적립금 삭제.
	* </pre>
	* @param po
	* @return
	*/
	public void deleteMemberSavedMoney(MemberBasePO po) {
		delete(BASE_DAO_PACKAGE + "deleteMemberSavedMoney", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MemberDao.java
	* - 작성일	: 2016. 5. 18.
	* - 작성자	: jangjy
	* - 설명		: 회원쿠폰 삭제.
	* </pre>
	* @param po
	* @return
	*/
	public void deleteMemberCoupon(MemberBasePO po) {
		delete(BASE_DAO_PACKAGE + "deleteMemberCoupon", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MemberDao.java
	* - 작성일	: 2016. 5. 18.
	* - 작성자	: jangjy
	* - 설명		: 회원관심상품 삭제.
	* </pre>
	* @param po
	* @return
	*/
	public void deleteMemberInterestGoods(MemberBasePO po) {
		delete(BASE_DAO_PACKAGE + "deleteMemberInterestGoods", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MemberDao.java
	* - 작성일	: 2016. 5. 18.
	* - 작성자	: jangjy
	* - 설명		: 회원로그인이력 삭제.
	* </pre>
	* @param po
	* @return
	*/
	public void deleteMemberLoginHist(MemberBasePO po) {
		delete(BASE_DAO_PACKAGE + "deleteMemberLoginHist", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MemberDao.java
	* - 작성일	: 2016. 5. 24.
	* - 작성자	: jangjy
	* - 설명		: 회원의 적립금 이력 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<MemberSavedMoneyVO> pageMemberSavedMoneyHist(MemberSavedMoneySO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageMemberSavedMoneyHist", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MemberDao.java
	* - 작성일	: 2016. 5. 24.
	* - 작성자	: jangjy
	* - 설명		: 회원의 1개월 이내의 소멸예정 적립금 취득
	* </pre>
	* @param mbrNo
	* @return
	*/
	public Long getLostExpectedMemberSavedMoney(Long mbrNo){
		return selectOne(BASE_DAO_PACKAGE + "getLostExpectedMemberSavedMoney", mbrNo);
	}

	public List<MemberSavedMoneyVO> pageMemberSavedMoney(MemberSavedMoneySO so) {
		return selectListPage("member.pageMemberSavedMoney", so);
	}











	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MemberDao.java
	* - 작성일	: 2016. 7. 13.
	* - 작성자	: jangjy
	* - 설명		: 회원의 본인인증 정보 갱신
	* </pre>
	* @param po
	* @return
	*/
	public int updateMemberCertification(MemberBasePO po) {
		return update(BASE_DAO_PACKAGE + "updateMemberCertification", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberDao.java
	* - 작성일		: 2016. 8. 1.
	* - 작성자		: snw
	* - 설명		: 회원 등급 포인트 이력 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertMemberGradePointHist(MemberGradePointHistPO po){
		return insert(BASE_DAO_PACKAGE + "insertMemberGradePointHist", po);
	}




	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberDao.java
	* - 작성일		: 2016. 8. 5.
	* - 작성자		: snw
	* - 설명		: 미사용 회원 휴면처리  대상 목록
	* </pre>
	* @return
	*/
	public List<MemberBaseVO> listMemberBaseNoUseTart(Integer period) {
		return selectList(BASE_DAO_PACKAGE + "listMemberBaseNoUseTart", period);
	}





	public MemberMainVO getMemberMain() {
		return (MemberMainVO)selectOne(BASE_DAO_PACKAGE + "getMemberMain");
	}









	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberDao.java
	* - 작성일		: 2017. 3. 7.
	* - 작성자		: hjko
	* - 설명		: 마이페이지 > 적립금 목록 조회
	* </pre>
	* @param so
	* @return
	 */
	public List<MemberSavedMoneyVO> listMemberSavedMoneyHist(MemberSavedMoneySO so) {
		return selectList(BASE_DAO_PACKAGE + "listMemberSavedMoneyHist", so);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberDao.java
	* - 작성일		: 2017. 3. 15.
	* - 작성자		: hjko
	* - 설명		: 마이페이지 > 환불 대기 금액 조회
	* </pre>
	* @param so
	* @return
	 */
	public Long getMemberRefundSchdAmt(MemberBaseSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getMemberRefundSchdAmt", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberDao.java
	* - 작성일		: 2017. 3. 17.
	* - 작성자		: wyjeong
	* - 설명		: 회원 탈퇴 시 회원 주문정보를 모두 비회원 정보로 업데이트
	* </pre>
	* @param po
	* @return
	*/
	public int updateMemberOrderLeave(MemberBasePO po) {
		return update(BASE_DAO_PACKAGE + "updateMemberOrderLeave", po);
	}
	
	
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.member.dao
	* - 파일명      : MemberDao.java
	* - 작성일      : 2017. 4. 25.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 사용자 정보 이력 
	* </pre>
	 */
	public List<MemberBaseVO> listMemberBaseHistory(MemberBaseSO so){
		//log.debug("★☆★☆★☆★☆★☆★☆★☆★☆ : {} ", so.toString());
		return selectList(BASE_DAO_PACKAGE + "listMemberBaseHistory", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberDao.java
	* - 작성일		: 2016. 8. 8.
	* - 작성자		: snw
	* - 설명		: 휴면 회원 복원
	* </pre>
	* @param mbrNo
	*/
	public void saveMemberUse(Long mbrNo){
		HashMap<String, Long> param = new HashMap<>();
		param.put("mbrNo", mbrNo);
		selectOne(BASE_DAO_PACKAGE + "saveMemberUse", param);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberDao.java
	* - 작성일		: 2016. 8. 8.
	* - 작성자		: snw
	* - 설명		: 본인인증코드로 멤버번호 조회
	* </pre>
	* @param mbrNo
	*/
	public Long getMbrNo(String ctfCd){
		return selectOne(BASE_DAO_PACKAGE + "getMbrNo", ctfCd);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberDao.java
	 * - 작성일		: 2021. 01. 07.
	 * - 작성자		: 이지희
	 * - 설명		: 회원목록(팝업)-최신결제일자 순
	 * </pre>
	 * @param so
	 */
	public List<MemberBaseVO> listPopupMemberBase(MemberBaseSO so ){
		return selectListPage(BASE_DAO_PACKAGE + "listPopupMemberBase", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberDao.java
	 * - 작성일		: 2021. 01. 15.
	 * - 작성자		: 이지희
	 * - 설명		: sns 로그인 시 기존 등록된 sns회원인지 체크
	 * </pre>
	 * @param so
	 */
	public MemberBaseVO getExistingSnsMemberCheck(SnsMemberInfoSO so ){
		return selectOne(BASE_DAO_PACKAGE + "getExistingSnsMemberCheck", so);
	}
	

	
	public Map<Long,MemberBaseVO> listMemberOrderInfo(MemberBaseSO so){
		List<MemberBaseVO> list = selectOne(BASE_DAO_PACKAGE + "listMemberOrderInfo",so);
		Map<Long,MemberBaseVO> result = new HashMap<Long,MemberBaseVO>();
		for(MemberBaseVO vo : list){
			result.put(vo.getMbrNo(),vo);
		}
		return result;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberBase.java
	 * - 작성일		: 2017. 2. 1.
	 * - 작성자		: snw
	 * - 설명			: 회원 간단 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public MemberBaseVO getMemberBaseInShort(MemberBaseSO so) {
		if(StringUtil.isNotEmpty(Optional.ofNullable(so.getMobile()).orElseGet(()->""))){
			so.setMobile(so.getMobile().replaceAll("-",""));
		}
		return selectOne(BASE_DAO_PACKAGE + "getMemberBaseInShort", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2017. 2. 1.
	 * - 작성자		: snw
	 * - 설명			: 회원 조회 - BO
	 * </pre>
	 * @param so
	 * @return
	 */
	public MemberBaseVO getMemberBaseBO(MemberBaseSO so) {
		if(StringUtil.isNotEmpty(Optional.ofNullable(so.getMobile()).orElseGet(()->""))){
			so.setMobile(so.getMobile().replaceAll("-",""));
		}
		return selectOne(BASE_DAO_PACKAGE + "getMemberBaseBO", so);
	}

	public MemberBaseVO getInfoRcvYnHistDtm(MemberBaseSO so){
		return selectOne(BASE_DAO_PACKAGE + "getInfoRcvYnHistDtm",so);
	}

	public MemberBaseVO getMkngRcvYnHistDtm(MemberBaseSO so){
		return selectOne(BASE_DAO_PACKAGE + "getMkngRcvYnHistDtm",so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021. 02. 05.
	 * - 작성자		: 김재윤
	 * - 설명			: 회원 관리 - 회원 상세 검색 - Tag 팔로우 내역 리스트 가져오기
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TagBaseVO> listMemberTagFollow(TagBaseSO so){
		return selectListPage(BASE_DAO_PACKAGE + "listMemberTagFollow",so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021. 02. 05.
	 * - 작성자		: 김재윤
	 * - 설명			: 회원 관리 - 회원 상세 검색 - 재입고 알림
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsBaseVO> listMemberGoodsIoList(GoodsBaseSO so){
		return selectListPage(BASE_DAO_PACKAGE + "listMemberGoodsIoList",so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021. 02. 05.
	 * - 작성자		: 김재윤
	 * - 설명			: 회원 관리 - 회원 상세 검색 - 신고된 내역
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ContentsReplyVO> listMemberReportList(MemberBaseSO so){
		return selectListPage(BASE_DAO_PACKAGE + "listMemberReportList",so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021. 02. 18.
	 * - 작성자		: 김재윤
	 * - 설명			: FO - 내 정보 관리 - 소셜로그인 연동 여부
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<SnsMemberInfoVO> getMemberSnsLoginYn(Long mbrNo){
		return selectList(BASE_DAO_PACKAGE + "getMemberSnsLoginYn",mbrNo);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberBaseDao.java
	 * - 작성일		: 2021. 02. 18.
	 * - 작성자		: KSH
	 * - 설명			: 080 수신거부 회원 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MemberBaseVO> getUnsubscribeMemberList(MemberBaseSO so){
		return selectListPage(BASE_DAO_PACKAGE + "getUnsubscribeMemberList",so);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberDao.java
	 * - 작성일		: 2021.03.06.
	 * - 작성자		: 김재윤
	 * - 설명			: 내 정보 관리 - 나를 팔로워 한 사람들
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MemberBaseVO> listFollowerMe(MemberBaseSO so){
		return selectListPage(BASE_DAO_PACKAGE + "listFollowerMe",so);
	}

	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberDao.java
	 * - 작성일		: 2021.03.06.
	 * - 작성자		: 김재윤
	 * - 설명			: 내 정보 관리 - 내가 팔로잉 한 사람들
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MemberBaseVO> listImFollowing(MemberBaseSO so){
		return selectListPage(BASE_DAO_PACKAGE + "listImFollowing",so);
	}
	
	public int updateAlmRcvYn(MemberBaseVO vo) {
		return update(BASE_DAO_PACKAGE + "updateAlmRcvYn" , vo);
	}

	public int callProcedureMarketingChange(MemberBasePO po){
		//임시 테이블 생성
		update(BASE_DAO_PACKAGE + "createTempMarketingTable");
		//임시테이블에 데이터 insert
		insert(BASE_DAO_PACKAGE+"insertTempMarketingTable",po);
		//배치 처리
		update(BASE_DAO_PACKAGE+"callProcedureMarketingChange",po);
		return po.getResultCnt();
	}

	public List<MemberBaseVO> getNickNameList(String nickNm) {
		return selectList(BASE_DAO_PACKAGE + "getNickNameList",nickNm);
	}
	
	public MemberBaseVO getMentionInfo(String nickNm) {
		return selectOne(BASE_DAO_PACKAGE + "getMentionInfo",nickNm);
	}
	
	public MemberBaseVO getMentionSearchInfo(Long mbrNo) {
		return selectOne(BASE_DAO_PACKAGE + "getMentionSearchInfo",mbrNo);
	}

	public PrsnPaySaveInfoVO getMemberPaySaveInfo(Long mbrNo){
		return selectOne(BASE_DAO_PACKAGE + "getMemberPaySaveInfo", mbrNo);
	}

	public PrsnCardBillingInfoVO getMemberCardBillInfo(Long mbrNo){
		return selectOne(BASE_DAO_PACKAGE + "getMemberCardBillInfo", mbrNo);
	}

	public List<PrsnCardBillingInfoVO> listMemberCardBillingInfo(MemberBaseSO so){
		return selectListPage(BASE_DAO_PACKAGE + "listMemberCardBillingInfo", so);
	}
	
	public List<SktmpCardInfoVO> listMemberSktmpCardInfo(MemberBaseSO so){
		return selectListPage(BASE_DAO_PACKAGE + "listMemberSktmpCardInfo", so);
	}

	 /** 회원 탈퇴 시, SNS 정보 삭제 */
	public void deleteSnsMemberInfo(MemberBasePO po){
		delete(BASE_DAO_PACKAGE + "deleteSnsMemberInfo",po);
	}
	
	public String checkInDelivery(MemberBaseSO so) {
		return selectOne(BASE_DAO_PACKAGE + "checkInDelivery", so);
	}
	
	public String checkInReturn(MemberBaseSO so) {
		return selectOne(BASE_DAO_PACKAGE + "checkInReturn", so);
	}
	
	public String checkInRefund(MemberBaseSO so) {
		return selectOne(BASE_DAO_PACKAGE + "checkInRefund", so);
	}
	
	public String checkInExchange(MemberBaseSO so) {
		return selectOne(BASE_DAO_PACKAGE + "checkInExchange", so);
	}

	public PrsnCardBillingInfoVO getBillCardInfo(PrsnCardBillingInfoPO pcbipo){
		return selectOne(BASE_DAO_PACKAGE + "getBillCardInfo", pcbipo);
	}

	public int deletePrsnSavePayInfo(Long mbrNo) {

		return delete(BASE_DAO_PACKAGE + "deletePrsnSavePayInfo", mbrNo);
	}
	
	public int deleteCouponIssue(MemberBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteCouponIssue", po);
	}
	
	public int deleteMemberAlarmRcvHist(MemberBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteMemberAlarmRcvHist", po);
	}
	
	public int deleteTermsRcvHistory(MemberBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteTermsRcvHistory", po);
	}
	
	public int deleteMemberCertifiedLog(MemberBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteMemberCertifiedLog", po);
	}
	
	public int deleteMbrTagMap(MemberBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteMbrTagMap", po);
	}
	
	public int deleteFollowMapMember(MemberBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteFollowMapMember", po);
	}
	
	public int deleteFollowMapTag(MemberBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteFollowMapTag", po);
	}
	
	public int deleteMemberBizStateHistory(MemberBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteMemberBizStateHistory", po);
	}
	
	public int deleteMemberBaseHistory(MemberBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteMemberBaseHistory", po);
	}
	
	public int deleteMemberPswdHist(MemberBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteMemberPswdHist", po);
	}
	
	public int deletePetDa(MemberBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deletePetDa", po);
	}
	
	public int deletePetInclRecode(MemberBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deletePetInclRecode", po);
	}
	
	public int deletePetBase(MemberBasePO po) {
		return delete(BASE_DAO_PACKAGE + "deletePetBase", po);
	}

	/*
	2021.05.06 - 김재윤
	회원가입 및 내정보 관리 - 입력 포커스 벗어날 시 중복 체크 ( 인덱싱 걸린 값 ) - 닉네임,로그인아이디,이메일
	 */
	public int getDuplicateChcekWhenBlur(MemberBaseSO so) {return selectOne(BASE_DAO_PACKAGE + "getDuplicateChcekWhenBlur",so); }

	/**
	 * 회원전환
	 * @param so
	 * @return
	 */
	public List<MemberBaseVO> memberBasePhoneList(MemberBaseSO so) {
		return selectList(BASE_DAO_PACKAGE + "getMemberBasePhoneList", so);
	}

	public int getMemberExistence(MemberBaseVO vo){
		return selectOne(BASE_DAO_PACKAGE + "getMemberBasePhoneListCount", vo);
	}
}

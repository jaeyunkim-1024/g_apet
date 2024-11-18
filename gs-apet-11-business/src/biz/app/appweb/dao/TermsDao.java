package biz.app.appweb.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.appweb.model.PushPO;
import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.appweb.model.TermsPO;
import biz.app.appweb.model.TermsSO;
import biz.app.appweb.model.TermsVO;
import biz.app.member.model.TermsRcvHistoryPO;
import biz.app.mobileapp.model.MobileVersionSO;
import biz.app.mobileapp.model.MobileVersionVO;
import biz.app.system.model.CodeDetailVO;
import framework.common.dao.MainAbstractDao;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.dao
 * - 파일명		: TermsDao.java
 * - 작성일		: 2021. 01. 11. 
 * - 작성자		: LDS
 * - 설 명		: 통합약관 관리 DAO
 * </pre>
 */
@Repository
public class TermsDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "terms.";

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsDao.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TermsVO> termsListGrid(TermsSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "termsListGrid", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsDao.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 상세정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TermsVO getTermsDetailInfo(TermsSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getTermsDetailInfo", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsDao.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 카테고리 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CodeDetailVO> getTermsCategoryList(TermsSO so) {
		return selectList(BASE_DAO_PACKAGE + "getTermsCategoryList", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsDao.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 버전 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public String getTermsVerCheck(TermsSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getTermsVerCheck", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsDao.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 등록
	 * </pre>
	 * @param so
	 * @return
	 */
	public int insertTerms(TermsPO po) {
		return insert(BASE_DAO_PACKAGE + "insertTerms", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsDao.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 수정
	 * </pre>
	 * @param so
	 * @return
	 */
	public int updateTerms(TermsPO po) {
		return update(BASE_DAO_PACKAGE + "updateTerms", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsDao.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 게시판 POC 등록
	 * </pre>
	 * @param so
	 * @return
	 */
	public int insertLetterPoc(TermsPO po) {
		return insert(BASE_DAO_PACKAGE + "insertLetterPoc", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsDao.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 게시판 POC 삭제
	 * </pre>
	 * @param so
	 * @return
	 */
	public int deleteLetterPoc(TermsPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteLetterPoc", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsDao.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 이전버전의 적용기간 종료일을 현재 날짜가 이전버전 시작일보다 크면 현재날짜, 아니면 이전버전의 시작일로 수정되도록 변경
	 * </pre>
	 * @param so
	 * @return
	 */
	public int updateTermsStrtDtToTermsEndDt(TermsPO po) {
		return update(BASE_DAO_PACKAGE + "updateTermsStrtDtToTermsEndDt", po);
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsDao.java
	 * - 작성일		: 2021. 01. 18.
	 * - 작성자		: 이지희
	 * - 설명			: FO회원가입 시 약관동의 화면에서 사용할 약관 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TermsVO> listTermsForMemberJoin(TermsSO so) {
		return selectList(BASE_DAO_PACKAGE + "listTermsForMemberJoin", so);
	}
	
	public List<TermsVO> listTermsContent(TermsSO so){
		return selectList(BASE_DAO_PACKAGE + "listTermsContent" , so);
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsService.java
	 * - 작성일		: 2021. 03. 31.
	 * - 작성자		: 김대희
	 * - 설명			: FO상품결재 시 결재 화면에서 사용할 약관 리스트
	 * </pre>
	 * @param TermsSO
	 * @return
	 */
	public List<TermsVO> listTermsForPayment(TermsSO so){
		return selectList(BASE_DAO_PACKAGE + "listTermsForPayment" , so);
	}
	
	public List<TermsVO> listGsPointTerms(TermsSO so) {
		return selectList(BASE_DAO_PACKAGE + "listGsPointTerms", so);
	}

	public List<TermsVO> listSktmpTerms(TermsSO so) {
		return selectList(BASE_DAO_PACKAGE + "listSktmpTerms", so);
	}

	public int insertCommonTermsRcvHistory(TermsRcvHistoryPO po) {
		return insert(BASE_DAO_PACKAGE + "insertCommonTermsRcvHistory", po);
	}
	
}

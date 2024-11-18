package biz.app.appweb.service;

import java.util.List;

import biz.app.appweb.model.TermsPO;
import biz.app.appweb.model.TermsSO;
import biz.app.appweb.model.TermsVO;
import biz.app.contents.model.EduContsSO;
import biz.app.mobileapp.model.MobileVersionPO;
import biz.app.mobileapp.model.MobileVersionSO;
import biz.app.mobileapp.model.MobileVersionVO;
import biz.app.system.model.CodeDetailVO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.service
 * - 파일명		: TermsService.java
 * - 작성일		: 2021. 01. 11. 
 * - 작성자		: LDS
 * - 설 명		: 통합약관 관리 서비스 Interface
 * </pre>
 */
public interface TermsService {
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsService.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TermsVO> termsListGrid(TermsSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsService.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 상세정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TermsVO getTermsDetailInfo(TermsSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsService.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 카테고리 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CodeDetailVO> getTermsCategoryList(TermsSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsService.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 버전 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public String getTermsVerCheck(TermsSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsService.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 등록
	 * </pre>
	 * @param so
	 * @return
	 */
	public int insertTerms(TermsPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsService.java
	 * - 작성일		: 2021. 05. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 수정
	 * </pre>
	 * @param so
	 * @return
	 */
	public int updateTerms(TermsPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsService.java
	 * - 작성일		: 2021. 01. 18.
	 * - 작성자		: 이지희
	 * - 설명			: FO회원가입 시 약관동의 화면에서 사용할 약관 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TermsVO> listTermsForMemberJoin(TermsSO so);
	
	public List<TermsVO> listTermsContent(TermsSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsService.java
	 * - 작성일		: 2021. 03. 31.
	 * - 작성자		: 김대희
	 * - 설명			: FO상품결재 시 결재 화면에서 사용할 약관 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TermsVO> listTermsForPayment(TermsSO so);
	
	public List<TermsVO> listGsPointTerms(TermsSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsService.java
	 * - 작성일		: 2021. 08. 09.
	 * - 작성자		: hjh
	 * - 설명			: FO SKT MP 멤버십 등록 시 사용할 약관 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TermsVO> listSktmpTerms(TermsSO so);
}

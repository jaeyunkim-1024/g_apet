package biz.app.appweb.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.appweb.dao.PushDao;
import biz.app.appweb.dao.TermsDao;
import biz.app.appweb.model.PushPO;
import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.appweb.model.TermsPO;
import biz.app.appweb.model.TermsSO;
import biz.app.appweb.model.TermsVO;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.BizService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.MaskingUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.service
 * - 파일명		: TermsServiceImpl.java
 * - 작성일		: 2021. 01. 11. 
 * - 작성자		: LDS
 * - 설 명		: 통합약관 관리 서비스
 * </pre>
 */
@Slf4j
@Service
@Transactional
public class TermsServiceImpl implements TermsService {
	
	@Autowired
	private TermsDao termsDao;
	
	@Autowired
	private BizService bizService;
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsServiceImpl.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TermsVO> termsListGrid(TermsSO so) {
		return termsDao.termsListGrid(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsServiceImpl.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 상세정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public TermsVO getTermsDetailInfo(TermsSO so) {
		return termsDao.getTermsDetailInfo(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsServiceImpl.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 카테고리 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CodeDetailVO> getTermsCategoryList(TermsSO so) {
		List<CodeDetailVO> codeList = new ArrayList<CodeDetailVO>();
		codeList = termsDao.getTermsCategoryList(so);
		return codeList;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsServiceImpl.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 버전 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public String getTermsVerCheck(TermsSO so) {
		String version = termsDao.getTermsVerCheck(so);
		return version;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsServiceImpl.java
	 * - 작성일		: 2021. 01. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertTerms(TermsPO po) {
		po.setTermsNo(bizService.getSequence(CommonConstants.SEQUENCE_TERMS_SEQ));
		
		int rsltCnt = termsDao.insertTerms(po);
		if(rsltCnt > 0) {
			String[] arrPocGb = po.getArrPocGb();
			//게시판 POC 등록
			for(String pocGb : arrPocGb) {
				po.setPocMenuCd("02");
				po.setPocGb(pocGb);
				termsDao.insertLetterPoc(po);
			}
			
			//통합약관 이전버전의 적용기간 종료일을 현재 날짜가 이전버전 시작일보다 크면 현재날짜, 아니면 이전버전의 시작일로 수정되도록 변경
			po.setBeTermsVer(po.getTermsVer()-1);
			termsDao.updateTermsStrtDtToTermsEndDt(po);
		}
		
		return rsltCnt;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsServiceImpl.java
	 * - 작성일		: 2021. 05. 11.
	 * - 작성자		: LDS
	 * - 설명			: 통합약관 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateTerms(TermsPO po) {
		int rsltCnt = termsDao.updateTerms(po);
		if(rsltCnt > 0) {
			String[] arrPocGb = po.getArrPocGb();
			
			po.setPocMenuCd("02");
			
			//게시판 POC 삭제
			termsDao.deleteLetterPoc(po);
			
			//게시판 POC 등록
			for(String pocGb : arrPocGb) {
				po.setPocGb(pocGb);
				termsDao.insertLetterPoc(po);
			}
		}
		
		return rsltCnt;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TermsServiceImpl.java
	 * - 작성일		: 2021. 01. 18.
	 * - 작성자		: 이지희
	 * - 설명			: FO회원가입 시 약관동의 화면에서 사용할 약관 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<TermsVO> listTermsForMemberJoin(TermsSO so) {
		List<TermsVO> list = termsDao.listTermsForMemberJoin(so);
		return list;
	}
	
	@Override
	public List<TermsVO> listTermsContent(TermsSO so){
		return termsDao.listTermsContent(so);
	}
	
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
	
	@Override
	public List<TermsVO> listTermsForPayment(TermsSO so){
			return termsDao.listTermsForPayment(so);
	}
	
	@Override
	public List<TermsVO> listGsPointTerms(TermsSO so) {
		return termsDao.listGsPointTerms(so);
	}
	
	
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
	@Override
	public List<TermsVO> listSktmpTerms(TermsSO so){
			return termsDao.listSktmpTerms(so);
	}
	
}

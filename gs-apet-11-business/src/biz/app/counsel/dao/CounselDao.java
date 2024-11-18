package biz.app.counsel.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.counsel.model.CounselPO;
import biz.app.counsel.model.CounselSO;
import biz.app.counsel.model.CounselStatusSO;
import biz.app.counsel.model.CounselStatusVO;
import biz.app.counsel.model.CounselVO;
import biz.app.counsel.model.CsMainVO;
import biz.app.display.model.DisplayTemplatePO;
import biz.app.order.model.OrderDetailVO;
import biz.common.model.AttachFilePO;
import biz.common.model.AttachFileVO;
import framework.common.dao.MainAbstractDao;
import framework.common.util.StringUtil;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.counsel.dao
* - 파일명		: CounselDao.java
* - 작성일		: 2017. 1. 25.
* - 작성자		: snw
* - 설명			: 상담 DAO
* </pre>
*/
@Repository
public class CounselDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "counsel.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselDao.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 상담 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<CounselVO> listCounsel( CounselSO so ) {
		return selectList( BASE_DAO_PACKAGE + "listCounsel", so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselDao.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 상담 목록 페이징 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<CounselVO> pageCounsel(CounselSO so) {
		if(StringUtil.isNotBlank(so.getEqrrMobile())){
			so.setEqrrMobile(so.getEqrrMobile().replaceAll("-", ""));
		}
		if(StringUtil.isNotBlank(so.getEqrrTel())){
			so.setEqrrTel(so.getEqrrTel().replaceAll("-", ""));
		}
		return selectListPage(BASE_DAO_PACKAGE + "pageCounsel", so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: CounselDao.java
	 * - 작성일		: 2021. 8. 17. 
	 * - 작성자		: YJU
	 * - 설명			: 1:1 문의 목록(FO)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CounselVO> getCounselListFO(CounselSO so) {
		return selectList(BASE_DAO_PACKAGE + "getCounselListFO", so); }
	
	/**
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: CounselDao.java
	 * - 작성일		: 2017. 3. 30.
	 * - 작성자		: snw
	 * - 설명			: 상담 목록 주문 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<OrderDetailVO> listCounselOrder(CounselSO so) {
		
		return selectList(BASE_DAO_PACKAGE + "listCounselOrder", so);
		
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselDao.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 상담 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertCounsel(CounselPO po) {
		if(po.getEqrrMobile() != null) {po.setEqrrMobile(po.getEqrrMobile().replaceAll("-", ""));}
		if(po.getEqrrTel() != null) {po.setEqrrTel(po.getEqrrTel().replaceAll("-", ""));}
		return insert(BASE_DAO_PACKAGE + "insertCounsel", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselDao.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 상담 상세 조회
	* </pre>
	* @param so
	* @return
	*/
	public CounselVO getCounsel(CounselSO so) {
		return (CounselVO) selectOne(BASE_DAO_PACKAGE + "getCounsel", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselDao.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 답변 완료 수
	* </pre>
	* @param so
	* @return
	*/
	public Integer getCounselAnswerCount(CounselSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getCounselAnswerCount", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselDao.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 답변 대기 수
	* </pre>
	* @param so
	* @return
	*/
	public Integer getCounselWaitCount(CounselSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getCounselWaitCount", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselDao.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 상담 상태 변경
	* </pre>
	* @param po
	* @return
	*/
	public int updateCounselCusStatCd(CounselPO po) {
		return update(BASE_DAO_PACKAGE + "updateCounselCusStatCd", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselDao.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 상담 취소 처리
	* </pre>
	* @param po
	* @return
	*/
	public int updateCounselCancel(CounselPO po) {
		return update(BASE_DAO_PACKAGE + "updateCounselCancel", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 1:1 상담 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteInquiry(CounselPO po) {
		return delete(BASE_DAO_PACKAGE + "deleteInquiry", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselDao.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 상담 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<AttachFileVO> getCounselFile( CounselSO so ) {
		return selectList( BASE_DAO_PACKAGE + "getCounselFile", so );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselDao.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 상담 완료 처리
	* </pre>
	* @param po
	* @return
	*/
	public int updateCounselComplete(CounselPO po) {
		return update(BASE_DAO_PACKAGE + "updateCounselComplete", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselDao.java
	* - 작성일		: 2017. 5. 31.
	* - 작성자		: Administrator
	* - 설명			: 상담 카테고리 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateCounselCtg(CounselPO po){
		return update(BASE_DAO_PACKAGE + "updateCounselCtg", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselDao.java
	* - 작성일		: 2017. 5. 31.
	* - 작성자		: Administrator
	* - 설명			: 상담 당당자 변경
	* </pre>
	* @param po
	* @return
	*/
	public int updateCounselChrg(CounselPO po){
		return update(BASE_DAO_PACKAGE + "updateCounselChrg", po);
	}
	

	public CsMainVO getCsMain() {
		return (CsMainVO) selectOne(BASE_DAO_PACKAGE +"getCsMain");
	}


	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselDao.java
	* - 작성일		: 2017. 4. 24.
	* - 작성자		: hjko
	 * @param so
	 * @return
	 */
	public List<CounselVO> listMOCounsel(CounselSO so) {
		return selectList( BASE_DAO_PACKAGE + "listMOCounsel", so );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselDao.java
	* - 작성일		: 2017. 6. 26.
	* - 작성자		: Administrator
	* - 설명			: 상담 요약 정보(회원)
	* </pre>
	* @param so
	* @return
	*/
	public CounselStatusVO getCounselStatusMem(Long mbrNo){
		return selectOne(BASE_DAO_PACKAGE + "getCounselStatusMem", mbrNo);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselDao.java
	* - 작성일		: 2017. 6. 27.
	* - 작성자		: Administrator
	* - 설명			: 상담 요약 정보(비회원)
	* </pre>
	* @param so
	* @return
	*/
	public CounselStatusVO getCounselStatusNoMem(CounselStatusSO so){
		if(StringUtil.isNotBlank(so.getMobile())){
			so.setMobile(so.getMobile().replaceAll("-", ""));
		}
		if(StringUtil.isNotBlank(so.getTel())){
			so.setTel(so.getTel().replaceAll("-", ""));
		}
		
		return selectOne(BASE_DAO_PACKAGE + "getCounselStatusNoMem", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselDao.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 상담 상태 변경
	* </pre>
	* @param po
	* @return
	*/
	public int updateFlCounsel(Long cusNo) {
		return update(BASE_DAO_PACKAGE + "updateFlCounsel", cusNo);
	}

	public int updateInquiry(CounselPO po) {
		return update(BASE_DAO_PACKAGE + "updateInquiry", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : CounselDao.java
	 * - 작성일        : 2021. 8. 18.
	 * - 작성자        : YKU
	 * - 설명          : 1:1문의 이미지 flNo 업데이트 
	 ** </pre>
	 * @param po
	 * @return
	 */
	public int updateIqrImg(CounselPO po) {
		return update(BASE_DAO_PACKAGE + "updateIqrImg", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : CounselDao.java
	 * - 작성일        : 2021. 8. 18.
	 * - 작성자        : YKU
	 * - 설명          : 1:1문의 이미지 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteInquiryImg(AttachFilePO po) {
		return delete(BASE_DAO_PACKAGE + "deleteInquiryImg", po);
	}

}
package biz.app.counsel.service;

import java.util.List;

import biz.app.counsel.model.CounselPO;
import biz.app.counsel.model.CounselProcessPO;
import biz.app.counsel.model.CounselProcessSO;
import biz.app.counsel.model.CounselSO;
import biz.app.counsel.model.CounselStatusSO;
import biz.app.counsel.model.CounselStatusVO;
import biz.app.counsel.model.CounselVO;
import biz.app.counsel.model.CsMainVO;
import biz.common.model.AttachFileVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.counsel.service
* - 파일명		: CounselService.java
* - 작성일		: 2016. 3. 24.
* - 작성자		: phy
* - 설명		:
* </pre>
*/
public interface CounselService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselService.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 상담 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<CounselVO> listCounsel( CounselSO so );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselService.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 상담 목록 페이징 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<CounselVO> pageCounsel(CounselSO so);
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: CounselService.java
	 * - 작성일		: 2021. 8. 17. 
	 * - 작성자		: YJU
	 * - 설명			: 1:1 문의 목록(FO)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<CounselVO> getCounselListFO(CounselSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselService.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 1:1 상담 파일 가져오기
	* </pre>
	* @param so
	* @return
	*/
	public List<AttachFileVO> getCounselFile( CounselSO so );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselService.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 웹 상담 등록
	* </pre>
	* @param po
	*/
	public void insertCounselWeb(CounselPO po, String deviceGb);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselService.java
	* - 작성일		: 2017. 5. 30.
	* - 작성자		: Administrator
	* - 설명			: 콜센터 상담 등록
	* </pre>
	* @param cpo
	* @param cppo
	*/
	public void insertCounselCc(CounselPO cpo, CounselProcessPO cppo, boolean lastPrcsYn);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselService.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 상담 상세 조회
	* </pre>
	* @param so
	* @return
	*/
	public CounselVO getCounsel(CounselSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselService.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 상담 취소
	* </pre>
	* @param po
	*/
	public void cancelCounsel(Long cusNo, Long cusCncrNo);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselService.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 상담 답변 완료 수
	* </pre>
	* @param so
	* @return
	*/
	public Integer getCounselAnswerCount(CounselSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselService.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 상담 답변 대기 수
	* </pre>
	* @param so
	* @return
	*/
	public Integer getCounselWaitCount(CounselSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselService.java
	* - 작성일		: 2017. 5. 31.
	* - 작성자		: Administrator
	* - 설명			: 상담 당당자 변경
	* </pre>
	* @param cusNo
	* @param cusChrgNo
	*/
	public void updateCounselChrg(Long cusNo, Long cusChrgNo);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselService.java
	* - 작성일		: 2017. 5. 31.
	* - 작성자		: Administrator
	* - 설명			: 상담 당당자 변경(멀티)
	* </pre>
	* @param cusNos
	* @param cusChrgNo
	*/
	public void updateCounselChrg(Long[] cusNos, Long cusChrgNo);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselService.java
	* - 작성일		: 2017. 5. 31.
	* - 작성자		: Administrator
	* - 설명			: 상담 기본 카테고리 수정
	* </pre>
	* @param po
	*/
	public void updateCounselCtg(Long cusNo, String cusCtg2Cd, String cusCtg3Cd);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselService.java
	* - 작성일		: 2017. 5. 31.
	* - 작성자		: Administrator
	* - 설명			: 1:1 상담 삭제
	* </pre>
	* @param po
	*/
	public int deleteInquiry(CounselPO po);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CounselService.java
	* - 작성일		: 2017. 6. 27.
	* - 작성자		: Administrator
	* - 설명			: 상담 요약 정보 조회
	* </pre>
	* @param so
	* @return
	*/
	public CounselStatusVO getCounselStatus(CounselStatusSO so);








	public CsMainVO getCsMain();

	/**
	 *  프로젝트명	: 11.business
	* - 파일명		: CounselService.java
	* - 작성일		: 2017. 4. 24
	* - 작성자		: hjko
	* - 설명			: 모바일 일대일문의 목록
	 * @param so
	 * @return
	 */
	public List<CounselVO> listMOCounsel(CounselSO so);


	/**
	 *  프로젝트명	: 11.business
	* - 파일명		: CounselService.java
	* - 작성일		: 2017. 4. 24
	* - 작성자		: hjko
	* - 설명			: 1:1 문의하기 APP용 이미지 업로드
	 * @param so
	 * @return
	 */
	public Long inquiryAppImgUpload(CounselPO po);
	
	public int updateFlCounsel(Long cusNo);


	public void appInquiryImageUpdate(CounselPO po);

	public void updateInquiry(CounselPO po, String deviceGb);

	public void insertInquiry(CounselPO po, String deviceGb);
}
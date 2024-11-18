package biz.interfaces.sktmp.service;

import java.util.List;

import biz.interfaces.sktmp.model.SktmpCardInfoPO;
import biz.interfaces.sktmp.model.SktmpCardInfoSO;
import biz.interfaces.sktmp.model.SktmpCardInfoVO;
import biz.interfaces.sktmp.model.SktmpLnkHistSO;
import biz.interfaces.sktmp.model.SktmpLnkHistVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00108ReqVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00110ReqVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00114ReqVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00102ResVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00108ResVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00110ResVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00114ResVO;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.service
 * - 파일명		: SktmpService.java
 * - 작성일		: 2021. 07. 22.
 * - 작성자		: JinHong
 * - 설명		: SKT MP 서비스
 * </pre>
 */
public interface SktmpService {
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.sktmp.service
	 * - 작성일		: 2021. 07. 23.
	 * - 작성자		: JinHong
	 * - 설명		: SKT MP 연동이력 페이징 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<SktmpLnkHistVO> pageSktmpLnkHist(SktmpLnkHistSO so);
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.sktmp.service
	 * - 작성일		: 2021. 08. 31.
	 * - 작성자		: JinHong
	 * - 설명		: SKT MP 연동이력 리스트 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<SktmpLnkHistVO> listSktmpLnkHist(SktmpLnkHistSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.sktmp.service
	 * - 작성일		: 2021. 07. 23.
	 * - 작성자		: JinHong
	 * - 설명		: SKT MP 연동이력 단건 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public SktmpLnkHistVO getSktmpLnkHist(SktmpLnkHistSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.sktmp.service
	 * - 작성일		: 2021. 07. 23.
	 * - 작성자		: JinHong
	 * - 설명		: SKT MP 연동 이력 총합계
	 * </pre>
	 * @param so
	 * @return
	 */
	public SktmpLnkHistVO getSktmpPntHistTotal(SktmpLnkHistSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.sktmp.service
	 * - 작성일		: 2021. 07. 26.
	 * - 작성자		: JinHong
	 * - 설명		: SKT MP 연동 이력 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public void insertSktmpLnkHist(SktmpLnkHistVO vo);
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.sktmp.service
	 * - 작성일		: 2021. 08. 17.
	 * - 작성자		: JinHong
	 * - 설명		: SKT MP 연동 이력 수정
	 * </pre>
	 * @param vo
	 */
	public void updateSktmpLnkHist(SktmpLnkHistVO vo);
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.sktmp.service
	 * - 작성일		: 2021. 07. 27.
	 * - 작성자		: JinHong
	 * - 설명		: SKT MP 사용/적립 요청
	 * </pre>
	 * @param vo
	 * @param isOrder - 주문 
	 * @return
	 */
	public void reqMpApprove(SktmpLnkHistVO vo, String ordClmGbCd, String errorCd);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.sktmp.service
	 * - 작성일		: 2021. 07. 27.
	 * - 작성자		: JinHong
	 * - 설명		: SKT MP 취소 요청
	 * </pre>
	 * @param po
	 * @return
	 */
	public void cancelMpApprove(SktmpLnkHistVO cncVO, String errorCd);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.sktmp.service
	 * - 작성일		: 2021. 08. 09.
	 * - 작성자		: hjh
	 * - 설명		: SKT MP 카드 정보 등록/변경
	 * </pre>
	 * @param po
	 * @return
	 */
	public void saveSktmpCardInfo(SktmpCardInfoPO po);

	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.sktmp.service
	 * - 작성일		: 2021. 08. 09.
	 * - 작성자		: hjh
	 * - 설명		: SKT MP 카드 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public SktmpCardInfoVO getSktmpCardInfo(SktmpCardInfoSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.sktmp.service
	 * - 작성일		: 2021. 08. 09.
	 * - 작성자		: hjh
	 * - 설명		: SKT MP 이력 암호화 처리
	 * </pre>
	 * @param cncVO
	 * @return
	 */
	public SktmpLnkHistVO encryptSktmpLnkHist(SktmpLnkHistVO cncVO);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.sktmp.service
	 * - 작성일		: 2021. 08. 24.
	 * - 작성자		: JinHong
	 * - 설명		: 오류건 재전송 
	 * </pre>
	 * @param so
	 * @return
	 */
	public SktmpLnkHistVO reReqSktmpLnkHist(SktmpLnkHistSO so);
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.sktmp.service
	 * - 작성일		: 2021. 08. 10.
	 * - 작성자		: JinHong
	 * - 설명		: 남은 적립 횟수 조회
	 * </pre>
	 * @param vo
	 * @return
	 */
	public ISR3K00110ResVO getMpSaveRmnCount(ISR3K00110ReqVO vo);
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.sktmp.service
	 * - 작성일		: 2021. 08. 09.
	 * - 작성자		: JinHong
	 * - 설명		: 사용가능 포인트 조회
	 * </pre>
	 * @param vo
	 * @return
	 */
	public ISR3K00108ResVO getUsableMpPnt(ISR3K00108ReqVO vo);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.sktmp.service
	 * - 작성일		: 2021. 08. 09.
	 * - 작성자		: hjh
	 * - 설명		: SKT MP PIN 번호 체크
	 * </pre>
	 * @param vo
	 * @return
	 */
	public ISR3K00102ResVO sktmpPinNoCheck(SktmpCardInfoVO vo);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.sktmp.service
	 * - 작성일		: 2021. 08. 24.
	 * - 작성자		: JinHong
	 * - 설명		: CI값 카드번호 일치 여부
	 * </pre>
	 * @param vo
	 * @return
	 */
	public ISR3K00114ResVO getEqualCheckCiAndCardNo(ISR3K00114ReqVO vo);
	
	
}

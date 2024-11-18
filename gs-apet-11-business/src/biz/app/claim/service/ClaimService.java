package biz.app.claim.service;

import java.util.List;

import biz.app.claim.model.ClaimAccept;
import biz.app.claim.model.ClaimBaseVO;
import biz.app.claim.model.ClaimDetailPO;
import biz.app.claim.model.ClaimDetailVO;
import biz.app.claim.model.ClaimListVO;
import biz.app.claim.model.ClaimRefundPayVO;
import biz.app.claim.model.ClaimRefundVO;
import biz.app.claim.model.ClaimRegist;
import biz.app.claim.model.ClaimSO;
import biz.app.claim.model.ClaimSummaryVO;
import biz.app.counsel.model.CounselPO;
import biz.app.order.model.OrderBaseVO;
import biz.app.order.model.OrderSO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.claim.service
 * - 파일명		: ClaimService.java
 * - 작성일		: 2016. 4. 4.
 * - 작성자		: dyyoun
 * - 설명		: 클레임 서비스
 * </pre>
 */
public interface ClaimService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ClaimService.java
	 * - 작성일		: 2017. 2. 22.
	 * - 작성자		: snw
	 * - 설명		: 클레임 취소
	 *					- 주문 취소의 경우 접수즉시 처리하므로 별도의 취소가 존재하지 않음
	 * </pre>
	 * 
	 * @param clmNo
	 * @param cncrNo
	 */
	public void cancelClaim(String clmNo, Long cncrNo);

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: claimReactPgCancel
	 * - 작성일		: 2021. 05. 12.
	 * - 작성자		: sorce
	 * - 설명			: PG 재환불 시킬 때 사용
	 * </pre>
	 * @param clmNo
	 * @param cncrNo
	 */
	public void claimReactPgCancel(String clmNo, Long cncrNo);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ClaimService.java
	 * - 작성일		: 2017. 6. 27.
	 * - 작성자		: Administrator
	 * - 설명		: 클레임 취소 가능 여부 체크
	 * </pre>
	 * 
	 * @param claimBase
	 * @param claimDetailList
	 * @return
	 */
	public boolean cancelClaimPossible(ClaimBaseVO claimBase, List<ClaimDetailVO> claimDetailList);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ClaimService.java
	 * - 작성일		: 2017. 3. 6.
	 * - 작성자		: snw
	 * - 설명		: 클레임 환불 예정금액 조회
	 *  				  클레임에 대한 예상금액에 대한 조회시 사용
	 * </pre>
	 * 
	 * @param clmRegist
	 * @return
	 */
	public ClaimRefundVO getClaimRefundExcpect(ClaimRegist clmRegist, String clmTpCd);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ClaimService.java
	 * - 작성일		: 2017. 3. 21.
	 * - 작성자		: snw
	 * - 설명		: 반품거부완료 처리
	 * </pre>
	 * 
	 * @param clmNo
	 * @param arrClmDtlSeq
	 * @param arrRefuseQty
	 * @param clmDenyRsnContent
	 * @param cpltrNo 완료자 번호
	 */
	public void completeClaimReturnRefuse(String clmNo, Integer[] arrClmDtlSeq, Integer[] arrRefuseQty, String clmDenyRsnContent, Long cpltrNo);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ClaimService.java
	 * - 작성일		: 2017. 3. 21.
	 * - 작성자		: snw
	 * - 설명		: 반품 승인 완료 처리
	 * </pre>
	 * 
	 * @param clmNo
	 * @param clmDtlSeq
	 * @param cpltrNo 완료자 번호
	 */
	public void completeClaimReturnConfirm(String clmNo, Integer clmDtlSeq, Long cpltrNo);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ClaimService.java
	 * - 작성일		: 2017. 3. 21.
	 * - 작성자		: snw
	 * - 설명		: 교환 거부 완료 처리
	 * </pre>
	 * 
	 * @param clmNo
	 * @param arrClmDtlSeq
	 * @param arrRefuseQty
	 * @param clmDenyRsnContent
	 * @param cpltrNo 완료자 번호
	 */
	public void completeClaimExchangeRefuse(String clmNo, Integer[] arrClmDtlSeq, Integer[] arrRefuseQty, String clmDenyRsnContent, Long cpltrNo);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ClaimService.java
	 * - 작성일		: 2017. 3. 21.
	 * - 작성자		: snw
	 * - 설명		: 교환 승인 완료 처리
	 * </pre>
	 * 
	 * @param clmNo
	 * @param clmDtlSeq
	 * @param cpltrNo 완료자 번호
	 */
	public void completeClaimExchangeConfirm(String clmNo, Integer clmDtlSeq, Long cpltrNo);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ClaimService.java
	 * - 작성일		: 2017. 4. 11.
	 * - 작성자		: snw
	 * - 설명		: 클레임 최종 완료 처리
	 * </pre>
	 * 
	 * @param clmNo
	 * @param cpltrNo
	 */
	public void completeClaim(String clmNo, Long cpltrNo);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명   	: biz.app.claim.service
	 * - 파일명      	: ClaimService.java
	 * - 작성일      	: 2017. 3. 20.
	 * - 작성자     	: valuefactory 권성중
	 * - 설명      		: 반품 목록 페이징 조회
	 * </pre>
	 * 
	 * @param claimSO
	 */
	public List<ClaimListVO> pageClaim(ClaimSO claimSO);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명   	: biz.app.claim.service
	 * - 파일명      	: ClaimService.java
	 * - 작성일      	: 2017. 3. 20.
	 * - 작성자     	: tigerfive
	 * - 설명      		: 반품 목록 페이징 조회 (API용)
	 * </pre>
	 * 
	 * @param claimSO
	 */
	public List<biz.app.claim.model.interfaces.ClaimListVO> pageClaimInterface(biz.app.claim.model.interfaces.ClaimSO claimSO);

	/**
	 * <pre>
	 * - 프로젝트명 	: 11.business
	 * - 패키지명   	: biz.app.claim.service
	 * - 파일명      	: ClaimService.java
	 * - 작성일      	: 2017. 3. 21.
	 * - 작성자      	: valuefactory 권성중
	 * - 설명      		: 반품/교환 회수 완료
	 * </pre>
	 * 
	 * @param clmNo
	 * @param clmDtlSeq
	 */
	public void claimProductRecoveryFinalExec(String clmNo, Integer clmDtlSeq);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명   	: biz.app.claim.service
	 * - 파일명      	: ClaimService.java
	 * - 작성일      	: 2017. 3. 21.
	 * - 작성자      	: valuefactory 권성중
	 * - 설명      		: CS 관리 - CS 접수
	 * </pre>
	 * 
	 * @param orderSO
	 * @param counselPO
	 */
	public void claimCsAcceptNonOrderExec(OrderSO orderSO, CounselPO counselPO);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명   	: biz.app.claim.service
	 * - 파일명      	: ClaimService.java
	 * - 작성일      	: 2017. 3. 21.
	 * - 작성자      	: valuefactory 권성중
	 * - 설명      		: CS 관리 - CS 완료처리
	 * </pre>
	 * 
	 * @param orderSO
	 * @param counselPO
	 */
	public void counselComplete(OrderSO orderSO, CounselPO counselPO);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ClaimService.java
	 * - 작성일		: 2016.6. 1.
	 * - 작성자		: yhkim
	 * - 설명		: 클레임 목록 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	public List<ClaimBaseVO> pageClaimCancelRefundList(ClaimSO so);
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: pageClaimCancelRefundList2ndE
	 * - 작성일		: 2021. 04. 17.
	 * - 작성자		: sorce
	 * - 설명			: 클레임 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<OrderBaseVO> pageClaimCancelRefundList2ndE(ClaimSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ClaimService.java
	 * - 작성일		: 2017. 3. 9.
	 * - 작성자		: hongjun
	 * - 설명		: 클레임(환불)
	 * </pre>
	 * 
	 * @param claimSO
	 * @return
	 */
	public ClaimBaseVO getClaimRefund(ClaimSO claimSO);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ClaimService.java
	 * - 작성일		: 2017. 7. 5.
	 * - 작성자		: hongjun
	 * - 설명		: 클레임(환불 가격)
	 * </pre>
	 * 
	 * @param claimSO
	 * @return
	 */
	public ClaimRefundPayVO getClaimRefundPay(ClaimSO claimSO);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ClaimService.java
	 * - 작성일		: 2016. 6. 8.
	 * - 작성자		: phy
	 * - 설명		: 취소/교환/반품 현황
	 * </pre>
	 * 
	 * @param claimSO
	 * @return
	 */
	public ClaimSummaryVO claimSummary(ClaimSO claimSO);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명   	: biz.app.claim.service
	 * - 파일명      	: ClaimService.java
	 * - 작성일      	: 2021. 3. 31.
	 * - 작성자     	: pse
	 * - 설명      		: 취소/교환/반품 엑셀 데이터 조회 
	 * </pre>
	 * 
	 * @param claimSO
	 */
	public List<ClaimListVO> getClaimExcelList(ClaimSO claimSO);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명   	: biz.app.claim.service
	 * - 파일명      	: ClaimService.java
	 * - 작성일      	: 2021. 5. 06.
	 * - 작성자     	: 
	 * - 설명      		: 클레임 전체 사유 이미지 정보 저장
	 * </pre>
	 * 
	 * @param po
	 * @param imgPaths
	 */
	public void saveAllImgClaimDetail(ClaimDetailPO po, List<String> imgPaths);

	void completeClaimCancel(String clmNo, Long cpltrNo);

	ClaimAccept getClaimBefore(ClaimRegist clmRegist, boolean accept);
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명	: biz.app.claim.service
	 * - 파일명		: ClaimService.java
	 * - 작성일		: 2021. 8. 09.
	 * - 작성자		: lts
	 * - 설명		: 클레임 통합 조회
	 * </pre>
	 * 
	 * @param claimSO
	 */
	public List<ClaimListVO> pageClaimIntegrateList(ClaimSO claimSO);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명	: biz.app.claim.service
	 * - 파일명		: ClaimService.java
	 * - 작성일		: 2021. 8. 10.
	 * - 작성자		: LST
	 * - 설명		: 홈 > 주문 관리 > 클레임 통합 조회 > 클레임 통합 조회 목록 엑셀다운 
	 * </pre>
	 * 
	 * @param claimSO
	 */
	public List<ClaimListVO> getClaimIntegrateExcelList(ClaimSO claimSO);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.claim.service
	 * - 작성일		: 2021. 08. 31.
	 * - 작성자		: JinHong
	 * - 설명		: MP 포인트 계산
	 * </pre>
	 * @param clmNo
	 * @param refundDlvrAmt
	 */
	public void calMpPnt(String clmNo);

}
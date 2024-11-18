package biz.app.pay.service;


import java.util.List;

import biz.app.pay.model.PayBasePO;
import biz.app.pay.model.PayBaseSO;
import biz.app.pay.model.PayBaseVO;
import biz.app.pay.model.PayIfLogVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.pay.service
* - 파일명		: PayBaseService.java
* - 작성일		: 2017. 1. 12.
* - 작성자		: snw
* - 설명			: 결제 기본 서비스
* </pre>
*/
public interface PayBaseService {
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayBaseService.java
	* - 작성일		: 2017. 2. 15.
	* - 작성자		: snw
	* - 설명			: 주문에 따른 전체 결제 완료 여부 체크
	* </pre>
	* @param ordNo
	* @return
	*/
	public boolean checkPayStatus(String ordNo);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayBaseService.java
	* - 작성일		: 2017. 3. 2.
	* - 작성자		: snw
	* - 설명			: 결제 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<PayBaseVO> listPayBase( PayBaseSO so );	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayBaseService.java
	* - 작성일		: 2017. 5. 18.
	* - 작성자		: Administrator
	* - 설명			: 주문의 원 결제 상세 조회
	* </pre>
	* @param ordNo
	* @param payMeansCd
	* @return
	*/
	public PayBaseVO getPayBaseOrg(String ordNo, String payMeansCd);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayBaseService.java
	* - 작성일		: 2017. 5. 25.
	* - 작성자		: Administrator
	* - 설명			: 가상계좌 입금 대상 정보 조회
	* </pre>
	* @param ordNo
	* @param acctNo
	* @return
	*/
	public PayBaseVO getPayBaseVirtual(String ordNo, String acctNo);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayBaseService.java
	* - 작성일		: 2017. 3. 2.
	* - 작성자		: snw
	* - 설명			: 결제 완료 처리
	* 					 결제 완료 후 결제 상태에 따른 주문 완료 처리 포함	
	* </pre>
	* @param arrOrdNo
	* @param arrPayNo
	*/
	public void updatePayBaseComplete(Long payNo);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayBaseService.java
	* - 작성일		: 2017. 4. 19.
	* - 작성자		: snw
	* - 설명			: 결제 환불 예정 목록 조회
	* </pre>
	* @return
	*/
	public List<PayBasePO> listPayBaseRefundExpect(String ordNo, Long refundAmt);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayBaseService.java
	* - 작성일		: 2017. 3. 9.
	* - 작성자		: snw
	* - 설명			: 결제 환불 접수
	* </pre>
	* @param clmNo
	*/
	public void acceptPayBaseRefund(String clmNo, String bankCd, String acctNo, String ooaNm, Long refundDlvrAmt);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayBaseService.java
	* - 작성일		: 2017. 3. 10.
	* - 작성자		: snw
	* - 설명			: 결제 환불 취소
	* </pre>
	* @param clmNo
	*/
	public void cancelPayBaseRefund(String clmNo);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PayBaseService.java
	* - 작성일		: 2017. 3. 10.
	* - 작성자		: snw
	* - 설명			: 결제 환불 완료
	* </pre>
	* @param clmNo
	*/
	public void completePayBaseRefund(String clmNo);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.pay.service
	 * - 작성일		: 2021. 03. 31.
	 * - 작성자		: JinHong
	 * - 설명		: 결제 기본 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public PayBaseVO getPayBase( PayBaseSO so );
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.pay.service
	 * - 작성일		: 2021. 03. 31.
	 * - 작성자		: JinHong
	 * - 설명		: 입금 확인 완료 처리
	 * </pre>
	 * @param po
	 */
	public void confirmDepositInfo(PayBasePO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.pay.service
	 * - 작성일		: 2021. 03. 31.
	 * - 작성자		: JinHong
	 * - 설명		: 입금 정보 등록
	 * </pre>
	 * @param po
	 */
	public void insertDepositInfo(PayBasePO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.pay.service
	 * - 작성일		: 2021. 03. 31.
	 * - 작성자		: JinHong
	 * - 설명		: 결제 페이지 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<PayBaseVO> pagePayBase(PayBaseSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: PayBaseService.java
	* - 작성일	: 2021. 5. 13.
	* - 작성자 	: valfac
	* - 설명 		: 결제 체크(전액 포인트 결제인지 확인)
	* </pre>
	*
	* @param so
	* @return
	*/
	public PayBaseVO checkOrgPayBase( PayBaseSO so );

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: insertPayIfLog
	 * - 작성일		: 2021. 05. 17.
	 * - 작성자		: sorce
	 * - 설명			: PG Log insert
	 * </pre>
	 * @param vo
	 * @return
	 */
	public Integer insertPayIfLog( PayIfLogVO vo );
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 메서드명	: insertPayIfLog
	 * - 작성일		: 2021. 07. 20.
	 * - 작성자		: KKB
	 * - 설명		: pay base 등록
	 * </pre>
	 * @param vo
	 * @return
	 */
	public Integer insertPayBase( PayBasePO po );
}

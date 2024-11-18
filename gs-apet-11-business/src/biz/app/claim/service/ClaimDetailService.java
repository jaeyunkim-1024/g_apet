package biz.app.claim.service;

import java.util.List;

import biz.app.claim.model.ClaimDetailPO;
import biz.app.claim.model.ClaimDetailSO;
import biz.app.claim.model.ClaimDetailVO;
import biz.app.claim.model.ClaimSO;
import biz.app.claim.model.ClmDtlCstrtPO;
import biz.app.order.model.OrderBaseVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.service
* - 파일명		: ClaimDetailService.java
* - 작성일		: 2017. 1. 25.
* - 작성자		: snw
* - 설명			: 클레임 상세 서비스 Interface
* </pre>
*/
public interface ClaimDetailService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimDetailService.java
	* - 작성일		: 2017. 3. 6.
	* - 작성자		: snw
	* - 설명			: 클레임 상세 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<ClaimDetailVO> listClaimDetail( ClaimDetailSO so );

	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: listClaimDetail2ndE
	 * - 작성일		: 2021. 04. 19.
	 * - 작성자		: sorce
	 * - 설명			: 클레임 상태 리스트
	 * </pre>
	 * @param claimSO
	 * @return
	 */
	public OrderBaseVO listClaimDetail2ndE(ClaimSO claimSO);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimDetailService.java
	* - 작성일		: 2017. 3. 6.
	* - 작성자		: snw
	* - 설명			: 클레임 상세 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<ClaimDetailVO> listClaimExchangeDetail( ClaimDetailSO so );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimDetailService.java
	* - 작성일		: 2017. 3. 10.
	* - 작성자		: snw
	* - 설명			: 클레임 상세 상태 수정
	* </pre>
	* @param po
	*/
	public void updateClaimDetailStatus(String clmNo, Integer clmDtlSeq, String clmDtlStatCd);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ClaimDetailService.java
	 * - 작성일		: 2017. 3. 10.
	 * - 작성자		: snw
	 * - 설명		: 클레임 상세 상태 수정 (클레임 상세의 모든 배송이 배송완료일자가 존재할때 배송완료로 UPDATE)
	 * </pre>
	 * @param po
	 */
	public int updateClaimDetailStatusDlvrCplt(String clmNo, Integer clmDtlSeq, String clmDtlStatCd);
	
	/**
	  *
	 * <pre>
	 * - 프로젝트명  : 11.business
	 * - 패키지명  	: biz.app.order.service
	 * - 파일명      	: ClaimDetailServiceImpl.java
	 * - 작성일      	: 2017. 6. 20.
	 * - 작성자      	: valuefactory hjko
	 * - 설명      	: Interface 클레임 상세 상태 수정
	 * </pre>
	  */
	public void updateClaimDetailStatusInf(ClaimDetailPO cpo);
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimDetailService.java
	* - 작성일		: 2017. 3. 7.
	* - 작성자		: snw
	* - 설명			: 클레임 상세 단건 조회
	* </pre>
	* @param so
	* @return
	*/
	public ClaimDetailVO getClaimDetail (ClaimDetailSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimDetailService.java
	* - 작성일		: 2021. 3. 4.
	* - 작성자		: ljj
	* - 설명			: 클레임 상세사유 이미지 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<ClaimDetailVO> listClaimDetailImage(ClaimDetailSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ClaimDetailService.java
	* - 작성일		: 2021. 3. 9.
	* - 작성자		: pse
	* - 설명			: 클레임 상세 간략 정보
	* </pre>
	* @param po
	* @return
	*/
	public List<ClmDtlCstrtPO> listClmDtlCstrt(ClaimDetailSO so);
}
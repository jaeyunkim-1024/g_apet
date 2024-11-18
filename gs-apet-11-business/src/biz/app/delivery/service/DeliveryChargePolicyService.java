package biz.app.delivery.service;

import java.util.List;

import biz.app.company.model.CompanySO;
import biz.app.delivery.model.DeliveryChargePolicyPO;
import biz.app.delivery.model.DeliveryChargePolicySO;
import biz.app.delivery.model.DeliveryChargePolicyVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.delivery.service
* - 파일명		: DeliveryChargePolicyService.java
* - 작성일		: 2017. 3. 14.
* - 작성자		: snw
* - 설명			: 배송비 정책 서비스 Interface
* </pre>
*/
public interface DeliveryChargePolicyService {


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryChargePolicyService.java
	* - 작성일		: 2017. 3. 14.
	* - 작성자		: snw
	* - 설명			: 배송비 정책 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<DeliveryChargePolicyVO> listDeliveryChargePolicy(DeliveryChargePolicySO so);

	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryChargePolicyService.java
	* - 작성일		: 2017. 3. 14.
	* - 작성자		: snw
	* - 설명			: 배송비 정책 상세 조회
	* </pre>
	* @param so
	* @return
	*/
	public DeliveryChargePolicyVO getDeliveryChargePolicy(DeliveryChargePolicySO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryChargePolicyService.java
	* - 작성일		: 2017. 3. 14.
	* - 작성자		: snw
	* - 설명			: 배송비 정책 삭제
	* </pre>
	* @param po
	* @return
	*/
	public int deleteDeliveryChargePolicy(DeliveryChargePolicyPO po);
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.delivery.service
	* - 파일명      : DeliveryChargePolicyService.java
	* - 작성일      : 2017. 5. 11.
	* - 작성자      : valuefactory 권성중
	* - 설명      :홈 > 업체 관리 > 업체 정책 변경 관리
	* </pre>
	 */
	public List<DeliveryChargePolicyVO> pageDeliveryChargePolicyHistory(CompanySO so);
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.delivery.service
	* - 파일명      : DeliveryChargePolicyService.java
	* - 작성일      : 2017. 5. 11.
	* - 작성자      : valuefactory 권성중
	* - 설명      :홈 > 업체 관리 > 업체 정책 변경 관리 상세보기
	* </pre>
	 */
	public DeliveryChargePolicyVO getDeliveryChargePolicyHistory(DeliveryChargePolicySO so);
	
}

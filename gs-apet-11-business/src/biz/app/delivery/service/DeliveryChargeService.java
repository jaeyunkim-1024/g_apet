package biz.app.delivery.service;

import java.util.List;

import biz.app.claim.model.ClaimBasePO;
import biz.app.claim.model.ClaimDetailVO;
import biz.app.delivery.model.DeliveryChargePO;
import biz.app.delivery.model.DeliveryChargeSO;
import biz.app.delivery.model.DeliveryChargeVO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.delivery.service
 * - 파일명		: DeliveryChargeService.java
 * - 작성일		: 2017. 3. 27.
 * - 작성자		: snw
 * - 설명		: 배송비 서비스
 * </pre>
 */
public interface DeliveryChargeService {

	public List<DeliveryChargeVO> listDeliveryCharge(DeliveryChargeSO so);
	public void estimateDeliveryCharge(ClaimBasePO claimBasePO, List<DeliveryChargePO> claimDeliveryChargeList, List<ClaimDetailVO> reqClaimDetailList) ;
	public void insertDeliveryCharge(ClaimBasePO claimBasePO);
	public ClaimBasePO selectDeliveryCharge(ClaimBasePO claimBasePO);
}

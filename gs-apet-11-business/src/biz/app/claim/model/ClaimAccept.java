package biz.app.claim.model;

import java.io.Serializable;
import java.util.List;

import biz.app.delivery.model.DeliveryChargePO;
import biz.app.order.model.OrderDlvraPO;
import lombok.Data;

@Data
public class ClaimAccept implements Serializable {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 귀책 대상 코드 */
	private String clmBlameCd;		 
	
	private ClaimBasePO claimBase;					// 클레임 기본
	private List<ClaimDetailVO> claimDetailList;	// 클레임 상세
	private List<ClmDtlCstrtPO> clmDtlCstrtList;	// 클레임 상세 구성
	private List<DeliveryChargePO> clmDlvrcList;	// 반품/교환 배송비
	private List<OrderDlvraPO> orderDlvraList;		// 배송지 및 회수지 정보
}
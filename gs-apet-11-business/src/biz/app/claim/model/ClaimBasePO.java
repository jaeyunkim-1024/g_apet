package biz.app.claim.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.model
* - 파일명		: ClaimBasePO.java
* - 작성일		: 2017. 1. 12.
* - 작성자		: snw
* - 설명			: 클레임 기본 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ClaimBasePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 클레임 번호 */
	private String clmNo;

	/** 사이트 아이디 */
	private Long		stId;
	
	/** 주문 번호 */
	private String ordNo;

	/** 회원 번호 */
	private Long mbrNo;

	/** 클레임 유형 코드 */
	private String clmTpCd;

	/** 클레임 상태 코드 */
	private String clmStatCd;

	/** 맞교환 여부 */
	private String	swapYn;
	
	/** 주문 매체 코드 */
	private String ordMdaCd;
	
	/** 채널 아이디 */
	private Long chnlId;
	
	/** 접수자 번호 */
	private Long acptrNo;
	
	/** 취소자 번호 */
	private Long cncrNo;

	/** 완료자 번호 */
	private Long cpltrNo;	

	/** 외부 클레임 상세 번호 */
	private String outsideClmNo;
	
	/** 배송 처리 유형 코드 */
	private String dlvrPrcsTpCd;
	
	/** 클레임상세 모두 클레임상세상태가 모두 처리되었나 체크여부*/
	private String checkClmDtlStatAllEndYn="N";
	
	
	/** 클레임 초도 배송비 관련 환불 금액 */
	/** 환불되어야 하는 금액 */
	private long refundDlvrAmt;
	
	/** 원배송비 */
	private Long 	orgDlvrcAmt;
	
	/** 무료배송 깨졋을 경우 -환불금액, 유료배송일경우 +환불금액 */
	private Long 	reduceDlvrcAmt;
	
	/** 반품/교환비 */
	private Long		clmDlvrcAmt;
	/** 반품/교환비 : 배송비 */
	private Long		claimDlvrcAmtCostGb10;
	/** 반품/교환비 : 회수비 */
	private Long		claimDlvrcAmtCostGb20;

	/** 환불 예정 금액 */
	private Long		totAmt;
	
	/** 추가 환불 배송 금액 */
	private Long addReduceDlvrcAmt;
	
	/** 추가 원 배송 금액 */
	private Long addOrgDlvrcAmt;
	
	/** 클레임 사유 코드 */
	private String	clmRsnCd;
	
	/** 사용 여부 -delivery_charge_detail- */
	private String	useYn;
	
	private String	cncClmNo;
	
	/** 주문 상세 여부 -> 클레임 등록 전인데도 계산시 insert 된 건이 조회되어서 추가- */
	private String	ordDetailYn;
	
}
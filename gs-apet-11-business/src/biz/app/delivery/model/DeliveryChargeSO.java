package biz.app.delivery.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;
import framework.common.model.BaseSysVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.delivery.model
* - 파일명		: DeliveryChargeSO.java
* - 작성일		: 2017. 2. 28.
* - 작성자		: snw
* - 설명			: 배송비 SO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class DeliveryChargeSO extends BaseSearchVO<DeliveryChargeSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문번호 */
	private String ordNo;

	/** 회원 쿠폰 사용 여부 */
	private String mbrCpUseYn;
	
	/** 클레임에 대한 배송비 조회용 */
	private String dlvrClmNo;

	/** 클레임에 대한 회수비 조회용 */
	private String rtnDlvrClmNo;

	/** 배송비 번호 */
	private Long dlvrcNo;
	
	/** 배송비 번호 배열 */
	private Object[] arrDlvrcNo;

	/** 취소 클레임 번호 */
	private String cncClmNo;

	/** 취소 여부 */
	private String cncYn;

	/** 원 배송비 번호 */
	private Long orgDlvrcNo;
	
	/** 클레임 번호 */
	private String clmNo;
	
	/** 클레임에 해당하는 원주문의 배송정보 조회를 위한 클레임 번호 */
	private String ordClmNo;
	
	private String orgOrdNo;
	private Integer[] arrOrdDtlSeq;
	
	/** 업체 번호 */
	private Long compNo;
	
	/** 상위 업체 번호 */
	private Long upCompNo;
	
	/** 검색 유형 */
	private String searchType; 
}
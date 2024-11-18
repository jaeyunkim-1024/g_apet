package biz.app.order.model.interfaces;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model.interfaces
* - 파일명		: CisDeliverListVO.java
* - 작성일		: 2021. 2. 2.
* - 작성자		: kek01
* - 설명			: CIS 주문 배송 상태 변경 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class CisOrderDeliveryStateChgVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 상세 상태 코드 */
	private String ordDtlStatCd;
	
	/** 주문 배송지 코드 */
	private Long   ordDlvraNo;
	
	/** 주문 상세 구성 번호 */
	private Long   ordDtlCstrtNo;
	
	/** 주문 번호 */
	private String ordNo;
	
	/** 주문 상세 순번 */
	private int   ordDtlSeq;
	
	/** 주문 구성 순번 */
	private Long   ordCstrtSeq;
	
	/** 구성 상품 아이디 */
	private String cstrtGoodsId;
	
	/** 구성 수량 */
	private Long   cstrtQty;
	
	/** 배송 처리 유형 코드 */
	private String dlvrPrcsTpCd;
	
	/** 회사 구분 코드 */
	private String compGbCd;
	
	/** 클레임 배송 여부 */
	private String clmDlvrYn;
	
	/** 배송 번호들 구분자:콤마 */
	private String dlvrNos;
	
	/** 배치 실행 여부 */
	private String batchExeYn;
	
	/** 클레임 주문 번호 */
	private String clmOrdNo;
	
	/** 클레임 주문 상세 순번 */
	private int   clmOrdDtlSeq;	

}
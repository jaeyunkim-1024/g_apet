package biz.app.order.model.interfaces;

import biz.interfaces.cis.model.request.order.OrderInsertPO;
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
* - 설명			: CIS 주문 배송 지시 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class CisOrderDeliveryCmdVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String ordNo;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;
	
	/** 주문 구성 순번 */
	private Integer ordCstrtSeq;
	
	/** 주문 상세 구성 번호 */
	private Long ordDtlCstrtNo;
	
	/** 배송 처리 유형 코드 */
	private String dlvrPrcsTpCd;
	
	/** 주문 배송지 번호 */
	private Long ordDlvraNo;
	
	/** 업체 구분 코드 */
	private String compGbCd;
	
	/** 클레임 배송 여부 */
	private String clmDlvrYn;
	
	
	/** CIS IF 주문등록 항목 VO */
	private OrderInsertPO orderInsertPO;
	
}
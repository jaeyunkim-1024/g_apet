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
* - 설명			: CIS 회수 상태 변경 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class CisOrderReturnStateChgVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 클레임 상세 상태 코드 */
	private String clmDtlStatCd;
	
	/** 클레임 배송지 코드 */
	private Long   clmDlvraNo;
	
	/** 클레임 상세 구성 번호 */
	private Long   clmDtlCstrtNo;
	
	/** 클레임 번호 */
	private String clmNo;
	
	/** 클레임 상세 순번 */
	private Long   clmDtlSeq;
	
	/** 클레임 구성 순번 */
	private int   clmCstrtSeq;
	
	/** 구성 상품 아이디 */
	private String cstrtGoodsId;
	
	/** 구성 수량 */
	private Long    cstrtQty;
	
	/** 배송 처리 유형 코드 */
	private String dlvrPrcsTpCd;
	
	/** 회사 구분 코드 */
	private String compGbCd;
	
	/** 교환 회수 여부 */
	private String exchgRtnYn;
	
	/** 배송 번호들 구분자:콤마 */
	private String dlvrNos;
	
	/** CIS 클레임번호 */
	private String cisClmNo;
	
	/** CIS 클레임 상세 순번 */
	private int cisClmDtlSeq;
	
	/** 주문 번호 */
	private String ordNo;
	
	/** 주문 상세 순번 */
	private Long   ordDtlSeq;
	
}
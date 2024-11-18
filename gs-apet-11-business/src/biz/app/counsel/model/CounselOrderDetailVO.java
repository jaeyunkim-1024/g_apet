package biz.app.counsel.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.counsel.model
* - 파일명		: CounselOrderDetailVO.java
* - 작성일		: 2017. 6. 9.
* - 작성자		: Administrator
* - 설명			: 상담 주문 상세 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class CounselOrderDetailVO extends BaseSysVO {

	private static final long serialVersionUID = 1L;

	/** 상담 번호 */
	private Long		cusNo;
	
	/** 주문번호 */
	private String		ordNo;	 
	
	/** 주문 상세 번호 */
	private Integer		ordDtlSeq;	 
	
	/** 상품 명 */
	private String	goodsNm;
	
	/** 단품 명 */
	private String	itemNm;
}

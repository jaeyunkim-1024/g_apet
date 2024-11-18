package biz.app.counsel.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.counsel.model
* - 파일명		: CounselOrderDetailPO.java
* - 작성일		: 2017. 6. 9.
* - 작성자		: Administrator
* - 설명			: 상담 주문 상세 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class CounselOrderDetailPO extends BaseSysVO {

	private static final long serialVersionUID = 1L;

	/** 상담 번호 */
	private Long		cusNo;
	
	/** 주문번호 */
	private String		ordNo;	 
	
	/** 주문 상세 번호 */
	private Integer		ordDtlSeq;	 
	
}

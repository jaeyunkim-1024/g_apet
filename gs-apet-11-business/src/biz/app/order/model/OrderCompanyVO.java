package biz.app.order.model;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명		: gs-apet-11-business
 * - 패키지명		: biz.app.order.model
 * - 파일명		: OrderDlvrListVO.java
 * - 작성일		: 2021. 04. 16.
 * - 작성자		: sorce
 * - 설명			: 주문/배송 리스트를 위한 객체
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class OrderCompanyVO {

	/** 업체 번호 */
	private Long compNo;

	/** 업체 명 */
	private String compNm;
	
	private List<OrderInvoiceVO> orderInvoiceListVO;
	

}
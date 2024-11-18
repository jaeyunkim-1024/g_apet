package biz.app.order.model.interfaces.ob;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model.interfaces.ob
* - 파일명		: ObOrderBasePO.java
* - 작성일		: 2017. 9. 18.
* - 작성자		: kimdp
* - 설명			: Outbound API 주문 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ObOrderBasePO extends BaseSysVO {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	private ObOrderHistoryPO obOrderHistoryPO;
	
	/* 마켓명 */
	private String marketNm;
	
	/* 판매자아이디 */
	private String sellerId;
	
	/* 쇼핑몰주문번호 */
	private String shopOrdNo;

	/* 마켓주문상태(10:결제완료,20:배송준비,30:배송완료,40:취소완료) */
	private String marketOrdStd;
	
	/* 쇼핑몰매칭상품코드 */
	private Integer shopPrdNo;

	/* 쇼핑몰상품명 */
	private String shopPrdNm;

	/* 판매자상품번호 */
	private String sellerPrdCd;
	
	/* 매칭옵션명 */
	private String shopPrdOptNm;
	
	/* 처리상태(10:주문수집,19:주문수집에러,20:주문등록,29:주문등록에러) */
	private String procCd;	
	
	/* 주문등록처리자ID */
	private String shopOrdId;
	
	/* 주문등록완료일시 */
	private String shopOrdDt;	

}

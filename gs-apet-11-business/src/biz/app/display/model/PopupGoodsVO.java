package biz.app.display.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PopupGoodsVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 아이디 */
	private String goodsId;

	/** 상품 명 */
	private String goodsNm;

	/** 브랜드 번호 */
	private Long bndNo;
	
	/** 브랜드 명 */
	private String bndNm;

	/** 판매 금액 */
	private Long saleAmt;

	/** 할인 금액 */
	private Long dcAmt;

	/** 이미지 경로 */
	private String imgPath;
	
	/** 홍보 문구 노출 여부 */
	private String prWdsShowYn;
	
	/** 홍보 문구 */
	private String prWds;
	
}
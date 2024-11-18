package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class StGoodsMapPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사이트 ID */
	private Long stId;

	/** 상품 아이디 */
	private String goodsId;

	/** 적립금률 */
	private Long svmnRate;

	/** 사용가능 적립금률 */
	private Long usePsbSvmnRate;

	/** 상품 스타일 코드 */
	private String goodsStyleCd;

	/** 수수료 율 */
	private Double cmsRate;

	/** 업체명 */
	private Long compNo;
	/** 공급금액 */
	private Long splAmt;
	/** 상품금액 */
	private Long saleAmt;
	/** 상품들 */
	private String[] goodsIds;
	
	/** 상품 가격 번호 */
	private Long goodsPrcNo;

}
package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsDescHistPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 설명 이력 번호 */
	private Long goodsDescHistSeq;

	/** 상품 아이디 */
	private String goodsId;

	/** 서비스 구분 코드 */
	private String svcGbCd;

	/** 내용 */
	private String content;

}
package biz.app.goods.model;

import biz.app.st.model.StStdInfoVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class StGoodsMapVO extends StStdInfoVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사이트 ID */
	private Long stId;

	/** 사이트 명 */
	private String stNm;

	/** 사이트 약어 */
	private String stSht;

	/** 사용 여부 */
	private String useYn;

	/** 상품 아이디 */
	private String goodsId;

	/** 수수료 율 */
	private Double cmsRate;

	/** 공급 금액 */
	private Long splAmt;

	/** 적립금률 */
	private Long svmnRate;

	/** 사용가능 적립금률 */
	private Long usePsbSvmnRate;

	/** 상품 스타일 코드 */
	private String goodsStyleCd;

	/** 상품 스타일명 */
	private String goodsStyleNm;

	/** SORT_SEQ */
	private Integer sortSeq;

	private String checkedYn;
}
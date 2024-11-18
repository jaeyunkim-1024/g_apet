package biz.app.goods.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper = true)
public class GoodsRelatedSO extends BaseSearchVO<GoodsRelatedSO> {
	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사이트 아이디 */
	private Long stId;

	/** 웹 모바일 구분 코드 */
	private String webMobileGbCd;

	/** 영상ID */
	private String vdId;

	/** 펫로그 번호 */
	private Long petLogNo;

	/** 후기 여부 */
	private String rvwYn;

	/** 상품추천 여부 */
	private String goodsRcomYn;

	/** 회원 번호 */
	private Long mbrNo;

	/** 펫 번호 */
	private Long petNo;

	private String goodsId;

	private String[] goodsIds;

}

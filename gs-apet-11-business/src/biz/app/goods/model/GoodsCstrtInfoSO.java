package biz.app.goods.model;

import java.util.List;

import org.apache.commons.lang3.StringUtils;

import biz.app.st.model.StStdInfoVO;
import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsCstrtInfoSO extends BaseSearchVO<GoodsCstrtInfoSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 아이디 */
	private String goodsId;

	/** 상품 구성 구분 코드 */
	private String goodsCstrtGbCd;

	/** 구성 상품 아이디 */
	private String cstrtGoodsId;

	/** 사용 여부 */
	private String useYn;

	/** 전시 순서 */
	private Integer dispPriorRank;

	/** 사이트 정보 목록 */
	private List<StStdInfoVO> stStdList;

	private String stUseYn;
	private Long mbrNo;

	private String webMobileGbCd;

	private String frontYn;

	public String getStUseYn () {
		return StringUtils.isEmpty(stUseYn) ? StringUtils.EMPTY : stUseYn;
	}

}
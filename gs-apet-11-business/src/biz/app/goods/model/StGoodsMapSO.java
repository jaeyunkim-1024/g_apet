package biz.app.goods.model;

import org.apache.commons.lang3.StringUtils;

import framework.common.constants.CommonConstants;
import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class StGoodsMapSO extends BaseSearchVO<StGoodsMapSO> {

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

	/** 업체 번호 */
	private Long compNo;

	/** 상품 아이디 */
	private String goodsId;

	/** 상품 스타일 코드 */
	private String goodsStyleCd;

	/** 사이트 ID 검색 */
	private String stIdArea;
	private Long[] stIds;

	/** 사이트 명 검색 */
	private String stNmArea;
	private String[] stNms;


	private String getAll;

	public String getGetAll() {
		return StringUtils.equalsIgnoreCase(CommonConstants.COMM_YN_Y, getAll) ? CommonConstants.COMM_YN_Y : StringUtils.EMPTY;
	}

}
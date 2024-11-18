package biz.app.display.model;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class DisplayPO implements Serializable {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 전시 코너 그리드 */
	private List<DisplayCornerPO> displayCornerPOList;

	/** 전시 코너 아이템 그리드 */
	private List<DisplayCornerItemPO> displayCornerItemPOList;

	/** 전시 상품 그리드 */
	private List<DisplayGoodsPO> displayGoodsPOList;

	/** 관련 브랜드 그리드 */
	private List<DisplayBrandPO> displayBrandPOList;

	/** 기획전 상품 일괄 업로드 */
	private List<DisplayGoodsPO> dipslayGoodsUploadPOList;

	/** 전시 분류 코너 리스트 */
	private List<DisplayClsfCornerPO> displayClsfCornerPOList;
}

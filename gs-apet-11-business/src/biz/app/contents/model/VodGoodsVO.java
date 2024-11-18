package biz.app.contents.model;

import biz.app.goods.model.GoodsBaseVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class VodGoodsVO extends GoodsBaseVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 영상 ID */
	private String vdId;

	/** 이력 번호 */
	private Long histNo;

}
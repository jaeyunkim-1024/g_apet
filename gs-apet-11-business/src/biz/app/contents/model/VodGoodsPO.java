package biz.app.contents.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class VodGoodsPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 영상 ID */
	private String vdId;

	/** 상품 ID */
	private String goodsId;

}
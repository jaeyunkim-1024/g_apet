package biz.app.display.model;

 
import biz.app.goods.model.GoodsBaseVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PopupTargetVO extends GoodsBaseVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 팝업 번호 */
	private Integer popupNo;

}
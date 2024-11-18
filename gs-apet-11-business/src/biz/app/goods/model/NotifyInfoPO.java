package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class NotifyInfoPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 고시 아이디 */
	private String ntfId;

	/** 고시 명 */
	private String ntfNm;

	/** 상세 품목 */
	private String dtlItem;

}
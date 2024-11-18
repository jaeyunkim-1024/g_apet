package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class NotifyItemPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 고시 아이디 */
	private String ntfId;

	/** 고시 항목 아이디 */
	private String ntfItemId;

	/** 항목 명 */
	private String itemNm;

	/** 설명 */
	private String dscrt;

	/** 비고 */
	private String bigo;

	/** 입력 방법 코드 */
	private String inputMtdCd;;

}
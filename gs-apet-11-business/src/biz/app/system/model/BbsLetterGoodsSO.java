package biz.app.system.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BbsLetterGoodsSO extends BaseSearchVO<BbsLetterGoodsSO> {
 
	/** UID */
	private static final long serialVersionUID = 1L;

	/** 글 번호 */
	private Long lettNo;

	/** 상품아이디 */
	private String goodsId;


}
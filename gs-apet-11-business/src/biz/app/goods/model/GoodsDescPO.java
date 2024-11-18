package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsDescPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 내용 */
	private String content;

	/** 서비스 구분 코드 */
	private String svcGbCd;

	/** 상품 아이디 */
	private String goodsId;
	
	
	private String contentPc;
	
	private String contentMobile;

}
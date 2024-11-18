package biz.app.goods.model.interfaces;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.model.interface
* - 파일명		: NotifyItemVO.java
*
*  - 설명		:  고시항목 Value Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class NotifyItemVO extends BaseSysVO {

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

	private String itemVal;
	private String inputMtdCd;

}
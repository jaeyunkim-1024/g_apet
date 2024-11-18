package biz.app.member.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.member.model
* - 파일명		: MemberInterestGoodsPO.java
* - 작성일		: 2016. 4. 26.
* - 작성자		: snw
* - 설명		: 회원 관심 상품 Param Obejct
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class MemberInterestGoodsPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Long mbrNo;

	/** 상품 아이디 */
	private String	goodsId;
	
	/** 보관기간 */
	private Long strgPeriod;

}
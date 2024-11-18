package biz.app.member.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.member.model
* - 파일명		: MemberInterestBrandSO.java
* - 작성일		: 2017. 02. 08.
* - 작성자		: wyjeong
* - 설명		: 회원 관심 상품 Search Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class MemberInterestBrandSO extends BaseSearchVO<MemberInterestBrandSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Long mbrNo;

	/** 브랜드 번호 */
	private Long bndNo;
	
}
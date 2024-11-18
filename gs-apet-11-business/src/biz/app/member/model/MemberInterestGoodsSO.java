package biz.app.member.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.member.model
* - 파일명		: MemberAddressSO.java
* - 작성일		: 2016. 4. 26.
* - 작성자		: snw
* - 설명		: 회원 관심 상품 Search Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class MemberInterestGoodsSO extends BaseSearchVO<MemberInterestGoodsSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Long mbrNo;

	/** 상품 아이디 */
	private String	goodsId;
	private String[]	goodsIds;
	
	/** 전시 분류 번호 */
	private Long dispClsfNo;
	
	/** 사이트 아이디 */
	private Long stId;
	
	/** 웹 구분 */
	private String webMobileGbCd;
	
	/** 디바이스 구분 */
	private String deviceGb;
}
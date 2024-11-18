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
* - 설명		: 회원 주소록 Search Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class MemberAddressSO extends BaseSearchVO<MemberAddressSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Long mbrNo;

	/** 회원 배송지 번호 */
	private Long mbrDlvraNo;

	/** 기본 여부 */
	private String dftYn;

	private String maskingUnlock = "N";
	
}
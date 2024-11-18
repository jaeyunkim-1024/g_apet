package biz.app.member.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.member.model
* - 파일명		: MemberInterestBrandVO.java
* - 작성일		: 2017. 02. 08.
* - 작성자		: wyjeong
* - 설명		: 회원 관심 브랜드 Value Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class MemberInterestBrandVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Integer mbrNo;

	/** 브랜드 번호 */
	private Long bndNo;

	/** 브랜드 소개 이미지 */
	private String bndItrdcImgPath;

	/** 브랜드 소개 모바일 이미지 */
	private String bndItrdcMoImgPath;

	/** 브랜드명 한글 */
	private String bndNmKo;
	private String bndNm;

	/** 브랜드명 영문 */
	private String bndNmEn;

}
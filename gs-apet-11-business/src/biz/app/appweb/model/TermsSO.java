package biz.app.appweb.model;

import java.util.List;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.model
 * - 파일명		: TermsSO.java
 * - 작성일		: 2021. 01. 11. 
 * - 작성자		: LDS
 * - 설 명		: 통합약관 관리 Search Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class TermsSO extends BaseSearchVO<TermsSO> {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 약관 카테고리 코드 */
	private String code;
	
	/** 약관 카테고리 1Depth */
	private String termsCd1;
	
	/** 약관 카테고리 2Depth */
	private String termsCd2;
	
	/** 약관 카테고리 3Depth */
	private String termsCd3;
	
	/** 동의 필수여부 */
	private String rqidYn;
	
	/** 약관 사용여부 */
	private String useYn;
	
	/** 노출 POC 배열 */
	private String[] arrPocGb;
	
	/** 통합약관 번호 */
	private Long termsNo;
	
	/** 버전업 여부 */
	private String verUpYn;
	
	/** 노출 POC*/
	private String pocGbCd;
	
	/** 약관 코드*/
	private String termsCd;
	
	/** 상용자 정의코드1*/
	private String usrDfn1Val;
	
	/** 상용자 정의코드1*/
	private String usrDfn2Val;
	
	/** 상용자 정의코드1*/
	private String usrDfn3Val;
	
	/** 회원 번호 */
	private Long mbrNo;
	
}

package biz.app.appweb.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.model
 * - 파일명		: TermsPO.java
 * - 작성일		: 2021. 01. 11. 
 * - 작성자		: LDS
 * - 설 명		: 통합약관 관리 Param Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class TermsPO extends BaseSysVO {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 약관 번호 */
	private Long termsNo;
	
	/** 사이드ID */
	private int stId = 0;
	
	/** 노출 POC 배열 */
	private String[] arrPocGb;
	
	/** POC */
	private String pocGb = "";
	
	/** 약관 카테고리 1Depth */
	private String termsCd1 = "";
	
	/** 약관 카테고리 2Depth */
	private String termsCd2 = "";
	
	/** 약관 카테고리 3Depth */
	private String termsCd3 = "";
	
	/** 약관 버전 */
	private Long termsVer = 0L;
	
	/** 이전 약관 버전 */
	private Long beTermsVer = 0L;
	
	/** 동의 필수여부 */
	private String rqidYn = "";
	
	/** 약관 사용여부 */
	private String useYn = "";
	
	/** 약관명 */
	private String termsNm = "";
	
	/** 약관 적용기간 시작일 */
	private String termsStrtDt = "";
	
	/** 약관 적용기간 종료일 */
	private String termsEndDt = "";
	
	/** 약관 요약정보 */
	private String smryContent = "";
	
	/** 약관 내용 */
	private String content = "";
	
	/** 게시판 POC > POC 메뉴 코드 */
	private String pocMenuCd = "";
	
}

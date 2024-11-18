package biz.app.appweb.model;

import java.sql.Timestamp;
import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.model
 * - 파일명		: TermsVO.java
 * - 작성일		: 2021. 01. 11. 
 * - 작성자		: LDS
 * - 설 명		: 통합약관 Value Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class TermsVO extends BaseSysVO {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 약관번호 */
	private Long termsNo;
	
	/** 약관 카테고리 1Depth */
	private String termsCd1;
	
	/** 약관 카테고리 2Depth */
	private String termsCd2;
	
	/** 약관 카테고리 3Depth */
	private String termsCd3;
	
	/** 약관 카테고리 코드 */
	private String termsCd;
	
	/** 약관 카테고리명 */
	private String categoryNm;
	
	/** 약관명 */
	private String termsNm;
	
	/** 약관버전 */
	private String termsVer;
	
	/** 약관 적용일시 시작일 */
	private String termsStrtDt;
	
	/** 약관 적용일시 종료일 */
	private String termsEndDt;
	
	/** 동의 필수여부 */
	private String rqidYn;
	
	/** 동의 필수여부명 */
	private String rqidNm;
	
	/** 약관 사용여부 */
	private String useYn;
	
	/** 약관 사용여부명 */
	private String useNm;
	
	/** POC 구분 */
	private String pocGbCd;
	
	/** POC 구분명 */
	private String pocGbNm;
	
	/** 약관 요약정보 */
	private String summaryContent;
	
	/** 약관 내용 */
	private String content;
	
	/** 시스템 등록자 번호 */
	private Long sysRegrNo;
	
	/** 시스템 등록자 명 */
	private String sysRegrNm;
	
	/** 시스템 등록 일시 */
	private Timestamp sysRegDtm;
	
	/** 시스템 등록일 */
	private String sysRegDt;
	
	/** 시스템 수정자 번호 */
	private Long sysUpdrNo;
	
	/** 시스템 수정자 명 */
	private String sysUpdrNm;
	
	/** 시스템 수정 일시 */
	private Timestamp sysUpdDtm;
	
	/** 시스템 수정일 */
	private String sysUpdDt;
	
	/** 최신버전여부 */
	private String newYn;
	
	/** 적용기간 종료 여부 */
	private String endDtCmplYn;
	
	/** depth1 코드*/
	private String usrDfn1Val;

	/** depth2 코드*/
	private String usrDfn2Val;
	
	/** depth3 코드*/
	private String usrDfn3Val;
	
	/** FO약관동의 페이지에서 쓸 것*/
	/** 동의여부 체크한 약관 JSON*/
	private String termsNos;
	
	@Deprecated
	private String emailRcvYn;
	@Deprecated
	private String smsRcvYn;
	
	/** 마케팅 수신여부*/
	private String mkngRcvYn;
	/** 위치정보제공여부*/
	private String pstInfoAgrYn;
	
	private List<TermsVO> listTermsContent;
	
	/** 약관 팝업에서 자동 선택 여부 */
	private String selected;
	
	/** 약관 동의 이력 카운트 */
	private Integer termsHistoryCnt;
	
}

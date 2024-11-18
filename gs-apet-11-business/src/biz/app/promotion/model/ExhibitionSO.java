package biz.app.promotion.model;

import java.sql.Timestamp;
import java.util.List;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.promotion.model
* - 파일명		: ExhibitionSO.java
* - 작성일		: 2017. 5. 31.
* - 작성자		: hongjun
* - 설명		:
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ExhibitionSO extends BaseSearchVO<ExhibitionSO> {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 기획전 번호 */
	private Long exhbtNo;
	
	/** 기획전 명 */
	private String exhbtNm;
	
	/** 기획전 구분 코드 */
	private String exhbtGbCd;
	
	/** 기획전 승인 상태 코드 */
	private String exhbtStatCd;
	
	/** 전시 시작 일시 */
	private Timestamp dispStrtDtm;
	
	/** 전시 종료 일시 */
	private Timestamp dispEndDtm;
	
	/** 전시 여부 */
	private String dispYn;
	
	/** 담당 MD 번호 */
	private Long mdUsrNo;
	
	/** 담당 MD 명 */
	private String mdUsrNm;
	
	/** 업체 번호 */
	private Long compNo;
	
	/** 사이트 아이디 */
	private Long stId;
	
	/** 시스템 등록 일시 */
	private Timestamp sysRegDtm;
	
	/** 등록자 번호 */
	private Long sysRegrNo;
	
	/** 웹 모바일 구분 코드 */
	private List<String> webMobileGbCds;
	private String deviceGb;
	
	/** 기획전 복사 여부 */
	private String copyYn;
	
	private Long upDispClsfNo;
	
	/** 전시 분류 번호 */
	private Long dispClsfNo;
	
	private Long mbrNo;
	
	/** 상품 카테고리 정보 */
	private Long cateCdM;
	private Long cateCdL;
	private Long lnbDispClsfNo;
	
	/* 시스템 등록 일시 : Start */
	private Timestamp sysRegDtmStart;
	
	/* 시스템 등록 일시 : End */
	private Timestamp sysRegDtmEnd;

}
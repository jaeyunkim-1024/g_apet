package biz.app.promotion.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.promotion.model
* - 파일명		: ExhibitionBasePO.java
* - 작성일		: 2017. 5. 30.
* - 작성자		: hongjun
* - 설명		:
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ExhibitionBasePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 기획전 번호 */
	private Long exhbtNo;

	/** 기획전 번호 */
	private Long[] exhbtNos;

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

	/** 키워드 */
	private String kwd;

	/** 담당 MD 번호 */
	private Long mdUsrNo;
	
	/** 담당 MD 명 */
	private String mdUsrNm;

	/** 웹 모바일 구분 코드 */
	private String webMobileGbCd;

	/** 타이틀 HTML */
	private String ttlHtml;

	/** 타이틀 HTML 모바일 */
	private String ttlMoHtml;

	/** 배너 이미지 경로 */
	private String bnrImgPath;

	/** 배너 모바일 이미지 경로 */
	private String bnrMoImgPath;

	/** 상품상세 이미지 경로 */
	private String gdBnrImgPath;

	/** 상품상세 모바일 이미지 경로 */
	private String gdBnrMoImgPath;

	/** 사이트 아이디 */
	private Long stId;

	/** 삭제 여부 */
	private String delYn;

	/** 비고 */
	private String bigo;
	
	/** 태그 번호 */
	private String tagNo;
	
	/** 태그 번호 */
	private String[] tagNos;
	
	/** 기획전 상세타입 */
	private String viewType;
	
	/** 전시 분류 번호  */
	private Long dispClsfNo;
	
	/** SEO 정보 번호  */
	private Long seoInfoNo;
}
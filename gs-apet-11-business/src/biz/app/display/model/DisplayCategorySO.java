package biz.app.display.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayCategorySO extends BaseSearchVO<DisplayCategorySO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 전시 분류 번호 */
	private Long dispClsfNo;

	/** 상위 전시 분류 번호 */
	private Long upDispClsfNo;

	/** 전시 분류 명 */
	private String dispClsfNm;

	/** 기획전 노출 명 */
	private String prmtShowNm;

	/** 전시 분류 코드 */
	private String dispClsfCd;

	/** 전시 분류 코드 */
	private String[] arrDispClsfCd;

	/** 전시 분류 타이틀 이미지 명 */
	private String dispClsfTitleImgNm;

	/** 전시 분류 타이틀 이미지 경로 */
	private String dispClsfTitleImgPath;

	/** 전시 분류 타이틀 HTML(PC) */
	private String dispClsfTitleHtml;

	/** 전시 분류 타이틀 HTML(MOBILE) */
	private String dispClsfTitleHtmlMo;

	/** 전시 우선 순위 */
	private Long dispPriorRank;

	/** 전시 레벨 */
	private long dispLvl;

	/** 전시 시작일자 */
	private Timestamp dispStrtdt;

	/** 전시 종료일자 */
	private Timestamp dispEnddt;

	/** 최하위 여부 */
	private String leafYn;

	/** 리스트타입코드 */
	private String listTpCd;

	/** 전시 여부 */
	private String dispYn;

	/** 상위 전시 여부 */
	private String upDispYn;

	/** 삭제 여부 */
	private String delYn;

	/** 템플릿 번호 */
	private Long tmplNo;

	/** 전시 코너 번호 */
	private Long dispCornNo;

	/** 대표 브랜드 번호 */
	private Long dlgtBndNo;

	/** 상품 아이디 */
	private String goodsId;

	/** 브랜드 구분 코드 */
	private String 	bndGbCd;

	/** 기획전 검색 조건 */
	private String searchPlan;

	/** 사이트 ID */
	private Long stId;

	/** 업체번호 */
	private Long compNo;

	/** 카테고리 조회 구분 */
	private String filterGb ; // G이면 상품 수정,등록과 관련하여 업체에 제한을 둠.

	/** 서브 카테고리 여부 **/
	private String subCateYN;

	/** 대카테고리 이미지 명 */
	private String tnImgNm;

	/** 대카테고리 이미지 경로 */
	private String tnImgPath;
	
	/** 브랜드 번호 */
	private Long bndNo;

	/** SEO 정보 번호 */
	private int seoInfoNo;
	
	/** 기획전 여부 */
	private String exhibitionYn;
	
	/** 평가 카테고리 여부 */
	private String estmYn;
	
	/** 승인여부 */
	private String cfmYn;
	
}
package biz.app.display.model;

import java.sql.Timestamp;
import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayCategoryPO extends BaseSysVO {

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
	private Long dispLvl;

	/** 전시 시작일자 */
	private Timestamp dispStrtdt;

	/** 전시 종료일자 */
	private Timestamp dispEnddt;

	/** 최하위 여부 */
	private String leafYn;

	/** 리스트 타입 코드 */
	private String listTpCd;

	/** 전시 여부 */
	private String dispYn;

	/** 삭제 여부 */
	private String delYn;

	/** 템플릿 번호 */
	private Long tmplNo;

	/** 배너 이미지 명 */
	private String bnrImgNm;

	/** 배너 이미지 경로 */
	private String bnrImgPath;

	/** 배너 모바일 이미지 명 */
	private String bnrMobileImgNm;

	/** 배너 모바일 이미지 경로 */
	private String bnrMobileImgPath;

	/** 전시 배너 번호 */
	private Long dispBnrNo;

	/** 사이트 ID */
	private Long stId;

	/** 업체 번호 */
	private Long compNo;

	/** 브랜드 번호 */
	private Long bndNo;

	/** 대카테고리 이미지 명 */
	private String tnImgNm;

	/** 대카테고리 이미지 경로 */
	private String tnImgPath;
	
	/** 승인여부 */
	private String cfmYn;
	
	/** 승인 사용자 번호 */
	private Long cfmUsrNo;
	
	/** 승인 일시 */
	private Timestamp cfmPrcsDtm;

	/** SEO 정보 번호 */
	private Long seoInfoNo;

	/** 카테고리 필터 정보 */
	private String[] categoryFilters;
	
	/** 전시 코너 리스트*/
	private List<DisplayCornerPO> displayCornerPOlist;
	
	/** LIVE 여부 */
	private String liveYn;
}
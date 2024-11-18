package biz.app.display.model.interfaces;

import java.sql.Timestamp;
import java.util.List;

import biz.app.brand.model.BrandVO;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayCategoryVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 전시 분류 번호 (3단계) */
	private Long dispClsfNo;

	/** 전시 분류 번호 (2단계) */
	private Long dispClsfNo2;
	
	/** 전시 분류 번호 (1단계) */
	private Long dispClsfNo1;

	/** 상위 전시 분류 번호 */
	private Long upDispClsfNo;

	/** 전시 분류 명 (3단계) */
	private String dispClsfNm;

	/** 전시 분류 명 (2단계) */
	private String dispClsfNm2;
	
	/** 전시 분류 명 (1단계) */
	private String dispClsfNm1;
	
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

	/** 전시 레벨 (3단계) */
	private Long dispLvl;

	/** 전시 레벨 (2단계) */
	private Long dispLvl2;
	
	/** 전시 레벨 (1단계) */
	private Long dispLvl1;

	/** 대표전시여부 */
	private String dlgtDispYn;

	/** 전시 시작일자 */
	private Timestamp dispStrtdt;

	/** 전시 종료일자 */
	private Timestamp dispEnddt;

	/** 최하위 여부 (3단계) */
	private String leafYn;

	/** 최하위 여부 (2단계) */
	private String leafYn2;
	
	/** 최하위 여부 (1단계) */
	private String leafYn1;

	/** 리스트 타입 코드 */
	private String listTpCd;

	/** 전시 여부 */
	private String dispYn;

	/** 삭제 여부 */
	private String delYn;

	/** 템플릿 번호 */
	private Long tmplNo;

	/** 하위 전시 갯수 */
	private int lowerDispCnt;

	/** 배너 이미지 명 */
	private String bnrImgNm;

	/** 배너 이미지 경로 */
	private String bnrImgPath;

	/** 배너 모바일 이미지 명 */
	private String bnrMobileImgNm;

	/** 배너 모바일 이미지 경로 */
	private String bnrMobileImgPath;

	/** 기본 배너 여부 */
	private String dftBnrYn;

	/** 배너 LINK URL */
	private String bnrLinkUrl;

	/** 배너 모바일 LINK URL */
	private String bnrMobileLinkUrl;

	/** 전시 배너 번호 */
	private Long dispBnrNo;

	//------------------------------------------------------------------------
	//	fo 에서 쓰는 변수 추가 시작
	//------------------------------------------------------------------------
	private Long cId;

	private Long level;

	/**  카테고리 순서명 */
	private String pathNm;

	/**  대카 번호 */
	private Long mastDispNo;

	/**  정렬값 */
	private String orderBy;

	/** 하위카테고리목록 */
	private List<DisplayCategoryVO> subDispCateList;
	private Long dispCtgLvl1;
	private Long dispCtgLvl2;
	private Long dispCtgLvl3;

	private List<BrandVO> seriesList;

	/** 브랜드 번호 */
	private Long bndNo;
	/** 브랜드 명 국문 */
	private String	bndNmKo;
	/** 브랜드 명 영문 */
	private String	bndNmEn;

	/** 사이트 아이디 */
	private Long stId;

	/** 사이트 명 */
	private String stNm;

	/** 전시 경로 */
	private String ctgPath;

	/** 업체번호 */
	private Long compNo;

	/** 상품 수 */
	private Integer goodsCnt;

	/** 대카테고리 이미지 명 */
	private String tnImgNm;

	/** 대카테고리 이미지 경로 */
	private String tnImgPath;

}
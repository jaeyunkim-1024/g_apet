package biz.app.display.model;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayCornerSO extends BaseSearchVO<DisplayCornerSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 전시 코너 번호 */
	private Long dispCornNo;

	/** 템플릿 번호 */
	private Long tmplNo;

	/** 전시 코너 설명 */
	private String dispCornDscrt;

	/** 노출 개수 */
	private Long showCnt;

	/** 전시 코너 타입 코드 */
	private String dispCornTpCd;

	/** 전시 코너명 */
	private String dispCornNm;

	/** 전시 분류 번호 */
	private Long dispClsfNo;
	
	/** 전시 분류 번호 LNB */
	private Long lnbDispClsfNo;
	
	/** 상품 카테고리 정보 */
	private Long cateCdL;
	private Long cateCdM;
	private Long cateCdS;
	
	/** 전시 분류 번호 */
	private Long dispClsfNo2;
	
	/** 전시 분류 번호 */
	private Long[] dispClsfNos;

	/** 전시 배너 번호 */
	private Long dispBnrNo;

	/** 전시 시작일자 */
	private Timestamp dispStrtdt;

	/** 전시 종료일자 */
	private Timestamp dispEnddt;
	
	private Long mbrNo;

	/** 아이템 번호 */
	private Long itemNo;
	
	private String dispCornNoArea;
	private String[] dispCornNos;
	private String dispCornNmArea;
	private String[] dispCornNms;
	
	/** 사이트 아이디 */
	private Long stId;
	
	/** 웹 모바일 구분 코드 */
	private String webMobileGbCd;
	
	private Long dispCornNoNew;
	private Long dispCornNoBest;
	
	/** 전시 우선 순위 */
	private Long dispPriorRank;
	
	/** 태그 중복 제거*/
	private List<String> listTag;
	
    /** 미리보기 날짜 */
    private String previewDt;
    /** 기획전 번호 */
    private Long exhbtNo;
    
    /** 전시 타입 **/
	private String dispType;

	/** 중복제거 vdId*/
	private List<String> dupleVdIds;
	
	/** 전시 코너에 등록된 태그 */
	private List<String> cornTagNoList;
	
	/** 초기 호출 Cnt */
	private Long dvsnCornerCnt;
}
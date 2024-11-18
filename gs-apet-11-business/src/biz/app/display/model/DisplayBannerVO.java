package biz.app.display.model;

import java.sql.Timestamp;
import java.util.List;

import biz.app.tag.model.TagBaseVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayBannerVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 전시 배너 번호 */
	private Long dispBnrNo;

	/** 배너 TEXT */
	private String bnrText;

	/** 배너 HTML */
	private String bnrHtml;

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

	/** 전시 분류 번호 */
	private Long dispClsfNo;

	/** 전시 코너 번호 */
	private Long dispCornNo;
	
	/** 전시 분류 코너 번호 */
	private Long dispClsfCornNo;

	/** 전시 우선 순위 */
	private Integer dispPriorRank;

	/** 전시 시작일자 */
	private Timestamp dispStrtdt;

	/** 전시 종료일자 */
	private Timestamp dispEnddt;

	/** 삭제 여부 */
	private String delYn;
	
	/** 전시갯수 */
	private Integer showCnt;
	
	/** 아이템번호 */
	private Long dispCnrItemNo;
	
	/** 전시코너타입코드 */
	private String dispCornTpCd;
	
	/** 배너 구분 코드 */
	private String bnrGbCd;
	
	/** 배너 설명 */
	private String bnrDscrt;
	
	/** 상품 ID */
	private String goodsId;
	
	/** 상품 명 */
	private String goodsNm;
	
	/** 전시 노출 차입 코드 */
	private String dispShowTpCd;

	/** 배너 동영상 경로 */
	private String bnrAviPath;

	/** 배너 모바일 동영상 경로 */
	private String bnrMobileAviPath;

	/** 브랜드 콘텐츠 번호 */
	private Long bndCntsNo;

	/** 콘텐츠 타이틀 */
	private String cntsTtl;
	
	/** 배너 번호 */
	private Long bnrNo;
	
	/** 영상 ID */
	private String vdId;

	private String vdGbCd;
	
	/** 배너 사용 여부 */
	private String useYn;
	
	/** 라이브 사용 여부 */
	private String liveYn;

	/** 전시 아이템 태그 맵 리스트 */
	private List<TagBaseVO> bannerTagList;
	
	/** 전시 코너 아이템 태그 리스트 */
	private List<DisplayCornerItemVO> tagList;
}
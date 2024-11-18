package biz.app.display.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayCornerItemPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 전시 분류 코너 번호 */
	private Long dispClsfCornNo;

	/** 전시 배너 번호 */
	private Long dispBnrNo;

	/** 콘텐츠 ID*/
	private String contentId;
	
	/** 전시 시작일자 */
	private Timestamp dispCornerItemStrtdt;

	/** 전시 종료일자 */
	private Timestamp dispCornerItemEnddt;
	
	/** 콘텐츠 전시 시작일자*/
	private Timestamp dispStrtdt;
	
	/** 콘텐츠 전시 종료일자*/
	private Timestamp dispEnddt;
	
	/** 배너 제목*/
	private String bnrTtl;
	
	/** 영상 제목*/
	private String vdTtl;
	
	/** 영상 ID*/
	private String vdId;
	
	/** 전시 우선 순위 */
	private Long dispPriorRank;

	/** 삭제 여부 */
	private String delYn;

	/** 상품평 번호 */
	private Long goodsEstmNo;

	/** 상품 번호 */
	private String goodsId;

	/** 상품 TEXT */
	private String goodsText;

	/** 전시 코너 타입 코드 */
	private String dispCornTpCd;

	/** 배너 TEXT */
	private String bnrText;

	/** 배너 LINK URL */
	private String bnrLinkUrl;

	/** 배너 모바일 LINK URL */
	private String bnrMobileLinkUrl;

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

	/** 아이템 번호 */
	private Long dispCnrItemNo;
	
	/** 배너 구분 코드 */
	private String bnrGbCd;
	
	/** 배너 설명 */
	private String bnrDscrt;

	/** 전시 분류 번호 */
	private Long dispClsfNo;

	/** 배너 동영상 경로 */
	private String bnrAviPath;

	/** 배너 모바일 동영상 경로 */
	private String bnrMobileAviPath;

	/** 브랜트 콘텐츠 번호 */
	private Long bndCntsNo;
	
	/** 태그 번호 */
	private String tagNo;
	
	/** 회원 번호 */
	private Long mbrNo;
	
	/** 펫로그 번호 */
	private Long petLogNo;
	
	/** 배너 번호*/
	private String bnrNo;
	
	/** 배너 아이디*/
	private String bnrId;
	
	/** 사이트 아이디*/
	private String stId;
	
	/** 사용 여부*/
	private String useYn;
	
	/** 시리즈 번호 */
	private Long srisNo;
	
	/** 시즌 번호 */
	private Integer sesnNo;
	
	/** 전시 여부 */
	private String dispYn;
	
	/** 좋아요수 */
	private Integer likeCnt;
	
	/** 공유 수 */
	private Integer shareCnt;
	
	/** 댓글수 */
	private Integer replyCnt;
	
	/** 조회수 */
	private Integer hits;
	
	/** 썸네일 이미지 */
	private String thumPath;
	
	/** 시리즈 명 */
	private String srisNm;
	
	/** 시즌 명 */
	private String sesnNm;
	
	/** 영상 배너 구분*/
	private String bnrVodGb;
}
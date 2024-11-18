package biz.app.display.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayClsfCornerVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 전시 분류 코너 번호 */
	private Long dispClsfCornNo;

	/** 전시 분류 번호 */
	private Long dispClsfNo;

	/** 전시 코너 번호 */
	private Long dispCornNo;

	/** 전시 노출 타입 코드 */
	private String dispShowTpCd;

	/** 전시 기간 설정 여부 */
	private String dispPrdSetYn;

	/** 전시 시작일자 */
	private Timestamp dispStrtdt;

	/** 전시 종료일자 */
	private Timestamp dispEnddt;

	/** 콘텐츠 타이틀 */
	private String cntsTtl;

	/** 콘텐츠 설명 */
	private String cntsDscrt;

	/** 코너 이미지 명 */
	private String cornImgNm;

	/** 코너 이미지 경로 */
	private String cornImgPath;

	/** 코너 모바일 이미지 명 */
	private String cornMobileImgNm;

	/** 코너 모바일 이미지 경로 */
	private String cornMobileImgPath;

	/** 상품 자동 여부 */
	private String goodsAutoYn;

	/** 삭제 여부 */
	private String delYn;

	/** 배너 이미지 - Mobile */
	private String bnrMobileImgNm;

	/** 배너 이미지 경로 - Mobile */
	private String bnrMobileImgPath;

	/** 코너 링크 경로 */
	private String linkUrl;

	/** 코너 모바일 링크 경로 */
	private String mobileLinkUrl;

	/** 코너 BG 컬러값 */
	private String bgColor;

	/** 콘텐츠 구분코드 명 */
	private String dtlNm;

	/** 배너 이미지 - PC */
	private String bnrImgNm;

	/** 배너 이미지 경로 - PC */
	private String bnrImgPath;

	/** 배너 이미지 경로 - 상품 아이디 */
	private String goodsId;

	/** 배너 이미지 경로 - 상품명 */
	private String goodsNm;

	/** 배너 이미지 경로 - 상품 이미지 경로 */
	private String imgPath;

	/** 배너 이미지 경로 - 상품 금액 */
	private String saleAmt;

	/** 배너 이미지 경로 - 상품 금액 */
	private String dcAmt;

	/** 위시리스트 여부 */
	private String interestYn;

	/** 상품 이미지 번호 */
	private String imgSeq;

	/** 홍보 문구 */
	private String prWds;

	/** 홍보문구 사용여부 */
	private String prWdsShowYn;

	/** 베스트 여부 */
	private String bestYn;

	/** 신상품 여부 */
	private String newYn;

	/** 무료배송 여부 */
	private String freeDlvrYn;

	/** 품절 여부 */
	private String soldOutYn;

	/** 쿠폰 여부 */
	private String couponYn;

	/** 사은품 여부 */
	private String freebieYn;

	/** 노출 개수 */
	private Long showCnt;

	/** 전시 코너 타입 코드 */
	private String dispCornTpCd;
}
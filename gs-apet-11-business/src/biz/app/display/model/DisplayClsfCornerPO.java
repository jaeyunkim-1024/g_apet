package biz.app.display.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayClsfCornerPO extends BaseSysVO {

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
	private Timestamp dispClsfCornerStrtdt;

	/** 전시 종료일자 */
	private Timestamp dispClsfCornerEnddt;

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

	/** 코너 링크 경로 */
	private String linkUrl;

	/** 코너 모바일 링크 경로 */
	private String mobileLinkUrl;

	/** 코너 BG 컬러값 */
	private String bgColor;

	/** 상품 자동 여부 */
	private String goodsAutoYn;

	/** 삭제 여부 */
	private String delYn;

	/** 전시 코너 타입 코드 */
	private String dispCornTpCd;

	/** 브랜드 콘텐츠 번호 */
	private Long bndCntsNo;

	/** 웹 모바일 구분 코드 */
	private String webMobileGbCd;

	/** 사이트 id */
	private Long stId;

	/** 회원 번호 */
	private Long mbrNo;

	/** 신규 전시 코너 번호 */
	private Long dispCornNoNew;

	/** 베스트 전시 코너 번호 */
	private Long dispCornNoBest;
}
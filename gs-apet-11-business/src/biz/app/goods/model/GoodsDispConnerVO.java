package biz.app.goods.model;

import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;


/***
 * <pre>
 * - 프로젝트명 : 11.business
 * - 패키지명   : biz.app.goods.model
 * - 파일명     : GoodsDispConnerVO.java
 * - 작성일     : 2021. 03. 04.
 * - 작성자     : valfac
 * - 설명       : 공지 배너 VO
 * </pre>
 */

@Data
@EqualsAndHashCode(callSuper=false)
@NoArgsConstructor
public class GoodsDispConnerVO extends GoodsListVO {

	/** 전시 번호 */
	private Long dispClsfNo;
	/** 전시 코너 번호 */
	private Long dispCornNo;
	/** 전시 분류 코너 번호 */
	private Long dispClsfCornNo;
	/** 아이템 번호 */
	private Long dispCnrItemNo;
	/** 배너 text */
	private String bnrText;
	/** 배너 html */
	private String bnrHtml;
	/** 브랜드 콘텐츠 번호 */
	private Long bndCntsNo;
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
	/** 배너 link url */
	private String bnrLinkUrl;
	/** 배너 모바일 link url */
	private String bnrMobileLinkUrl;
	/** 전시 시작일자 */
	private String dispStrtdt;
	/** 전시 종료일자 */
	private String dispEnddt;
	/** 전시 우선 순위 */
	private Long dispPriorRank;
	/** 삭제 여부 */
	private String delYn;

}

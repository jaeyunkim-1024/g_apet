package biz.app.display.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayBannerSO extends BaseSearchVO<DisplayBannerSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 전시 배너 번호 */
	private Integer dispBnrNo;

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
	private Integer dispClsfNo;
	
	/** 전시 분류 코너 번호 */
	private Long dispClsfCornNo;

}
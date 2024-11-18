package biz.app.display.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class SeoInfoPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** SEO 정보 번호 */
	private Long seoInfoNo;

	/** 사이트 구분 코드 */
	private String seoSvcGbCd;

	/** 전시카테고리 번호 */
	private Long dispClsfNo;

	/** SEO 유형 */
	private String seoTpCd;

	/** 페이지 제목 */
	private String pageTtl;

	/** 페이지 설명 */
	private String pageDscrt;

	/** 페이지 키워드 */
	private String pageKwd;

	/** 페이지 저자 */
	private String pageAthr;

	/** No Index 사용여부 */
	private String noIndexUseYn;

	/** canonicalUrl */
	private String canonicalUrl;

	/** redirectUrl */
	private String redirectUrl;

	/** openGraph 제목 */
	private String openGraphTtl;

	/** openGraph 유형코드 */
	private String openGraphTpCd;

	/** openGraph 설명 */
	private String openGraphDscrt;

	/** openGraph 이미지 */
	private String openGraphImg;

	/** openGraph 동영상 */
	private String openGraphVd;

	/** openGraph 소제목 */
	private String openGraphSmlttl;
	
	/** 기본 설정 여부*/
	private String dftSetYn;
}
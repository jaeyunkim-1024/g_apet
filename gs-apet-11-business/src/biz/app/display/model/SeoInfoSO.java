package biz.app.display.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class SeoInfoSO extends BaseSearchVO<SeoInfoSO> {
	/** UID */
	private static final long serialVersionUID = 1L;

	/** SEO 정보 번호 */
	private Long seoInfoNo;

	/** 사이트 구분 코드 */
	private String seoSvcGbCd;

	/** SEO 유형 */
	private String seoTpCd;

	/** 전시카테고리 번호 */
	private Long dispClsfNo;

	/** 전시카테고리 분류코드 */
	private int dispClsfCd;

	/** 기본설정여부 */
	private String dftSetYn;
	
}

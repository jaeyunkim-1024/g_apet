package biz.app.display.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayTemplateVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 템플릿 번호 */
	private Long tmplNo;

	/** PC웹 URL */
	private String pcwebUrl;

	/** 모바일 URL */
	private String mobileUrl;

	/** 템플릿 설명 */
	private String tmplDscrt;

	/** 템플릿 명 */
	private String tmplNm;
	
	/** 사이트 아이디 */
	private Long stId;	
	
	/** 사이트 명 */
	private String stNm;
}
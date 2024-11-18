package biz.app.display.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayTemplateSO extends BaseSearchVO<DisplayTemplateSO> {

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

	/** 등록일시 시작 */
	private Timestamp strtDtm;

	/** 등록일시 종료 */
	private Timestamp endDtm;

	/** 사이트 아이디 */
	private Integer stId;
}
package biz.app.promotion.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.promotion.model
* - 파일명		: ExhibitionThemeSO.java
* - 작성일		: 2017. 5. 31.
* - 작성자		: hongjun
* - 설명		:
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ExhibitionThemeSO extends BaseSearchVO<ExhibitionThemeSO> {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 테마 번호 */
	private Long thmNo;
	
	/** 기획전 번호 */
	private Long exhbtNo;
	
	/** 업체 번호 */
	private Long compNo;
	
	/** 기획전 승인 상태 코드 */
	private Long exhbtStatCd;

}
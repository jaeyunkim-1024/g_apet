package biz.app.promotion.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.promotion.model
* - 파일명		: ExhibitionMainVO.java
* - 작성일		: 2017. 5. 31.
* - 작성자		: hongjun
* - 설명		:
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ExhibitionMainVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	private Long stat10;
	private Long stat20;
	private Long stat30;
	private Long stat40;

}
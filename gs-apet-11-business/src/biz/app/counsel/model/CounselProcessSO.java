package biz.app.counsel.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.counsel.model
* - 파일명		: CounselProcessSO.java
* - 작성일		: 2017. 5. 10.
* - 작성자		: Administrator
* - 설명			: 상담 처리 조회
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class CounselProcessSO extends BaseSearchVO<CounselProcessSO> {

	private static final long serialVersionUID = 1L;

	/** 상담 번호 */
	private Long cusNo;

	/** 처리 번호 */
	private Long prcsNo;
}

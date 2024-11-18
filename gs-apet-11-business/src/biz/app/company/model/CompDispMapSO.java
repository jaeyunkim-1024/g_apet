package biz.app.company.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class CompDispMapSO extends BaseSearchVO<CompDispMapSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 업체 번호 */
	private Long compNo;

	/** 전시카테고리번호  */
	private Long DispClsfNo;

	/** 사이트 아이디 */
	private Long stId;
	
	/** 전시카테고리 분류코드 */
	private String DispClsfCd;
	

}
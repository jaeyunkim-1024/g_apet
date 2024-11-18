package biz.app.counsel.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CounselFileSO extends BaseSearchVO<CounselFileSO> {

	private static final long serialVersionUID = 1L;

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front area
	//-------------------------------------------------------------------------------------------------------------------------//

	/** 상담번호 */
	private Long cusNo;

}

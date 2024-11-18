package biz.app.st.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class StPolicySO extends BaseSearchVO<StPolicySO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사이트 정책 번호 */
	private Long stPlcNo;
	/** 사이트id */
	private Long stId;
	/** 사이트 정책 구분 코드 */
	private String stPlcGbCd;
	/** 내용 */
	private String content;
	/** 정렬 순서 */
	private Integer sortSeq;
	/** 전시 여부 */
	private String dispYn;
	
	/** 사이트 정책 번호 */ 
	private Long[] arrStPlcNo; 
 
}
package biz.app.tag.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명 : gs-apet-11-business
* - 패키지명   : biz.app.tag.model
* - 파일명     : TagGroupSO.java
* - 작성일     : 2020. 12. 16.
* - 작성자     : ljy01
* - 설명       :
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class TagGroupSO extends BaseSearchVO<TagGroupSO> {
	
	private static final long serialVersionUID = 1L;

	/** 그룹 번호 */
	private String tagGrpNo;
	
	/** 상위 그룹 번호 */
	private String upGrpNo;	
	
	/** 상태 */
	private String stat;
	
	/** 태그 번호 */
	private String tagNo;
	
	/** 정렬 순서 */
	private Long sortSeq;
	
}

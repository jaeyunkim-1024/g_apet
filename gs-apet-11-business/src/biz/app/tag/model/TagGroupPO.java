package biz.app.tag.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명 : gs-apet-11-business
* - 패키지명   : biz.app.tag.model
* - 파일명     : TagGroupPO.java
* - 작성일     : 2020. 12. 16.
* - 작성자     : ljy01
* - 설명       :
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class TagGroupPO extends BaseSysVO {
	
	private static final long serialVersionUID = 1L;

	/** 그룹 번호 */
	private String tagGrpNo;
	
	/** 상위 그룹 번호 */
	private String upGrpNo;
	
	/** 그룹 명 */
	private String grpNm;	
	
	/** 정렬 순서 */
	private Integer sortSeq;
	
	/** 상태 */
	private String stat;
	
	/** 연관어 */
	private String rltTagNo;
	
	/** 유의어 */
	private String synTagNo;
	
}

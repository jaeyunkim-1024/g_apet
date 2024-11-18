package biz.app.tag.model;

import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명 : gs-apet-11-business
* - 패키지명   : biz.app.tag.model
* - 파일명     : TagGroupVO.java
* - 작성일     : 2020. 12. 16.
* - 작성자     : ljy01
* - 설명       :
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class TagGroupVO extends BaseSysVO {
	
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
	
	/** 하위 그룹 리스트 */
	private List<TagGroupVO> listTagGroupVO;
	
}

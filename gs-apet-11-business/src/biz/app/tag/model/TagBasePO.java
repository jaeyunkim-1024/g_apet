package biz.app.tag.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명 : gs-apet-11-business
* - 패키지명   : biz.app.tag.model
* - 파일명     : TagBasePO.java
* - 작성일     : 2020. 12. 16.
* - 작성자     : ljy01
* - 설명       :
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class TagBasePO extends BaseSysVO {
	
	private static final long serialVersionUID = 1L;

	/** 태그 번호 */
	private String tagNo;
	
	/** 태그 명 */
	private String tagNm;
	
	/** 그룹 번호 */
	private String tagGrpNo;
	
	/** 출처 코드 */
	private String srcCd;
	
	/** 상태 코드 */
	private String statCd;
	
	/** 유의어 태그 번호 */
	private String synTagNo;
	
	/** 연관어 태그 번호 */
	private String rltTagNo;
	
	private String tagGrpArea;
	private String[] tagGrpNos;
	
	private String synTagNoArea;
	private String[] synTagNos;
	
	private String rltTagNoArea;
	private String[] rltTagNos;
	
	/** 사용 횟수 */
	private Integer useCnt;
	
	/** 신조어에서 사전으로 등록여부 */
	private String reSaveYn;
}

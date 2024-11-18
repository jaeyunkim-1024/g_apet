package biz.app.promotion.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.promotion.model
* - 파일명		: ExhibitionThemePO.java
* - 작성일		: 2017. 5. 30.
* - 작성자		: hongjun
* - 설명		:
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ExhibitionThemePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 테마 번호 */
	private Long thmNo;
	
	/** 기획전 번호 */
	private Long exhbtNo;
	
	/** 테마 명 */
	private String thmNm;
	
	/** 리스트 타입 코드 */
	private String listTpCd;
	
	/** 전시 여부 */
	private String dispYn;
	
	/** 테마 명 노출 여부 */
	private String thmNmShowYn;
	
	/** 업체 번호 */
	private Long compNo;

	/** 전시 우선 순위 */
	private Integer dispPriorRank;
	
	/** 삭제 여부 */
	private String delYn;
}
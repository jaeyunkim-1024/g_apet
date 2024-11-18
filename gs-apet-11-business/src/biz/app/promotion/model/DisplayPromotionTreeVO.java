package biz.app.promotion.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class DisplayPromotionTreeVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String id;

	private String text;

	private String parent; 

	private DisplayPromotionTreeStateVO state;

	private Boolean leaf;
	
	/** 전시 분류 번호 */
	private Integer dispClsfNo;

	/** 브랜드 번호 */
	private Integer prmtNo;

	/** 전시 우선 순위 */
	private Integer dispPriorRank;

	private String dispCtgPath;
	
	private String stNm;
	
}

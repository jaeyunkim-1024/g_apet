package biz.app.brand.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class DisplayBrandTreeVO implements Serializable {

	private static final long serialVersionUID = 1L;
 
	private String id;

	private String text;

	private String parent; 

	private DisplayBrandTreeStateVO state;

	private Boolean leaf;
	
	/** 전시 분류 번호 */
	private Integer dispClsfNo;

	/** 팝업 번호 */
	private Integer bndNo;

	/** 전시 우선 순위 */
	private Integer dispPriorRank;

	private String dispCtgPath;
	
	private String stNm;
	
}

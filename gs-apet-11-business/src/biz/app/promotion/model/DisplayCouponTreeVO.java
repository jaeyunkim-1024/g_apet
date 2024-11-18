package biz.app.promotion.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class DisplayCouponTreeVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String id;

	private String text;

	private String parent;

	private DisplayCouponTreeStateVO state;

	private Boolean leaf;
	
	/** 전시 분류 번호 */
	private Integer dispClsfNo;

	/** 쿠폰번호  */
	private Long cpNo;

	/** 전시 우선 순위 */
	private Integer dispPriorRank;

	private String dispCtgPath;
	
	private String stNm;
}

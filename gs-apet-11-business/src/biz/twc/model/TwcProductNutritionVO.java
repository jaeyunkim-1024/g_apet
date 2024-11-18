package biz.twc.model;

import lombok.Data;

/**
 * <pre>
 * - 프로젝트명 : batch
 * - 패키지명   : biz.twc.model
 * - 파일명     : TwcProductNutritionVO.java
 * - 작성일     : 2021. 03. 31.
 * - 작성자     : valfac
 * - 설명       :
 * </pre>
 */

@Data
public class TwcProductNutritionVO {

	private Integer id;
	private String crudeProtein;
	private String crudeFat;
	private String crudeFiber;
	private String ash;
	private String calcium;
	private String phosphorus;
	private String omega3;
	private String omega6;
	private String moisture;
	private String other;
	private String dryMatterCrudeProtein;
	private String dryMatterCrudeFat;
	private String dryMatterCrudeFiber;
	private String dryMatterAsh;
	private String dryMatterCalcium;
	private String dryMatterPhosphorus;
	private String dryMatterOmega3;
	private String dryMatterOmega6;
	private String carbohydrate;
	private Integer productId;

}

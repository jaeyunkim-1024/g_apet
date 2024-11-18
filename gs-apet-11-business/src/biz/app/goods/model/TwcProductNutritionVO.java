package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: TwcProductNutritionVO.java
* - 작성일	: 2021. 1. 29.
* - 작성자	: valfac
* - 설명 	: 성분 영양 PO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
public class TwcProductNutritionVO extends BaseSysVO {
	
	private Integer id;
	
	/** 조단백질(수분포함)  */
	private String crudeProtein;
	
	/** 조지방(수분포함)   */
	private String crudeFat;
	
	/** 조섬유질(수분포함)  */
	private String crudeFiber;
	
	/** 조회분(수분포함)   */
	private String ash;
	
	/** 칼슘(수분포함)    */
	private String calcium;
	
	/** 인(수분포함)      */
	private String phosphorus;
	
	/** 오메가3(수분포함)  */
	private String omega3;
	
	/** 오메가6(수분포함)  */
	private String omega6;
	
	/** 수분            */
	private String moisture;
	
	/** 기타성분         */
	private String other;
	
	/** 조단백질(수분제거)  */
	private String dryMatterCrudeProtein;
	
	/** 조지방(수분제거)   */
	private String dryMatterCrudeFat;
	
	/** 조섬유질(수분제거)  */
	private String dryMatterCrudeFiber;
	
	/** 조회분(수분제거)   */
	private String dryMatterAsh;
	
	/** 칼슘(수분제거)    */
	private String dryMatterCalcium;
	
	/** 인(수분제거)      */
	private String dryMatterPhosphorus;
	
	/** 오메가3(수분제거)  */
	private String dryMatterOmega3;
	
	/** 오메가6(수분제거)  */
	private String dryMatterOmega6;
	
	/** 탄수화물(수분제거)  */
	private String carbohydrate;
	
	/** TWC상품번호      */
	private Integer productId;
	
}

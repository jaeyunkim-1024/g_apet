package biz.app.goods.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.model
* - 파일명 	: TwcProductVO.java
* - 작성일	: 2021. 1. 29.
* - 작성자	: valfac
* - 설명 		: 성분 정보 VO
* </pre>
*/
@Data
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
public class TwcProductVO extends BaseSysVO {

	/** TWC 상품 번호 */
	private Integer id;

	/** 상품명 */
	private String name = "";
	
	/** 브랜드명 */
	private String brandName = "";
	
	/** 어바웃펫(펫츠비) 상품 코드 */
	private String productCode = "";
	
	/** 자체 상품 코드 */
	private String petsbeId = "";
	
	/** 서비스 대상 */
	private String appName = "";
	
	/** 유형 */
	private String type = "";
	
	/** 향 */
	private String scent = "";
	
	/** 생애주기 */
	private String lifeStage = "";

	/** 상품 권장 연령 */
	private String recommendAge = "";
	
	/** 반려동물 사이즈 */
	private String breedSize = "";
	
	/** 제조사 */
	private String manufacturer = "";
	
	/** 수입사 */
	private String importer = "";
	
	/** 원산지 */
	private String countryOfOrigin = "";
	
	/** 유통기한 */
	private String expiryText = "";
	
	/** 유통기한 읽는법 */
	private String expiryDesc = "";
	
	/** 제품 크기 */
	private String productDimensions = "";
	
	/** 용량/중량 */
	private String capacityWeight = "";
	
	/** 사이즈 */
	private String size = "";
	
	/** 칼로리 */
	private String calorie = "";
	
	/** 포장 */
	private String packagingType = "";
	
	/** 소포장 단위 */
	private String innerPacking = "";
	
	/** 털길이 */
	private String hairType = "";

	/** 색상 */
	private String color = "";
	
	/** 주요 원료 */
	private String material = "";
	
	/** \R\N수량(매수) */
	private String quantity = "";

	/** 주요 성분 */
	private String mainNutrition = "";
	
	/** 동물성 원료 */
	private String animalIngredient = ""; //삭제항목 20210406
	
	/** 식물성 원료 */
	private String vegetableIngredient = ""; //삭제항목 20210406
	
	/** 배변 유도제 함유 여부 */
	private String petInducer = "";
	
	/** 사료 등급 */
	private String feedGrade = "";

	/** 그레인 프리 여부 */
	private String grainFree = "";

	/** AAFCO 기준 충족 여부 */
	private String aafco = "";

	/** 타사 존재 유무 */
	private String existence = "";
	
	/** 재포장여부(소분) */
	private String repackaging = "";
	
	/** 작업자 의견 */
	private String commentOperator = "";
	
	/** GSN 의견 */
	private String commentGsn = "";
	
	/** MD 의견 */
	private String commentMd = "";
	
	/** 설명(안내) */
	private String feedingGuideline = "";
	
	/** 보관방법 */
	private String storageInstructions = "";
	
	/** 특징 */
	private String feature = "";
	
	private Timestamp createDate;
	private String createBy = "";
	private String modifyBy = "";
	private Timestamp modifyDate;
	private String status = "";
	private String cautionAdditive = "";
	private Integer descriptionId;

	//추가항목 20210406
	private String code = "";
	private String suggestAge = "";
	private String endAgeMonth = "";
	private String startAgeMonth = "";
	private String tags = "";
	private String category = "";
	private String description = "";

}

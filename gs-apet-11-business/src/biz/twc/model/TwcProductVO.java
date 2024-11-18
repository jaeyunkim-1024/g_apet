package biz.twc.model;

import lombok.Data;

/**
 * <pre>
 * - 프로젝트명 : batch
 * - 패키지명   : biz.twc.model
 * - 파일명     : TwcProductVO.java
 * - 작성일     : 2021. 03. 31.
 * - 작성자     : valfac
 * - 설명       :
 * </pre>
 */

@Data
public class TwcProductVO {
	private Integer id;
	private String name;            //상품명
	private String brandName;       //상품 브랜드 이름
	private String productCode;     //제품 코드
	private String petsbeId;        //펫츠비 Id
	private String appName;         //채널
	private String type;            //타입
	private String scent;           //향
	private String lifeStage;       //생애주기
	private String recommendAge;    //권장 연령
	private String breedSize;       //반려동물사이즈
	private String manufacturer;    //제조사
	private String importer;        //수입사(매입처)
	private String countryOfOrigin; //원산지
	private String expiryText;      //유통 날짜 또는 기한
	private String expiryDesc;      //유통 날짜 또는 기한 설명
	private String productDimensions;//제품크기
	private String capacityWeight;  //용량
	private String size;            //크기
	private String calorie;         //칼로리
	private String packagingType;   //포장
	private String innerPacking;    //소포장단위
	private String hairType;        //털길이
	private String color;           //색상
	private String material;        //소재.재질
	private String quantity;        //수량(매수)
	private String mainNutrition;   //성분구성
	private String petInducer;      //배변유도제함유
	private String feedGrade;       //사료등급
	private String grainFree;       //그레인프리여부
	private String aafco;           //AAFCO 기준충족
	private String existence;       //타사존재여부(타사이트에 동일한 상품 존재여부)
	private String repackaging;     //재포장여부(소분)
	private String commentOperator; //기타(작업자의견)
	private String commentGsn;      //기타(GSN의견)
	private String commentMd;       //기타(MD의견)
	private String feedingGuideline;//권장급여방법
	private String storageInstructions;//보관방법
	private String feature;         //특징/기능
	private String createDate;      //등록일
	private String createBy;        //생성 ID
	private String modifyDate;      //수정일
	private String status;          //상태
	private String cautionAdditive; //주의 펫푸드 첨가물
	private Integer descriptionId;  //설명 ID
	private String description;     //설명
	private String code;            //관리 코드
	private String suggestAge;      //전연령,유아기,성년기,노령기
	private String category;        //새컬럼 등장
	private String tags;            //어디쓰는건지..
	private String modifyBy;
}

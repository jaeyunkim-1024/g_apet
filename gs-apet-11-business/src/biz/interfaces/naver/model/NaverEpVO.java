package biz.interfaces.naver.model;

import com.opencsv.bean.CsvBindByName;
import com.opencsv.bean.CsvBindByPosition;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * <pre>
 * - 프로젝트명 : 11.business
 * - 패키지명   : biz.interfaces.naver.model
 * - 파일명     : NaverEpVO.java
 * - 작성일     : 2021. 03. 02.
 * - 작성자     : valfac
 * - 설명       :
 * </pre>
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NaverEpVO implements Serializable {

	@CsvBindByName(column = "id") @CsvBindByPosition(position = 0)
	private String id;                          //[필수]상품 ID
	@CsvBindByName(column = "title") @CsvBindByPosition(position = 1)
	private String title;                       //[필수]상품명
	@CsvBindByName(column = "pricePc") @CsvBindByPosition(position = 2)
	private String pricePc;                    //[필수]상품 가격 - 쿠폰 적용가
	@CsvBindByName(column = "normalPrice") @CsvBindByPosition(position = 3)
	private String normalPrice;                //모바일 상품 가격
	@CsvBindByName(column = "link") @CsvBindByPosition(position = 4)
	private String link;                        //[필수]상품 URL
	@CsvBindByName(column = "mobileLink") @CsvBindByPosition(position = 5)
	private String mobileLink;                 //상품 모바일 URL
	@CsvBindByName(column = "imageLink") @CsvBindByPosition(position = 6)
	private String imageLink;                  //[필수]이미지 URL
	@CsvBindByName(column = "addImageLink") @CsvBindByPosition(position = 7)
	private String addImageLink;              //추가 이미지 URL  구분값 | 기준 최대 10개 가능
	@CsvBindByName(column = "categoryName1") @CsvBindByPosition(position = 8)
	private String categoryName1;              //[필수]제휴사 카테고리명(대분류)
	@CsvBindByName(column = "categoryName2") @CsvBindByPosition(position = 9)
	private String categoryName2;              //제휴사 카테고리명(중분류)
	@CsvBindByName(column = "categoryName3") @CsvBindByPosition(position = 10)
	private String categoryName3;              //제휴사 카테고리명(소분류)
	@CsvBindByName(column = "categoryName4") @CsvBindByPosition(position = 11)
	private String categoryName4;              //제휴사 카테고리명(세분류) x
	@CsvBindByName(column = "naverCategory") @CsvBindByPosition(position = 12)
	private String naverCategory;              //네이버 카테고리
	@CsvBindByName(column = "naverProductId") @CsvBindByPosition(position = 13)
	private String naverProductId;            //카탈로그 페이지 ID
	@CsvBindByName(column = "condition") @CsvBindByPosition(position = 14)
	private String condition;                   //상품상태 nullable [default:신상품][validate:신상품,중고]
	@CsvBindByName(column = "importFlag") @CsvBindByPosition(position = 15)
	private String importFlag;                 //해외구매대행 여부 nullable [해외구매대행 상품:Y]
	@CsvBindByName(column = "parallelImport") @CsvBindByPosition(position = 16)
	private String parallelImport;             //병행수입 여부 nullable [병행수입 상품:Y]
	@CsvBindByName(column = "orderMade") @CsvBindByPosition(position = 17)
	private String orderMade;                  //주문제작상품 여부 nullable [주문제작상품:Y]
	@CsvBindByName(column = "productFlag") @CsvBindByPosition(position = 18)
	private String productFlag;                //판매방식 구분 nullable [validate:도매,렌탈,대여,할부,예약판매,구매대행,예약구매]
	@CsvBindByName(column = "adult") @CsvBindByPosition(position = 19)
	private String adult;                       //미성년자 구매불가 상품 여부 nullable [성인인증 로그인이 필요한 상품:Y]
	@CsvBindByName(column = "modelNumber") @CsvBindByPosition(position = 20)
	private String modelNumber;                //FIXME
	@CsvBindByName(column = "brand") @CsvBindByPosition(position = 21)
	private String brand;                       //브랜드
	@CsvBindByName(column = "maker") @CsvBindByPosition(position = 22)
	private String maker;                       //제조사
	@CsvBindByName(column = "origin") @CsvBindByPosition(position = 23)
	private String origin;                      //원산지
	@CsvBindByName(column = "eventWords") @CsvBindByPosition(position = 24)
	private String eventWords;                 //FIXME 이벤트
	/**
	 * 일반쿠폰만 : 1000원, 10%
	 * 일반쿠폰, 정율제휴쿠폰만 : 1000원^5, 10%^5
	 * 정율제휴쿠폰만 : ^5
	 * 정액제휴쿠폰만 : ^^1000
	 */
	@CsvBindByName(column = "coupon") private String coupon;                      //일반/제휴쿠폰 구분값은 ^ - 기준 일반쿠폰(원단위 콤마제외, 할인율 % 포함)^제휴쿠폰(정률, 소수점1자리)^제휴쿠폰(정액, 숫자만 표기)
	@CsvBindByName(column = "interestFreeEvent") private String interestFreeEvent;         //카드 무이자 할부 정보 카드명^무이자할부개월수 | 구분자로 카드 구분 ex) 삼성카드^2~3|신한카드^2~3|현대카드^2~3
	@CsvBindByName(column = "point") private String point;                       //포인트 포인트명^포인트금액
	@CsvBindByName(column = "installationCosts") private String installationCosts;          //별도 설치비 유무 nullable [설치비 추가:Y]
	@CsvBindByName(column = "searchTag") private String searchTag;                  //검색태그 띄워쓰기없이 |구분자, 최대 10개, max 100자
	@CsvBindByName(column = "minimumPurchaseQuantity") private String minimumPurchaseQuantity;   //최소구매수량
	@CsvBindByName(column = "reviewCount") private String reviewCount;                //상품평(리뷰, 구매평)개수 nullable or 0
	@CsvBindByName(column = "shipping") private String shipping;                    //[필수]배송료, 원화기준 정수만 사용가능, 무료배송 0, 착불 -1, 조건부 배송일 경우 1개 상품 기준 조건부가 넘지 않을 경우 기본 배송비 표기
	@CsvBindByName(column = "deliveryGrade") private String deliveryGrade;              //차등배송비 여부 nullable [배송비 추가로 발생할 경우:Y]
	@CsvBindByName(column = "deliveryDetail") private String deliveryDetail;             //차등배송비 내용 nullable [배송비 추가로 발생할 경우 상세 내용]
	@CsvBindByName(column = "attribute") private String attribute;                   //상품속성 ex) 서울^1개^오션뷰^2명^주중^조식포함^무료주차^와이파이
	@CsvBindByName(column = "ageGroup") private String ageGroup;                   //주 이용 고객층 nullable [default:성인][validate:성인,유아,아동,청소년]
	@CsvBindByName(column = "gender") private String gender;                      //성별 nullable [validate:남녀공용,남성,여성]
}

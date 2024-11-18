package biz.interfaces.cis.model.request.order;

import lombok.Data;

@Data
public class OrderInsertItemPO {
	
	/** 단품 코드 - 필수 */
	private String skuCd;			//상품등록 시 CIS에 전송된 상품코드

	/** 단품 이름 - 필수 */
	private String skuNm;

	/** 옵션 내용 */
	private String optTxt;

	/** 단위 - 필수 */
	private String unitNm;

	/** 가격 - 필수 */
	private int price=0;

	/** 수량 - 필수 */
	private int ea=0;

	/** 구성 구분 코드 - 필수 */
	private String cstrtGbCd;		//10:단품, 20:세트, 30: 사은품
	
	/** 화주 코드 - 필수 */
	private String ownrCd;

	/** 물류센터 코드 - 필수 */
	private String wareCd;

	/** 출고 유형 코드 - 필수 */
	private String drelTpCd;		//SO1 : 온라인, SO2 : 오프라인

	/** 배송 유형 코드 - 필수 */
	private String dlvtTpCd;		//10 : 택배, 20 : 당일배송, 21 : 새벽배송, 30 : 자체배송, 40 : 퀵배송

	/** 도착지 코드 - 필수 */
	private String arrvCd;

	/** 배송 권역 코드 */
	private String dlvGrpCd;		//당일/새벽배송일 경우 필수
	
	/** 새벽배송 배송센터코드 */
	private String dawnMallId;
	
	/** 배송 요청일자 */
	private String dlvReqDd;

	/** 상점 주문번호 - 필수 */
	private String shopOrdrNo;		//aboutPet 주문번호

	/** 상점 주문순번 - 필수 */
	private String shopSortNo;		//aboutPet (주문상세순번_주문구성순번) 으로 조합 [주의!!]

	/** 교환주문여부 */
	private String exchgYn;

	/** 원 상점 주문 번호 */
	private String orgShopOrdrNo;	//교환주문일 경우 원 주문의 상점 주문번호
	
	/** 원 상점 주문 순번 */
	private String orgShopSortNo;	//교환주문일 경우 원 주문의 상점 주문순번
	
	/** 비고 */
	private String rmkTxt;


	/*****************************/
	/** 필요에 의해 추가            */
	/*****************************/
	/** 배송비 번호 */
	private Long dlvrcNo;
	/** 업체 구분 코드 */
	private String compGbCd;
	/** 업체 번호 */
	private String compNo;
	/** 주문 상세 구성 번호 */
	private Long ordDtlCstrtNo;
	
}

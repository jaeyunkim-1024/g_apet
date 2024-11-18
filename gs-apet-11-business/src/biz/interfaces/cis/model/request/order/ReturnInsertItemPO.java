package biz.interfaces.cis.model.request.order;

import lombok.Data;

@Data
public class ReturnInsertItemPO {
	
	private String shopOrdrNo;		/** 상점 주문번호 - 필수*/	//aboutPet 주문번호
	private String shopSortNo;		/** 상점 주문순번 - 필수*/	//aboutPet (주문상세순번_주문구성순번) 으로 조합 [주의!!]
	private int    ea=0;			/** 반품 수량 - 필수*/
	private String dlvCmpyCd;		/** 택배사 코드 */
	private String rmkTxt;			/** 비고 */
	private String exchgYn;			/** 교환반품 여부 - 교환이면 Y */
	
	/*****************************/
	/** 필요에 의해 추가            */
	/*****************************/
	private String  dlvtTpCd;		/** 배송유형코드 */
	private String  clmNo;			/** 클레임 번호 */
	private Integer clmDtlSeq;		/** 클레임 상세 순번 */
	private Integer clmCstrtSeq;	/** 클레임 구성 순번 */
	private Long    clmDtlCstrtNo;	/** 클레임 상세 구성 번호 */
//	private Long   dlvrcNo;			/** 배송비 번호 */
//	private String compGbCd;		/** 업체 구분 코드 */
//	private String compNo;			/** 업체 번호 */
}

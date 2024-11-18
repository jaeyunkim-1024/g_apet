package biz.app.order.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderDetailPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String ordNo;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;

	/** 주문 상세 상태 코드 */
	private String ordDtlStatCd;

	/** 상품 아이디 */
	private String goodsId;
	
	/** 묶음 상품 아이디 */
	private String pakGoodsId;

	/** 상품 명 */
	private String goodsNm;

	/** 단품 번호 */
	private Long itemNo;

	/** 단품 명 */
	private String itemNm;

	/** 딜 상품 아이디 */
	private String dealGoodsId;

	/** 전시 분류 번호 */
	private Long dispClsfNo;

	/** 업체상품 아이디 */
	private String compGoodsId;

	/** 업체단품 아이디 */
	private String compItemId;

	/** 주문 수량 */
	private Integer ordQty;

	/** 잔여 주문 수량 */
	private Integer rmnOrdQty;

	/** 상품 가격 번호 */
	private Long 	goodsPrcNo;
	
	/** 판매 금액 */
	private Long saleAmt;

	/** 결제 금액 */
	private Long payAmt;

	/** 잔여 결제 금액 */
	private Long rmnPayAmt;
	
	/** 수수료 */
	private Long cms;

	/** 상품수수료율 */
	private Double goodsCmsnRt;

	/** 과세 구분 코드 */
	private String taxGbCd;

	/** 부여 적립금 */
	private Long ordSvmn;

	/** 적립금 유효기간 코드 */
	private String svmnVldPrdCd;
	
	/** 적립금 유효기간 */
	private Integer svmnVldPrd;
	
	/** 배송비 번호 */
	private Long dlvrcNo;

	/** 무료 배송 여부 */
	private String freeDlvrYn;

	/** 핫 딜 여부 */
	private String	hotDealYn;
	
	/** 주문 배송지 번호 */
	private Long ordDlvraNo;

	/** 업체 번호 */
	private Long compNo;

	/** 상위 업체 번호 */
	private Long upCompNo;

	/** 회원 번호 */
	private Long mbrNo;

	/** 외부 주문 상세 번호 */
	private String outsideOrdDtlNo;

	/** 취소 수량 */
	private Integer cncQty;

	/** 반품 수량 */
	private Integer rtnQty;

	/** MD 사용자 번호 */
	private Long 	mdUsrNo;


	/** 상품 평가 등록 여부 */
	private String goodsEstmRegYn;
	
	/** 상품 평가 번호 */
	private Long goodsEstmNo;

	/** 배송번호*/
	private Long dlvrNo;
	
	/** 배송 완료 사진 URL */
	private String dlvrCpltPicUrl;
	
	/** 배송 완료 여부 */
	private String dlvrCpltYn;
	
	/** 발급 예정 포인트 */
	private Integer isuSchdPnt;
	
	/** 각인 문구 여부*/
	private String mkiGoodsYn;
	
	/** 각인 문구 */
	private String mkiGoodsOptContent;
	
	/** 예약 상품 여부 */
	private String rsvGoodsYn;
	
	/** 주문상세 전체 배송완료여부 */
	private String ordDtlAllDlvrCpltYn;

}
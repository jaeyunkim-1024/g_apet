package biz.app.order.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderDetailDivVO extends BaseSysVO {

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

	/** 상품 명 */
	private String goodsNm;

	/** 단품 번호 */
	private Integer itemNo;

	/** 단품 명 */
	private String itemNm;


	/** 딜 상품 아이디 */
	private String dealGoodsId;

	/** 전시 분류 번호 */
	private String dispClsfNo;

	/** 업체 상품 번호 */
	private String compGoodsNo;

	/** 업체 단품 번호 */
	private String compItemNo;

	/** 판매 금액 */
	private Long saleAmt;

	/** 주문 수량 */
	private Long ordQty;

	/** 결제 금액 */
	private Long payAmt;

	/** 공급 금액 */
	private Long splAmt;

	/** 상품수수료율 */
	private Double goodsCmsnRt;

	/** 상품 쿠폰 할인 금액 */
	private Long goodsCpDcAmt;

	/** 배송비 쿠폰 할인 금액 */
	private Long dlvrcCpDcAmt;

	/** 조립비 쿠폰 할인 금액 */
	private Long asbcCpDcAmt;

	/** 장바구니 쿠폰 할인 금액 */
	private Long cartCpDcAmt;

	/** 적립금 할인 금액 */
	private Long svmnDcAmt;



	/** 결제 번호 */
	private Integer payNo;

	/** 배송비 번호 */
	private Integer dlvrcNo;

	/** 조립비 번호 */
	private Integer asbcNo;

	/** 업체 번호 */
	private Long compNo;

	/** 업체 명 */
	private String compNm;

	/** 업체 계약 번호 */
	private String compContrNo;

	/** 회원 번호 */
	private Integer mbrNo;

	/** 배송 희망 일자 */
	private String dlvrHopeDt;

	/** 상품 준비 일시 */
	private Timestamp goodsPrpDtm;

	/** 출고 지시 일시 */
	private Timestamp ooCmdDtm;

	/** 출고 완료 일시 */
	private Timestamp ooCpltDtm;

	/** 배송 완료 일시 */
	private Timestamp dlvrCpltDtm;

	/** 상품 평가 등록 여부 */
	private String goodsEstmRegYn;

	//===============================================================
	// 배송지
	//===============================================================
	/** 배송 번호 */
	private Long dlvrNo;

	/** 주문 클레임 구분 코드 */
	private String ordClmGbCd;

	/** 클레임 번호 */
	private String clmNo;

	/** 클레임 상세 순번 */
	private Long clmDtlSeq;

	/** 배송 처리 유형 코드 */
	private String dlvrPrcsTpCd;

	/** 택배사 코드 */
	private String hdcCd;

	/** 송장 번호 */
	private String invNo;

	/** 배송정책번호 */
	private Integer dlvrcPlcNo;

	/** 우편 번호 구 */
	private String postNoOld;

	/** 우편 번호 신 */
	private String postNoNew;

	/** 도로 주소 */
	private String roadAddr;

	/** 도로 상세 주소 */
	private String roadDtlAddr;

	/** 지번 주소 */
	private String prclAddr;

	/** 지번 상세 주소 */
	private String prclDtlAddr;

	/** 전화 */
	private String tel;

	/** 휴대폰 */
	private String mobile;

	/** 이메일 */
	private String email;

	/** 수취인 명 */
	private String adrsNm;

	/** 배송 메모 */
	private String dlvrMemo;

	/** 직배송아이ㅣ */
	private String areaId;

}
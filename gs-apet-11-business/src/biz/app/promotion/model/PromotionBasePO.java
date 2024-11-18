package biz.app.promotion.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PromotionBasePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 프로모션 번호 */
	private Long prmtNo;

	/** 프로모션 종류 코드 */
	private String prmtKindCd;

	/** 프로모션 상태 코드 */
	private String prmtStatCd;

	/** 프로모션 명 */
	private String prmtNm;

	/** 최소 구매 금액 */
	private Long minBuyAmt;

	/** 최대 구매 금액 */
	private Long maxBuyAmt;

	/** 프로모션 적용 코드 */
	private String prmtAplCd;

	/** 적용 값 */
	private Long aplVal;

	/** 프로모션 대상 코드 */
	private String prmtTgCd;

	/** 공급업체 분담율 */
	private Double splCompDvdRate;

	/** 적용 시작 일시 */
	private Timestamp aplStrtDtm;

	/** 적용 종료 일시 */
	private Timestamp aplEndDtm;

	/** 행사 상품 대상 String */
	private String promotionTargetStr;

	/** 사은품 String */
	private String promotionFreebieStr;

	/** 행사 상품 대상 String */
	private String promotionTargetDelStr;

	/** 사은품 String */
	private String promotionFreebieDelStr;

	/** 카테고리 번호 */
	private Long[] arrDispClsfNo;
	/** 기획전 번호  */
	private Long[] arrExhbtNo;

	/** 쿠폰 대상 상품 아이디 */
	private String[] arrGoodsId;

	/** 쿠폰 제외 대상 상품 아이디 */
	private String[] arrGoodsExId;

	/** 사이트 아이디 */
	private Long[] stId;

	/** 프로모션 매핑 적용 구분 코드 (프로모션-사은품 : 10) */
	private String prmtAplGbCd;

	/** 업체번호 */
	private Long[] arrCompNo;
	/** 브랜드번호 */
	private Long[] arrBndNo;
	/**  역 마진 허용 여부 */
	private String rvsMrgPmtYn;

}
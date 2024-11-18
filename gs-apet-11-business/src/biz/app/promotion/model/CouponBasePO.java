package biz.app.promotion.model;

import java.sql.Timestamp;
import java.util.Objects;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class CouponBasePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 쿠폰 번호 */
	private Long cpNo;

	/** 쿠폰 명 */
	private String cpNm;

	/** 쿠폰 설명 */
	private String cpDscrt;

	/** 쿠폰 종류 코드 */
	private String cpKindCd;

	/** 쿠폰 상태 코드 */
	private String cpStatCd;

	/** 쿠폰 적용 코드 */
	private String cpAplCd;

	/** 쿠폰 대상 코드 */
	private String cpTgCd;

	/** 유효 기간 코드 */
	private String vldPrdCd;

	/** 유효 기간 시작 일시 */
	private Timestamp vldPrdStrtDtm;

	/** 유효 기간 종료 일시 */
	private Timestamp vldPrdEndDtm;

	/** 유효 기간 일 */
	private Long vldPrdDay;

	/** 쿠폰 지급 방식 코드 */
	private String cpPvdMthCd;

	/** 중복 사용 여부 */
	private String dupleUseYn;
	
	/** 복원 가능 여부 */
	private String cpRstrYn;	

	/** 공급 업체 분담 율 */
	private Double splCompDvdRate;

	/** 발급 주체 코드 */
	private String isuHostCd;

	/** 쿠폰 발급 코드 */
	private String cpIsuCd;

	/** 쿠폰 발급 수량 */
	private Long cpIsuQty;

	/** 적용 값 */
	private Long aplVal;

	/** 최소 구매 금액 */
	private Long minBuyAmt;
	
	public Long getMinBuyAmt() {
		return Objects.isNull(minBuyAmt) ? 0 : minBuyAmt;
	}

	/** 최대 할인 금액 */
	private Long maxDcAmt;

	/** 적용 시작 일시 */
	private Timestamp aplStrtDtm;

	/** 적용 종료 일시 */
	private Timestamp aplEndDtm;

	/** 쿠폰 이미지 파일명 */
	private String cpImgFlnm;

	/** 쿠폰 이미지 경로명 */
	private String cpImgPathnm;

	/** 웹 모바일 구분 코드 */
	private String webMobileGbCd;

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
	
	/** 업체번호 */
	private Long[] arrCompNo;
	/** 브랜드번호 */
	private Long[] arrBndNo;
	/**  역 마진 허용 여부 */
	private String rvsMrgPmtYn;
	
	/**  쿠폰존 노출 여부 */
	private String cpShowYn;
	
	/**  쿠폰 대상 코드*/
	private String isuTgCd;
	
	/**  메세지 발송 여부*/
	private String msgSndYn;
	
	/**  만료 안내 여부*/
	private String exprItdcYn;
	
	/** 외부 쿠폰 코드 */
	private String outsideCpCd;
	
	/** 외부 쿠폰 여부 */
	private String outsideCpYn;
	
	/** 유의사항 */
	private String notice;
	
	/** 복수 적용 여부 */
	private String multiAplYn;
	
	/** 쿠폰 코드 */
	private String cpCd;
	
	/** 멤버 등급 코드 배열 */
	private String[] arrMbrGrdCd;
	
	/** 멤버 등급 코드 */
	private String mbrGrdCd;
}
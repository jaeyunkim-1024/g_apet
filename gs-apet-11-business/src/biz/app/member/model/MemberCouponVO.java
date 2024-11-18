package biz.app.member.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberCouponVO extends BaseSysVO{

	private static final long serialVersionUID = 1L;

	/** 회원 쿠폰 번호 */
	private Long mbrCpNo;

	/** 사용 가능 여부 */
	private String usePsbYn;

	/** 쿠폰 번호 */
	private Long cpNo;

	/** 회원 번호 */
	private Long mbrNo;

	/** 사용 여부 */
    private String useYn;

    /** 사용 일시 */
    private Timestamp UseDtm;
    
    /** 발급 여부 */
    private String cpUseYn;

    /** 발급 여부 */
    private String cpDwYn;

    /** 주문 번호 */
    private String ordNo;

    /** 발급 유형 코드 */
    private String 	isuTpCd;

    /** 회원 쿠폰 사용 시작 일시 */
    private Timestamp useStrtDtm;

    /** 회원 쿠폰 사용 종료 일시 */
    private Timestamp useEndDtm;

    /** 쿠폰 복원여부 */
    private String cpRstrYn;

    /** 웹 모바일 구분코드 */
    private String webMobileGbCd;

    /** 최소 구매 금액 */
    private Long minBuyAmt;

    /** 최대 할인 금액 */
    private Long maxDcAmt;

    /** 다운로드 가능한 쿠폰 개수(다운 받았든 안 받았든) */
    private Integer cpDownCnt;

    /** 다운로드 가능한 쿠폰 중 실제로 다운로드 받은 쿠폰 수*/
    private Integer mbrCpDownCnt;


    /** 회원 쿠폰 사용 종료일시 */

    //----------------------------------------------


    private String cpNm;
    private String cpShtNm;
    private String cpDscrt;
    private String vldPrdDay;
    private Timestamp vldPrdStrtDtm;
    private Timestamp vldPrdEndDtm;
    private String cpKindCd;
    private String cpKindNm;
    private String cpStatCd;
    private String cpAplCd;
    private String cpTgCd;
    private String vldPrdCd;
    private String cpPvdMthCd;
    private String dupleUseYn;
    private Long aplVal;
    private String aplValUnit;
    private String cpImgFlnm;
    private String cpImgPathnm;
    private Timestamp aplStrtDtm;
    private Timestamp aplEndDtm;
    private String isuSrlNo;

    private String notice;
    private String[] notices;

    private String mobile;

    /** 쿠폰 유효기간까지 남은 일수 */
    private Long leftDays;

    /** 쿠폰 일괄 다운로드 시, 결과 메세지 및 결과 코드*/
    private String resultCode;
    private String resultMsg;

    private String mbrNm;

    private String exprItdcYn;

}

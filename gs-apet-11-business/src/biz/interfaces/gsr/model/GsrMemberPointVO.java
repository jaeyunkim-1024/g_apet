package biz.interfaces.gsr.model;

import lombok.Data;

@Data
public class GsrMemberPointVO {
    /** UID */
    private static final long serialVersionUID = 1L;

    /** 고객 번호*/
    private String custNo;

    /** 고객 번호*/
    private String custNoGs;

    /**고객 이름*/
    private String custName;

    /** 거래 일시 ( yyyyMMdd )*/
    private String apprDate;

    /** 거래 번호(=CRM 쪽 고유 식별 번호)*/
    private String apprNo;

    /** 일 선물 사용 한도*/
    private Integer ddUseLmt;

    /**통합 고객 여부*/
    private String gsnCustYn;

    /**통합 고객 번호*/
    private String intgrCustNo;

    /** 월 선물 적립 한도*/
    private Integer mmRsvLmt;

    /** 월 선물 사용 한도*/
    private Integer mmUseLmt;

    /** 익월 소멸 예정 포인트*/
    private Integer nextmmVanishIntendPt;

    /** 고객 일선물 사용 합계 */
    private Integer sumDdUseLmt;

    /** 고객 일선물 가능 합계*/
    private Integer sumDdUsePssblPt;

    /** 고객 월선물 적립 합계*/
    private Integer sumMmRsvLmt;

    /** 고객 월선물 적립 가능 합계*/
    private Integer sumMmRsvPssblPt;

    /** 고객 월선물 사용 합계*/
    private Integer sumMmUseLmt;

    /** 고객 월선물 가능 합계*/
    private Integer sumMmUsePssblPt;

    /**총 적립 포인트*/
    private Integer totRsvPt;

    /**총 잔여 포인트*/
    private Integer totRestPt;

    /**총 사용 누적 포인트*/
    private Integer totUseAccumPt;

    /** 총 이관 수신 포인트*/
    private Integer totTransRcvPt;
        
    /** 이관 불가능 포인트*/
	private Integer transImpssblPt;

	/** 이관 가능 포인트*/
	private Integer transPssblPt;

    /** 응답 코드*/
    private String resultCode;

    /** 응답 메세지*/
    private String resultMessage;

    /** 분리 보관 해제 시, 노출 노티 메세지 */
    private String separateNotiMsg;
}

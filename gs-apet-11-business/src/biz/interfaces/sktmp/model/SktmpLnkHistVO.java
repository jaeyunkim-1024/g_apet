package biz.interfaces.sktmp.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.model
 * - 파일명		: SktmpLnkHistVO.java
 * - 작성일		: 2021. 07. 23.
 * - 작성자		: JinHong
 * - 설명		: SKTMP 연동이력 VO
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class SktmpLnkHistVO extends BaseSysVO {
    /** UID */
    private static final long serialVersionUID = 1L;

    /** 이력 번호*/
    private Long mpLnkHistNo;

    /** 주문 번호*/
    private String ordNo;

    /** 클레임 번호 */
    private String clmNo;

    /** 원 이력 번호 */
    private Long orgMpLnkHistNo;

    /** MP 연동 구분 코드 */
    private String mpLnkGbCd;

    /** MP 실 연동 구분 코드*/
    private String mpRealLnkGbCd;
    
    /** 카드 번호*/
    private String cardNo;
    
    /** 상품 코드 */
    private String ifGoodsCd;
    
    /** 거래 번호*/
    private String dealNo;
    
    /** 거래 금액 */
    private Long dealAmt;
    
    /** 사용 포인트 */
    private Long usePnt;
    
    /** 추가 사용 포인트 */
    private Long addUsePnt;
    
    /** 적립 예정 포인트 */
    private Long saveSchdPnt;
    
    /** 추가 적립 예정 포인트 */
    private Long addSaveSchdPnt;
    
    /** 핀 번호*/
    private String pinNo;
    
    /** 요청 전문 */
    private String reqString;
    
    /** 요청 JSON */
    private String reqJson;
    
    /** 요청 일시*/
    private Timestamp reqDtm;

    /** 응답 코드*/
    private String resCd;
    
    /** 응답 상세 코드 */
    private String resDtlCd;
    
    /** 승인 번호 */
    private String cfmNo;
    
    /** 적립 포인트 */
    private Long savePnt;
    
    /** 부스트업 포인트 */
    private Long boostUpPnt;
    
    /** 실 사용 포인트 */
    private Long realUsePnt;
    
    /** 응답 전문 */
    private String resString;
    
    /** 응답 JSON */
    private String resJson;
    
    /** 응답 일시 */
    private Timestamp resDtm;
    
    /** 연동 처리 결과 여부*/
    private String reqScssYn;
    
    /** 사용 가능 응답 코드*/
    private String usePsbResCd;
    
    /** 사용 가능 응답 메세지*/
    private String usePsbResMsg;
    
    /** 에러 처리 요청 일시*/
    private Timestamp errPrcsReqDtm;

    /** 에러 처리 성공 여부*/
    private String errPrcsScssYn;
    
    /** 재처리 가능 여부*/
    private String reReqPsbYn;
    
    /** 결과 메시지 */
    private String cfmRstMsg;
    
    /** 사용  */
    private Long viewUsePnt;
    /** 적립 */
    private Long viewSavePnt;
    /** 사용 취소 */
    private Long viewUseCncPnt;
    /** 적립 취소 */
    private Long viewSaveCncPnt;
    
    /** 포인트 번호 */
   	private Long pntNo;
   	
   	/** 취소용 승인 번호 */
    private String cncCfmNo;
   	
    /** Excel NO */
	private Long excelNo;
	
	//정산 연동이력 합계 노출
	private Long totalUsePnt;
	private Long totalSavePnt;
	private Long totalCncPnt;
	private Long rowIndex;
	private Long mbrNo;
	private Long payAmt;
	private String ciCtfVal;
	
	/** 포인트 프로모션 구분 코드 */
	private String pntPrmtGbCd;
	
	/** 사용율 */
	private Double useRate;
	
	/** 최대 적립 포인트 */
	private Integer maxSavePnt;
	
	/** 원 연동 응답 코드 */
	private String orgResCd;
	
	/** IF 용 사용자 ID 구분코드 */
	private String userIdGbCd;
	
	/* MP 포인트 재계산 사용여부 체크 - N Start */
	private Long rmnAddUsePnt;
}

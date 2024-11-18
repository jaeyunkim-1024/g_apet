package biz.interfaces.sktmp.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.model
 * - 파일명		: SktmpLnkHistSO.java
 * - 작성일		: 2021. 07. 23.
 * - 작성자		: JinHong
 * - 설명		: SKTMP 연동이력 SO
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class SktmpLnkHistSO extends BaseSearchVO<SktmpLnkHistSO> {
    /** UID */
    private static final long serialVersionUID = 1L;
    
    /** 이력 번호*/
    private Long mpLnkHistNo;

    /** 주문 번호*/
    private String ordNo;
    
    /** 결제 주문 번호*/
    private String payOrdNo;
    
    /** 클레임 번호 */
    private String clmNo;
    
    /** MP 연동 구분 코드 */
    private String mpLnkGbCd;
    
    /** MP 실 연동 구분 코드*/
    private String mpRealLnkGbCd;
    
    /** 요청 시작 일시*/
    private Timestamp reqStrtDtm;

    /** 요청 종료 일시*/
    private Timestamp reqEndDtm;

    /** 연동 처리 여부*/
    private String reqScssYn;

    /** 에러 처리 여부*/
    private String errPrcsScssYn;
    
    /** 검색 조건 : 주문정보 */
	private String searchKeyOrder;

	/** 검색 값 : 주문정보 */
	private String searchValueOrder;
	
	private Long searchPnt;
	
	/** 1일1회 적립 초과 */
	private String chkSaveYn;
	
    
}

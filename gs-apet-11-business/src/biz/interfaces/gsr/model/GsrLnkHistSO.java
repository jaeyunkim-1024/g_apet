package biz.interfaces.gsr.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

@Data
@EqualsAndHashCode(callSuper=false)
public class GsrLnkHistSO extends BaseSearchVO<GsrLnkHistSO> {
    /** UID */
    private static final long serialVersionUID = 1L;

    /** 연동 번호 */
    private Long gsrLnkHistNo;
    
    /** gsr 연동 코드*/
    private String gsrLnkCd;

    /** 포인트 사유 코드*/
    private String pntRsnCd;

    /** 요청 성공 여부*/
    private String reqScssYn;

    /** 결과 코드*/
    private String rstCd;

    /** 에러 처리 성공 여부*/
    private String errPrcsScssYn;

    /** 요청 시작 일시*/
    private Timestamp reqStrtDtm;

    /** 요청 종료 일시*/
    private Timestamp reqEndDtm;

    /** 에러 처리 요청 시작 일시*/
    private Timestamp errPrcsReqStrtDtm;

    /** 에러 처리 요청 종료 일시*/
    private Timestamp errPrcsReqEndDtm;
}

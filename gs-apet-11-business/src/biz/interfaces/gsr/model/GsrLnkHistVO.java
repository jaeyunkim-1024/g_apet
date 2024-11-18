package biz.interfaces.gsr.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

@Data
@EqualsAndHashCode(callSuper=false)
public class GsrLnkHistVO extends BaseSysVO {
    /** UID */
    private static final long serialVersionUID = 1L;

    /** 이력 번호*/
    private Long gsrLnkHistNo;

    /** 포인트 */
    private String point;

    /** gsr 연동 코드*/
    private String gsrLnkCd;

    /** gsr 연동 코드명*/
    private String gsrLnkNm;

    /** 포인트 사유 코드*/
    private String pntRsnCd;
    
    /** 포인트 사유 코드 명*/
    private String pntRsnNm;

    /** 요청 파라미터(json 문자열)*/
    private String reqParam;

    /** 요청 일시*/
    private Timestamp reqDtm;

    /** 요청 성공 여부*/
    private String reqScssYn;

    /** 결과 코드*/
    private String rstCd;
    
    /** 결과 코드 메세지*/
    private String rstMsg;

    /** 에러 처리 요청 일시*/
    private Timestamp errPrcsReqDtm;

    /** 에러 처리 성공 여부*/
    private String errPrcsScssYn;
}

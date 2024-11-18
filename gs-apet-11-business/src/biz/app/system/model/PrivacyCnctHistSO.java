package biz.app.system.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

@Data
@EqualsAndHashCode(callSuper=false)
public class PrivacyCnctHistSO extends BaseSearchVO<PrivacyCnctHistSO> {
    /** UID */
    private static final long serialVersionUID = 1L;

    /*접근 이력 번호*/
    private Long cnctHistNo;

    /*조회 이력 번호*/
    private Long inqrHistNo;

    /*개인정보 조회 구분 코드*/
    private String inqrGbCd;

    /*접속자 id*/
    private String adminLoginId;

    /*접속자 이름*/
    private String usrNm;

    /*접속 시작 일시*/
    private Timestamp acsStrtDtm;

    /*접속 종료 일시*/
    private Timestamp acsEndDtm;
}

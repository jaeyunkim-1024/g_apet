package biz.app.system.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

@Data
@EqualsAndHashCode(callSuper=false)
public class PrivacyCnctHistPO extends BaseSysVO {
    /** UID */
    private static final long serialVersionUID = 1L;

    /*접근 이력 번호*/
    private Long cnctHistNo;

    /*조회 이력 번호*/
    private Long inqrHistNo;

    /*기능 번호*/
    private Long actNo;

    /*메뉴 번호*/
    private Long menuNo;

    /*접근 일시*/
    private Timestamp acsDtm;

    /*사용자 번호*/
    private Long usrNo;

    /*아이피*/
    private String ip;

    /*회원 번호*/
    private Long mbrNo;

    /*컬럼 구분 코드*/
    private String colGbCd;

    /*개인정보 조회 구분 코드*/
    private String inqrGbCd;

    /*적용 값*/
    private String aplVal;

    /*url*/
    private String url;

    /*기능 구분 코드*/
    private String actGbCd;

    /** 실행 쿼리 */
    private String execSql;
}

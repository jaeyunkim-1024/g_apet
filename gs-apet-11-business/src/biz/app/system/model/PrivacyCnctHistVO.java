package biz.app.system.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

@Data
@EqualsAndHashCode(callSuper=false)
public class PrivacyCnctHistVO extends BaseSysVO {
    /** UID */
    private static final long serialVersionUID = 1L;

    /*이력 번호*/
    private Long cnctHistNo;

    /*기능 번호*/
    private Long actNo;

    /*메뉴 번호*/
    private Long menuNo;

    /*사용자 번호*/
    private Long usrNo;

    /*아이피*/
    private String ip;

    /*접근 일시*/
    private Timestamp acsDtm;

    /* 조회 번호 */
    private Long inqrHistNo;

    /*회원 번호*/
    private Long mbrNo;

    /* 컬럼 구분 코드 */
    private String colGbCd;

    /* 컬럼 구분 이름 */
    private String colGbNm;

    /*개인정보 조회 구분 코드*/
    private String inqrGbCd;

    /*개인정보 조회 구분 이름 */
    private String inqrGbNm;

    /* 적용 값 */
    private String aplVal;

    /*회원 이름*/
    private String mbrNm;

    /*회원 아이디*/
    private String loginId;

    /*접근 화면*/
    private String menuPath;

    /*접속자 ID*/
    private String adminLoginId;

    /*접속자*/
    private String usrNm;

    /*url*/
    private String url;

    /* 그리드 행 번호*/
    private Long rowNum;
}

package biz.app.login.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class SnsMemberInfoPO extends BaseSysVO {
    /** UID */
    private static final long serialVersionUID = 1L;

    /** sns 고유식별자 */
    private String snsUuid;

    /** 가입경로 */
    private String snsLnkCd;

    /** sns로 가입여부 */
    private String snsJoinYn;

    /** 회원번호*/
    private Long mbrNo;

    /** 이메일 */
    private String email;

    /** 애플 비공개 이메일 */
    private String emailApple;

    /** SNS상태코드*/
    private String snsStatCd ;

    private String token;
}

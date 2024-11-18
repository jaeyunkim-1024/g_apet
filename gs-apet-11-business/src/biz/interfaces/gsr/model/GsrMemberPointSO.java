package biz.interfaces.gsr.model;

import lombok.Data;
import lombok.NonNull;

@Data
public class GsrMemberPointSO {
    /** UID */
    private static final long serialVersionUID = 1L;

    /** 고객 번호*/
    private String custNo;

    /** 회원 번호*/
    private Long mbrNo;

    /** CI 인증값 */
    private String ciCtfVal;
}

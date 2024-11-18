package biz.app.event.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class EventEntryWinInfoVO extends BaseSysVO {
    /** UID */
    private static final long serialVersionUID = 1L;

    /** 로우 번호 */
    private Integer rowNum;

    /** 이벤트 번호*/
    private Long eventNo;
    
    /** 참여 번호*/
    private Long patiNo;
    
    /** 회원 번호*/
    private Long mbrNo;

    /** 프로필 이미지 */
    private String prflImg;

    /** 참여자(회원) 로그인 아이디*/
    private String loginId;
    
    /** 참여자 이름*/
    private String patirNm;
    
    /** 핸드폰 번호*/
    private String ctt;
    
    /** 이메일 */
    private String email;
    
    /** 주소 */
    private String addr;
    
    /** SNS */
    private String sns;
    
    /** 쿠폰 번호*/
    private Long cpNo;

    /** 난수 쿠폰 번호 */
    private String isuSrlNo;

    /** 응모 댓글 */
    private String enryAply;
    
    /** 댓글 시간 */
    private String strDateDiff;
    
    /** 닉네임 */
    private String nickNm;
    
    /**펫로그 경로 */
    private String petLogUrl;
}

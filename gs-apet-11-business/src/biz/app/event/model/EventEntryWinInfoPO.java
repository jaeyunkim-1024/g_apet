package biz.app.event.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class EventEntryWinInfoPO extends BaseSysVO {
    /** UID */
    private static final long serialVersionUID = 1L;

    /** 이벤트 번호*/
    private Long eventNo;

    /** 참여 번호*/
    private Long patiNo;

    /** 회원 번호*/
    private Long mbrNo;

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

    /** 발급 일련 번호*/
    private String isuSrlNo;

    private String enryAply;
    
	/** 댓글 멘션 닉네임 리스트 (배열) */
	private String[] nickNmArr;
	
	private String nickNm;
	
	private String landingUrl;
}

package biz.app.petlog.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetLogMentionMemberVO extends BaseSysVO {
    /** UID */
    private static final long serialVersionUID = 1L;

    /* 언급 번호*/
    private Long srlNo;   

    /*펫로그 번호*/
    private Long petLogNo;

    /*댓글 번호*/
    private int aplyNo;
    
    /*멘션 순번*/
    private int metnSeq;
    
    /*언급 회원 번호 */
    private Long metnTgMbrNo;	
    
    /* 댓글 등록 회원 번호 */
    private Long metnMbrNo;  
}

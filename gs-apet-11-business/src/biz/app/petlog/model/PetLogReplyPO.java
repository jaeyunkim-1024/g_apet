package biz.app.petlog.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetLogReplyPO extends BaseSysVO {
    /** UID */
    private static final long serialVersionUID = 1L;
    
    /*펫로그 댓글 순번*/
    private Long petLogAplySeq;
    
    /*펫로그 번호*/
    private Long petLogNo;

    /*회원 번호*/
    private Long mbrNo;
    
    /*댓글*/
    private String aply;
    
    /*컨텐츠 상태코드*/
    private String contsStatCd;
    
    private String updateGb;
}

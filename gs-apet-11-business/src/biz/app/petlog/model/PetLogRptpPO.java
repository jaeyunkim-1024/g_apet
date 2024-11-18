package biz.app.petlog.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetLogRptpPO extends BaseSysVO {
    /** UID */
    private static final long serialVersionUID = 1L;

    /*펫로그 신고 번호*/
    private Long petLogRptpNo;
    
    /*펫로그 번호*/
    private Long petLogNo;
    
    /*펫로그 댓글 순번*/
    private Long petLogAplySeq;

    /*회원 번호*/
    private Long mbrNo;
    
    /*신고 내용*/
    private String rptpContent;
    
    /*신고 사유코드(10:광고성 스팸, 20:부적절한 콘텐츠, 30:허위사실/비상/혐오)*/
    private String rptpRsnCd;
    
    private String saveGb;
}

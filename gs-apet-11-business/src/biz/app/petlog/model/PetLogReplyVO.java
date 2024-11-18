package biz.app.petlog.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetLogReplyVO extends BaseSysVO {
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
    
    /*닉네임*/
    private String nickNm;   
    
    /*회원 프로필 이미지*/
    private String prflImg;
    
    /*신고 여부*/
    private String rptpYn;
    
    private String petLogUrl;
    
    private String mbrStatCd;
}

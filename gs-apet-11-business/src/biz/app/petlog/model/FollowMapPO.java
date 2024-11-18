package biz.app.petlog.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class FollowMapPO extends BaseSysVO {
    /** UID */
    private static final long serialVersionUID = 1L;

    /*회원 번호*/
    private Long mbrNo;
    
    /*회원번호 followed */
    private Long mbrNoFollowed;
    
    /*태그번호 followed */
    private String tagNoFollowed;    
    
    private String saveGb;
}

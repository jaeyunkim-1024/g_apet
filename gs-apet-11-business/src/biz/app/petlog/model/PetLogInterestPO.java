package biz.app.petlog.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetLogInterestPO extends BaseSysVO {
    /** UID */
    private static final long serialVersionUID = 1L;
    
    /*관심 펫로그 번호*/
    private Long intsPetLogNo;
    
    /*펫로그 번호*/
    private Long petLogNo;

    /*회원 번호*/
    private Long mbrNo;
    
    /*관심구분코드(10-좋아요, 20-찜)*/
    private String intsGbCd;
    
    private String saveGb;
    

}

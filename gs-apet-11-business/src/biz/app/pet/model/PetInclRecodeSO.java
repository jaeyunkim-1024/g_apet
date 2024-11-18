package biz.app.pet.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetInclRecodeSO extends BaseSearchVO<PetInclRecodeSO> {
    /** UID */
    private static final long serialVersionUID = 1L;

    /*펫 번호*/
    private Long petNo;

    /*회원 번호*/
    private Long mbrNo;

    /*펫 구분 코드*/
    private String petGbCd;
    
    private Long inclNo;

}

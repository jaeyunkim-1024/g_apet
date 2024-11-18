package biz.app.pet.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetDaVO extends BaseSysVO {
	
    /** UID */
    private static final long serialVersionUID = 1L;

    /** 펫 번호 */
    private Long petNo;
    
    /** 질환 일련번호 */
    private Long daNo;
    
    /** 질환 구분 : 10 염려질환, 20 알러지 */
    private String daGbCd;
    
    /** 질환 코드 */
    private String daCd;
}

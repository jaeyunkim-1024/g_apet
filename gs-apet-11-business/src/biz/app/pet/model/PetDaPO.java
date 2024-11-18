package biz.app.pet.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetDaPO extends BaseSysVO {
    /** UID */
    private static final long serialVersionUID = 1L;
    
    /** 펫 번호 */
    private Long petNo;
    
    /** 질병 번호 */
    private Long daNo;
    
    /** 질병 구분 코드 */
    private String daGbCd;
    
    /** 질병 값 */
    private String daCd;
    
    /** 질환 코드 배열 */
    private String[] daCds;
    
    /** 염려 질환 코드 배열 */
    private String[] wryDaCds;
    
    /** 알러지 코드 배열 */
    private String[] allergyCds;
}

package biz.app.petlog.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetLogSharePO extends BaseSysVO {
    /** UID */
    private static final long serialVersionUID = 1L;
    
    /*펫로그 공유 번호*/
    private Long petLogShrNo;
    
    /*펫로그 번호*/
    private Long petLogNo;

    /*회원 번호*/
    private Long mbrNo;
    
    /*공유채널코드(10:카카오, 20:네이버, 30:URL)*/
    private String shrChnlCd;
    	
	/** 펫로그 URL */
	private String shrPetLogUrl;

}

package biz.app.petlog.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetLogGoodsSO extends BaseSearchVO<PetLogGoodsSO> {
    /** UID */
    private static final long serialVersionUID = 1L;

    /*펫로그 번호*/
    private Long petLogNo;

    /*회원 번호*/
    private Long mbrNo;
    
    /*컨텐츠 상태코드*/
    private String contsStatCd;
    
    /*제재 여부*/
    private String snctYn;
    
    /* 펫로그 채널 코드 */
    private String petLogChnlCd;
    
	/*펫로그 상세번호*/
    private Long petDetailNo;
    
    /* 상품 아이디 */
    private String goodsId;
    
    /* 상품명 유형 */
    private String goodsEstmTp;
    
    /* 상품평 번호 */
    private Long goodsEstmNo;
    
    /* 시스템 삭제 여부 */
    private String sysDelYn;
    
    /** 전시 분류 코너 번호 */
	private Long dispClsfCornNo;
	
	private String goodsCstrtTpCd;
}

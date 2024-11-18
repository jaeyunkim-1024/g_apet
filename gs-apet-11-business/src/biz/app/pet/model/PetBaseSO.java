package biz.app.pet.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetBaseSO extends BaseSearchVO<PetBaseSO> {
    /** UID */
    private static final long serialVersionUID = 1L;

    /*펫 번호*/
    private Long petNo;

    /*회원 번호*/
    private Long mbrNo;

    /*펫 구분 코드*/
    private String petGbCd;

    /*펫 종류 */
    private String petKindNm;

    /*대표 여부*/
    private String dlgtYn;

    /*중성화 여부*/
    private String fixingYn;

    /*알러지 여부*/
    private String allergyYn;

    /*염려질환 여부*/
    private String diseaseYn;
    
    /* 탭 번호 */
    private String tabNo;
    
    /** 접종 시작일 */
    private String inclStDt;
    
    /** 접종 종료일 */
    private String inclEnDt;
    
    /** 이미지 경로 */
    private String imgPath;
    
    /** 상품 번호[배열] */
	private String[] goodsIds;
	
    /** webMobileGbCd */
    private String webMobileGbCd;

}

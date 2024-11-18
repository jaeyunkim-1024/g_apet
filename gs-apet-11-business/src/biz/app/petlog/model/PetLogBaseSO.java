package biz.app.petlog.model;

import biz.app.tag.model.TagBaseSO;
import framework.common.model.BaseSearchVO;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetLogBaseSO extends BaseSearchVO<PetLogBaseSO> {
    /** UID */
    private static final long serialVersionUID = 1L;

    /*펫로그 번호*/
    private Long petLogNo;

    /*설명*/
    private String dscrt;    

    /*회원 번호*/
    private Long mbrNo;
    
    /*경도*/
    private String logLitd;
    
    /*위도*/
    private String logLttd;
    
    /*지번주소*/
    private String prclAddr;
    
    /*도로주소*/
    private String roadAddr;    
    
    /*신 우편번호*/
    private String postNoNew;    

    /*이미지 경로*/
    private String imgPath1;

    /*이미지 경로*/
    private String imgPath2;      

    /*이미지 경로*/
    private String imgPath3;

    /*이미지 경로*/
    private String imgPath4;

    /*이미지 경로*/
    private String imgPath5;
    
    /*영상경로*/
    private String vdPath;
    
    /*단축경로*/
    private String srtPath;
    
    /*조회수*/
    private Integer hits;
    
    /*컨텐츠 상태코드*/
    private String contsStatCd;
    
    /*제재 여부*/
    private String snctYn;
    
    /*후기 여부*/
    private String rvwYn;
    
    /*상품추천 여부*/
    private String goodsRcomYn;
    
    /*펫로그 채널 코드*/
    private String petLogChnlCd;
	
	/** 연관 아이디 */
	private String rltId;      
    
	/** 펫로그 번호 */
	private Long[] petLogNos;
	
	/** 회원id */
	private String loginId;
	
	/** 펫로그 검색 태그 */
	private String[] tags;	
	
	/** 펫로그 태그 */
	private String tag;
	
	/** 정렬 타입 */
	private String sortType;
	
	/** 회원 MbrNo */
	private Long loginMbrNo;
    
    /** Admin 여부*/
    private String adminYn;
    
    /*상품후기번호*/
    private Long goodsEstmNo;
    
    /* 공유하기로 접근여부 */
    private String shareAcc;
	
	private Long excludeMbrNo;

	private String ordNo;
	
	private String pageType;
}

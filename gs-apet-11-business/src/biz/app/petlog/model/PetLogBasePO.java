package biz.app.petlog.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetLogBasePO extends BaseSysVO {
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
    
    /*영상 경로*/
    private String vdPath;
    
    /*영상썸네일 경로*/
    private String vdThumPath;
    
    
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
    
    /*상품후기번호*/
    private Long goodsEstmNo;
    
    /*상품추천 여부*/
    private String goodsRcomYn;    
    
    /*펫로그 채널 코드*/
    private String petLogChnlCd;
	
	/** 연관 아이디 */
	private String rltId;    
    
	private String[] tags;	
	
	/** 펫로그 태그 */
	private String tagNo;		

	/** 이미지 경로 */
	private String[] imgPath;
	
	/** 이미지 순번 */
	private String[] imgSeq;
	
	/** 이미지 삭제 순번 */
	private String[] deleteSeq;	
	
	/** 위치 명 */
	private String pstNm;
	
	/** 위치동의 여부 */
	private String pstAgrYn;

	private String updateGb;
	
	/** 인코딩 여부 */
	private String encCpltYn;

	/** 주문 번호 */
	private String ordNo;

	private String orginDscrt;
}

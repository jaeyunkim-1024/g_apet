package biz.app.petlog.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetLogBaseListVO extends BaseSysVO {
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
    
    /*컨텐츠 상태코드(10-노출, 20-미노출, 30-신고차단)*/
    private String contsStatCd;
    
    /*제재 여부*/
    private String snctYn;
    
    /*후기 여부*/
    private String rvwYn;
    
    /*상품추천 제공여부*/
    private String goodsRcomYn;    
    
    /*닉네임*/
    private String nickNm;   
    
    /*댓글수*/
    private String replyCnt;
    
    /*연관상품 여부*/
    private String goodsMapYn;    
    
    /*회원 로그인 아이디*/
    private String loginId;   
    
    /*프로필 이미지*/
    private String prflImg;
}

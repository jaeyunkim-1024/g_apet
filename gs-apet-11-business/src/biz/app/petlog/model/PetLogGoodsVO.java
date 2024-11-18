package biz.app.petlog.model;

import java.util.List;

import biz.app.goods.model.GoodsEstmQstVO;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetLogGoodsVO extends BaseSysVO {
    /** UID */
    private static final long serialVersionUID = 1L;

    /*펫로그 번호*/
    private Long petLogNo;

    /*설명*/
    private String dscrt;    

    /*회원 번호*/
    private Long mbrNo;
    
    /*위치 명*/
    private String pstNm;
    
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
    
    /*컨텐츠 상태코드*/
    private String contsStatCd;
    
    /*제재 여부*/
    private String snctYn;
    
    /*닉네임*/
    private String nickNm;       
    
    /* 펫로그 이미지 갯수 */
    private Long ImgCnt;
    
    /* 펫로그 채널 코드 */
    private String petLogChnlCd;
    
    /* 펫로그 이미지 갯수 */
    private String imgPathAll;
    
    /*영상썸네일 경로*/
    private String vdThumPath;   
    
    /* 펫로그 좋아요 갯수 */
    private Long likeCnt;
    
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
    
    /* 평가 점수 */
    private Long estmScore;
    
    /* 펫 이름 */
    private Long petNo;
    
    /* 펫 나이 */
    private String age;
    
    private String month;
    
    /* 펫 이름 */
    private String petNm;
    
    /* 펫 무게 */
    private String weight;
    
    /* 펫 종류 명 */
    private String petKindNm;
    
    /** 상품 평가 문항 */
    private List<GoodsEstmQstVO> petLogGoodsList;
    
    /** 프로필 이미지 */
    private String prflImg;
    
    private String optName;
    
    private String likeYn;
    
    private String ordNo;
    
    private Integer ordDtlSeq;
    
    private String rptYn;
    
    private String bestYn;
    
    private String petGdNm;
    
    private String pakGoodsId;
}

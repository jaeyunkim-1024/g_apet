package biz.app.petlog.model;

import java.util.ArrayList;
import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetLogBaseVO extends BaseSysVO {
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
    
    /*영상썸네일 경로*/
    private String vdThumPath;    
    
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
    private Integer replyCnt;
    
    /*연관상품 여부*/
    private String goodsMapYn;   
    
    /*펫로그 채널 코드 : 10-펫로그, 20-상품, 30-펫스쿨, 40-이벤트*/
    private String petLogChnlCd;    
	
	/** 연관 아이디 */
	private String rltId;    
    
    /*회원 로그인 아이디*/
    private String loginId;       

	/** 이미지 경로 */
	private List<String> imgPathList;
	
    /*좋아요수*/
    private Integer likeCnt;
 	
    /*이미지 수*/
    private Integer imgCnt;
    
    /*검색 매칭률*/
    private String rate;
    
    /*회원 프로필 이미지*/
    private String prflImg;
    
    private String tagNm;
    
	private String[] images;
	
	private List<PetLogReplyVO> replyList;	
	
    /*좋아요수*/
    private Integer bookmarkCnt;    
    
    /*팔로우 여부*/
    private String followYn;
    	
	/** 펫로그 태그 */
	private String tagNo;
	
    /*이미지 경로 '|'로 연결됨 */
    private String imgPathAll;
    
    /*신고 여부*/
    private String rptpYn;
    
    /** 펫로그 URL */
    private String petLogUrl;
    
    /*펫로그 상세번호*/
    private Long petDetailNo;
    
    /*연관상품 수*/
    private Integer goodsRltCnt;
    
    /*위치명*/
    private String pstNm;      
    
    /*연관상품 수*/
    private String goodsThumbImgPath;
	
	/** 펫로그 Short URL */
	private String petLogSrtUrl;
	    
    /*찜 여부*/
    private String bookmarkYn; 
    
    /*좋아요 여부*/
    private String likeYn;
    
    /* Tag팔로우 게시물의 경우만 T */
    private String petLogType; 
    
    private List<String> petLogFollowTagNm;
    
    /* 동영상 인코딩 여부 */
    private String encCpltYn;
    
    /* 신규 게시물 여부*/
    private String newPostYn;
    
    private String followTagNm;
}

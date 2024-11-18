package biz.app.petlog.model;

import java.sql.Timestamp;
import java.util.List;

import biz.app.tag.model.TagBaseSO;
import framework.common.model.BaseSearchVO;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetLogListSO extends BaseSearchVO<PetLogListSO> {
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
    
	/** 펫로그 번호 */
	private Long[] petLogNos;
	
	/** 회원id */
	private String loginId;
	
	/** 펫로그 검색 태그 */
	private String[] tags;	
	
	/** 펫로그 태그 */
	private String tag;
	
	/** 펫로그 태그 */
	private String tagNo;
	
	/** 정렬 타입 */
	private String sortType;	

	/** 전시분류번호 */
	private Long dispClsfNo;	
	private List<Long> dispClsfNos;	
	
	/** 전시 코너 번호 */
	private Long dispCornNo;
	
	/** 웹/모바일 구분코드 */
	private String webMobileGbCd;
	private List<String> webMobileGbCds;
	
    /*닉네임*/
    private String nickNm;       
    
    /*추천 회원 */
    private Long recMbrNo;       
    
    /*팔로우 여부*/
    private String followYn;
    
    /*게시물 종류(일반=N, 태그팔로우=T, 좋아요=L, 마이펫로그=M)*/
    private String listType;
    
    /** 미리보기 날짜 */
    private String  previewDt;
    	
	/** 회원 MbrNo */
	private Long loginMbrNo;
	
	/*펫로그 상세번호*/
    private Long petDetailNo;
	
	/** 펫로그 URL */
	private String petLogUrl;
	
	/** 펫로그 Short URL */
	private String petLogSrtUrl;

	private List<String> tagNms;
	
	private String imgType;
	
	/* 일치율 */
	private String rate;
	
	private Integer recommendPage;
	
	/** 프로필 이미지*/
	private String prflImg;

	private String excludeLogNo;
	
	/* 신규 게시물 페이지*/
	private int newPostPage;
	
	/* 신규 게시물 노출 시작 페이지*/
	private int newPostCheckPage;
	
	/* 이 친구 어때요 페이지*/
	private int recMemberPage;
	
	/*이 친구 어때요 검색 API 조회여부*/
	private String recYn;
	
	/*조회시 제외 신규 게시물 번호*/
	private String[] searchExcludeLogNo;
	
	/*최상단 펫로그 번호(페이징 도중 게시된 게시물 노출하지 않기 위한 기준)*/
	private String compareLogNo;
	
	/*최상단 신규 펫로그 번호(페이징 도중 게시된 게시물 노출하지 않기 위한 기준)*/
	private String compareNewLogNo;
	
	/*상단 페이징 여부*/
	private String upper;
	
	/*신규 게시물 카운트*/
	private int newPostCount;

	private String excludeRecMbrNo;
	
	private int boRecMemberPage;
	
	private String backYn;
	
	private String pageType;
}

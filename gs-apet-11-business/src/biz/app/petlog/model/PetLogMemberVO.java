package biz.app.petlog.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetLogMemberVO extends BaseSysVO {
    /** UID */
    private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Long mbrNo;

	/** 회원 명 */
	private String mbrNm;

	/*닉네임*/
	private String nickNm;

	/** 프로필 이미지*/
	private String prflImg;
	
	/** 펫 등록 여부 */
	private String petRegYn;
	
	/** 펫로그 소개 */
	private String petLogItrdc;		
	
	/** 펫로그 URL */
	private String petLogUrl;
	
	/** 펫로그 Short URL */
	private String petLogSrtUrl;	
    
    /** 펫로그 게시물 수*/
    private Integer petLogCnt;
    
    /** 팔로잉 수*/
    private Integer followingCnt;
    
    /** 태그 팔로잉 수*/
    private Integer followingTagCnt;    
    
    /** 팔로워 수*/
    private Integer followerCnt;    
    
    /** 팔로우 여부*/
    private String followYn;    
    
    /** 위치정보 동의 여부*/
    private String pstInfoAgrYn;   
	
	/* 일치율 */
	private String rate;
	
	private String mbrStatCd;
}

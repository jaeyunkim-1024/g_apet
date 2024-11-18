package biz.app.petlog.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class FollowMapVO extends BaseSysVO {
    /** UID */
    private static final long serialVersionUID = 1L;

    /*회원 번호*/
    private Long mbrNo;    
    
    /*회원번호 followed */
    private String mbrNoFollowed;
    
    /* followed (회원번호/태그번호) */
    private String followedNo;    
    
    /* followed (회원 닉네임/태그명) */
    private String followedNm;
    
    /*태그번호 followed */
    private String tagNoFollowed;    
    
    /** 팔로우 구문(M-member, T-tag)*/
    private String followType;    
	
	/** 펫로그 URL */
	private String petLogUrl;

	/** 프로필 이미지*/
	private String prflImg;	
    
    /** 팔로우 여부*/
    private String followYn;  	
}

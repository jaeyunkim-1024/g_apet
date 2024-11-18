package biz.app.pettv.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ApetContentsWatchHistVO extends BaseSysVO {
	
	/** UID */
    private static final long serialVersionUID = 1L;
    
    /*회원 번호*/
    private Long mbrNo;
    
    /*영상 ID*/
    private String vdId;
    
    /*조회수*/
    private Integer hits;
    
    /*단계 번호*/
    private Integer stepNo;
    
    /*영상 길이*/
    private Integer vdLnth;
    
    /* 영상 제목*/
    private String ttl;
    
    /* 파일 경로*/
    private String phyPath;
    
    /* 영상 총 길이*/
    private Integer totalLnth;
    
    /* 영상 시청 길이*/
    private Integer histLnth;
    
    /* 썸네일 이미지*/
    private String thumPath;
    
    /* 영상 구분*/
    private String vdGbCd;
    

}

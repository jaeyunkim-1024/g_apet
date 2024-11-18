package biz.app.tv.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.model
 * - 파일명		: TvDetailPO.java
 * - 작성일		: 2021. 01. 19. 
 * - 작성자		: LDS
 * - 설 명		: 펫TV 상세 Param Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class TvDetailPO extends BaseSysVO {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 영상ID */
	private String vdId;
	
	/** 회원번호 */
	private Long mbrNo;
	
	/** 영상길이(시청길이) */
	private Long vdLnth;
	
	/** 단계번호(펫스쿨사용) */
	private int stepNo;
	
	/** 관심구분코드 */
	private String intrGbCd;
	
	/** 공유번호 */
	private Long contsShrNo;
	
	/** 공유채널코드 */
	private String shrChnlCd;
	
	/** 단축URL */
	private String srtUrl;
	
	/** 펫스쿨 완료 여부 */
	private String cpltYn;
}

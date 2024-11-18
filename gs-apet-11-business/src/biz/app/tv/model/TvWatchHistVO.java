package biz.app.tv.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.model
 * - 파일명		: TvWatchHistVO.java
 * - 작성일		: 2021. 01. 19. 
 * - 작성자		: LDS
 * - 설 명		: 펫TV 상세 시청이력 Value Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class TvWatchHistVO extends BaseSysVO {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 영상ID */
	private String vdId;
	
	/** 회원번호 */
	private Long mbrNo;
	
	/** 조회수 */
	private Long hits;
	
	/** 단계번호 */
	private Long stepNo;
	
	/** 영상길이 */
	private Long vdLnth;
	
	/** 시스템 등록자번호 */
	private Long sysRegrNo;
	
	/** 시스템 등록 일시 */
	private Timestamp sysRegDtm;
	
	/** 시스템 등록일 */
	private String sysRegDt;
	
	/** 시스템 수정자번호 */
	private Long sysUpdrNo;
	
	/** 시스템 수정 일시 */
	private Timestamp sysUpdDtm;
	
	/** 시스템 수정일 */
	private String sysUpdDt;
	
}

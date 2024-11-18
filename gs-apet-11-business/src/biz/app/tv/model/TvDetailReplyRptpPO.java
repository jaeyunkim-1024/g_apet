package biz.app.tv.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.model
 * - 파일명		: TvDetailReplyVO.java
 * - 작성일		: 2021. 01. 19. 
 * - 작성자		: hjh
 * - 설 명		: 펫TV 상세 댓글 신고 Param Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class TvDetailReplyRptpPO extends BaseSysVO {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 신고 번호 */
	private Long rptpNo;
	
	/** 영상 ID */
	private String vdId;
	
	/** 펫TV 댓글 순번 */
	private Long aplySeq;
	
	/** 회원 번호 */
	private Long mbrNo;
	
	/** 신고 내용 */
	private String rptpContent;
	
	/** 신고 사유 코드 */
	private String rptpRsnCd;
	
	/** 신고 받은 댓글 작성자 회원 번호 */
	private Long rptpMbrNo;

}

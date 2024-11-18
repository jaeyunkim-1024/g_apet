package biz.app.tv.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.model
 * - 파일명		: TvDetailReplyMentionMbrPO.java
 * - 작성일		: 2021. 08. 25. 
 * - 작성자		: LDS
 * - 설 명		: 펫TV 상세 댓글 멘션 회원정보 Param Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class TvDetailReplyMentionMbrPO extends BaseSysVO {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 펫TV 멘션 회원정보 순번  */
	private Long srlNo;
	
	/** 펫TV 멘션 회원정보 영상 ID */
	private String vdId;
	
	/** 펫TV 멘션 회원정보 댓글 번호 */
	private Long aplyNo;
	
	/** 펫TV 멘션 회원정보 순번 */
	private int metnSeq;
	
	/** 펫TV 멘션 회원정보 대상 회원 번호(멘션당한 회원) */
	private Long metnTgMbrNo;
	
	/** 펫TV 멘션 회원정보 회원 번호(로그인한 회원) */
	private Long metnMbrNo;
}

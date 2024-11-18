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
 * - 설 명		: 펫TV 상세 댓글 Param Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class TvDetailReplyPO extends BaseSysVO {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 펫TV 댓글 순번 */
	private Long aplySeq;
	
	/** 영상 ID */
	private String vdId;
	
	/** 회원 번호 */
	private Long mbrNo;
	
	/** 댓글 내용 */
	private String aply;
	
	/** 컨텐츠 상태 코드 */
	private String contsStatCd;
	
	/** 댓글 멘션 닉네임 리스트 (배열) */
	private String[] nickNmArr;
	
	/** 댓글 태그 리스트 (배열) */
	private String[] tagNmArr;
	
	/** 댓글 등록/수정한 회원 닉네임 */
	private String nickNm;
	
	/** landing url */
	private String landingUrl;

}

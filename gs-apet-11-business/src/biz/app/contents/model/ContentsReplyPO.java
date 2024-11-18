package biz.app.contents.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.contents.model
 * - 파일명		: ContentsReplyPO.java
 * - 작성일		: 2020. 12. 14. 
 * - 작성자		: hjh
 * - 설 명		: 컨텐츠 댓글 관리 Param Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class ContentsReplyPO extends BaseSysVO {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 사용자 번호 */
	private Long usrNo;
	
	/** 회원 번호 */
	private Long mbrNo;
	
	/** 어바웃TV 댓글 순번 */
	private Long aplySeq;
	
	/** 펫로그 댓글 순번 */
	private Long petLogAplySeq;
	
	/** 답변 */
	private String rpl;
	
	/** 컨텐츠 상태 코드 */
	private String contsStatCd;
	
	/** 댓글 순번 리스트(배열) */
	private String[] arrReplySeq;
	
	/** 댓글 */
	private String aply;
	
	/** 로그인 아이디 */
	private String loginId;
	
	/** 댓글,답변 구분값 */
	private String replyGb;
	
	/** 답변 등록일시 */
	private Timestamp rplRegDtm;
	
	/** 답변 수정일시 */
	private Timestamp rplUpdDtm;
}

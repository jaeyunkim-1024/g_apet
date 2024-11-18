package biz.app.contents.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.contents.model
 * - 파일명		: ContentsReplyVO.java
 * - 작성일		: 2020. 12. 14. 
 * - 작성자		: hjh
 * - 설 명		: 컨텐츠 댓글 관리 Value Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class ContentsReplyVO extends BaseSysVO {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** rownum */
	private Long rowIndex;
	
	/** 어바웃TV 댓글 순번 */
	private Long aplySeq;
	
	/** 펫로그 댓글 순번 */
	private Long petLogAplySeq;
	
	/** 펫로그 번호 */
	private Long petLogNo;
	
	/** 회원 번호 */
	private Long mbrNo;
	
	/** 댓글 */
	private String aply;
	
	/** 사용자 번호 */
	private Long usrNo;
	
	/** 답변 */
	private String rpl;
	
	/** 컨텐츠 상태 코드 */
	private String contsStatCd;
	
	/** 댓글,답변 구분값 */
	private String replyGb;
	
	/** 로그인 아이디 */
	private String loginId;
	
	/** 댓글,답변 등록자 명 */
	private String replyRegrNm;
	
	/** 답변 등록일시 */
	private Timestamp rplRegDtm;
	
	/** 답변 수정일시 */
	private Timestamp rplUpdDtm;

	/*펫로그,어바웃펫 구분 코드*/
	private String replyGbCd;

	private Long rowNum;
	
	/** 영상 ID */
	private String vdId;
	
	/** 영상 제목 */
	private String ttl;
	
	/** 영상 썸네일 이미지 */
	private String thumPath;
	
	/** 펫로그 신고 번호 */
	private Long petLogRptpNo;
	
	/** 펫로그 신고 사유 명 */
	private String rptpRsnNm;
	
	/** 펫로그 신고자 */
	private String rptpLoginId;
	
	/** 신고 번호 */
	private String rptpNo;
	
	/** 신고 사유 */
	private String rptpRsnCd;
	
	/** 신고 내용 */
	private String rptpContent;
	
	/** 신고 접수 건수 */
	private Integer rptpCnt;
	
	/** 펫로그 : 설명 */
	private String dscrt;

	/** 펫 로그 제재 여부 */
	private String snCtYn;

	/** 펫 로그 채널 코드 */
	private String petLogChnlCd;
	
	private String sysRegDate;
	private String sysUpdDate;
	private String rplRegDate;
	private String rplUpdDate;
	
	
}

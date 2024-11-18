package biz.app.contents.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.contents.model
 * - 파일명		: ContentsReplySO.java
 * - 작성일		: 2020. 12. 14. 
 * - 작성자		: hjh
 * - 설 명		: 컨텐츠 댓글 관리 Search Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class ContentsReplySO extends BaseSearchVO<ContentsReplySO> {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 등록 시작일자 */
	private Timestamp strtDate;
	
	/** 등록 종료일자 */
	private Timestamp endDate;
	
	/** 등록자 (로그인 아이디) */
	private String loginId;
	
	/** 컨텐츠 상태 코드 */
	private String contsStatCd;
	
	/** 댓글 */
	private String aply;
	
	/** 어바웃TV 댓글 순번 */
	private Long aplySeq;
	
	/** 펫로그 댓글 순번 */
	private Long petLogAplySeq;

	/*회원 번호*/
	private Long mbrNo;
	
	/** 신고 접수 건수 */
	private Integer rptpCnt;

	/* 신고 사유 코드 */
	private String rptpRsnCd;
	
	/* 영상 ID */
	private String vdId;
	
	/* 영상별 검색 구분 */
	private String vdSearchGb;
	
	/* 영상별 검색 값 */
	private String vdSearchTxt;
	
	/* 답변자 명 */
	private String usrNm;
	
	/* 댓글 신고 관리 구분 */
	private String rptpGb;
}

package biz.app.tv.model;

import java.sql.Timestamp;
import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.model
 * - 파일명		: TvDetailReplyVO.java
 * - 작성일		: 2021. 01. 19. 
 * - 작성자		: LDS
 * - 설 명		: 펫TV 상세 댓글 Value Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class TvDetailReplyVO extends BaseSysVO {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 영상ID */
	private String vdId;
	
	/** 댓글순번 */
	private Long aplySeq;
	
	/** 회원번호 */
	private Long mbrNo;
	
	/** 회원명 */
	private String mbrNm;
	
	/** 로그인ID */
	private String loginId;
	
	/** 회원 닉네임 */
	private String nickNm;
	
	/** 댓글 */
	private String aply;
	
	/** 답변 */
	private String rpl;
	
	/** 컨텐츠상태코드 */
	private String contsStatCd;
	
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
	
	/** 답변 등록자번호 */
	private Long rplRegrNo;
	
	/** 답변 등록 일시 */
	private Timestamp rplRegDtm;
	
	/** 답변 등록일 */
	private String rplRegDt;
	
	/** 답변 수정자번호 */
	private Long rplUpdrNo;
	
	/** 답변 수정 일시 */
	private Timestamp rplUpdDtm;
	
	/** 답변 수정일 */
	private String rplUpdDt;
	
	/** 총 목록수 */
	private int totCnt;
	
	/** 댓글,답변 구분값 */
	private String replyGb;
	
	/** 답변 리스트 */
	private List<TvDetailReplyVO> tvDetailRplList;
	
	/** 시리즈 명 */
	private String srisNm;
	
	/** 프로필 이미지 경로 */
	private String prflImg;
	
	/** 시리즈 썸네일 이미지 경로 */
	private String srisPrflImg;
	
	/** 댓글 멘션 회원 번호 */
	private Long mentionMbrNo;
	
	/** 댓글 멘션 펫로그 URL */
	private String mentionPetLogUrl;
}

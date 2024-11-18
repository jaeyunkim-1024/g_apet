package biz.app.contents.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetLogMgmtSO extends BaseSearchVO<PetLogMgmtSO> {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 펫로그등록 시작 일시 */
	private Timestamp regStrtDtm;

	/** 펫로그등록 종료 일시 */
	private Timestamp regEndDtm;

	/** 펫로그 번호 */
	private Long petLogNo;
	
	/** 펫로그 회원번호 */
	private Long mbrNo;
	
	/** 펫로그 전시구분 */
	private String contsStatCd;
	
	/** 펫로그 태그 */
	private String tag;
	
	/** 펫로그 상품추천여부 */
	private String goodsMapYn;
	
	/** 펫로그 설명 */
	private String dscrt;
	
	/** 펫로그 조회수 */
	private Long hits;
	
	/** 펫로그 신고수 */
	private Long claimCnt;
	
	/** 펫로그 정렬구분 */
	private String orderingGb;
	
	/* 시스템 등록 일시 : Start */
	private Timestamp sysRegDtmStart;
	/* 시스템 등록 일시 : End */
	private Timestamp sysRegDtmEnd;
	
	/** 펫로그 번호 */
	private Long[] petLogNos;
	
	/** 회원id */
	private String loginId;
	
	/** 펫로그 검색 태그 */
	private String[] tags;
	
	/** 펫로그 제재여부 */
	private String snctYn;
	
	/** 펫로그 댓글 신고 상세 : 댓글 내용 */
	private String aply;
	
	/** 펫로그 댓글 신고 상세 : 화면 구분 */
	private String replyRptpGb;
	
	/** 단축경로 */
	private String srtPath;
	
	/** 신고 접수 건수 */
	private Integer rptpCnt;
	
	/** 등록자 구분 */
	private String regGb;
	
	/** 펫로그 컨텐츠 구분 */
	private String petlogContsGb; 
	
	/** 펫로그 채널 코드 */
	private String petLogChnlCd;
	
	/** 펫로그 공유건수 시작 */
	private Long shareCntStrt;
	
	/** 펫로그 공유건수 끝 */
	private Long shareCntEnd;
	
	/** 펫로그 좋아요건수 시작 */
	private Long goodCntStrt;
	
	/** 펫로그 좋아요건수 끝 */
	private Long goodCntEnd;
	
	/** 태그관리에서 호출여부 */
	private String tagCallYn = "N";
	
	/** 전시관리에서 호출여부 */
	private String dispCallYn;	
	
	/** 펫로그관리에서 호출여부 */
	private String petLogMgmtCallYn;
	
	/******************************/
	/**      펫로그 신고내역          */
	/******************************/
	
	/** 펫로그 신고번호 */
	private Long petLogRptpNo;
	
	/** 펫로그 댓글 순번 */
	private Long petLogAplySeq;
	
	/** 펫로그 신고 내용 */
	private String rptpContent;
	
	/** 펫로그 신고 사유 코드 */
	private String rptpRsnCd;
	
	/** 펫로그 신고 사유 코드 */
	private String[] arrRptpRsnCd;
	
	/** 펫로그 신고자 */
	private String rptpLoginId;
		
	
	
}
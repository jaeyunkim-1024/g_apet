package biz.app.contents.model;

import biz.app.tag.model.TagBaseVO;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;

@Data
@EqualsAndHashCode(callSuper=false)
public class PetLogMgmtVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** rownum */
	private Long rowIndex;
	
	/** 펫로그 번호 */
	private Long petLogNo;
	
	/** 펫로그 설명 */
	private String dscrt;
	
	/** 펫로그 회원번호 */
	private Long mbrNo;
	
	/** 펫로그 이미지경로1 */
	private String imgPath1;
	
	/** 펫로그 이미지경로2 */
	private String imgPath2;
	
	/** 펫로그 이미지경로3 */
	private String imgPath3;
	
	/** 펫로그 이미지경로4 */
	private String imgPath4;
	
	/** 펫로그 이미지경로5 */
	private String imgPath5;
	
	/** 펫로그 동영상경로 */
	private String vdPath;

	/* 대표 썸네일 */
	private String thumbNail;
	
	/** 펫로그 조회수 */
	private Long hits;
	
	/** 펫로그 상품추천여부 */
	private String goodsMapYn;
	
	/** 펫로그 신고수 */
	private Long claimCnt;
	
	/** 펫로그 전시구분 */
	private String contsStatCd;
	
	/** 펫로그 제재여부 */
	private String restrictYn;

	/** 펫로그 좋아요 갯수 */
	private Long goodCnt;
	
	/** 펫로그 등록수정일 */
	private String regModDtm;
	
	/** 회원id */
	private String loginId;
	
	/** 펫로그 제재여부 */
	private String snctYn;
	
	/** 단축경로 */
	private String srtPath;
	
	/** 펫로그 컨텐츠 구분 */
	private String petlogContsGb;
	
	/** 위치 */
	private String pstNm;
	
	/** 닉네임 */
	private String nickNm;
	
	/** 공유수 */
	private Long shareCnt;
	
	/** 펫로그 채널 코드(등록유형) */
	private String petLogChnlCd;
	
	/** 펫로그 상품추천여부 */
	private String goodsRcomYn;
	
	/** 펫로그 썸네일 경로 */
	private String vdThumPath;
	
	
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
	
	/** 펫로그 신고 사유 명 */
	private String rptpRsnNm;
	
	/** 펫로그 신고자 */
	private String rptpLoginId;

	/*관련 태그*/
	private List<TagBaseVO> tagList;

	/** 펫로그 신고수*/
	private Integer rptCnt;
}
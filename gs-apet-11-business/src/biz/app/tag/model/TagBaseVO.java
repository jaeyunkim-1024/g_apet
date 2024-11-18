package biz.app.tag.model;

import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명 : gs-apet-11-business
* - 패키지명   : biz.app.tag.model
* - 파일명     : TagBaseVO.java
* - 작성일     : 2020. 12. 16.
* - 작성자     : ljy01
* - 설명       :
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class TagBaseVO extends BaseSysVO {
	
	private static final long serialVersionUID = 1L;

	/** 태그 번호 */
	private String tagNo;
	
	/** 태그 명 */
	private String tagNm;
	
	/** 그룹 번호 */
	private String tagGrpNo;
	
	/** 그룹 번호 */
	private String grpNm;
	
	/** 출처 코드 */
	private String srcCd;
	
	/** 상태 코드 */
	private String statCd;
	
	/** 매핑 그룹 갯수 */
	private int tagGrpCnt;
	
	/** 관련 영상 수 */
	private int rltCntsCnt;
	
	/** 관련 상품 수 */
	private int rltGoodsCnt;
	
	/** realated tag 수 */
	private int rltTagCnt;
	
	/** 연관 태그 */
	private String rltTag;
	
	/** 동의 태그 */
	private String synTag;
	
	/** 관련 영상/상품 ID */
	private String rltId;
	
	/** 관련 영상/상품 명 */
	private String rltNm;	
	
	/** 관련 영상/상품 구분(어바웃TV, 펫로그, 시리즈) */
	private String rltGb;
	
	/** 관련 영상/상품 구분 코드(어바웃TV=T, 펫로그=P, 시리즈=S) */
	private String rltGbCd;
	
	/** 관련 영상/상품 분류(영상/상품) */
	private String rltTp;
	
	/** 상태 코드-엑셀다운로드용 */
	private String statNm;
	
	/** 태그 리스트 */
	private List<TagBaseVO> getMainBannerTagList;

	/** 그리드 전용 No*/
	private Long rowIndex;
	
	/** 등장회수 */
	private Long nbrCnt;
	
	/** 출처 코드 (엑셀다운로드 용) */
	private String tagSrcCd;
	
	/** 등록일 */
	private String sysRegDt;
	
	/** 수정일 */
	private String sysUpdDt;
	
	/** 펫로그 전시여부 */
	private String contsStatCd;
	
	/** 펫로그 등록유형 */
	private String petLogChnlCd;
	
	/** 영상구분코드 */
	private String vdGbCd;
	
	/** 관련 로그수 */
	private int rltLogCnt;
}

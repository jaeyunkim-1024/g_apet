package biz.app.tag.model;

import java.sql.Timestamp;
import java.util.List;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;


/**
* <pre>
* - 프로젝트명 : gs-apet-11-business
* - 패키지명   : biz.app.tag.model
* - 파일명     : TagBaseSO.java
* - 작성일     : 2020. 12. 16.
* - 작성자     : ljy01
* - 설명       :
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class TagBaseSO extends BaseSearchVO<TagBaseSO> {
	
	private static final long serialVersionUID = 1L;

	/** 태그 번호 */
	private String tagNo;
	
	/** 태그 명 */
	private String tagNm;
	
	/** 그룹 번호 */
	private String tagGrpNo;
	
	/** 출처 코드 */
	private String srcCd;
	
	/** 상태 코드 */
	private String statCd;
	
	/** 시스템 등록 일시 : Start */
	private Timestamp sysRegDtmStart;
	
	/** 시스템 등록 일시 : End */
	private Timestamp sysRegDtmEnd;
	
	/** 검색어 : Tag ID or Tag 명 */
	private String srchWord;
	
	private String[] srchWords;
	
	private String[] tagNos;

	/* 펫 로그 번호 */
	private Long petLogNo;

	/* 회원 번호 */
	private Long mbrNo;
		
	/** 그룹 번호-Tag 조회 */
	private String searchTagGrpNo;
	
	/* popup 여부 */
	private String popYn = "N";
	
	/** App & 펫TV 영상상세 화면에서 호출일때만 callParam값이 있다. */
	private String callParam;
	
	/** total 중복 영상 제거*/
	private List<String> dupleVdIds;
	
}

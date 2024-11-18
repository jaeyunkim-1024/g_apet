package biz.app.tag.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;


@Data
@EqualsAndHashCode(callSuper=false)
public class TagTrendSO extends BaseSearchVO<TagTrendSO> {
	
	private static final long serialVersionUID = 1L;
	
	/** Trend 태그 번호 */
	private String trdNo;
	
	/** Trend 태그 명 */
	private String trdTagNm;	
	
	/** 태그 번호 */
	private String tagNo;
	
	/** 태그 명 */
	private String tagNm;
	
	/** 그룹 번호 */
	private String tagGrpNo;
	
	/** 상태 코드 */
	private String useYn;
	
	/** 검색어 : Tag ID or Tag 명 */
	private String srchWord;
	
	/** 시스템 등록 일시 : Start */
	private Timestamp sysRegDtmStart;
	
	/** 시스템 등록 일시 : End */
	private Timestamp sysRegDtmEnd;
	
	private String[] trdNos;
	
}

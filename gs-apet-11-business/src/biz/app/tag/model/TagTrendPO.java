package biz.app.tag.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;


@Data
@EqualsAndHashCode(callSuper=false)
public class TagTrendPO extends BaseSysVO {
	
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
	
	private String tagArea;
	private String[] tagNos;
	
	/** 사용 기간(from) */
	private Timestamp	useStrtDtm;
	
	/** 사용 기간(to) */
	private Timestamp	useEndDtm;	
	
	/** 그룹 명 */
	private String grpNm;
}

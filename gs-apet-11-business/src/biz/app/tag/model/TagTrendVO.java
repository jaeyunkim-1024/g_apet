package biz.app.tag.model;

import java.sql.Timestamp;
import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;


@Data
@EqualsAndHashCode(callSuper=false)
public class TagTrendVO extends BaseSysVO {
	
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
	
	/** 사용 기간(from) */
	private Timestamp	useStrtDtm;
	
	/** 사용 기간(to) */
	private Timestamp	useEndDtm;	
	
	/** 그룹 명 */
	private String grpNm;
	
 	private List<TagTrendVO> tagDetailList;
 	
	/** 사용 기간  */
	private String	useDtm;
	
	/** 그리드 전용 No*/
	private Long rowIndex;
	
	/** 태그 명 (엑셀다운로드 용)*/
	private String tagNmExcel;
}

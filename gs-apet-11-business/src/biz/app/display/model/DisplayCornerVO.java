package biz.app.display.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayCornerVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 전시 코너 번호 */
	private Long dispCornNo;

	/** 템플릿 번호 */
	private Long tmplNo;

	/** 전시 코너 설명 */
	private String dispCornDscrt;

	/** 노출 개수 */
	private Long showCnt;

	private Integer dispPriorRank;
	
	/** 전시 코너 타입 코드 */
	private String dispCornTpCd;

	/** 전시 코너명 */
	private String dispCornNm;

	/** 전시 분류 번호 */
	private Long dispClsfNo;

	/** 전시 시작일자 */
	private Timestamp dispStrtdt;

	/** 전시 종료일자 */
	private Timestamp dispEnddt;
}
package biz.app.system.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PntInfoSO extends BaseSearchVO<PntInfoSO> {

	private static final long serialVersionUID = 1L;

	/** 포인트 번호 */
	private Long pntNo;
	
	/** 포인트 유형 코드 */
	private String pntTpCd;
	
	/** 포인트 프로모션 구분 코드 */
	private String pntPrmtGbCd;
	
	/** 적용 시작 일시 */
	private Timestamp aplStrtDtm;
	
	/** 적용 종료 일시 */
	private Timestamp aplEndDtm;
	
	/** 회원번호 */
	private Long mbrNo;
}
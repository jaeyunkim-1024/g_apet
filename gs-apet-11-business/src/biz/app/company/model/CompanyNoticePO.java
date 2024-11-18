package biz.app.company.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class CompanyNoticePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 업체 번호 */
	private Long compNo;

	/** 업체 공지 번호 */
	private Long compNtcNo;

	/** 내용 */
	private String content;

	/** 전시 여부 */
	private String dispYn;

	/** 공지 시작 일시 */
	private Timestamp ntcStrtDtm;

	/** 공지 종료 일시 */
	private Timestamp ntcEndDtm;

	/** 업체 공지 번호 */
	private Long[] arrCompNtcNo;

}
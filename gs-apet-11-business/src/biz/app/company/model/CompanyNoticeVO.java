package biz.app.company.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CompanyNoticeVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 업체 번호 */
	private Long compNo;

	/** 업체 명 */
	private String compNm;

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

	/** 공지 작성 업체 명 */
	private String wrCompNm;

	/** 공지 작성 업체 번호 */
	private String wrCompNo;

}
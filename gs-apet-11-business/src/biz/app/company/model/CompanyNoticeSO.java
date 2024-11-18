package biz.app.company.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CompanyNoticeSO extends BaseSearchVO<CompanyNoticeSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 업체 번호 */
	private Long compNo;

	/** 하위업체 번호 */
	private Long lowCompNo;

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

	/** 전체 하위업체 표시 플래그 */
	private String showAllLowCompany;
}
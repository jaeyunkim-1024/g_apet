package biz.app.system.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class ChnlStdInfoPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 채널 ID */
	private Long chnlId;

	/** 채널 명 */
	private String chnlNm;

	/** 채널 약어 */
	private String chnlSht;

	/** 채널 구분 코드 */
	private String chnlGbCd;

	/** 정산 대상 여부 */
	private String cclTgYn;

	/** 세금 계산서 발행 여부 */
	private String taxIvcIssueYn;

}
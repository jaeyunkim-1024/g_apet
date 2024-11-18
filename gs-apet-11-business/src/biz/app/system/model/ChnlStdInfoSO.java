package biz.app.system.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class ChnlStdInfoSO extends BaseSearchVO<ChnlStdInfoSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 채널 ID */
	private Long chnlId;

	/** 채널 명 */
	private String chnlNm;
	
	/** 채널 구분코드 */
	private String chnlGbCd;	
}
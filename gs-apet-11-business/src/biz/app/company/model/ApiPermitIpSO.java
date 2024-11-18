package biz.app.company.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper = false)
public class ApiPermitIpSO extends BaseSearchVO<ApiPermitIpSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 업체 번호 */
	private Long compNo;

	/** 허용 IP */
	private String pmtIp;

}
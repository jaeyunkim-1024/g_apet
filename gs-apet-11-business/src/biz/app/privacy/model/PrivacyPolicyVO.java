package biz.app.privacy.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PrivacyPolicyVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 처리 방침 번호 */
	private Integer policyNo;
	
	/** 버전 정보 */
	private String verInfo;
	
	/** 내용 */
	private String content;

	/** 사용 여부 */
	private String useYn;

	/** 사이트 ID */
	private Integer stId;

	/** 사이트 명 */
	private String stNm;

	/** 처리 방침 명 */
	private String plcyNm;
	
}
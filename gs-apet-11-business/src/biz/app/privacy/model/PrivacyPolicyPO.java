package biz.app.privacy.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class PrivacyPolicyPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 처리 방침 번호 */
	private Long policyNo;
	
	/** 버전 정보 */
	private String verInfo;
	
	/** 내용 */
	private String content;

	/** 사용 여부 */
	private String useYn;

	/** 사이트 ID */
	private Long stId;

	/** 사이트 명 */
	private String stNm;

}
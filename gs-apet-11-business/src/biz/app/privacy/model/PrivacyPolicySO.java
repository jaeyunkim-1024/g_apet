package biz.app.privacy.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class PrivacyPolicySO extends BaseSearchVO<PrivacyPolicySO> {

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

	/** 처리 방침 번호 검색 */
	private String policyNoArea;
	private Integer[] policyNos;

	/** 버전 정보 검색 */
	private String versionInfoArea;
	private String[] versionInfos;

}
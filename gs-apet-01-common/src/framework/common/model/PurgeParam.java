package framework.common.model;

import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: common.common.model
* - 파일명		: PurgeParam.java
* - 작성일		: 2021. 01. 18.
* - 작성자		: KSH
* - 설명		: PurgeParam
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class PurgeParam extends BaseSysVO{

	private static final long serialVersionUID = 1L;
	
	/** cdnInstanceNo */
	private String cdnInstanceNo;
	
	/** 전체 도메인 여부 */
	private String isWholeDomain;
	
	/** 전체 파일 여부 */
	private String isWholePurge;
	
	/** 대상 디렉토리 */
	private String targetDirectoryName;
	
	/** 대상 파일 리스트 */
	private String[] targetFileList;
	
	/** 도메인 ID 리스트 */
	private String[] domainIdList;

}
package biz.app.claim.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.claim.model
* - 파일명		: ClaimBaseSO.java
* - 작성일		: 2017. 3. 6.
* - 작성자		: snw
* - 설명			: 클레임 기본 Search Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ClaimBaseSO extends BaseSearchVO<ClaimBaseSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 클레임 번호 */
	private String clmNo;

}
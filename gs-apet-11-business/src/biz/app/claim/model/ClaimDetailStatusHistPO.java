package biz.app.claim.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model
* - 파일명		: ClaimDetailStatusHistPO.java
* - 작성일		: 2017. 3. 10.
* - 작성자		: snw
* - 설명			: 클레임 상세 상태 이력 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ClaimDetailStatusHistPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 클레임 번호 */
	private String clmNo;

	/** 클레임 상세 순번 */
	private Integer clmDtlSeq;

}
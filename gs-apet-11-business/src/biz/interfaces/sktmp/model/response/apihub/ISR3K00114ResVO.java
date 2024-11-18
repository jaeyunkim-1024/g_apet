package biz.interfaces.sktmp.model.response.apihub;

import biz.interfaces.sktmp.model.response.ApihubResponseCommonVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.model.response.apihub
 * - 파일명		: ISR3K00114ResVO.java
 * - 작성일		: 2021. 08. 24.
 * - 작성자		: JinHong
 * - 설명		: CI 값 - 멤버십 카드 번호 일치 여부
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
@ToString(callSuper = true)
public class ISR3K00114ResVO extends ApihubResponseCommonVO {
	
	private static final long serialVersionUID = 1L;
	
	/** CI 값 일치 여부 */
	private String CNNT_INFO_STATUS;
}

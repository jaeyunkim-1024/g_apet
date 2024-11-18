package biz.interfaces.sktmp.model.response.apihub;

import biz.interfaces.sktmp.model.response.ApihubResponseCommonVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.model.response.apihub
 * - 파일명		: ISR3K00109ResVO.java
 * - 작성일		: 2021. 06. 30.
 * - 작성자		: JinHong
 * - 설명		: 가용포인트 전환하기 Response VO
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
@ToString(callSuper = true)
public class ISR3K00109ResVO extends ApihubResponseCommonVO {
	
	private static final long serialVersionUID = 1L;
	
	/** 코드 */
	private String CODE;
	
	/** 메시지 */
	private String MESSAGE;
}

package biz.interfaces.sktmp.model.response.apihub;

import biz.interfaces.sktmp.model.response.ApihubResponseCommonVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.model.response.apihub
 * - 파일명		: ISR3K00101ResVO.java
 * - 작성일		: 2021. 06. 30.
 * - 작성자		: JinHong
 * - 설명		: MP 포인트 조회 (가용, 적립예정) Response VO
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
@ToString(callSuper = true)
public class ISR3K00101ResVO extends ApihubResponseCommonVO {
	
	private static final long serialVersionUID = 1L;
	
	/** 사용 가능 포인트 */
	private String USABLE_POINT;
	
	/** 사용 가능 포인트 */
	private String EARNABLE_POINT;

}

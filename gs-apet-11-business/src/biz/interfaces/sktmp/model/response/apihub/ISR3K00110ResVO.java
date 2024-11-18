package biz.interfaces.sktmp.model.response.apihub;

import biz.interfaces.sktmp.model.response.ApihubResponseCommonVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.model.response.apihub
 * - 파일명		: ISR3K00110ResVO.java
 * - 작성일		: 2021. 06. 30.
 * - 작성자		: JinHong
 * - 설명		: 제휴사별 할인/적립/사용 횟수 제공 Response VO
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
@ToString(callSuper = true)
public class ISR3K00110ResVO extends ApihubResponseCommonVO {
	
	private static final long serialVersionUID = 1L;
	
	/** 할인횟수 */
	private String DIS_CNT;
	
	/** 사용횟수 */
	private String USE_CNT;
	
	/** 적립횟수 */
	private String ACCUM_CNT;
}

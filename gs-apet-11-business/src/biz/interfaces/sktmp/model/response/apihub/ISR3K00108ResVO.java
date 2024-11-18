package biz.interfaces.sktmp.model.response.apihub;

import biz.interfaces.sktmp.model.response.ApihubResponseCommonVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.model.response.apihub
 * - 파일명		: ISR3K00108ResVO.java
 * - 작성일		: 2021. 06. 30.
 * - 작성자		: JinHong
 * - 설명		: 포인트 최대 사용 가능 금액 조회하기 Response VO
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
@ToString(callSuper = true)
public class ISR3K00108ResVO extends ApihubResponseCommonVO {
	
	private static final long serialVersionUID = 1L;
	
	/** 잔여포인트 */
	private String MP_AMT;
	
	/** 상품당최대사용포인트금액 */
	private String MP_PER;
}

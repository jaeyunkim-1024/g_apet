package biz.interfaces.sktmp.model.response.apihub;

import biz.interfaces.sktmp.model.response.ApihubResponseCommonVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.model.response.apihub
 * - 파일명		: ISR3K00102ResVO.java
 * - 작성일		: 2021. 06. 30.
 * - 작성자		: JinHong
 * - 설명		: PIN 번호 체크 Response VO
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
@ToString(callSuper = true)
public class ISR3K00102ResVO extends ApihubResponseCommonVO {
	
	private static final long serialVersionUID = 1L;
	
	/** ebcNum1 */
	private String EBC_NUM1;
	
	/** 핀번호 */
	private String PIN_NUMBER;
	
	/** 동일여부 */
	private String IS_SAME;
	
	/** 핀번호 전체 오류건수 */
	private String TOTAL_FAIL_COUNT;

	/** 핀번호 일일 오류건수 */
	private String DAILY_FAIL_COUNT;
	
	/** 핀번호 유효 상태(true / false) */
	private String IS_INVALID;
}

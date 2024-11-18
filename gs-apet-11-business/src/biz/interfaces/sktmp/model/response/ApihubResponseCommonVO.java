package biz.interfaces.sktmp.model.response;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.model.response
 * - 파일명		: ApihubResponseCommonVO.java
 * - 작성일		: 2021. 06. 30.
 * - 작성자		: JinHong
 * - 설명		: SKT MP API HUB response common VO
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ApihubResponseCommonVO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String RESULT_CODE;
	
	private String RESULT;
	
	private String RESULT_MESSAGE;
	
	private String RESPONSEBODY;
}

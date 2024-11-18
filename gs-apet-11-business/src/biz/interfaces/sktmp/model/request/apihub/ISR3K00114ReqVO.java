package biz.interfaces.sktmp.model.request.apihub;

import java.io.Serializable;

import lombok.Data;


/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.model.request.apihub
 * - 파일명		: ISR3K00114ReqVO.java
 * - 작성일		: 2021. 08. 24.
 * - 작성자		: JinHong
 * - 설명		: CI 값 - 멤버십 카드 번호 일치 여부
 * </pre>
 */
@Data
public class ISR3K00114ReqVO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	/** 필수 : 멤버십카드번호(16자리)  */
	private String EBC_NUM;
	
	/** 필수 : CI 값  */
	private String CNNT_INFO;
}

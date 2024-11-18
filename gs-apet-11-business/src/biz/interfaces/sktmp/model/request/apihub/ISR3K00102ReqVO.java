package biz.interfaces.sktmp.model.request.apihub;

import java.io.Serializable;

import lombok.Data;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.model.request.apihub
 * - 파일명		: ISR3K00102ReqVO.java
 * - 작성일		: 2021. 06. 30.
 * - 작성자		: JinHong
 * - 설명		: PIN 번호 체크 Request VO
 * </pre>
 */
@Data
public class ISR3K00102ReqVO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	/** 필수 : 멤버십카드번호(16자리) */
	private String EBC_NUM;
	
	/** 필수 : 핀번호 */
	private String PIN_NUMBER;
}

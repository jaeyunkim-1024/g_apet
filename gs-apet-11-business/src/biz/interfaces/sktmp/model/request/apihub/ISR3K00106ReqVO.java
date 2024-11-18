package biz.interfaces.sktmp.model.request.apihub;

import java.io.Serializable;

import lombok.Data;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.model.request.apihub
 * - 파일명		: ISR3K00106ReqVO.java
 * - 작성일		: 2021. 06. 30.
 * - 작성자		: JinHong
 * - 설명		: OTB 번호, PIN 번호로 멤버십카드번호 조회 Request VO
 * </pre>
 */
@Data
public class ISR3K00106ReqVO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	/** 필수 : OTB번호 또는 멤버십카드번호 */
	private String OTB_NUM;
	
	/** 필수 : PIN번호 */
	private String PIN_NUM;
}

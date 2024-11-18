package biz.interfaces.sktmp.model.request.apihub;

import java.io.Serializable;

import lombok.Data;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.model.request.apihub
 * - 파일명		: ISR3K00110ReqVO.java
 * - 작성일		: 2021. 06. 30.
 * - 작성자		: JinHong
 * - 설명		: 제휴사별 할인/적립/사용 횟수 제공 Request VO
 * </pre>
 */
@Data
public class ISR3K00110ReqVO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	/** 필수 : 멤버십카드번호1 */
	private String EBC_NUM1;
	
	/** 필수 : 제휴사코드(옵션) */
	private String CO_CD;
	
	/** 필수 : 상품코드 */
	private String GOODS_CD;
}

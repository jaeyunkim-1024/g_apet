package biz.interfaces.sktmp.model.request.apihub;

import java.io.Serializable;

import lombok.Data;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.model.request.apihub
 * - 파일명		: ISR3K00107ReqVO.java
 * - 작성일		: 2021. 06. 30.
 * - 작성자		: JinHong
 * - 설명		: 할인금액 및 잔여횟수 조회하기 Request VO
 * </pre>
 */
@Data
public class ISR3K00107ReqVO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	/** 필수 : 멤버십카드번호1	 */
	private String EBC_NUM1;
	
	/** 필수 : 제휴사코드(필수) */
	private String CO_CD;
	
	/** 필수 : 상품코드 */
	private String GOODS_CD;
	
	/** 필수 : 금액 */
	private String GOODS_AMT;
	
	/** 필수 : 가맹점코드 */
	private String JOIN_CD;
}

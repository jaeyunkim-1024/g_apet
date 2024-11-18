package front.web.view.mypage.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.PopParam;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.mypage.model
* - 파일명		: DeliveryInquire.java
* - 작성일		: 2016. 7. 13.
* - 작성자		: phy
* - 설명		:	배송 조회 팝업 Param
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=true)
public class DeliveryInquireParam extends PopParam {
	
	private static final long serialVersionUID = 1L;
	
	/** 배송 번호 */
	private Long dlvrNo;
	
}

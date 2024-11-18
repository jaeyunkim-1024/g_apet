package front.web.config.view;

import java.util.List;

import biz.app.display.model.DisplayBannerVO;
import biz.common.model.BankBookVO;
import lombok.Data;
import lombok.EqualsAndHashCode;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.config.view
* - 파일명		: ViewOrder.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: Front Web OrderLayout View 정보
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=true)
@Deprecated
public class ViewOrder extends ViewBase {
	
	private static final long serialVersionUID = 1L;

	/** 주문 단계 */
	private String orderStep;

	/** 적립금 잔여 금액 */
	private Long svmnRmnAmt;

	/** 쿠폰 수 */
	private Integer cpCnt;
	
	/** 회원 등급 코드 */
	private String	mbrGrdCd;
	
	/** 회원 등급 명 */
	private String	mbrGrdNm;

}
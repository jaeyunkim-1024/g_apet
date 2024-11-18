package front.web.view.mypage.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.PopParam;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.order.model
* - 파일명		: OptionChangeParam.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명			: 주문옵션 변경 팝업 Param
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=true)
public class OrderOptionChangeParam extends PopParam {


	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String ordNo;
	
	/** 주문 상세 순번 */
	private Integer ordDtlSeq;

	/** order:주문변경, exchange:교환 */
	private String mode;
	
}
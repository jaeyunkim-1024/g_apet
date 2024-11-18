package front.web.view.mypage.model;

import framework.common.model.PopParam;
import lombok.Data;
import lombok.EqualsAndHashCode;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.mypage.model
* - 파일명		: CashReceiptRequestParam.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 현금영수증 신청 팝업 Param
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=true)
public class CashReceiptRequestParam extends PopParam {

	private static final long serialVersionUID = 1L;

	private String	ordNo;
	private Integer	ordDtlSeq;
	private Long cashRctNo;

	/** 주문 상세 번호 : 배열 */
	private Integer[] arrOrdDtlSeq;

}
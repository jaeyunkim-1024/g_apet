package front.web.view.mypage.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.PopParam;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.mypage.model
* - 파일명		: TaxInvoiceRequestParam.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 세금계산서 신청 팝업 Param
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=true)
public class TaxInvoiceRequestParam extends PopParam {

	private static final long serialVersionUID = 1L;

	private String	ordNo;
	private Integer	ordSeq;
	
}
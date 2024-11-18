package front.web.view.mypage.model;

import framework.common.model.PopParam;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.mypage.model
* - 파일명		: PurchaseReceiptParam.java
* - 작성일		: 2016. 6. 2.
* - 작성자		: phy
* - 설명		: 구매영수증 출력 팝업 Param
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=true)
public class PurchaseReceiptParam extends PopParam {
	
	private static final long serialVersionUID = 1L;

	private String	ordNo;
	
}

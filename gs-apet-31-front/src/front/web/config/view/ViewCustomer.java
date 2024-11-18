package front.web.config.view;

import java.util.List;

import biz.app.display.model.DisplayBannerVO;
import biz.common.model.BankBookVO;
import lombok.Data;
import lombok.EqualsAndHashCode;



/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명		: front.web.config.view
* - 파일명		: ViewCustomer.java
* - 작성일		: 2017. 4. 20.
* - 작성자		: snw
* - 설명			: Front Web CustomerLayout View 정보
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
@Deprecated
public class ViewCustomer extends ViewBase{

	private static final long serialVersionUID = 1L;

	/** 회원 등급 코드 */
	private String	mbrGrdCd;
	
	/** 회원 등급 명 */
	private String	mbrGrdNm;

}
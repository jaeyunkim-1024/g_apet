package front.web.view.event.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.PopParam;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.event.model
* - 파일명		: CouponTargetParam.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 업체검색 팝업 Param
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=true)
public class CouponTargetParam extends PopParam {

	private static final long serialVersionUID = 1L;

	private Long cpNo; //쿠폰 번호
	
}
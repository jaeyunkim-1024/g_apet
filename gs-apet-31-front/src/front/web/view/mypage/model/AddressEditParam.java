package front.web.view.mypage.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.PopParam;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.mypage.model
* - 파일명		: AddressEditParam.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 배송지 추가/수정 팝업 Param
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=true)
public class AddressEditParam extends PopParam {


	private static final long serialVersionUID = 1L;

	private Long	mbrDlvraNo;
	private String	mode;
	private Long mbrNo;
	
}
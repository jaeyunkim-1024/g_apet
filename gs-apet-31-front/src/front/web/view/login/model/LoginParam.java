package front.web.view.login.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.PopParam;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.login.model
* - 파일명		: LoginParam.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 로그인 팝업 Param
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=true)
public class LoginParam extends PopParam {
	
	private static final long serialVersionUID = 1L;

	private String loginType;

	
}
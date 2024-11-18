package front.web.view.post.model;

import framework.common.model.PopParam;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.mobile.view.common.model
* - 파일명		: SnsVo.java
* - 작성일		: 2017. 4. 6.
* - 작성자		: hg.jeong
* - 설명		: SNS 공유용
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=true)
public class SnsShareVo extends PopParam {

	private static final long serialVersionUID = 1L;
	
	private String ogTitle;
	
	private String ogUrl;

	private String ogImage;
	
	private String ogDesc;
	
}
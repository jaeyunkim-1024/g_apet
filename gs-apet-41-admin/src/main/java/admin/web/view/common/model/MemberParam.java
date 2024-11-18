package admin.web.view.common.model;

import java.io.Serializable;

import framework.common.model.PopParam;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 41.admin.web
* - 패키지명		: admin.web.view.common.model
* - 파일명		: MemberParam.java
* - 작성일		: 2017. 5. 22.
* - 작성자		: Administrator
* - 설명			: 회원 검색 Param
* </pre>
*/
@Data
public class MemberParam implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private Long		stId;

	private String	stNm;

	private String 	mbrNm;
	
	private String 	loginId;
	
	private String	tel;

	private String 	mobile;

}

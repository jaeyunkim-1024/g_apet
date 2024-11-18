package admin.web.view.common.model;

import java.io.Serializable;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 41.admin.web
* - 패키지명		: admin.web.view.common.model
* - 파일명		: UserParam.java
* - 작성일		: 2017. 6. 1.
* - 작성자		: Administrator
* - 설명			: 사용자 검색 Param
* </pre>
*/
@Data
public class UserParam implements Serializable {

	private static final long serialVersionUID = 1L;

	/** 사용자 상태 코드 */
	private String usrStatCd;

	/** 업체 번호 */
	private Long compNo;

	/** 업체 명 */
	private String compNm;

	/** 사용자 구분 코드 */
	private String usrGbCd;
}

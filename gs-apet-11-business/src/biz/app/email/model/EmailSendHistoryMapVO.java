package biz.app.email.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.email.model
* - 파일명		: EmailSendHistoryMapVO.java
* - 작성일		: 2017. 5. 18.
* - 작성자		: Administrator
* - 설명			: 이메일 전송 이력 Map VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class EmailSendHistoryMapVO extends BaseSysVO{

	private static final long serialVersionUID = 1L;

	/** 이력 번호 */
	private Long 	histNo;
	
	/** 이력 순번 */
	private Long		histSeq;
	
	/** 매개변수1 */
	private String	map01;
	
	/** 매개변수2 */
	private String	map02;

	/** 매개변수3 */
	private String	map03;

	/** 매개변수4 */
	private String	map04;

	/** 매개변수5 */
	private String	map05;

	/** 매개변수6 */
	private String	map06;

	/** 매개변수7 */
	private String	map07;

	/** 매개변수8 */
	private String	map08;

	/** 매개변수9 */
	private String	map09;

	/** 매개변수10 */
	private String	map10;
	
}
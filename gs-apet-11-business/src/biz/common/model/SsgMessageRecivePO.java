package biz.common.model;

import java.util.Map;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.common.model
* - 파일명		: SsgMessageRecivePO.java
* - 작성일		: 2021. 01. 18.
* - 작성자		: KSH
* - 설명		: 이메일 수신 정보 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class SsgMessageRecivePO{

	/** 수신자 번호 */
	private String receivePhone;

	/** 매개변수 */
	private Map<String, String> parameters;

}
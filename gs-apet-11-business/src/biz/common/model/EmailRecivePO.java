package biz.common.model;

import java.util.Map;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.email.model
* - 파일명		: EmailSend.java
* - 작성일		: 2021. 01. 18.
* - 작성자		: KKB
* - 설명		: 이메일 수신 정보 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class EmailRecivePO{
		
	/** 수신자 주소 */
	private String address;
	
	/** 회원 번호 */
	private Long mbrNo;
	
	/** 수신자 이름 */
	private String name;
	
	/** 매개변수 */
	private Map<String, String> parameters;
	
	/** type  (R: 수신자, C: 참조인, B: 숨은참조) */
	private String type = "R"; 
}
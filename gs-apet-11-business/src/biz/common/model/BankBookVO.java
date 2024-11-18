package biz.common.model;

import java.io.Serializable;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.common.model
* - 파일명		: BankBookVO.java
* - 작성일		: 2016. 5. 30.
* - 작성자		: snw
* - 설명		: 무통장 목록
* </pre>
*/
@Data
public class BankBookVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	/** 순번 */
	private Integer seq;
	/** 은행 코드 */
	private String bankCd;
	/** 은행 명 */
	private String bankNm;
	/** 계좌 번호 */
	private String accountNo;
	/** 예금주 */
	private String depositor;
	
}
package biz.common.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.common.model
* - 파일명		: SsgMmsSendPO.java
* - 작성일		: 2021. 1. 27.
* - 작성자		: snw
* - 설명		: MMS 전송 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class SsgMmsSendPO extends SsgSmsSendPO{

	private static final long serialVersionUID = 1L;

	/** MMS메시지가 바코드MMS인지 여부
	 * Y:바코드MMS
	 * N: 일반 
	 */
	private String	fbarcode;

	/** 메시지제목(LMS/MMS) */
	private String fsubject;

	/* 파일개수 */
	private Long ffilecnt;

	/** 파일경로. 다중파일은 세미콜론으로 구분 */
	private String ffilepath;

}
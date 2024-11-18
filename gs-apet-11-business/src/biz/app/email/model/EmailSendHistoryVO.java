package biz.app.email.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.email.model
* - 파일명		: EmailSendHistoryVO.java
* - 작성일		: 2017. 5. 18.
* - 작성자		: Administrator
* - 설명			: 이메일 전송 이력 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class EmailSendHistoryVO extends BaseSysVO{

	private static final long serialVersionUID = 1L;

	/** 이력 번호 */
	private Long 	histNo;
	
	/** 이메일 유형 코드 */
	private String	emailTpCd;
	
	/** 회원 번호 */
	private Long 	mbrNo;
	
	/** 받는사람 이름 */
	private String	receiverNm;
	
	/** 받는사람 이메일 */
	private String	receiverEmail;
	
	/** 보내는사람 이름 */
	private String	senderNm;
	
	/** 보내는사람 이메일 */
	private String	senderEmail;

	/** 사이트 아이디 */
	private Long		stId;

	/** 제목 */
	private String	subject;
	
	/** 내용 */
	private String	contents;

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

	/** 매개변수11 */
	private String	map11;

	/** 매개변수12 */
	private String	map12;

	/** 매개변수13 */
	private String	map13;

	/** 매개변수14 */
	private String	map14;

	/** 매개변수15 */
	private String	map15;

	/** 매개변수16 */
	private String	map16;

	/** 매개변수17 */
	private String	map17;

	/** 매개변수18 */
	private String	map18;

	/** 매개변수19 */
	private String	map19;

	/** 매개변수20 */
	private String	map20;

	/** 매개변수21 */
	private String	map21;
	
	/** 매개변수22 */
	private String	map22;

	/** 매개변수23 */
	private String	map23;

	/** 매개변수24 */
	private String	map24;

	/** 매개변수25 */
	private String	map25;

	/** 매개변수26 */
	private String	map26;

	/** 매개변수27 */
	private String	map27;

	/** 매개변수28 */
	private String	map28;

	/** 매개변수29 */
	private String	map29;

	/** 매개변수30 */
	private String	map30;

	/** 매개변수31 */
	private String	map31;

	/** 매개변수32 */
	private String	map32;

	/** 매개변수33 */
	private String	map33;

	/** 매개변수34 */
	private String	map34;

	/** 매개변수35 */
	private String	map35;

	/** 매개변수36 */
	private String	map36;
	
	/** 발송 요청 여부 */
	private String	sendReqYn;

	/** 발송 요청 일시 */
	private Timestamp sendReqDtm;
	
}
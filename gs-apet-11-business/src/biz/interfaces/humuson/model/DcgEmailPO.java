package biz.interfaces.humuson.model;

import java.io.Serializable;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.humuson.model
* - 파일명		: DcgEmailPO.java
* - 작성일		: 2017. 5. 18.
* - 작성자		: Administrator
* - 설명			: DCG 이메일 PO
* </pre>
*/
@Data
public class DcgEmailPO implements Serializable {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 테이블 명 */
	private String	tableNm;
	
	/** 시퀀스 */
	private Long 	seq;
	
	/** 받는 사람 이름 */
	private String toName;
	
	/** 받는 이메일 주소 */
	private String toEmail;

	/** 보내는 사람 이름 */
	private String fromName;

	/** 보내는 이메일 주소 */
	private String fromEmail;

	/** 메일 제목 */
	private String subJect;
	
	/** 내용 */
	private String contents;

	/** 사이트 아이디 */
	private String siteId;
	
	/** map1 */
	private String map1;

	/** map2 */
	private String map2;

	/** map3 */
	private String map3;

	/** map4 */
	private String map4;
	
	/** map5 */
	private String map5;
	
	/** map6 */
	private String map6;
	
	/** map7 */
	private String map7;
	
	/** map8 */
	private String map8;
	
	/** map9 */
	private String map9;
	
	/** map10 */
	private String map10;
	
	/** map11 */
	private String map11;

	/** map12 */
	private String map12;

	/** map13 */
	private String map13;

	/** map14 */
	private String map14;

	/** map15 */
	private String map15;

	/** map16 */
	private String map16;

	/** map17 */
	private String map17;

	/** map18 */
	private String map18;

	/** map19 */
	private String map19;

	/** map20 */
	private String map20;

	/** map21 */
	private String map21;

	/** map22 */
	private String	map22;

	/** map23 */
	private String	map23;

	/** map24 */
	private String	map24;

	/** map25 */
	private String	map25;

	/** map26 */
	private String	map26;

	/** map27 */
	private String	map27;

	/** map28 */
	private String	map28;

	/** map29 */
	private String	map29;

	/** map30 */
	private String	map30;

	/** map31 */
	private String	map31;

	/** map32 */
	private String	map32;

	/** map33 */
	private String	map33;

	/** map34 */
	private String	map34;

	/** map35 */
	private String	map35;

	/** map36 */
	private String	map36;
	
	private String mailCode;
}
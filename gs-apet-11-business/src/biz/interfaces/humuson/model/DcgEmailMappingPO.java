package biz.interfaces.humuson.model;

import java.io.Serializable;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.humuson.model
* - 파일명		: DcgEmailMappingPO.java
* - 작성일		: 2017. 5. 18.
* - 작성자		: Administrator
* - 설명			: DCG 이메일 Mapping PO
* </pre>
*/
@Data
public class DcgEmailMappingPO implements Serializable {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 테이블 명 */
	private String	tableNm;
	
	/** 시퀀스 */
	private Long 	seq;
	
	/** 리스트 시퀀스 */
	private Long		listSeq;

	/** lmap1 */
	private String	lmap1;

	/** lmap2 */
	private String	lmap2;

	/** lmap3 */
	private String	lmap3;

	/** lmap4 */
	private String	lmap4;

	/** lmap5 */
	private String	lmap5;

	/** lmap6 */
	private String	lmap6;

	/** lmap7 */
	private String	lmap7;

	/** lmap8 */
	private String	lmap8;

	/** lmap9 */
	private String	lmap9;

	/** lmap10 */
	private String	lmap10;

}
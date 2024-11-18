package biz.app.shop.model;

import java.io.Serializable;
import java.sql.Timestamp;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.shop.model
* - 파일명		: ShopEnterFilelVO.java
* - 작성일		: 2016. 9. 06.
* - 작성자		: muelKim
* - 설명		:
* </pre>
*/
@Data
public class ShopEnterFileVO implements Serializable {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 파일번호 */
	private String flNo;
	
	/** 첨부파일 경로 */
	private String phyPath;
	
	/** 파일원본명 */
	private String orgFlNm;

}

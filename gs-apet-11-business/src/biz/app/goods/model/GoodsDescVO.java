package biz.app.goods.model;

import java.io.Serializable;
import java.sql.Timestamp;

import lombok.Data;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.model
* - 파일명		: GoodsDescVO.java
* - 작성일		: 2016. 3. 3.
* - 작성자		: snw
* - 설명		: 상품 설명 Value Object
* </pre>
*/
@Data
public class GoodsDescVO implements Serializable {

	private static final long serialVersionUID = 1L;

	/* 상품아이디 */
	private String 	goodsId;
	/* 서비스 구분 코드 */
	private	String	svcGbCd;
	/* 내용 */
	private String	content;
	/* 시스템 등록자 번호 */
	private Integer	sysRegrNo;
	/* 시스템 등록 일시 */
	private Timestamp sysRegDtm;
	/* 시스템 수정자 번호 */
	private Integer	sysUpdrNo;
	/* 시스템 수정 일시 */
	private Timestamp sysUpdDtm;

	/** 추가 */
	private String contentPc;
	private String contentMobile;
	private String goodsNm;

}
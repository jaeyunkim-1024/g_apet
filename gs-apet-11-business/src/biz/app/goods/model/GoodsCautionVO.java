package biz.app.goods.model;

import java.io.Serializable;
import java.sql.Timestamp;

import lombok.Data;



/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.model
* - 파일명		: GoodsCautionVO.java
* - 작성일		: 2016. 3. 3.
* - 작성자		: snw
* - 설명		: 상품 주의사항 Value Object
* </pre>
*/
@Data
public class GoodsCautionVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	/* 상품아이디 */
	private String 	goodsId;	
	
	private String goodsNm;
	
	/* 순번 */
	private	Integer	seq;
	/* 내용 */
	private String	content;
	/* 전시 여부 */
	private String	dispYn;
	/* 시스템 등록자 번호 */
	private Integer	sysRegrNo;
	/* 시스템 등록 일시 */
	private Timestamp sysRegDtm;
	/* 시스템 수정자 번호 */
	private Integer	sysUpdrNo;
	/* 시스템 수정 일시 */
	private Timestamp sysUpdDtm;

}
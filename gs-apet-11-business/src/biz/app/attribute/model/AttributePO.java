package biz.app.attribute.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class AttributePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 속성 번호 */
	private Long attrNo;
	
	private String webMobileGbCd;
	/** 사이트 아이디 */
	private Long stId;


	/** 속성 명 */
	private String attrNm;

	/** 사용 여부 */
	private String useYn;
	
	/** 상품 아이디 */
	private String goodsId;
	
	/** 단품 ID */
	private Long itemNo;
	
	/* 옵션속성순번 */
	private String attrIdx;
	
	/* 상품가격 */
	private Long saleAmt;
	
	/* 품절상품 제외여부 */
	private String soldOutExceptYn;

	/* 속성 */
	private String attr1No;
	private String attr1ValNo;
	private String attr2No;
	private String attr2ValNo;
	private String attr3No;
	private String attr3ValNo;
	private String attr4No;
	private String attr4ValNo;
	private String attr5No;
	private String attr5ValNo;
}
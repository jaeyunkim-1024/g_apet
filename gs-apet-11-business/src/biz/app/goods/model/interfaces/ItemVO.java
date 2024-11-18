package biz.app.goods.model.interfaces;

import java.io.Serializable;
import java.util.List;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.model.interface
* - 파일명		: ItemVO.java
* - 작성일		: 2017. 8. 25.
* - 작성자		: hjko
* - 설명		: 단품 Value Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ItemVO implements Serializable {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 단품 번호 */
	private Long itemNo;

	/** 단품 명 */
	private String itemNm;

	/** BARCODE */
	private String barCode ;


	private List<ItemAttributesVO> itemAttributes;

}
package biz.app.goods.model.interfaces;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.model.interface
* - 파일명		: StGoodsMapVO.java
* - 작성일		: 2017. 8. 25.
* - 작성자		: hjko
* - 설명		: 사이트 상품 맵핑 Value Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class StGoodsMapVO implements Serializable {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사이트 ID */
	private Long stId;

	/** 상품 스타일 코드 */
	private String goodsStyleCd;

}
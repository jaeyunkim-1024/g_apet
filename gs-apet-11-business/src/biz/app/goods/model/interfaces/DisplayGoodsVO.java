package biz.app.goods.model.interfaces;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

import framework.common.model.BaseSysVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.model.interface
* - 파일명		: DisplayGoodsVO.java
* - 작성일		: 2017. 8. 25.
* - 작성자		: hjko
* - 설명		: 전시 상품 맵핑 Value Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayGoodsVO implements Serializable {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 전시 분류 번호 */
	private Integer categoryNo;

	/** 대표 전시 여부 */
	private String mainDisplayYn;;

}
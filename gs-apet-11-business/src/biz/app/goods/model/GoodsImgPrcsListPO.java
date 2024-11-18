package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.model
* - 파일명		: GoodsImgPrcsListVO.java
* - 작성일		: 2016. 5. 22.
* - 작성자		: hongjun
* - 설명		: 상품 이미지 처리 내역  Value Object
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsImgPrcsListPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 아이디 */
	private String goodsId;

	/** 처리 순번 */
	private Integer prcsSeq;
	
	/** 이미지 처리 여부 */
	private String imgPrcsYn;
	
	/** 메모 */
	private String memo;

}

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
public class GoodsImgPrcsListVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 아이디 */
	private String goodsId;

	/** 처리 순번 */
	private Integer prcsSeq;
	
	/** 이미지1 URL */
	private String img1Url;
	
	/** 반전 이미지1 URL */
	private String rvsImg1Url;
	
	/** 이미지2 URL */
	private String img2Url;
	
	/** 반전 이미지2 URL */
	private String rvsImg2Url;
	
	/** 이미지3 URL */
	private String img3Url;
	
	/** 반전 이미지3 URL */
	private String rvsImg3Url;
	
	/** 이미지4 URL */
	private String img4Url;
	
	/** 반전 이미지4 URL */
	private String rvsImg4Url;
	
	/** 이미지5 URL */
	private String img5Url;
	
	/** 반전 이미지5 URL */
	private String rvsImg5Url;
	
	/** URL Array */
	private String urlArray;

}

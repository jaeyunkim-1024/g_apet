package biz.app.goods.service;

import java.util.List;

import biz.app.goods.model.GoodsBulkUploadPO;
import biz.app.goods.model.GoodsImgPrcsListPO;
import biz.app.goods.model.GoodsImgPrcsListVO;
import biz.app.goods.validation.GoodsValidator;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.goods.service
* - 파일명		: GoodsBulkUploadService.java
* - 작성일		: 2016. 5. 20.
* - 작성자		: valueFactory
* - 설명			: 상품 일괄 등록 서비스
* </pre>
*/
public interface GoodsBulkUploadService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsBulkUploadService.java
	* - 작성일		: 2016. 5. 20.
	* - 작성자		: valueFactory
	* - 설명			: 상품 일괄등록
	* </pre>
	* @param goodsBasePOList
	*/
	GoodsBulkUploadPO uploadGood (GoodsValidator goodsValidator, GoodsBulkUploadPO po) throws Exception;

	List<GoodsBulkUploadPO> bulkUploadGoods (List<GoodsBulkUploadPO> goodsBulkUploadPOList );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsBulkUploadService.java
	* - 작성일		: 2016. 5. 20.
	* - 작성자		: valueFactory
	* - 설명			: 상품 일괄등록 Validation
	* </pre>
	* @param goodsBasePOList
	* @return
	*/
	List<GoodsBulkUploadPO> validateBulkUpladGoods (List<GoodsBulkUploadPO> goodsBulkUploadPOList );

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsBulkUploadService.java
	 * - 작성일		: 2017. 5. 22.
	 * - 작성자		: honjun
	 * - 설명			: 상품 이미지 처리 내역 조회
	 * </pre>
	 * @return
	 */
	List<GoodsImgPrcsListVO> getGoodsImgPrcsList ();

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsBulkUploadService.java
	 * - 작성일		: 2017. 5. 22.
	 * - 작성자		: honjun
	 * - 설명			: 상품 이미지 처리 내역 수정
	 * </pre>
	 * @return
	 */
	int updateGoodsImgPrcsList (GoodsImgPrcsListPO po );
}

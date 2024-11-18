package biz.app.goods.service;

import java.util.List;

import biz.app.contents.model.ApetContentsGoodsMapSO;
import biz.app.contents.model.VodVO;
import biz.app.delivery.model.DeliveryChargePolicySO;
import biz.app.delivery.model.DeliveryChargePolicyVO;
import biz.app.display.model.DisplayBannerVO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.goods.service
 * - 파일명		: GoodsDetailService.java
 * - 작성일		: 2021. 3. 11.
 * - 작성자		: valfac
 * - 설명		: 상품 상세 서비스
 * </pre>
 */
public interface GoodsDetailService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDetailService.java
	 * - 작성일		: 2021. 3. 11.
	 * - 작성자		: valfac
	 * - 설명		: 상품 카테고리 lnb
	 * </pre>
	 * @return List
	 */
	List<DisplayCategoryVO> listShopCategories();

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDetailService.java
	 * - 작성일		: 2021. 3. 11.
	 * - 작성자		: valfac
	 * - 설명		: 상품 상세
	 * </pre>
	 * @param goodsId
	 * @return
	 * @throws Exception
	 */
	GoodsBaseVO getGoodsDetail(GoodsBaseSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDetailService.java
	 * - 작성일		: 2021. 3. 11.
	 * - 작성자		: valfac
	 * - 설명		: 상품 옵션 목록
	 * </pre>
	 * @param goodsId
	 * @return
	 * @throws Exception
	 */
	List listGoodsCstrt(GoodsBaseSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDetailService.java
	* - 작성일	: 2021. 3. 15.
	* - 작성자 	: valfac 
	* - 설명 		: 관련 영상
	* </pre>
	*
	* @param so
	* @param mbrNo
	* @param stId
	* @return
	*/
	List<VodVO> pageContentsGoods(ApetContentsGoodsMapSO so, Long mbrNo, Long stId);

	/**
	 * 쿠폰 목록
	 * @param so
	 * @return
	 */
	List listGoodsCoupon(GoodsBaseSO so);

	/**
	 * 상품 가격 정보
	 * @param goodsId
	 * @return
	 */
	List listGoodsPrices(String goodsId);

	/**
	 * 상품 기획전 목록
	 * @param goodsId
	 * @param webMobileGbCd
	 * @return
	 */
	List listGoodsExhibited(String goodsId, String webMobileGbCd);

	/**
	 * 상품 사은품 목록 조회
	 * @param goodsId
	 * @return
	 */
	List listGoodsGifts(String goodsId, String goodsCstrtTpCd);

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: GoodsDetailService.java
	 * - 작성일		: 2021. 3. 15.
	 * - 작성자		: valfac
	 * - 설명		: 상품 일치율 조회
	 * </pre>
	 * @param stId
	 * @param contentId
	 * @param webMobileGbCd
	 * @param mbrNo
	 * @return
	 */
	double getGoodsRecommendRate(Long stId, String contentId, Long mbrNo, String index) throws Exception;

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDetailService.java
	 * - 작성일		: 2021. 3. 15.
	 * - 작성자		: valfac
	 * - 설명		: 업체 배송 정보
	 * </pre>
	 * @param so
	 * @return DeliveryChargePolicyVO vo
	 */
	DeliveryChargePolicyVO getDeliveryChargePolicy(DeliveryChargePolicySO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDetailService.java
	 * - 작성일		: 2021. 4. 22.
	 * - 작성자		: valfac
	 * - 설명		: 상품 상세 공지 배너 목록
	 * </pre>
	 * @param dispCornNo
	 * @return List
	 */
	List<DisplayBannerVO> listDisplayBannerContents(Long dispCornNo);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDetailService.java
	 * - 작성일		: 2021. 6. 15.
	 * - 작성자		: valfac
	 * - 설명		: 상품이 현재 사은품으로 매핑되어 있는지 체크
	 * </pre>
	 * @param goodsId
	 * @return string
	 */
	String getGoodsGiftYn(String goodsId);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsDetailService.java
	* - 작성일		: 2021. 7. 12.
	* - 작성자		: pcm
	* - 설명		: 상품 상세 공유하기
	* </pre>
	* @param so
	* @return
	*/
	GoodsBaseVO getGoodsShareInfo(GoodsBaseSO so);
}

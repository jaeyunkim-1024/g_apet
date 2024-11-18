package biz.app.goods.dao;

import java.util.HashMap;
import java.util.List;

import biz.app.display.model.DisplayBannerVO;
import org.springframework.stereotype.Repository;

import biz.app.contents.model.ApetContentsGoodsMapSO;
import biz.app.contents.model.VodVO;
import biz.app.delivery.model.DeliveryChargePolicySO;
import biz.app.delivery.model.DeliveryChargePolicyVO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.promotion.model.ExhibitionThemeGoodsSO;
import framework.common.dao.MainAbstractDao;

/**
 * <pre>
 * - 프로젝트명 : 11.business
 * - 패키지명   : biz.app.goods.dao
 * - 파일명     : GoodsDetailDao.java
 * - 작성일     : 2021. 03. 11.
 * - 작성자     : valfac
 * - 설명       : 상품 상세 DAO
 * </pre>
 */
@Repository
public class GoodsDetailDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "goodsDetail.";

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 03. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 상품 상세 카테고리 lnb
	 * </pre>
	 * @param so
	 * @return List
	 */
	public List<DisplayCategoryVO> listShopCategories() {
		return selectList(BASE_DAO_PACKAGE + "listShopCategories");
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDao.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: shkim
	 * - 설명		: 상품상세 상품정보 조회
	 * </pre>
	 * @param goodsId
	 * @return
	 */
	public GoodsBaseVO getGoodsDetail(GoodsBaseSO so){
		return selectOne(BASE_DAO_PACKAGE+"getGoodsDetail", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDao.java
	 * - 작성일		: 2016. 5. 11.
	 * - 작성자		: valfac
	 * - 설명		: 상품 옵션 정보
	 * </pre>
	 * @param goodsId
	 * @return
	 */
	public List listGoodsCstrt(GoodsBaseSO so){
		return selectList(BASE_DAO_PACKAGE+"listGoodsCstrt", so);
	}

	public List listGoodsCoupon(GoodsBaseSO so){
		return selectList(BASE_DAO_PACKAGE+"listGoodsCoupon", so);
	}

	public List listGoodsGifts(String goodsId, String goodsCstrtTpCd ){
		HashMap<String, Object> params = new HashMap<>();
		params.put("goodsId", goodsId);
		params.put("goodsCstrtTpCd", goodsCstrtTpCd);
		return selectList(BASE_DAO_PACKAGE+"listGoodsGifts", params);
	}

	public List listGoodsPrices(String goodsId){ return selectList(BASE_DAO_PACKAGE+"listGoodsPrices", goodsId); }

	public List listGoodsExhibited(ExhibitionThemeGoodsSO exhibitionThemeGoodsSO){ return selectList(BASE_DAO_PACKAGE+"listGoodsExhibited", exhibitionThemeGoodsSO); }
	
	public List<VodVO> pageContentsGoods(ApetContentsGoodsMapSO so) {
		return selectListPage(BASE_DAO_PACKAGE+"pageContentsGoods", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 3. 15.
	 * - 작성자		: valfac
	 * - 설명		: 업체 배송 정보
	 * </pre>
	 * @param so
	 * @return DeliveryChargePolicyVO vo
	 */
	public DeliveryChargePolicyVO selectDeliveryChargePolicy(DeliveryChargePolicySO so) { return selectOne(BASE_DAO_PACKAGE+"selectDeliveryChargePolicy", so);}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 4. 15.
	 * - 작성자		: valfac
	 * - 설명		: 상품 상세 접근 관리자 여부
	 * </pre>
	 * @param so
	 * @return string
	 */
	public String selectAdminByNo(GoodsBaseSO so) {
		return selectOne(BASE_DAO_PACKAGE + "selectAdminByNo", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 4. 22.
	 * - 작성자		: valfac
	 * - 설명		: 상품 상세 공지 배너 목록
	 * </pre>
	 * @param dispCornNo
	 * @return List
	 */
	public List<DisplayBannerVO> listDisplayBannerContents(Long dispCornNo) {
		return selectList(BASE_DAO_PACKAGE + "listDisplayBannerContents", dispCornNo);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDispDao.java
	 * - 작성일		: 2021. 6. 15.
	 * - 작성자		: valfac
	 * - 설명		: 상품이 현재 사은품으로 매핑되어 있는지 체크
	 * </pre>
	 * @param goodsId
	 * @return string
	 */
	public String selectGoodsGiftYn(String goodsId) {
		return selectOne(BASE_DAO_PACKAGE + "selectGoodsGiftYn", goodsId);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsDetailDao.java
	* - 작성일		: 2021. 7. 12.
	* - 작성자		: pcm
	* - 설명		: 상품 상세 공유하기
	* </pre>
	* @param so
	* @return
	*/
	public GoodsBaseVO getGoodsShareInfo(GoodsBaseSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getGoodsShareInfo", so);
	}
}

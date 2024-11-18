package biz.app.display.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import biz.app.banner.model.BannerVO;
import biz.app.brand.model.BrandBaseSO;
import biz.app.brand.model.BrandBaseVO;
import biz.app.company.model.CompDispMapSO;
import biz.app.contents.model.SeriesSO;
import biz.app.contents.model.SeriesVO;
import biz.app.contents.model.VodSO;
import biz.app.contents.model.VodVO;
import biz.app.display.model.DisplayBannerPO;
import biz.app.display.model.DisplayBannerVO;
import biz.app.display.model.DisplayBrandPO;
import biz.app.display.model.DisplayBrandSO;
import biz.app.display.model.DisplayBrandVO;
import biz.app.display.model.DisplayCategoryPO;
import biz.app.display.model.DisplayCategorySO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.display.model.DisplayClsfCornerPO;
import biz.app.display.model.DisplayClsfCornerSO;
import biz.app.display.model.DisplayClsfCornerVO;
import biz.app.display.model.DisplayCornerItemPO;
import biz.app.display.model.DisplayCornerItemSO;
import biz.app.display.model.DisplayCornerItemVO;
import biz.app.display.model.DisplayCornerPO;
import biz.app.display.model.DisplayCornerSO;
import biz.app.display.model.DisplayCornerTotalVO;
import biz.app.display.model.DisplayCornerVO;
import biz.app.display.model.DisplayGoodsPO;
import biz.app.display.model.DisplayGoodsSO;
import biz.app.display.model.DisplayGoodsVO;
import biz.app.display.model.DisplayGroupBuySO;
import biz.app.display.model.DisplayGroupBuyVO;
import biz.app.display.model.DisplayTemplatePO;
import biz.app.display.model.DisplayTemplateSO;
import biz.app.display.model.DisplayTemplateVO;
import biz.app.display.model.DisplayTreeVO;
import biz.app.display.model.EventPopupSO;
import biz.app.display.model.EventPopupVO;
import biz.app.display.model.SeoInfoPO;
import biz.app.display.model.SeoInfoSO;
import biz.app.display.model.SeoInfoVO;
import biz.app.goods.model.GoodsDispSO;
import biz.app.goods.model.GoodsDispVO;
import biz.app.goods.model.GoodsFiltAttrSO;
import biz.app.goods.model.GoodsFiltAttrVO;
import biz.app.goods.model.GoodsFiltGrpPO;
import biz.app.goods.model.GoodsFiltGrpSO;
import biz.app.goods.model.GoodsFiltGrpVO;
import biz.app.goods.model.GoodsListSO;
import biz.app.goods.model.GoodsListVO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberInterestBrandSO;
import biz.app.pet.model.PetBaseSO;
import biz.app.petlog.model.PetLogBaseVO;
import biz.app.petlog.model.PetLogListSO;
import biz.app.pettv.model.ApetContentsWatchHistVO;
import biz.app.system.model.CodeDetailVO;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.model.TagBaseVO;
import biz.app.tv.model.TvDetailPO;
import biz.common.service.CacheService;
import framework.common.dao.MainAbstractDao;

@Repository
public class DisplayDao extends MainAbstractDao {
	@Autowired private CacheService cacheService;
	
	//========================================================================
	// BO
	//========================================================================
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 템플릿 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayTemplateVO> listDisplayTemplateGrid(DisplayTemplateSO so) {
		return selectListPage("display.listDisplayTemplateGrid", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 템플릿 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public DisplayTemplateVO getDisplayTemplateDetail(DisplayTemplateSO so) {
		return (DisplayTemplateVO) selectOne("display.getDisplayTemplateDetail", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 템플릿 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertDisplayTemplate(DisplayTemplatePO po) {
		return insert("display.insertDisplayTemplate", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 템플릿 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateDisplayTemplate(DisplayTemplatePO po) {
		return update("display.updateDisplayTemplate", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 템플릿 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteDisplayTemplate(DisplayTemplatePO po) {
		return delete("display.deleteDisplayTemplate", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 8.
	 * - 작성자		: valueFactory
	 * - 설명		: 템플릿 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayTemplateVO> listDisplayTemplate(DisplayTemplateSO so) {
		return selectList("display.listDisplayTemplate", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public DisplayCornerVO getDisplayCorner(DisplayTemplateSO so) {
		return (DisplayCornerVO) selectOne("display.getDisplayCorner", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 관리 트리 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayTreeVO> listDisplayTree(DisplayCategorySO so) {
		return selectList("display.listDisplayTree", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2017. 1. 12.
	 * - 작성자		: hjko
	 * - 설명		:
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayTreeVO> listDisplayTreeFilter(DisplayCategorySO so) {
		return selectList("display.listDisplayTreeFilter", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: hjko
	 * - 설명		: FO 카테고리 목록리스팅
	 * </pre>
	 * @param po
	 * @return
	 */
	public List<DisplayCategoryVO> listDisplayCategoryFO(DisplayCategorySO so){
		return selectList("display.listDisplayCategoryFO",so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 기본정보
	 * </pre>
	 * @param so
	 * @return
	 */
	public DisplayCategoryVO getDisplayBase(DisplayCategorySO so) {
		return (DisplayCategoryVO) selectOne("display.getDisplayBase", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 8.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 기본정보 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertDisplayBase(DisplayCategoryPO po) {
		return insert("display.insertDisplayBase", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 8.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 기본정보 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateDisplayBase(DisplayCategoryPO po) {
		return update("display.updateDisplayBase", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 19.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 기본정보 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteDisplayBase(DisplayCategoryPO po) {
		return update("display.deleteDisplayBase", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 
	 * - 작성자		: 
	 * - 설명		: 
	 * </pre>
	 * @param po
	 * @return
	 */
	public int getDisplayBaseLeafCheck(DisplayCategoryPO po) {
		return selectOne("display.getDisplayBaseLeafCheck", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 12.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCornerVO> listDisplayCornerGrid(DisplayCornerSO so) {
		return selectList("display.listDisplayCornerGrid", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertDisplayCorner(DisplayCornerPO po) {
		return insert("display.insertDisplayCorner", po);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateDisplayCorner(DisplayCornerPO po) {
		return update("display.updateDisplayCorner", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteDisplayCorner(DisplayCornerPO po) {
		return delete("display.deleteDisplayCorner", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너에 속한 아이템 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteDisplayCornerAllItem(DisplayCornerPO po) {
		return delete("display.deleteDisplayCornerAllItem", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 분류 코너에 속한 아이템 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteDisplayCornerItemAll(DisplayCornerItemPO po) {
		return update("display.deleteDisplayCornerItemAll", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 생성 여부 확인
	 * </pre>
	 * @param po
	 * @return
	 */
	public DisplayCornerItemVO getDisplayCornerItem(DisplayCornerItemSO so) {
		return (DisplayCornerItemVO) selectOne("display.getDisplayCornerItem", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertDisplayCornerItem(DisplayCornerItemPO po) {
		return insert("display.insertDisplayCornerItem", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateDisplayCornerItem(DisplayCornerItemPO po) {
		return update("display.updateDisplayCornerItem", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteDisplayCornerItem(DisplayCornerItemPO po) {
		return update("display.deleteDisplayCornerItem", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 배너 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertDisplayBanner(DisplayBannerPO po) {
		return insert("display.insertDisplayBanner", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 배너 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateDisplayBanner(DisplayBannerPO po) {
		return update("display.updateDisplayBanner", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 배너 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteDisplayBanner(DisplayCornerItemPO po) {
		return delete("display.deleteDisplayBanner", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 리스트(상품)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCornerItemVO> listDisplayCornerGoodsGrid(DisplayCornerItemSO so) {
		return selectList("display.listDisplayCornerGoodsGrid", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 리스트(상품평)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCornerItemVO> listDisplayCornerGoodsEstmGrid(DisplayCornerItemSO so) {
		return selectList("display.listDisplayCornerGoodsEstmGrid", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 리스트(배너 TEXT / 배너 HTML / 배너 이미지 / 배너 복합 / 10초 영상 / Code Set 배너)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayBannerVO> listDisplayCornerBnrItemGrid(DisplayCornerItemSO so) {
		return selectList("display.listDisplayCornerBnrItemGrid", so);
	}
		
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 상품 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayGoodsVO> listDisplayGoodsGrid(DisplayGoodsSO so) {
		return selectList("display.listDisplayGoodsGrid", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 29.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 상품 추가
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertDisplayGoods(DisplayGoodsPO po) {
		return insert("display.insertDisplayGoods", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 상품 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateDisplayGoods(DisplayGoodsPO po) {
		return update("display.updateDisplayGoods", po);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 상품 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteDisplayGoods(DisplayGoodsPO po) {
		return delete("display.deleteDisplayGoods", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 29.
	 * - 작성자		: valueFactory
	 * - 설명		:  전시 상품 대표 존재 여부 체크
	 * </pre>
	 * @param po
	 * @return
	 */
	public int getDisplyGoodsCheck(DisplayGoodsPO po) {
		return (Integer) selectOne("display.getDisplyGoodsCheck", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 29.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 상품 대표 전시 여부 업데이트
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateAllDlgtDispN(DisplayGoodsPO po) {
		return update("display.updateAllDlgtDispN", po);
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 5. 12.
	 * - 작성자		: valueFactory
	 * - 설명		:
	 * </pre>
	 * @param goodsId
	 * @return
	 */
	public int deleteDisplayGoodsAll(String goodsId) {
		return delete("display.deleteDisplayGoodsAll", goodsId);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 상품 쇼룸 저장
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertDisplayGoodsShowroom(DisplayGoodsPO po) {
		return insert("display.insertDisplayGoodsShowroom", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 상품 쇼룸 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteDisplayGoodsShowroom(DisplayGoodsPO po) {
		return delete("display.deleteDisplayGoodsShowroom", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 관련 브랜드 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayBrandVO> listDisplayBrandGrid(DisplayBrandSO so) {
		return selectList("display.listDisplayBrandGrid", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 29.
	 * - 작성자		: valueFactory
	 * - 설명		: 관련 브랜드 추가
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertDisplayBrand(DisplayBrandPO po) {
		return insert("display.insertDisplayBrand", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 관련 브랜드 저장
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateDisplayBrand(DisplayBrandPO po) {
		return update("display.updateDisplayBrand", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 관련 브랜드 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteDisplayBrand(DisplayBrandPO po) {
		return delete("display.deleteDisplayBrand", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 쇼룸 카테고리 리스트
	 * </pre>
	 * @return
	 */
	public List<DisplayCategoryVO> listDisplayShowRoomCategory() {
		return selectList("display.listDisplayShowRoomCategory");
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		: 쇼룸 전시 상품 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayGoodsVO> listDisplayShowRoomGoodsGrid(DisplayGoodsSO so) {
		return selectList("display.listDisplayShowRoomGoodsGrid", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		: 쇼룸 전시 상품 추가
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertDisplayShowRoomGoods(DisplayGoodsPO po) {
		return insert("display.insertDisplayShowRoomGoods", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		: 전시분류번호
	 * </pre>
	 * @param so
	 * @return
	 */
	public DisplayCategoryVO getDispClsfNo(DisplayCategorySO so) {
		return (DisplayCategoryVO) selectOne("display.getDispClsfNo", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 6. 30.
	 * - 작성자		: valueFactory
	 * - 설명		: 중복된 상품번호 검사
	 * </pre>
	 * @param goodsId
	 * @return
	 */
	public int checkGoodsId(DisplayGoodsPO po) {
		return selectOne("display.checkGoodsId", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2017. 1. 13.
	 * - 작성자		: hjko
	 * - 설명		:
	 * </pre>
	 * @param cdSo
	 * @return
	 */
	public List<DisplayCategoryVO> listStDisp(CompDispMapSO cdSo) {
		return selectList("display.listStDisp", cdSo);
	}

	public List<DisplayCategoryVO> listCompDisp(CompDispMapSO cdSo) {
		return selectList("display.listCompDisp", cdSo);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2017. 1. 23.
	 * - 작성자		: hongjun
	 * - 설명		: 전시 분류 코너 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayClsfCornerVO> listDisplayClsfCornerGrid(DisplayClsfCornerSO so) {
		return selectList("display.listDisplayClsfCornerGrid", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2017. 1. 23.
	 * - 작성자		: hongjun
	 * - 설명		: 전시 분류 코너 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertDisplayClsfCorner(DisplayClsfCornerPO po) {
		return insert("display.insertDisplayClsfCorner", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2017. 1. 23.
	 * - 작성자		: hongjun
	 * - 설명		: 전시 분류 코너 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateDisplayClsfCorner(DisplayClsfCornerPO po) {
		return update("display.updateDisplayClsfCorner", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2017. 1. 24.
	 * - 작성자		: hongjun
	 * - 설명		: 전시 분류 코너 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteDisplayClsfCorner(DisplayClsfCornerPO po) {
		return update("display.deleteDisplayClsfCorner", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2017. 1. 24.
	 * - 작성자		: hongjun
	 * - 설명		: 전시 코너에 속한 전시 분류 코너 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteDisplayClsfCornerAll(DisplayCornerPO po) {
		return delete("display.deleteDisplayClsfCornerAll", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2017. 5. 24.
	 * - 작성자		: hongjun
	 * - 설명		: 카테고리 목록리스팅
	 * </pre>
	 * @param po
	 * @return
	 */
	public List<DisplayCategoryVO> listDisplayCategory(DisplayCategorySO so){
		return selectList("display.listDisplayCategory",so);
	}
	
	
	//========================================================================
	// FO
	//========================================================================
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 5. 16.
	 * - 작성자		: yhkim
	 * - 설명		: Category List 가져오기
	 * </pre>
	 * @param goodsId
	 * @return
	 */
	public List<DisplayCategoryVO> listCategory(DisplayCategorySO so) {
		return  selectList("display.listCategory",so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 5. 16.
	 * - 작성자		: hjko
	 * - 설명		: leaf node 로 조상 node 찾기 (하위카테고리로 상위 카테고리 찾기) 프로시저 호출
	 * </pre>
	 * @param goodsId
	 * @return
	 */
	public List<DisplayCategoryVO> listAncestorCategory(DisplayCategorySO so) {
		return  selectList("display.listAncestorCategory",so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 
	 * - 작성자		: 
	 * - 설명		: 
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCategoryVO> listDescendantCategory(DisplayCategorySO so) {
		return selectList("display.listDescendantCategory", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 8. 18.
	 * - 작성자		: snw
	 * - 설명		: 네비게이션 구성을 위한 카테고리 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public DisplayCategoryVO getDisplayBaseNavigation(DisplayCategorySO so) {
		return (DisplayCategoryVO) selectOne("display.getDisplayBaseNavigation", so);
	}
	
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2017. 05. 29.
	 * - 작성자		: wyjeong
	 * - 설명		: 전시 카테고리 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCategoryVO> listDisplayCategoryByDispYn(DisplayCategorySO so) {
		return selectList("display.listDisplayCategoryByDispYn", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2017. 07. 07.
	 * - 작성자		: wyjeong
	 * - 설명		: 스토어, 디자이너, 브랜드 샵 전시 카테고리 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCategoryVO> listDisplayCategoryByComp(DisplayCategorySO so) {
		return selectList("display.listDisplayCategoryByComp", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 5. 4.
	 * - 작성자		: hjko
	 * - 설명		: 전시코너에 해당하는 전시아이템 목록 가져오기(배너타입)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayBannerVO> pageDisplayCornerItemBnrFO(DisplayCornerSO so) {
		return selectListPage("display.pageDisplayCornerItemBnrFO", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 5. 4.
	 * - 작성자		: hjko
	 * - 설명		: 전시코너에 해당하는 전시아이템 목록 가져오기(배너타입)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BannerVO> pageDisplayCornerItemBannerFO(DisplayCornerSO so) {
		return selectList("display.pageDisplayCornerItemBannerFO", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 5. 4.
	 * - 작성자		: hjko
	 * - 설명		: 전시코너에 해당하는 전시아이템 목록 가져오기(배너타입)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> pageDisplayCornerItemVodFO(VodSO so) {
		return selectListPage("display.pageDisplayCornerItemVodFO", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 5. 4.
	 * - 작성자		: hjko
	 * - 설명		: 전시코너에 해당하는 전시아이템 목록 가져오기(배너타입)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> pageDisplayCornerItemTopVodFO(DisplayCornerSO so) {
		return selectListPage("display.pageDisplayCornerItemTopVodFO", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 5. 4.
	 * - 작성자		: hjko
	 * - 설명		: 전시코너에 해당하는 전시아이템 목록 가져오기(배너타입)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> pageDisplayCornerItemVodNexFO(VodSO so) {
		return selectList("display.pageDisplayCornerItemVodNexFO", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 5. 4.
	 * - 작성자		: hjko
	 * - 설명		: 전시코너에 해당하는 전시아이템 목록 가져오기(신규 영상)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> pageDisplayCornerItemNewVodFO(VodSO so) {
		return selectList("display.pageDisplayCornerItemNewVodFO", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 5. 4.
	 * - 작성자		: hjko
	 * - 설명		: 전시코너에 해당하는 전시아이템 목록 가져오기(배너타입)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<SeriesVO> pageDisplayCornerItemSeriesFO(DisplayCornerSO so) {
		return selectListPage("display.pageDisplayCornerItemSeriesFO", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2017. 06. 09.
	 * - 작성자		: wyjeong
	 * - 설명		: 전시 분류별 코너 리스트 조회
	 * </pre>
	 * @param dispClsfNo
	 * @return
	 */
	public List<DisplayCornerTotalVO> listDisplayClsfCorner(Long dispClsfNo) {
		return selectList("display.listDisplayClsfCorner", dispClsfNo);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 2. 25. 
	 * - 작성자		: YJU
	 * - 설명			: 기간별 전시 분류별 코너 리스트 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCornerTotalVO> listDisplayClsfCornerDate(DisplayCornerSO so) {
		return selectList("display.listDisplayClsfCornerDate", so);
	}
	
	public List<DisplayCornerTotalVO> listDisplayClsfCornerDateCache(DisplayCornerSO so) {
		return cacheService.listDisplayClsfCornerDate(so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2017. 07.
	 * - 작성자		: dlswjdd
	 * - 설명		: 입점희망 카테고리 조회
	 * </pre>
	 * @param po
	 * @return
	 */
	public List<DisplayCategoryVO> listDisplayHopeCategory(DisplayCategorySO so){
		return selectList("display.listDisplayHopeCategory",so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2017. 07. 05.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 카테고리 별 MD 추천상품 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsListVO> listMdRcomGoodsFO(GoodsListSO so) {
		return selectList("display.listMdRcomGoodsFO", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2017. 08. 22.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 공동구매 리스트 조회
	 * </pre>
	 * @param po
	 * @return
	 */
	public List<DisplayGroupBuyVO> pageGroupBuyGoods(DisplayGroupBuySO so) {
		return selectListPage("display.pageGroupBuyGoods", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2017. 08. 22.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 공동구매 상품이 속한 페이지 번호 조회
	 * </pre>
	 * @param po
	 * @return
	 */
	public DisplayGroupBuySO getGroupBuyGoodPage(DisplayGroupBuySO so) {
		return (DisplayGroupBuySO) selectOne("display.getGroupBuyGoodPage", so);
	}
	
	
	public List<CodeDetailVO> getDistinctDispClsfCds(Long siteId){
		return selectList("display.getDistinctDispClsfCds", siteId);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2017. 08. 22.
	 * - 작성자		: wyjeong
	 * - 설명		: SEO 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public SeoInfoVO getSeoInfo(SeoInfoSO so) {
		return (SeoInfoVO) selectOne("display.getSeoInfo", so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: SEO 정보 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertSeoInfo(SeoInfoPO po) {
		return insert("display.insertSeoInfo", po);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: SEO 정보 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateSeoInfo(SeoInfoPO po) {
		return update("display.updateSeoInfo", po);
	}

	public List<GoodsFiltGrpPO> getCategoryFilters(DisplayCategorySO so) {
		return selectList("display.getCategoryFilterInfo", so);
	}

	public int deleteCategoryFilter(DisplayCategoryPO po) {
		return delete("display.deleteCategoryFilter", po);
	}

	public int insertCategoryFilter(DisplayCategoryPO po) {
		return insert("display.insertCategoryFilter", po);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 (영상 + 배너) 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCornerItemVO> listDisplayCornerBnrVdBnrGrid(DisplayCornerItemSO so) {
		return selectList("display.listDisplayCornerBnrVdBnrGrid", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 (영상 + 배너 + 태그) 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayBannerVO> listDisplayCornerBnrVodTagGrid(DisplayCornerItemSO so) {
		return selectList("display.listDisplayCornerBnrVodTagGrid", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 (영상 + 배너 + 태그) 전시 코너 아이템 태그 맵핑 
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCornerItemVO> getTagList(DisplayCornerItemSO so) {
		return selectList("display.getTagList", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 5. 4.
	 * - 작성자		: hjko
	 * - 설명		: 전시코너에 해당하는 전시아이템 목록 가져오기(배너타입)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> apetEducationHist(MemberBaseSO so) {
		return selectList("display.apetEducationHist", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 5. 4.
	 * - 작성자		: hjko
	 * - 설명		: 전시코너에 해당하는 전시아이템 목록 가져오기(배너타입)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> baseEduVod(VodSO so) {
		return selectList("display.baseEduVod", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 5. 4.
	 * - 작성자		: hjko
	 * - 설명		: 전시 코너 아이템(태그 리스트)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TagBaseVO> pageDisplayCornerTagListFO(DisplayCornerSO so) {
		return selectList("display.pageDisplayCornerTagListFO", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 5. 4.
	 * - 작성자		: CJA
	 * - 설명		: 전시 코너 아이템(펫tv 신규 영상)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> pageDisplayCornerItemNewVodFOList(DisplayCornerSO so) {
		return selectListPage("display.pageDisplayCornerItemNewVodFOList", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 5. 4.
	 * - 작성자		: CJA
	 * - 설명		: 전시 코너 아이템(펫tv 인기 영상)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> pageDisplayCornerItemPopVodFOList(DisplayCornerSO so) {
		return selectListPage("display.pageDisplayCornerItemPopVodFOList", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: SeriesDao.java
	 * - 작성일		: 2020. 12. 16.
	 * - 작성자		: valueFactory
	 * - 설명			: 오리지널 인기 series 목록 조회
	 * </pre>
	 * @author valueFactory
	 * @param so SeriesSO
	 * @return 
	 */
	public List<SeriesVO> getOriginSeries(SeriesSO so) {
		return selectList("display.getOriginSeries", so);
	}
	
	/**
	 * <pre>영상 상세</pre>
	 * 
	 * @author valueFactory
	 * @param so VodSO
	 * @return 
	 */
	public VodVO getVodDetail(VodSO so) {
		return (VodVO) selectOne("display.getVodDetail", so);
	}
	
	// cja
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 (배너) 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCornerItemVO> listDisplayCornerBannerGrid(DisplayCornerItemSO so) {
		return selectList("display.listDisplayCornerBannerGrid", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 (영상) 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCornerItemVO> listDisplayCornerVdGrid(DisplayCornerItemSO so) {
		return selectList("display.listDisplayCornerVdGrid", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 (시리즈) 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCornerItemVO> listDisplayCornerSeriesGrid(DisplayCornerItemSO so) {
		return selectList("display.listDisplayCornerSeriesGrid", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 사용자 최근 본 동영상 리스트 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ApetContentsWatchHistVO> getContentWatchHist(Long mbrNo) {
		return selectList("apetContentsWatchHist.getContentWatchHist", mbrNo);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 사용자 관심 등록 태그 관련 영상 리스트
	 * </pre>
	 * @param TagNo
	 * @return
	 */
	public List<VodVO> tagVodList(TagBaseSO so) {
		return selectListPage("display.tagVodList", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 펫tv 2위 ~ 펫스쿨 교육 영상`
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> eduNextVod(VodSO so) {
		return selectList("display.eduNextVod", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 전시 코너 아이템 maxNo
	 * </pre>
	 * @return
	 */
	public Long maxDispItemNo() {
		return selectOne("display.maxDispItemNo");
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 교육 영상 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> schoolEduVod(VodSO so) {
		return selectList("display.schoolEduVod", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 전시 코너 아이템 리스트(펫tv 메인 태그 리스트)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayBannerVO> pageDisplayCornerItemMainBnrFO(DisplayCornerSO so) {
		return selectListPage("display.pageDisplayCornerItemMainBnrFO", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 전시 코너 아이템 리스트(영상 + 배너 관련 태그)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TagBaseVO> bannerTagList(Long dispCnrItemNo) {
		return selectList("display.bannerTagList", dispCnrItemNo);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 펫스쿨 메인 배너 
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> schoolMainBanner(VodSO so) {
		return selectList("display.schoolMainBanner", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 마이 찜리스트 (펫TV)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> myWishListTv(VodSO so) {
		return selectList("display.myWishListTv", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 마이 찜리스트 (펫 로그)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<PetLogBaseVO> myWishListLog (PetLogListSO so ) {
		return selectList("display.myWishListLog", so );
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 찜 영상 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int noFavorites(TvDetailPO po) {
		return delete("display.noFavorites", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandDao.java
	 * - 작성일		: 2017. 06. 08.
	 * - 작성자		: valueFactory
	 * - 설명		: 관심 브랜드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BrandBaseVO> interestBrand(MemberInterestBrandSO so) {
		return selectList("display.interestBrand", so);
	}
	
	// cja
	
	// yjy
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: YJU
	 * - 설명			: 전시 코너 아이템 리스트(태그 리스트)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayBannerVO> listDisplayCornerTagsGrid(DisplayCornerItemSO so) {
		return selectList("display.listDisplayCornerTagsGrid", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 1. 13. 
	 * - 작성자		: YJU
	 * - 설명			: 전시 코너 아이템 리스트(펫로그 회원)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCornerItemVO> listDisplayCornerPetLogMemberGrid(DisplayCornerItemSO so) {
		return selectList("display.listDisplayCornerPetLogMemberGrid", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 1. 13. 
	 * - 작성자		: YJU
	 * - 설명			: 전시 코너 아이템 리스트(로그 리스트)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCornerItemVO> listDisplayCornerLogsGrid(DisplayCornerItemSO so) {
		return selectList("display.listDisplayCornerLogsGrid", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 2. 24. 
	 * - 작성자		: YJU
	 * - 설명			: 펫샵 검색 창 문구 조회
	 * </pre>
	 * @param dispClsfNo
	 * @return
	 */
	public DisplayBannerVO getBnrTextFO(DisplayCornerItemSO so) {
		return selectOne("display.getBnrTextFO", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 2. 8. 
	 * - 작성자		: YJU
	 * - 설명			: 전시아이템 목록 가져오기(상품)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsListVO> pageDisplayCornerItemGoodsFO(GoodsListSO so) {
		return selectListPage("display.pageDisplayCornerItemGoodsFO", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 2. 8. 
	 * - 작성자		: YJU
	 * - 설명			: 전시아이템 목록 가져오기(BEST 상품)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsListVO> pageDisplayCornerItemBestGoodsFO(GoodsListSO so) {
		return selectListPage("display.pageDisplayCornerItemBestGoodsFO", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 2. 16. 
	 * - 작성자		: YJU
	 * - 설명			: 전시아이템 목록 가져오기(상품 카테고리)
	 * </pre>
	 * @param gso
	 * @return
	 */
	public List<GoodsListVO> getDisplayCornerItemGoodsCategoryFO(GoodsListSO so) {
		return selectList("display.getDisplayCornerItemGoodsCategoryFO", so);
	}
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 2. 9. 
	 * - 작성자		: YJU
	 * - 설명			: 펫샵 라이브 여부 update
	 * </pre>
	 * @param so
	 * @return
	 */
	public int updateLiveYn(DisplayCategoryPO po) {
		return update("display.updateDisplayBaseLiveYn", po);
	}
	// yjy

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayDao.java
	 * - 작성일        : 2021. 2. 17.
	 * - 작성자        : YKU
	 * - 설명          : 카테고리 필터 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsFiltGrpVO> foCategoryFilterInfo(GoodsFiltGrpSO so) {
		return selectList("display.foCategoryFilterInfo", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayDao.java
	 * - 작성일        : 2021. 3. 15.
	 * - 작성자        : KKB
	 * - 설명          : 검색 필터 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsFiltGrpVO> foSearchFilterInfo() {
		return selectList("display.foSearchFilterInfo");
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayDao.java
	 * - 작성일        : 2021. 2. 17.
	 * - 작성자        : YKU
	 * - 설명          : FO 카테고리 필터 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsFiltAttrVO> foGetFiltAttr(GoodsFiltAttrSO so) {
		return selectList("display.foGetFiltAttr", so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayDao.java
	 * - 작성일        : 2021. 2. 18.
	 * - 작성자        : YKU
	 * - 설명          : 코너 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public DisplayCornerTotalVO getCornList(DisplayCornerSO so) {
		return selectOne("display.getCornList", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 1. 28. 
	 * - 작성자		: YJU
	 * - 설명			: 펫샵 바로가기 영역 리스트(FO)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayBannerVO> getBnrImgListFO(DisplayCornerItemSO so) {
		return selectList("display.getBnrImgListFO", so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayDao.java  
	 * - 작성일        : 2021. 3. 3.
	 * - 작성자        : YKU
	 * - 설명          : 브랜드 필터 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BrandBaseVO> filterBrand(BrandBaseSO so) {
		return selectList("display.filterBrand", so);
	}

	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 3. 12. 
	 * - 작성자		: YJU
	 * - 설명			: 비정형 전시분류 번호로 코너 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public DisplayCornerTotalVO getCornerInfoToDispCornType(GoodsDispSO so) {
		return (DisplayCornerTotalVO) selectOne("display.getCornerInfoToDispCornType", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 4. 2. 
	 * - 작성자		: YJU
	 * - 설명			: 베스트 수동 상품 개수 조회
	 * </pre>
	 * @param po
	 * @return
	 */
	public List<DisplayCornerTotalVO> getBestManual(GoodsDispSO so) {
		return selectList("display.getBestManual", so);
	}
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 6. 16. 
	 * - 작성자		: 이동식
	 * - 설명			: 펫스쿨 메인 > 시청이력의 교육Intro, 교육영상 5초이상 시청한 갯수
	 * </pre>
	 * @param so
	 * @return
	 */
	public int selectEduWatchCount(VodSO so) {
		return selectOne("display.selectEduWatchCount", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: SeriesDao.java
	 * - 작성일		: 2021. 06. 21.
	 * - 작성자		: 이동식
	 * - 설명			: 시리즈 TAG 목록 조회
	 * </pre>
	 * 
	 * @param so
	 * @return 
	 */
	public List<SeriesVO> selectSeriesTagList(DisplayCornerSO so) {
		return selectList("display.selectSeriesTagList", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailDao.java
	 * - 작성일		: 2021. 07. 27.
	 * - 작성자		: LDS
	 * - 설명			: 공통 > 이벤트팝업 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<EventPopupVO> selectPopLayerEventList(EventPopupSO so) {
		return selectList("display.selectPopLayerEventList", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayDao.java
	 * - 작성일		: 2021. 08. 31.
	 * - 작성자		: ValFac
	 * - 설명		: petshop 사용자 맞춤 추천상품
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsDispVO> selectRecommendTotalGoodsList(PetBaseSO so) {
		return selectList("display.selectRecommendTotalGoodsList", so);
	}
}
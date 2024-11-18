package biz.app.display.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;

import biz.app.brand.model.BrandBaseSO;
import biz.app.brand.model.BrandBaseVO;
import biz.app.contents.model.SeriesSO;
import biz.app.contents.model.SeriesVO;
import biz.app.contents.model.VodSO;
import biz.app.contents.model.VodVO;
import biz.app.display.model.DisplayBannerVO;
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
import biz.app.display.model.DisplayPO;
import biz.app.display.model.DisplayTemplatePO;
import biz.app.display.model.DisplayTemplateSO;
import biz.app.display.model.DisplayTemplateVO;
import biz.app.display.model.DisplayTreeVO;
import biz.app.display.model.EventPopupSO;
import biz.app.display.model.EventPopupVO;
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
import biz.app.petlog.model.PetLogBaseVO;
import biz.app.petlog.model.PetLogListSO;
import biz.app.pettv.model.ApetContentsWatchHistVO;
import biz.app.system.model.CodeDetailVO;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.model.TagBaseVO;
import biz.app.tv.model.TvDetailPO;
import framework.front.model.Session;



/**
 * get업무명	:	단건
 * list업무명	:	리스트
 * page업무명	:	리스트 페이징
 * insert업무명	:	입력
 * update업무명	:	수정
 * delete업무명	:	삭제
 * save업무명	:	입력 / 수정
 */
/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.display.service
 * - 파일명		: DisplayService.java
 * - 작성일		: 2016. 5. 18.
 * - 작성자		: valueFactory
 * - 설명		:
 * </pre>
 */
public interface DisplayService {

	//========================================================================
	// BO
	//========================================================================
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 템플릿 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayTemplateVO> listDisplayTemplateGrid(DisplayTemplateSO so);

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 템플릿 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public DisplayTemplateVO getDisplayTemplateDetail(DisplayTemplateSO so);

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 템플릿 등록
	 * </pre>
	 * @param po
	 */
	public void insertDisplayTemplate(DisplayTemplatePO po);

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 템플릿 수정
	 * </pre>
	 * @param po
	 */
	public void updateDisplayTemplate(DisplayTemplatePO po);

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 템플릿 삭제
	 * </pre>
	 * @param po
	 */
	public void deleteDisplayTemplate(DisplayTemplatePO po);

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 8.
	 * - 작성자		: valueFactory
	 * - 설명		:
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayTemplateVO> listDisplayTemplate(DisplayTemplateSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 관리 트리 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayTreeVO> listDisplayTree(DisplayCategorySO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2017. 1. 13.
	 * - 작성자		: hjko
	 * - 설명		:
	 * </pre>
	 * @param so
	 */
	public List<DisplayCategoryVO> displayListTreeFilter(DisplayCategorySO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 기본정보
	 * </pre>
	 * @param so
	 * @return
	 */
	public DisplayCategoryVO getDisplayBase(DisplayCategorySO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 8.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 기본정보 등록 및 수정
	 * </pre>
	 * @param po
	 */
	public void saveDisplayBase(DisplayCategoryPO po);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 19.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 기본정보 삭제
	 * </pre>
	 * @param po
	 */
	public void deleteDisplayBase(DisplayCategoryPO po);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 12.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCornerVO> listDisplayCornerGrid(DisplayCornerSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 12.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 등록 및 수정
	 * </pre>
	 * @param po
	 */
	public void saveDisplayCorner(DisplayCornerPO po);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 6. 9. 
	 * - 작성자		: YJU
	 * - 설명			: 전시 코너, 전시분류 코너 등록
	 * </pre>
	 * @param po
	 */
	public void SaveDisplayCornerAndDisplayClsfCorner(DisplayCornerPO po);
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteDisplayCorner(DisplayCornerPO po);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 저장
	 * </pre>
	 * @param po
	 */
	public void saveDisplayCornerItem(DisplayPO po, DisplayCornerItemPO displayCornerItemPO, String[] tagNos);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public void deleteDisplayCornerItem(DisplayPO po);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 리스트(상품)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCornerItemVO> listDisplayCornerGoodsGrid(DisplayCornerItemSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 리스트(상품평)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCornerItemVO> listDisplayCornerGoodsEstmGrid(DisplayCornerItemSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 코너 아이템 리스트(배너 TEXT / 배너 HTML / 배너 이미지 / 배너 복합)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayBannerVO> listDisplayCornerBnrItemGrid(DisplayCornerItemSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 14.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 상품 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayGoodsVO> listDisplayGoodsGrid(DisplayGoodsSO so);

	/**
	 *
	 * <pre>u
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 20.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 상품 저장
	 * </pre>
	 * @param po
	 */
	public void saveDisplayGoods(DisplayPO po);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 29.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 상품 추가
	 * </pre>
	 * @param list
	 */
	public void insertDisplayGoods(List<DisplayGoodsPO> list);

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 15.
	 * - 작성자		: valueFactory
	 * - 설명		: 전시 상품 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public void deleteDisplayGoods(DisplayPO po);

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 관련 브랜드 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayBrandVO> listDisplayBrandGrid(DisplayBrandSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 관련 브랜드 저장
	 * </pre>
	 * @param po
	 */
	public void saveDisplayBrand(DisplayPO po);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 29.
	 * - 작성자		: valueFactory
	 * - 설명		: 관련 브랜드 추가
	 * </pre>
	 * @param list
	 */
	public void insertDisplayBrand(DisplayPO po);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 21.
	 * - 작성자		: valueFactory
	 * - 설명		: 관련 브랜드 삭제
	 * </pre>
	 * @param po
	 */
	public void deleteDisplayBrand(DisplayPO po);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 쇼룸 카테고리 리스트
	 * </pre>
	 * @return
	 */
	public List<DisplayCategoryVO> listDisplayShowRoomCategory();
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		: 전시 상품 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayGoodsVO> listDisplayShowRoomGoodsGrid(DisplayGoodsSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		: 쇼룸 전시 상품 추가
	 * </pre>
	 * @param list
	 */
	public void insertDisplayShowRoomGoods(List<DisplayGoodsPO> list);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		: 쇼룸 전시 상품 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public void deleteDisplayShowRoomGoods(DisplayPO po);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2017. 1. 23.
	 * - 작성자		: hongjun
	 * - 설명		: 전시 분류 코너 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayClsfCornerVO> listDisplayClsfCornerGrid(DisplayClsfCornerSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2017. 1. 23.
	 * - 작성자		: hongjun
	 * - 설명		: 전시 분류 코너 등록 및 수정
	 * </pre>
	 * @param po
	 */
	public void saveDisplayClsfCorner(DisplayClsfCornerPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2017. 1. 24.
	 * - 작성자		: hongjun
	 * - 설명		: 전시 분류 코너 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public void deleteDisplayClsfCorner(DisplayPO po);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2017. 5. 24.
	 * - 작성자		: hongjun
	 * - 설명		:  카테고리 목록리스팅
	 * </pre>
	 * @param po
	 */
	public List<DisplayCategoryVO> listDisplayCategory(DisplayCategorySO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 6. 29.
	 * - 작성자		: valueFactory
	 * - 설명		: 기획전 상품 일괄업로드
	 * </pre>
	 * @param po
	 */
	public void displayGoodsUpload(DisplayPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 6. 29.
	 * - 작성자		: valueFactory
	 * - 설명		: 기획전 상품 엑셀 데이터 유효성 검사
	 * </pre>
	 * @param dipslayGoodsUploadPOList
	 * @return
	 */
	public List<DisplayGoodsPO> validateBulkUpladGoods (List<DisplayGoodsPO> dipslayGoodsUploadPOList);
	
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: DisplayService.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 상품 전시 등록
	* </pre>
	*
	* @param goodsId
	* @param displayGoodsPOList
	* @return
	*/
	public void insertDisplayGoods(String goodsId, List<DisplayGoodsPO> displayGoodsPOList);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: DisplayService.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 전시 등록
	* </pre>
	*
	* @param goodsId
	* @param displayGoodsPOList
	*/
	public void updateDisplayGoods(String goodsId, List<DisplayGoodsPO> displayGoodsPOList);

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
	 * @param so
	 * @return
	 */
	public List<DisplayCategoryVO> listCategory(DisplayCategorySO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 5. 16.
	 * - 작성자		: hjko
	 * - 설명		: leaf node 로 조상 node 찾기 (하위카테고리로 상위 카테고리 찾기)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCategoryVO> listAncestorCategory(DisplayCategorySO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 7. 22.
	 * - 작성자		: hjko
	 * - 설명		: leaf node 로 navigation 만들기
	 * </pre>
	 * @param dispClsfNo
	 * @return
	 */
	public Map<Long,String> getFullCategoryNaviList(Long dispClsfNo);
	
	
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2017. 05. 29.
	 * - 작성자		: wyjeong
	 * - 설명		: 상품이 존재하는 전시 카테고리 목록 조회
	 * </pre>
	 * @param so
	 */
	public List<DisplayCategoryVO> listDisplayCategoryByGoodsYn(DisplayCategorySO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2017. 07. 07.
	 * - 작성자		: wyjeong
	 * - 설명		: 스토어, 디자이너, 브랜드 샵 전시 카테고리 목록 조회
	 * </pre>
	 * @param so
	 */
	public List<DisplayCategoryVO> listDisplayCategoryByComp(DisplayCategorySO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2017. 06. 09.
	 * - 작성자		: wyjeong
	 * - 설명		: 전시 분류별 전시 코너 정보 전체 조회
	 * </pre>
	 * @param dispClsfNo
	 * @param gso
	 * @return
	 */
	public List<DisplayCornerTotalVO> getDisplayCornerItemTotalFO(Long dispClsfNo, GoodsListSO gso);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2017. 06. 09.
	 * - 작성자		: CJA
	 * - 설명		: 펫TV 전시 분류별 전시 코너 정보 전체 조회
	 * </pre>
	 * @param dispClsfNo
	 * @param session
	 * @throws Exception 
	 * @return
	 */
	public List<DisplayCornerTotalVO> getPetTvDisplayCornerItemTotalFO(Long dispClsfNo, Session session, DisplayCornerSO so) throws Exception;
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2017. 06. 09.
	 * - 작성자		: wyjeong
	 * - 설명		: 특정 전시 코너 정보 조회
	 * </pre>
	 * @param dso
	 * @param gso
	 * @return
	 */
	public DisplayCornerTotalVO getDisplayCornerItemFO(DisplayCornerSO dso, GoodsListSO gso);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2017. 07.
	 * - 작성자		: dlswjdd
	 * - 설명		: 입점희망 카테고리 조회
	 * </pre>
	 * @param dispClsfNo
	 */
	public List<DisplayCategoryVO> listDisplayHopeCategory(DisplayCategorySO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2017. 07. 05.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 카테고리 별 MD 추천상품 조회
	 * </pre>
	 * @param so
	 */
	public List<GoodsListVO> listMdRcomGoodsFO(GoodsListSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2017. 08. 22.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 공동구매 리스트 조회
	 * </pre>
	 * @param po
	 * @return
	 */
	public List<DisplayGroupBuyVO> pageGroupBuyGoods(DisplayGroupBuySO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2017. 08. 22.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 공동구매 상품이 속한 페이지 번호 조회
	 * </pre>
	 * @param po
	 * @return
	 */
	public DisplayGroupBuySO getGroupBuyGoodPage(DisplayGroupBuySO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2019. 12. 25
	 * - 작성자		: jylee
	 * - 설명		: BO 전시 영역 관리에서 해당 사이트에 사용하기로 되어 있는 (ufd2 컬럼에 st_id를 ,로 구분하여 등록)
	 * </pre>
	 * @param String
	 * @return
	 */
	public List<CodeDetailVO> getDistinctDispClsfCds(Long siteId);

	public List<GoodsFiltGrpPO> getCategoryFilters(DisplayCategorySO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2019. 12. 25
	 * - 작성자		: CJA
	 * - 설명		: 전시 코너 아이템(배너 + 영상) 그리드
	 * </pre>
	 * @param String
	 * @return
	 */
	public List<DisplayCornerItemVO> listDisplayCornerBnrVdBnrGrid(DisplayCornerItemSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2019. 12. 25
	 * - 작성자		: CJA
	 * - 설명		: 전시 코너 아이템(배너 + 영상 + 태그) 그리드
	 * </pre>
	 * @param String
	 * @return
	 */
	public List<DisplayBannerVO> listDisplayCornerBnrVodTagGrid(DisplayCornerItemSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2019. 12. 25
	 * - 작성자		: CJA
	 * - 설명		: 전시 코너 아이템 (영상 + 배너 + 태그) 전시 코너 아이템 태그 맵핑
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCornerItemVO> getTagList(DisplayCornerItemSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2019. 12. 25
	 * - 작성자		: CJA
	 * - 설명		: 전시 코너 아이템(태그 리스트)
	 * </pre>
	 * @param String
	 * @return
	 */
	public List<TagBaseVO> pageDisplayCornerTagListFO(DisplayCornerSO so);
	
	/**
	 * <pre>영상 상세</pre>
	 * 
	 * @author valueFactory
	 * @param so VodSO
	 * @return 
	 */
	public VodVO getVodDetail(VodSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2019. 12. 25
	 * - 작성자		: CJA
	 * - 설명		: 전시 코너 날짜별 조회
	 * </pre>
	 * @param String
	 * @return
	 */
	public List<DisplayCornerTotalVO> listDisplayClsfCornerDate(DisplayCornerSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2019. 12. 25
	 * - 작성자		: CJA
	 * - 설명		: 펫TV 마이 찜리스트
	 * </pre>
	 * @param String
	 * @return
	 */
	public List<VodVO> myWishListTv(VodSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2019. 12. 25
	 * - 작성자		: CJA
	 * - 설명		: 펫 로그 마이 찜리스트
	 * </pre>
	 * @param String
	 * @return
	 */
	public List<PetLogBaseVO> myWishListLog (PetLogListSO so );
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2019. 12. 25
	 * - 작성자		: CJA
	 * - 설명		: 영상 찜 해제  
	 * </pre>
	 * @param String
	 * @return
	 */
	public void noFavorites(TvDetailPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2019. 12. 25
	 * - 작성자		: CJA
	 * - 설명		: 관심 브랜드  
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BrandBaseVO> interestBrand(MemberInterestBrandSO so);
	// cja
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2019. 12. 25
	 * - 작성자		: CJA
	 * - 설명		: 전시 코너 아이템(배너) 그리드
	 * </pre>
	 * @param String
	 * @return
	 */
	public List<DisplayCornerItemVO> listDisplayCornerBannerGrid(DisplayCornerItemSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2019. 12. 25
	 * - 작성자		: CJA
	 * - 설명		: 전시 코너 아이템(영상) 그리드
	 * </pre>
	 * @param String
	 * @return
	 */
	public List<DisplayCornerItemVO> listDisplayCornerVdGrid(DisplayCornerItemSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2019. 12. 25
	 * - 작성자		: CJA
	 * - 설명		: 전시 코너 아이템(시리즈) 그리드
	 * </pre>
	 * @param String
	 * @return
	 */
	public List<DisplayCornerItemVO> listDisplayCornerSeriesGrid(DisplayCornerItemSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2019. 12. 25
	 * - 작성자		: CJA
	 * - 설명		: 사용자 최근 본 영상 리스트 조회
	 * </pre>
	 * @param String
	 * @return
	 */
	public List<ApetContentsWatchHistVO> getContentWatchHist(Long mbrNo);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 전시 코너 아이템 리스트(태그 리스트)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> pageDisplayCornerItemVodFO(VodSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 전시 코너 아이템 리스트(태그 리스트)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> pageDisplayCornerItemVodNexFO(VodSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 전시 코너 아이템 리스트(태그 리스트)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> pageDisplayCornerItemNewVodFO(VodSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 전시 코너 아이템 리스트(태그 리스트)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> apetEducationHist(MemberBaseSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2016. 5. 4.
	 * - 작성자		: hjko
	 * - 설명			: 전시코너에 해당하는 전시아이템 목록 가져오기(배너타입)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> baseEduVod(VodSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 사용자 관심 등록 태그 관련 영상 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> tagVodList(TagBaseSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 펫tv 2위 ~ 펫스쿨 교육 영상
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> eduNextVod(VodSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 전시 코너 아이템 maxNo
	 * </pre>
	 * @param so
	 * @return
	 */
	public Long maxDispItemNo();
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 교육 영상 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> schoolEduVod(VodSO so);

	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 전시 코너 아이템 리스트(펫tv 메인 태그 리스트)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayBannerVO> pageDisplayCornerItemMainBnrFO(DisplayCornerSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 전시 코너 아이템 리스트(영상 + 배너 관련 태그)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TagBaseVO> bannerTagList(Long dispCnrItemNo);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 펫스쿨 메인 배너
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> schoolMainBanner(VodSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 펫tv 신규영상
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> pageDisplayCornerItemNewVodFOList(DisplayCornerSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: CJA
	 * - 설명			: 펫tv 인기영상
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<VodVO> pageDisplayCornerItemPopVodFOList(DisplayCornerSO so);
	// cja
	
	// yjy
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 1. 11. 
	 * - 작성자		: YJU
	 * - 설명			: 전시 코너 아이템 리스트(태그 리스트)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayBannerVO> listDisplayCornerTagsGrid(DisplayCornerItemSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 1. 13. 
	 * - 작성자		: YJU
	 * - 설명			: 전시 코너 아이템 리스트(펫로그 회원)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCornerItemVO> listDisplayCornerPetLogMemberGrid(DisplayCornerItemSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 1. 13. 
	 * - 작성자		: YJU
	 * - 설명			: 전시 코너 아이템 리스트(로그 리스트)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCornerItemVO> listDisplayCornerLogsGrid(DisplayCornerItemSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 1. 26. 
	 * - 작성자		: YJU
	 * - 설명			: 전시 카테고리 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCategoryVO> listDisplayCategoryByDispYn(DisplayCategorySO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 2. 24. 
	 * - 작성자		: YJU
	 * - 설명			: 펫샵 검색 창 문구 조회
	 * </pre>
	 * @param valueOf
	 * @return
	 */
	public DisplayBannerVO getBnrTextFO(DisplayCornerItemSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2017. 06. 09.
	 * - 작성자		: wyjeong
	 * - 설명		: 전시 분류별 전시 코너 정보 전체 조회(PETSHOP)
	 * </pre>
	 * @param dispClsfNo
	 * @param gso
	 * @return
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonParseException 
	 */
	public List<DisplayCornerTotalVO> getDisplayCornerItemTotalPetShopFOTest(Long dispClsfNo, GoodsDispSO gso) throws JsonParseException, JsonMappingException, IOException;

	/**
	 * - 설명		: test
	 */
	public List<DisplayCornerTotalVO> getDisplayCornerItemTotalPetShopFO(Long dispClsfNo, GoodsDispSO gso, List<DisplayCornerTotalVO> cornList) throws JsonParseException, JsonMappingException, IOException;
	
	/**
	 * - 설명		: test
	 */
	public List<DisplayCornerTotalVO> dvsnCorner1(Long dispClsfNo, GoodsDispSO gso) throws JsonParseException, JsonMappingException, IOException;
	
	/**
	 * - 설명		: test
	 */
	public List<DisplayCornerTotalVO> dvsnCorner2(Long dispClsfNo, GoodsDispSO gso) throws JsonParseException, JsonMappingException, IOException;
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 2. 9. 
	 * - 작성자		: YJU
	 * - 설명			: 펫샵 라이브 여부 정보 update
	 * </pre>
	 * @param so
	 */
	public void liveOnOff(DisplayCategoryPO po);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 2. 18. 
	 * - 작성자		: YJU
	 * - 설명			: 펫샵 베스트 상품 카테고리별 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsListVO> pageDisplayCornerItemBestGoodsFO(GoodsListSO so);
	// yjy
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayService.java
	 * - 작성일        : 2021. 2. 17.
	 * - 작성자        : YKU
	 * - 설명          : FO 카테고리 필터 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsFiltGrpVO> foCategoryFilterInfo(GoodsFiltGrpSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayService.java
	 * - 작성일        : 2021. 2. 17.
	 * - 작성자        : KKB
	 * - 설명          : 검색 필터 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsFiltGrpVO> foSearchFilterInfo();
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayService.java
	 * - 작성일        : 2021. 2. 17.
	 * - 작성자        : YKU
	 * - 설명          : FO 카테고리 필터 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsFiltAttrVO> foGetFiltAttr(GoodsFiltAttrSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayService.java
	 * - 작성일        : 2021. 2. 18.
	 * - 작성자        : YKU
	 * - 설명          : 코너 조회
	 * </pre>
	 * @param cornSo
	 * @return
	 */
	public DisplayCornerTotalVO getCornList(DisplayCornerSO cornSo);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayService.java
	 * - 작성일        : 2021. 2. 18.
	 * - 작성자        : CJA
	 * - 설명          : 오리지널 인기 series 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<SeriesVO> getOriginSeries(SeriesSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 1. 28. 
	 * - 작성자		: YJU
	 * - 설명			: 펫샵 바로가기 영역 리스트(FO)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayBannerVO> getBnrImgListFO(DisplayCornerItemSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 3. 4. 
	 * - 작성자		: YJU
	 * - 설명			: 전시 분류별 전시 코너 정보 전체 조회 
	 * </pre>
	 * @param gso
	 * @return
	 */
	public List<DisplayCornerTotalVO> getDisplayCornerItemCaterotyFO(GoodsDispSO gso, String dispCornTpCd);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 3. 2. 
	 * - 작성자		: YJU
	 * - 설명			: 펫샵 상품 리스트(FO)
	 * </pre>
	 * @param so
	 * @return
	 */
	public DisplayCornerTotalVO getGoodsList(GoodsDispSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 3. 2. 
	 * - 작성자		: YJU
	 * - 설명			: 펫샵 상품 리스트(FO)
	 * </pre>
	 * @param so
	 * @return
	 */
	public DisplayCornerTotalVO getDispTypeCornerGoodsList(GoodsDispSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명    : gs-apet-11-business
	 * - 파일명        : DisplayService.java
	 * - 작성일        : 2021. 3. 3.
	 * - 작성자        : YKU
	 * - 설명          : 브랜드 필터 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BrandBaseVO> filterBrand(BrandBaseSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 3. 4. 
	 * - 작성자		: YJU
	 * - 설명			: LNB 변경에 따른 펫구분코드 변경 
	 * </pre>
	 * @param gso
	 * @return
	 */
	public String updatePetGbCdLnbHistory(Long dispClsfNo, Long mbrNo);

	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 3. 12. 
	 * - 작성자		: YJU
	 * - 설명			: 비정형 전시분류 번호로 코너 정보 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public DisplayCornerTotalVO getCornerInfoToDispCornType(GoodsDispSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 4. 2. 
	 * - 작성자		: YJU
	 * - 설명			: 베스트 수동 상품 개수 조회
	 * </pre>
	 * @param po
	 * @return
	 */
	public List<DisplayCornerTotalVO> getBestManual(GoodsDispSO so);

	/**
	 *
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 4. 7. 
	 * - 작성자		: YJU
	 * - 설명			: 맞춤추천 다른 반려동물 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsDispVO> getRecOtherPetGoodsList(GoodsDispSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 6. 16. 
	 * - 작성자		: 이동식
	 * - 설명			: 펫스쿨 메인 > 시청이력의 교육Intro, 교육영상 5초이상 시청한 갯수
	 * </pre>
	 * @param so
	 * @return
	 */
	public int selectEduWatchCount(VodSO so);
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: DisplayService.java
	 * - 작성일		: 2021. 06. 21.
	 * - 작성자		: 이동식
	 * - 설명			: 시리즈 TAG 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<SeriesVO> selectSeriesTagList(DisplayCornerSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailService.java
	 * - 작성일		: 2021. 07. 27.
	 * - 작성자		: LDS
	 * - 설명			: 공통 > 이벤트팝업 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<EventPopupVO> selectPopLayerEventList(EventPopupSO so);
	
}

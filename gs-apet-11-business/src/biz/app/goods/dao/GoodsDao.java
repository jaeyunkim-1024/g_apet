package biz.app.goods.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import biz.app.goods.model.*;
import org.springframework.stereotype.Repository;

import biz.app.brand.model.CompanyBrandVO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.display.model.DisplayGoodsVO;
import biz.app.display.model.DisplayHotDealVO;
import biz.app.goods.model.interfaces.WmsGoodsListSO;
import biz.app.goods.model.interfaces.WmsGoodsListVO;
import biz.app.st.model.StStdInfoVO;
import biz.app.tv.model.TvDetailGoodsVO;
import biz.app.tv.model.TvDetailSO;
import biz.app.petlog.model.PetLogBaseSO;
import framework.common.dao.MainAbstractDao;

@Repository
public class GoodsDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goods.";

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 4. 7.
	* - 작성자		: snw
	* - 설명		: 상품상세 조회
	* </pre>
	* @param goodsId
	* @return
	*/


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: GoodsDao.java
	* - 작성일	: 2016. 4. 28.
	* - 작성자	: jangjy
	* - 설명		: 상품 가격 집계 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public GoodsPriceTotalVO getGoodsPriceTotal(String goodsId){
		return selectOne(BASE_DAO_PACKAGE + "getGoodsPriceTotal", goodsId);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2017. 02. 01.
	* - 작성자		: xerowiz@naver.com
	* - 설명		: 상품 리스트 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsBaseVO> listGoods(GoodsBaseSO so){
		return selectListPage("goods.listGoods", so);
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2017. 02. 01.
	* - 작성자		: wyjeong
	* - 설명		: BEST 상품 리스트 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsListVO> pageBestGoods(GoodsListSO so){
		return selectListPage("goods.pageBestGoods", so);
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
	public GoodsBaseVO getGoodsDetailFO(GoodsBaseSO mso){
		return selectOne(BASE_DAO_PACKAGE+"getGoodsDetailFO", mso);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 8. 16.
	* - 작성자		: snw
	* - 설명		: 상품의 대표 전시 카테고리 번호  조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public Long getDlgtDispClsfNo(GoodsBaseSO mso) {
		return selectOne(BASE_DAO_PACKAGE + "getDlgtDispClsfNo", mso);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 8. 16.
	* - 작성자		: snw
	* - 설명		: 핫딜 상품 - 판매건수, 남은 시간 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public DisplayHotDealVO getHotDealInfo(GoodsBaseSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getHotDealInfo", so);
	}

	//-------------------------------------------------------------------------------------------------------------------------//
	//- 어드민
	//-------------------------------------------------------------------------------------------------------------------------//




	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 6. 8.
	* - 작성자		: valueFactory
	* - 설명			: 상품 이력 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertGoodsBaseHist (GoodsBaseHistPO po ) {
		return insert("goods.insertGoodsBaseHist", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 3. 7.
	* - 작성자		: valueFactory
	* - 설명			: 상품 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateGoodsBase (GoodsBasePO po ) {
		return insert("goods.updateGoodsBase", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDao.java
	* - 작성일	: 2021. 4. 6.
	* - 작성자 	: valfac
	* - 설명 		: 상품 유형 수정
	* </pre>
	*
	* @param po
	* @return
	*/
	public int updateGoodsTpCd (GoodsBasePO po) {
		return update("goods.updateGoodsTpCd", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 4. 27.
	* - 작성자		: valueFactory
	* - 설명			: 상품 리스트 조회
	* </pre>
	* @param goodsBaseSO
	* @return
	*/
	public List<GoodsBaseVO> pageGoodsBase (GoodsBaseSO goodsBaseSO ) {
		return selectListPage ("goods.pageGoodsBase", goodsBaseSO );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDao.java
	 * - 작성일		: 2021. 3. 10.
	 * - 작성자		: valueFactory
	 * - 설명		: EXCEL 다운로드용 상품 리스트 조회 (페이징 없음)
	 * </pre>
	 * @param goodsBaseSO
	 * @return
	 */
	public List selectGoodsBaseList (GoodsBaseSO goodsBaseSO ) {
		return selectList ("goods.selectGoodsBaseList", goodsBaseSO );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 4. 29.
	* - 작성자		: valueFactory
	* - 설명			: 상품 간단 정보 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public GoodsBaseVO getGoodsSimpleInfo (String goodsId ) {
		return (GoodsBaseVO)selectOne("goods.getGoodsSimpleInfo", goodsId);
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 5. 2.
	* - 작성자		: valueFactory
	* - 설명			: 상품 기본정보 조회 [BO]
	* </pre>
	* @param goodsId
	* @return
	*/
	public GoodsBaseVO getGoodsDetail (String goodsId ) {
		return (GoodsBaseVO)selectOne("goods.getGoodsDetail", goodsId );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 5. 2.
	* - 작성자		: valueFactory
	* - 설명			: 상품 전시 카테고리 정보 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public List<DisplayGoodsVO> listGoodsDispCtg (String goodsId ) {
		return selectList("goods.listGoodsDispCtg", goodsId );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 6. 7.
	* - 작성자		: shkim
	* - 설명		: 세트상품/딜상품 구성상품 리스트 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public List<GoodsBaseVO> listSubGoods (String goodsId){
		return selectList("goods.listSubGoods", goodsId);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDao.java
	 * - 작성일		: 2016. 5. 19.
	 * - 작성자		: eojo
	 * - 설명		: Deal 구성 상품 리스트 등록
	 * </pre>
	 * @param list
	 * @return
	 */
	public int insertGoodsCstrtInfo(GoodsCstrtInfoPO list) {
		return insert("goodsCstrt.insertGoodsCstrtInfo", list);
	}

	public int deleteGoodsBase(String goodsId) {
		return delete("goods.deleteGoodsBase", goodsId);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 8. 5.
	* - 작성자		: snw
	* - 설명		: 상품 가격 배치
	* </pre>
	 * @return 
	* @return
	*/
	public Integer batchGoodsPriceTotal() {
		Integer resultCnt = Integer.valueOf(1);
		update("goods.batchGoodsPriceTotal", resultCnt);
		
		return resultCnt;
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 8. 8.
	* - 작성자		: snw
	* - 설명		: 상품 인기순위 배치
	* </pre>
	*/
	public void batchGoodsPopularity() {
		selectOne("goods.batchGoodsPopularity");
	}



	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 8. 5.
	* - 작성자		:
	* - 설명		: 일반/세트 상품 중 판매상태가 '판매중'으로 판매기간이 종료된 상품을 판매중지처리 (배치용)
	* </pre>
	* @return
	*/
	public int updateGoodsBaseSaleEnd() {
		return update("goods.updateGoodsBaseSaleEnd");
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 8. 5.
	* - 작성자		:
	* - 설명		: 단품의 판매중지 처리
	* </pre>
	* @return
	*/
	public int updateItemSoldout() {
		return update("goods.updateItemSoldout");
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 8. 5.
	* - 작성자		: snw
	* - 설명		: 일반상품 판매중지 처리
	* </pre>
	* @return
	*/
	public int updateGoodsBaseSoldout() {
		return update("goods.updateGoodsBaseSoldout");
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 8. 5.
	* - 작성자		: snw
	* - 설명		: 구성하는 상품의 판매상태에 따른 세트상품의 상태를 판매중 > 판매중지
	* </pre>
	* @return
	*/
	public int updateSetGoodsBaseSoldout() {
		return update("goods.updateSetGoodsBaseSoldout");
	}

	

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 6. 10.
	* - 작성자		: valueFactory
	* - 설명			: 상품 이력 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public List<GoodsBaseHistVO> listGoodsBaseHist (GoodsBaseHistSO goodsBaseHistSO ) {
		return selectList("goods.listGoodsBaseHist", goodsBaseHistSO );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 6. 29.
	* - 작성자		: valueFactory
	* - 설명			: 상품 통계 배치
	* </pre>
	* @param po
	* @return
	*/
	public int insertDayGoodsPplrtTotal (DayGoodsPplrtTotalSO so ) {
		return insert("goods.insertDayGoodsPplrtTotal", so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 6. 29.
	* - 작성자		: valueFactory
	* - 설명			: 상품 통계 순위 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateDayGoodsPplrtTotal (DayGoodsPplrtTotalSO so ) {
		return insert("goods.updateDayGoodsPplrtTotal", so );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 7. 22.
	* - 작성자		: yhkim
	* - 설명		: 상품 위시리스트 여부 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public GoodsBaseVO getInterestYn(GoodsBaseSO so){
		return selectOne(BASE_DAO_PACKAGE+"getInterestYn", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: GoodsDao.java
	* - 작성일	: 2016. 7. 27.
	* - 작성자	: jangjy
	* - 설명		: 조립설명서 목록
	* </pre>
	* @param goodsBaseSO
	* @return
	*/
	public List<GoodsBaseVO> pageAssembleList (GoodsBaseSO goodsBaseSO ) {
		return selectListPage ("goods.pageAssembleList", goodsBaseSO );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 8. 5.
	* - 작성자		: snw
	* - 설명		: 상품 조회수 증가
	* </pre>
	* @param goodsId
	* @return
	*/
	public int updateGoodsHits(String goodsId) {
		return update("goods.updateGoodsHits", goodsId);
	}

	public int insertGoodsHits(String goodsId) {
		return update("goods.insertGoodsHits", goodsId);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 9. 7.
	* - 작성자		: hjko
	* - 설명			: 세일중인 상품 리스트 조회
	* </pre>
	* @param goodsBaseSO
	* @return
	*/
	public List<GoodsBaseVO> pageSaleGoodsBase (GoodsBaseSO goodsBaseSO ) {
		return selectListPage ("goods.pageSaleGoodsBase", goodsBaseSO );
	}

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StDao.java
	* - 작성일		: 2017. 1. 6.
	* - 작성자		: hjko
	* - 설명		:  사이트 상품 매핑테이블에 있는 사이트 목록 조회
	* </pre>
	* @param so
	* @return
	 */
	public List<StGoodsMapVO> listStStdInfoGoods(StGoodsMapSO so) {
		return selectList(BASE_DAO_PACKAGE + "listStStdInfoGoods", so);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: StDao.java
	* - 작성일		: 2017. 1. 10.
	* - 작성자		: hjko
	* - 설명		:
	* </pre>
	* @param po
	* @return
	 */
	public Integer deleteStGoodsMap(StGoodsMapSO so) {

		return delete(BASE_DAO_PACKAGE+ "deleteStGoodsMap", so);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2017. 1. 10.
	* - 작성자		: hjko
	* - 설명		:
	* </pre>
	* @param po
	* @return
	 */
	public Integer insertStGoodsMap(StGoodsMapPO po) {
		return insert(BASE_DAO_PACKAGE+ "insertStGoodsMap", po);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2017. 1. 10.
	* - 작성자		: hjko
	* - 설명		:
	* </pre>
	* @param so
	* @return
	 */
	public List<DisplayCategoryVO> listCompDispMapGoods(GoodsBaseSO so) {
		return selectList(BASE_DAO_PACKAGE+"listCompDispMapGoods", so);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: hjko
	* - 설명		:
	* </pre>
	* @param compNo
	* @return
	 */
	public List<CompanyBrandVO> listCompanyBrand(Long compNo) {

		return selectList(BASE_DAO_PACKAGE+"listCompanyBrand", compNo);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2017. 2. 1.
	* - 작성자		: hjko
	* - 설명		: 사이트에 해당하는 상품 스타일 목록 가져오기
	* </pre>
	* @param stId
	* @return
	 */
	public List<StGoodsMapVO> listStGoodsStyle(StGoodsMapSO so){
		return selectList(BASE_DAO_PACKAGE+"listStGoodsStyle", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2017. 2. 01.
	* - 작성자		: les
	* - 설명		: 상품 적립금율 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public Long getStStdAvmnRateById(GoodsBaseSO so){
		return (Long)selectOne(BASE_DAO_PACKAGE+"getStStdAvmnRateById", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2017. 2. 01.
	* - 작성자		: les
	* - 설명		: 연관 상품 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public List<GoodsBaseVO> listCstrtGoods(GoodsBaseSO so){
		return selectList(BASE_DAO_PACKAGE+"listCstrtGoods", so);
	}


	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.goods.dao
	* - 파일명      : GoodsDao.java
	* - 작성일      : 2017. 6. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  수수료율 수정
	* </pre>
	 */
	public int updateStGoodsMap (StGoodsMapPO so ) {
		return update(BASE_DAO_PACKAGE + "updateStGoodsMap", so );
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.goods.dao
	* - 파일명      : CompanyDao.java
	* - 작성일      : 2017. 6. 19.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 상품 배송비정책 일괄 변경
	* </pre>
	 */
	public int updateGoodsDlvrcPlcNoBatch(GoodsBasePO po) {
		return update("goods.updateGoodsDlvrcPlcNoBatch",po);
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDao.java
	 * - 작성일		: 2017. 06. 16.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 상품 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsListVO> pageGoodsFO(GoodsListSO so) {
		return selectListPage("goods.pageGoodsFO", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDao.java
	 * - 작성일		: 2017. 06. 16.
	 * - 작성자		: wyjeong
	 * - 설명		: FO 상품 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsListVO> pageGoodsByDispClsfCornNo(GoodsListSO so) {
		return selectListPage("goods.pageGoodsByDispClsfCornNo", so);
	}

	public List<StStdInfoVO> listCompCmsRate(StGoodsMapSO so) {
		return selectList(BASE_DAO_PACKAGE + "listCompCmsRate", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDao.java
	 * - 작성일		: 2017. 07. 11.
	 * - 작성자		: wyjeong
	 * - 설명		: 셀러, 스토어, 디자이너 상단 BEST 상품 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsListVO> listBestGoodsByComp(GoodsListSO so) {
		return selectList("goods.listBestGoodsByComp", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명   : biz.app.goods.service
	 * - 파일명		: GoodsService.java
	 * - 작성일		: 2017. 08. 25.
	 * - 작성자		: hjko
	 * - 설명		:  interface 상품 목록 조회(wms용)
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<WmsGoodsListVO> pageGoodsListInterface(WmsGoodsListSO so) {
		//return selectListPage("goods.pageGoodsListInterface", so);
		return selectListPage("goods.pageWmsGoodsListInterface",so);
	}

	public int getGoodsListInterfacetotalCount(WmsGoodsListSO so) {
		//return selectOne("goods.getGoodsListInterfacetotalCount", so);
		return selectOne("goods.pageWmsGoodsListInterfaceCount",so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 패키지명   : biz.app.goods.service
	 * - 파일명		: GoodsService.java
	 * - 작성일		: 2017. 08. 04.
	 * - 작성자		: hjko
	 * - 설명		:  interface 상품 등록시 기존에 등록된 상품 조회
	 * </pre>
	 * @param so
	 * @return
	 */
//	public GoodsBaseVO interfaceCheckGoodsExists(GoodsSO dupSO) {
//		return selectOne(BASE_DAO_PACKAGE+"interfaceCheckGoodsExists",dupSO);
//	}

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2019*. 12. 17.
	* - 작성자		: hjko
	* - 설명		:
	* </pre>
	* @param po
	* @return
	 */
	public Integer updateGoodsPrice(StGoodsMapPO po) {
		return update(BASE_DAO_PACKAGE+ "updateGoodsPrice", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDao.java
	 * - 작성일		: 2020. 01. 17.
	 * - 작성자		: pkt
	 * - 설명		: 상품 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<GoodsBaseVO> pageGoodsBaseBO(GoodsBaseSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageGoodsBaseBO", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsDao.java
	 * - 작성일		: 2021. 01. 22.
	 * - 작성자		:
	 * - 설명		: 사이트 상품 매핑
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<StGoodsMapPO> listStGoodsMap(String goodsId) {
		return selectList(BASE_DAO_PACKAGE + "listStGoodsMap", goodsId);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDao.java
	* - 작성일	: 2021. 2. 8.
	* - 작성자 	: valfac
	* - 설명 		: 상품 컨텐츠 목록
	* </pre>
	*
	* @param so
	* @return
	*/
	public List<TvDetailGoodsVO> listGoodsContentsBO(TvDetailSO so) {
		return selectList(BASE_DAO_PACKAGE + "listGoodsContentsBO", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDao.java
	* - 작성일	: 2021. 2. 9.
	* - 작성자 	: valfac
	* - 설명 		: 상품 수정 가능 카운트
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	public GoodsBaseVO checkPossibleCnt(String goodsId) {
		return selectOne(BASE_DAO_PACKAGE + "checkPossibleCnt", goodsId);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDao.java
	* - 작성일	: 2021. 3. 17.
	* - 작성자 	: valfac
	* - 설명 		: 대표 상품 정보 조회
	* </pre>
	*
	* @param so
	* @return
	*/
	public GoodsBaseVO getDlgtSubGoodsInfo(GoodsBaseSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getDlgtSubGoodsInfo", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsDao.java
	 * - 작성일	: 2021. 2. 26.
	 * - 작성자 	: valfac
	 * - 설명 		: TV 연관상품 목록 조회
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	public List<GoodsBaseVO> getGoodsRelatedWithTv(GoodsRelatedSO so) {
		return selectList(BASE_DAO_PACKAGE + "getGoodsRelatedWithTv", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsDao.java
	 * - 작성일	: 2021. 2. 26.
	 * - 작성자 	: valfac
	 * - 설명 		: 펫로그 연관상품 목록 조회
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	public List<GoodsBaseVO> getGoodsRelatedWithPetLog(GoodsRelatedSO so) {
		return selectList(BASE_DAO_PACKAGE + "getGoodsRelatedWithPetLog", so);
	}

	public List<GoodsBaseVO> getGoodsRelatedInGoods(GoodsRelatedSO so) {
		return selectList(BASE_DAO_PACKAGE + "getGoodsRelatedInGoods", so);
	}

	public int getGoodsRelatedInGoodsCount(GoodsRelatedSO so) {
		//Object count = Optional.ofNullable(selectOne(BASE_DAO_PACKAGE + "getGoodsRelatedInGoodsCount", so)).orElseGet(()->0);
		//return (int)count;
		return selectOne(BASE_DAO_PACKAGE + "getGoodsRelatedInGoodsCount", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsDao.java
	 * - 작성일	: 2021. 2. 26.
	 * - 작성자 	: valfac
	 * - 설명 		: TV 연관상품 갯수
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	public int getGoodsRelatedWithTvCount(GoodsRelatedSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getGoodsRelatedWithTvCount", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsDao.java
	 * - 작성일	: 2021. 2. 26.
	 * - 작성자 	: valfac
	 * - 설명 		: 펫로그 연관상품 목록 조회
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	public int getGoodsRelatedWithPetLogCount(GoodsRelatedSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getGoodsRelatedWithPetLogCount", so);
	}

	public GoodsImgVO getGoodsRelatedWithTvThumb(GoodsRelatedSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getGoodsRelatedWithTvThumb", so);
	}

	public GoodsImgVO getGoodsRelatedWithPetLogThumb(GoodsRelatedSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getGoodsRelatedWithPetLogThumb", so);
	}

	public GoodsImgVO getGoodsRelatedWithPetLogThumbInGoods(GoodsRelatedSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getGoodsRelatedWithPetLogThumbInGoods", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명	: GoodsDao.java
	 * - 작성일	: 2021. 3. 4.
	 * - 작성자 	: valfac
	 * - 설명 	: 상품 팝업 카테고리 선택
	 * </pre>
	 *
	 * @param dispClsfNo
	 * @return hashmap
	 */
	public HashMap selectGoodsDisplayCategory(long dispClsfNo) {
		return selectOne(BASE_DAO_PACKAGE + "selectGoodsDisplayCategory", dispClsfNo);
	}

	public List<GoodsBaseVO> getSgrGoodsList(GoodsBaseSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectSgrGoodsList", so);
	}

	public Integer selectGoodsCisNo(String goodsId) {
		return selectOne(BASE_DAO_PACKAGE + "selectGoodsCisNo", goodsId);
	}
}
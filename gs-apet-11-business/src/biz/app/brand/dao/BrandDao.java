package biz.app.brand.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.brand.model.BrandBasePO;
import biz.app.brand.model.BrandBaseSO;
import biz.app.brand.model.BrandBaseVO;
import biz.app.brand.model.BrandCategoryVO;
import biz.app.brand.model.BrandGoodsPO;
import biz.app.brand.model.BrandGoodsSO;
import biz.app.brand.model.BrandGoodsVO;
import biz.app.brand.model.BrandInitialVO;
import biz.app.brand.model.BrandPO;
import biz.app.brand.model.BrandSO;
import biz.app.brand.model.BrandTop10VO;
import biz.app.brand.model.BrandVO;
import biz.app.brand.model.CompanyBrandPO;
import biz.app.brand.model.DisplayBrandTreeVO;
import biz.app.display.model.DisplayBannerVO;
import biz.app.display.model.DisplayBrandPO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsListVO;
import biz.app.st.model.StStdInfoPO;
import biz.app.system.model.CodeDetailVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.brand.dao
* - 파일명		: BrandDao.java
* - 작성일		: 2016. 4. 14.
* - 작성자		: snw
* - 설명		: 브랜드 DAO
* </pre>
*/
@Repository
public class BrandDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "brand.";

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Common area
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2016. 4. 18.
	* - 작성자		: snw
	* - 설명		: 브랜드 단건 조회
	* </pre>
	* @param so
	* @return
	*/
	public BrandBaseVO getBrand(BrandBaseSO so){
		return selectOne(BASE_DAO_PACKAGE + "getBrandBase", so);
	}

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin area
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertBrandBase (BrandBasePO po ) {
		return insert("brand.insertBrandBase", po );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 사이트와 브랜드 매핑 정보 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertStBrandMap (StStdInfoPO po ) {
		return insert("brand.insertStBrandMap", po );
	}
	

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 업체 브랜드 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertCompanyBrand (CompanyBrandPO po ) {
		return insert("brand.insertCompanyBrand", po );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 사이트와 브랜드 매핑 삭제
	* </pre>
	* @param bndNo
	* @return
	*/
	public int deleteStStdBrand (Long bndNo ) {
		return delete("brand.deleteStStdBrand", bndNo );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 업체 브랜드 삭제
	* </pre>
	* @param bndNo
	* @return
	*/
	public int deleteCompanyBrand (Long bndNo ) {
		return delete("brand.deleteCompanyBrand", bndNo );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 조회 [BO]
	* </pre>
	* @param bndNo
	* @return
	*/
	public BrandBaseVO getBrandBase (Long bndNo ) {
		return (BrandBaseVO)selectOne("brand.getBrandBase", bndNo );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 업체 브랜드 조회
	* </pre>
	* @param bndNo
	* @return
	
	public CompanyBrandVO getCompanyBrand (Long bndNo ) {
		return (CompanyBrandVO)selectOne("brand.getCompanyBrand", bndNo );
	}
	*/

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 리스트 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<BrandBaseVO> pageBrandBase (BrandBaseSO so ) {
		return selectListPage("brand.pageBrandBase", so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2016. 5. 4.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 삭제
	* </pre>
	* @param bndNo
	* @return
	*/
	public int deleteBrandBase (Long bndNo ) {
		return delete("brand.deleteBrandBase", bndNo );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2016. 5. 4.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateBrandBase (BrandBasePO po ) {
		return update("brand.updateBrandBase", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2016. 5. 4.
	* - 작성자		: valueFactory
	* - 설명			: 사이트와 브랜드 매핑 정보 삭제
	* </pre>
	* @param po
	* @return
	*/
	public int deleteStBrandMap(BrandBasePO po) {
		return delete("brand.deleteStStdBrand", po);
	}


	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front area
	//-------------------------------------------------------------------------------------------------------------------------//


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: Administrator
	* - 설명		:
	* </pre>
	* @return
	*/
	public List<DisplayCategoryVO> listBrandCate(){
		return selectList(BASE_DAO_PACKAGE + "listBrandCate");
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: Administrator
	* - 설명		:
	* </pre>
	* @param so
	* @return
	*/
	public List<BrandCategoryVO> listLowestCate(BrandSO so){
		return selectList(BASE_DAO_PACKAGE + "listLowestCate", so);
	}
	
	public List<BrandVO> listSeries(BrandSO so){
		return selectList(BASE_DAO_PACKAGE + "listSeries", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2017. 2. 7.
	* - 작성자		: hg.jeong
	* - 설명		: 메인 BRAND 초성 검색
	* </pre>
	* @param String
	* @return
	*/
	public List<BrandVO> listInitCharBrand(BrandPO po){
		return selectList(BASE_DAO_PACKAGE + "listInitCharBrand", po);
	}

	/**
	 * 브랜드
	 * 카테고리 트리 
	 */
	public List<DisplayBrandTreeVO> listBrandDisplayTree(BrandSO so) {
		return selectList(BASE_DAO_PACKAGE + "listBrandDisplayTree", so);
	}
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.brand.dao
	* - 파일명      : BrandDao.java
	* - 작성일      : 2017. 2. 16.
	* - 작성자      : valuefctory 권성중
	* - 설명        :브랜드 전시분류 리스트  
	* </pre>
	 */
	public List<DisplayBrandTreeVO> listBrandShowDispClsf (Long brandNo ) {
		return selectList(BASE_DAO_PACKAGE + "listBrandShowDispClsf", brandNo );
	}
	/**
	 * 브랜드
	 * 카테고리 트리 등록 
	 */
	public int insertDisplayBrand(DisplayBrandPO po) {
		return insert(BASE_DAO_PACKAGE+ "insertDisplayBrand", po);
	}
	/**
	 * 브랜드
	 * 카테고리 트리 삭제 
	 */
	public int deleteDisplayBrand(DisplayBrandPO po) {
		return delete(BASE_DAO_PACKAGE+ "deleteDisplayBrand", po);
	}
 
	/**
	 * 브랜드 상품 리스트
	 */
	public List<BrandGoodsVO> listBrandGoods(BrandGoodsSO so) {
		return selectList(BASE_DAO_PACKAGE + "listBrandGoods", so);
	}
	/**
	 * 브랜드 상품 리스트 등록
	 */
	public int insertBrandGoods(BrandGoodsPO po) {
		return insert(BASE_DAO_PACKAGE+ "insertBrandGoods", po);
	}
	/**
	 * 브랜드 상품 리스트 삭제
	 */
	public int deleteBrandGoods(BrandGoodsPO po) {
		return delete(BASE_DAO_PACKAGE+ "deleteBrandGoods", po);
	}
	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2017. 02. 08.
	* - 작성자		: wyjeong
	* - 설명		: 브랜드 정보 조회
	* </pre>
	* @param so
	* @return
	*/
	public BrandBaseVO getBrandDetail(BrandBaseSO so){
		return selectOne(BASE_DAO_PACKAGE + "getBrandDetail", so);
	}
	
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2017. 02. 22.
	* - 작성자		: wyjeong
	* - 설명		: 브랜드 NEW 상품 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsListVO> listBrandNewGoods(GoodsBaseSO so){
		return selectList(BASE_DAO_PACKAGE + "listBrandNewGoods", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2017. 02. 22.
	* - 작성자		: wyjeong
	* - 설명		: 브랜드 BEST 상품 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsListVO> listBrandBestGoods(GoodsBaseSO so){
		return selectList(BASE_DAO_PACKAGE + "listBrandBestGoods", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2017. 02. 22.
	* - 작성자		: wyjeong
	* - 설명		: 연관 브랜드 상품 조회(상품상세)
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsBaseVO> listBrandRelGoods(GoodsBaseSO so){
		return selectList(BASE_DAO_PACKAGE + "listBrandRelGoods", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2017. 02. 22.
	* - 작성자		: wyjeong
	* - 설명		: 브랜드 기획전 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<DisplayBannerVO> listBrandEvent(BrandBaseSO so){
		return selectList(BASE_DAO_PACKAGE + "listBrandEvent", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2017. 03. 06.
	* - 작성자		: Edgar.O
	* - 설명		: Top 10 브랜드 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<BrandTop10VO> listIndexTopBrand(Long stId){
		return selectList(BASE_DAO_PACKAGE + "listIndexTopBrand", stId);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2017. 2. 7.
	* - 작성자		: hg.jeong
	* - 설명		: 메인 BRAND 초성 검색
	* </pre>
	* @param String
	* @return
	*/
	public List<BrandVO> listBrandChar(BrandPO po){
		return selectList(BASE_DAO_PACKAGE + "listBrandChar", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2017. 3. 24.
	* - 작성자		: hg.jeong
	* - 설명		: 메인 BRAND 초성 목록
	* </pre>
	* @param String
	* @return
	*/
	public List<CodeDetailVO> listBrandInitChar(){
		return selectList(BASE_DAO_PACKAGE + "listBrandInitChar");
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandDao.java
	* - 작성일		: 2017. 3. 24.
	* - 작성자		: hg.jeong
	* - 설명		: 브랜드 목록
	* </pre>
	* @param String
	* @return
	*/
	public List<BrandBaseSO> listBrand(BrandBaseSO so){
		return selectList(BASE_DAO_PACKAGE + "listBrand", so);
	}	
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandDao.java
	 * - 작성일		: 2017. 05. 31.
	 * - 작성자		: wyjeong
	 * - 설명		: 전시분류별 브랜드 리스트 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCategoryVO> listBrandByDisplayCategory(BrandSO so) {
		return selectList(BASE_DAO_PACKAGE + "listBrandByDisplayCategory", so);
	}

	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandDao.java
	 * - 작성일		: 2017. 06. 01.
	 * - 작성자		: wyjeong
	 * - 설명		: 전시분류별 초성 브랜드 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BrandInitialVO> listBrandByInitChar(BrandSO so) {
		return selectList(BASE_DAO_PACKAGE + "listBrandByInitChar", so);
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandDao.java
	 * - 작성일		: 2017. 06. 08.
	 * - 작성자		: wyjeong
	 * - 설명		: StyleDCG 브랜드 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BrandBaseVO> listBrandByStyle(BrandSO so) {
		return selectList(BASE_DAO_PACKAGE + "listBrandByStyle", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandDao.java
	 * - 작성일		: 2021. 07. 15
	 * - 작성자		: kwj
	 * - 설명		: 동일한 이름의 브랜드명 존재 여부 확인
	 * </pre>
	 * @param so
	 * @return
	 */
	public int getSameBrandNameCount(BrandSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getSameBrandNameCount", so);
	}
}

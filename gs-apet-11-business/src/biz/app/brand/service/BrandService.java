package biz.app.brand.service;

import java.util.List;

import biz.app.brand.model.BrandBasePO;
import biz.app.brand.model.BrandBaseSO;
import biz.app.brand.model.BrandBaseVO;
import biz.app.brand.model.BrandCategoryVO;
import biz.app.brand.model.BrandGoodsSO;
import biz.app.brand.model.BrandGoodsVO;
import biz.app.brand.model.BrandInitialVO;
import biz.app.brand.model.BrandPO;
import biz.app.brand.model.BrandSO;
import biz.app.brand.model.BrandTop10VO;
import biz.app.brand.model.BrandVO;
import biz.app.brand.model.DisplayBrandTreeVO;
import biz.app.display.model.DisplayBannerVO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsListVO;
import biz.app.system.model.CodeDetailVO;
 

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.brand.service
* - 파일명		: BrandService.java
* - 작성일		: 2016. 4. 15.
* - 작성자		: snw
* - 설명		: 브랜드 서비스 Interface
* </pre>
*/
public interface BrandService {

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Common area
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandService.java
	* - 작성일		: 2016. 4. 18.
	* - 작성자		: snw
	* - 설명		: 브랜드 단건 조회
	* </pre>
	* @param bndNo
	* @return
	* @throws Exception
	*/
	BrandBaseVO getBrand(Long bndNo);

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin area
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	 * 
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandService.java
	* - 작성일		: 2017. 1. 31.
	* - 작성자		: hjko
	* - 설명		:
	* </pre>
	* @param brandPO
	* @param companyPO
	* @return
	 */
	public Long insertBrand (BrandBasePO brandPO);


	//public Long insertBrandOld (BrandBasePO brandPO, CompanyBrandPO companyPO ) ;
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandService.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 조회 [BO]
	* </pre>
	* @param bndNo
	* @return
	*/
	public BrandBaseVO getBrandBase (Long bndNo );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandService.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 업체 브랜드 조회
	* </pre>
	* @param bndNo
	* @return
	*/
	//public CompanyBrandVO getCompanyBrand (Long bndNo );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandService.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 리스트 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<BrandBaseVO> pageBrandBase (BrandBaseSO so );


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandService.java
	* - 작성일		: 2016. 5. 4.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 삭제
	* </pre>
	* @param bndNos
	* @return
	*/
	public int deleteBrand (Long[] bndNos);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandService.java
	* - 작성일		: 2016. 5. 4.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 수정
	* </pre>
	* @param brandPO
	* @param companyPO
	* @return
	*/
	//public Long updateBrand (BrandBasePO brandPO, CompanyBrandPO companyPO, String orgBndItrdcImgPath );

	public Long updateBrand (BrandBasePO brandPO) ;
		
	
	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front area
	//-------------------------------------------------------------------------------------------------------------------------//


	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandService.java
	* - 작성일		: 2016. 5. 17.
	* - 작성자		: Administrator
	* - 설명		:
	* </pre>
	* @return
	*/
	List<DisplayCategoryVO> listBrandCate();
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandService.java
	* - 작성일		: 2016. 5. 26.
	* - 작성자		: Administrator
	* - 설명		:
	* </pre>
	* @param so
	* @return
	*/
	public List<BrandCategoryVO> listLowestCate(BrandSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandService.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: Administrator
	* - 설명		:
	* </pre>
	* @return
	*/
	public List<BrandVO> listSeries(BrandSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandService.java
	* - 작성일		: 2017. 2. 7.
	* - 작성자		: hg.jeong
	* - 설명		: 메인 BRAND 초성 검색
	* </pre>
	* @return
	*/	
	public List<BrandVO> listInitCharBrand(BrandPO po);
	
	/**
	 * 브랜드
	 * 카테고리 트리 
	 */
	public List<DisplayBrandTreeVO> listBrandDisplayTree(BrandSO so);
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.brand.service
	* - 파일명      : BrandService.java
	* - 작성일      : 2017. 2. 16.
	* - 작성자      : valuefctory 권성중
	* - 설명      : 브랜드 전시분류 리스트
	* </pre>
	 */
	public List<DisplayBrandTreeVO> listBrandShowDispClsf (Long brandNo );
	
	/**
	 * 브랜드 상품 리스트
	 */
	public List<BrandGoodsVO> listBrandGoods(BrandGoodsSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandService.java
	* - 작성일		: 2017. 02. 08.
	* - 작성자		: wyjeong
	* - 설명		: 브랜드 정보 조회
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	BrandBaseVO getBrandDetail(BrandBaseSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandService.java
	* - 작성일		: 2017. 02. 22.
	* - 작성자		: wyjeong
	* - 설명		: 브랜드 NEW 상품 조회
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	public List<GoodsListVO> listBrandNewGoods(GoodsBaseSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandService.java
	* - 작성일		: 2017. 02. 22.
	* - 작성자		: wyjeong
	* - 설명		: 브랜드 BEST 상품 조회
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	public List<GoodsListVO> listBrandBestGoods(GoodsBaseSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandService.java
	* - 작성일		: 2017. 02. 22.
	* - 작성자		: wyjeong
	* - 설명		: 연관 브랜드 상품 조회(상품상세)
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	public List<GoodsBaseVO> listBrandRelGoods(GoodsBaseSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandService.java
	* - 작성일		: 2017. 02. 22.
	* - 작성자		: wyjeong
	* - 설명		: 브랜드 BEST 상품 조회
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	public List<DisplayBannerVO> listBrandEvent(BrandBaseSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandService.java
	* - 작성일		: 2017. 03. 06.
	* - 작성자		: Edgar.O
	* - 설명		: Top 10 브랜드  조회
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	public List<BrandTop10VO> listIndexTopBrand(Long stId);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandService.java
	* - 작성일		: 2017. 3. 20.
	* - 작성자		: hg.jeong
	* - 설명		: 검색 BRAND 초성 목록
	* </pre>
	* @return
	*/	
	public List<BrandVO> listBrandChar(BrandPO po);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandService.java
	* - 작성일		: 2017. 3. 24.
	* - 작성자		: hg.jeong
	* - 설명		: BRAND 초성 목록
	* </pre>
	* @return
	*/	
	public List<CodeDetailVO> listBrandInitChar();
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BrandService.java
	* - 작성일		: 2017. 3. 24.
	* - 작성자		: hg.jeong
	* - 설명		: 브랜드 목록
	* </pre>
	* @return
	*/		
	public List<BrandBaseSO> listBrand(BrandBaseSO so);
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandService.java
	 * - 작성일		: 2017. 05. 30.
	 * - 작성자		: wyjeong
	 * - 설명		: 전시분류별 브랜드 리스트 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DisplayCategoryVO> listBrandByDisplayCategory(BrandSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandService.java
	 * - 작성일		: 2017. 06. 01.
	 * - 작성자		: wyjeong
	 * - 설명		: 전시분류별 초성 브랜드 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BrandInitialVO> listBrandByInitChar(BrandSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandService.java
	 * - 작성일		: 2017. 06. 08.
	 * - 작성자		: wyjeong
	 * - 설명		: StyleDCG 브랜드 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BrandBaseVO> listBrandByStyle(BrandSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandService.java
	 * - 작성일		: 2021. 07. 15.
	 * - 작성자		: kwj
	 * - 설명		: 동일한 브랜드명 존재 여부 확인
	 * </pre>
	 * @param so
	 * @return
	 */
	public int getSameBrandNameCount(BrandSO so) ;
}
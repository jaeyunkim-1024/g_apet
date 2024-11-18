package biz.common.service;

import biz.app.brand.model.BrandBaseSO;
import biz.app.brand.model.BrandBaseVO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.display.model.DisplayCornerSO;
import biz.app.display.model.DisplayCornerTotalVO;
import biz.app.goods.model.GoodsDispSO;
import biz.app.system.model.CodeDetailVO;

import java.util.List;

/**
 * Web service
 * @author	snw
 * @since	    2013.09.02
 */

public interface CacheService {

	/***************************************
	 * 공통 코드 캐쉬
	 ***************************************/
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CacheService.java
	* - 작성일		: 2017. 1. 25.
	* - 작성자		: snw
	* - 설명		: 공통 코드 캐쉬 설정
	* </pre>
	*/
	public void listCodeCache();

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CacheService.java
	* - 작성일		: 2017. 1. 25.
	* - 작성자		: snw
	* - 설명		: 공통 코드 캐쉬 재설정
	* </pre>
	*/
	public void listCodeCacheRefresh();

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CacheService.java
	* - 작성일		: 2017. 1. 25.
	* - 작성자		: snw
	* - 설명		: 공통코드 목록 조회 (캐쉬)
	* </pre>
	* @param grpCd
	* @param usrDfn1Val
	* @param usrDfn2Val
	* @param usrDfn3Val
	* @param usrDfn4Val
	* @param usrDfn5Val
	* @return
	*/
	public List<CodeDetailVO> listCodeCache(String grpCd, String usrDfn1Val, String usrDfn2Val, String usrDfn3Val, String usrDfn4Val, String usrDfn5Val);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CacheService.java
	* - 작성일		: 2017. 1. 25.
	* - 작성자		: snw
	* - 설명		: 공통코드 목록 조회 (캐쉬)
	* </pre>
	* @param grpCd
	* @param useYn
	* @param usrDfn1Val
	* @param usrDfn2Val
	* @param usrDfn3Val
	* @param usrDfn4Val
	* @param usrDfn5Val
	* @return
	*/
	public List<CodeDetailVO> listCodeCache(String grpCd, boolean useYn, String usrDfn1Val, String usrDfn2Val, String usrDfn3Val, String usrDfn4Val, String usrDfn5Val);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CacheService.java
	* - 작성일		: 2017. 3. 15.
	* - 작성자		: snw
	* - 설명		: 공통코드 단건 조회(캐쉬)
	* </pre>
	* @param grpCd
	* @param dtlCd
	* @return
	*/
	public CodeDetailVO getCodeCache(String grpCd, String dtlCd);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CacheService.java
	* - 작성일		: 2017. 1. 25.
	* - 작성자		: snw
	* - 설명		: 공통코드 상세명 조회 (캐쉬)
	* </pre>
	* @param grpCd
	* @param dtlCd
	* @return
	*/
	public String getCodeName(String grpCd, String dtlCd);


	/***************************************
	 * 전시 카테고리 캐쉬
	 ***************************************/

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CacheService.java
	* - 작성일		: 2017. 1. 25.
	* - 작성자		: snw
	* - 설명		: 전시 카테고리 목록 캐쉬 설정
	* </pre>
	* @param stId
	*/
	public void listDisplayCategoryCache(Long stId);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CacheService.java
	* - 작성일		: 2016. 4. 29.
	* - 작성자		: snw
	* - 설명		: 전시 카테고리 목록 캐쉬 재설정
	* </pre>
	*/
	public void listDisplayCategoryCacheRefresh(Long stId);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CacheService.java
	* - 작성일		: 2017. 1. 25.
	* - 작성자		: snw
	* - 설명		: 전시 카테고리 목록 조회(캐쉬내용)
	* </pre>
	* @return
	*/
	public List<DisplayCategoryVO> listDisplayCategory();

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CacheService.java
	 * - 작성일		: 2017. 1. 25.
	 * - 작성자		: kjy
	 * - 설명		: 공통 코드 초기화
	 * </pre>
	 * @return
	 */
	public void initInterestTag();

	public List selectGoodsBestManual(GoodsDispSO so);

	public List<DisplayCornerTotalVO> listDisplayClsfCornerDate(DisplayCornerSO so);

	public List selectGoodsDc(GoodsDispSO so);

	public List selectGoodsPackage(GoodsDispSO so);

	public List selectGoodsMd(GoodsDispSO so);

	public List<BrandBaseVO> filterGoodsBrand(BrandBaseSO so);

	public List selectGoods(GoodsDispSO so);
	
	public void initApetCache ();
	
	
}
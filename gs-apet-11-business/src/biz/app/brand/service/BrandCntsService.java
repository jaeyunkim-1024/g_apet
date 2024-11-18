package biz.app.brand.service;

import java.util.List;

import biz.app.brand.model.BrandCntsItemPO;
import biz.app.brand.model.BrandCntsItemSO;
import biz.app.brand.model.BrandCntsItemVO;
import biz.app.brand.model.BrandCntsPO;
import biz.app.brand.model.BrandCntsSO;
import biz.app.brand.model.BrandCntsVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.brand.service
* - 파일명		: BrandCntsService.java
* - 작성일		: 2017. 2. 7.
* - 작성자		: hongjun
 * - 설명		: 브랜드 콘텐츠 서비스 Interface
* </pre>
*/
public interface BrandCntsService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsService.java
	 * - 작성일		: 2017. 2. 7.
	 * - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 페이징
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BrandCntsVO> pageBrandCnts(BrandCntsSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsService.java
	 * - 작성일		: 2017. 2. 7.
	 * - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 등록
	 * </pre>
	 * @param po
	 */
	public void insertBrandCnts(BrandCntsPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsService.java
	 * - 작성일		: 2017. 2. 7.
	 * - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 수정
	 * </pre>
	 * @param po
	 */
	public void updateBrandCnts(BrandCntsPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsService.java
	 * - 작성일		: 2017. 2. 7.
	 * - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 삭제
	 * </pre>
	 * @param po
	 */
	public void deleteBrandCnts(BrandCntsPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsService.java
	 * - 작성일		: 2017. 2. 7.
	 * - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 아이템 페이징
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BrandCntsItemVO> pageBrandCntsItem(BrandCntsItemSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsService.java
	 * - 작성일		: 2017. 2. 7.
	 * - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 아이템 등록/수정
	 * </pre>
	 * @param po
	 */
	public void brandCntsItemSave(BrandCntsItemPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsService.java
	 * - 작성일		: 2017. 2. 7.
	 * - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 아이템 삭제
	 * </pre>
	 * @param itemNos
	* @return
	 */
	public int deleteBrandCntsItem(Long[] itemNos);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsService.java
	 * - 작성일		: 2017. 3. 8.
	 * - 작성자		: wyjeong
	 * - 설명		: 브랜드 미니샵 노출 top 컨텐츠 조회
	 * </pre>
	 * @param bndNo
	 */
	public BrandCntsVO getTopBrandCnt(Long bndNo);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsService.java
	 * - 작성일		: 2017. 3. 8.
	 * - 작성자		: wyjeong
	 * - 설명		: 브랜드 미니샵 노출 컨텐츠 리스트
	 * </pre>
	 * @param po
	 */
	public List<BrandCntsVO> listBrandCnts(BrandCntsSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsService.java
	 * - 작성일		: 2017. 3. 8.
	 * - 작성자		: wyjeong
	 * - 설명		: 브랜드 컨텐츠 조회
	 * </pre>
	 * @param bndCntsNo
	 */
	public BrandCntsVO getBrandCnts(Long bndCntsNo);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsService.java
	 * - 작성일		: 2017. 3. 8.
	 * - 작성자		: wyjeong
	 * - 설명		: 브랜드 미니샵 노출 컨텐츠 아이템 리스트
	 * </pre>
	 * @param po
	 */
	public List<BrandCntsItemVO> listBrandCntsItem(BrandCntsItemSO so);
}
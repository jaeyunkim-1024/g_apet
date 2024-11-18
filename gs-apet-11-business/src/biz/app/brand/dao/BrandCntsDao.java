package biz.app.brand.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.brand.model.BrandCntsItemPO;
import biz.app.brand.model.BrandCntsItemSO;
import biz.app.brand.model.BrandCntsItemVO;
import biz.app.brand.model.BrandCntsPO;
import biz.app.brand.model.BrandCntsSO;
import biz.app.brand.model.BrandCntsVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.promotion.dao
* - 파일명		: BrandCntsDao.java
* - 작성일		: 2017. 2. 7.
* - 작성자		: hongjun
* - 설명		: 브랜드 콘텐츠 DAO
* </pre>
*/
@Repository
public class BrandCntsDao extends MainAbstractDao {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsDao.java
	 * - 작성일		: 2017. 2. 7.
	 * - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 페이징
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<BrandCntsVO> pageBrandCnts(BrandCntsSO so) {
		return selectListPage("brandCnts.pageBrandCnts", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsDao.java
	 * - 작성일		: 2017. 2. 7.
	 * - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 등록
	 * </pre>
	 * @param po
	 */
	public int insertBrandCnts(BrandCntsPO po) {
		return insert("brandCnts.insertBrandCnts", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsDao.java
	 * - 작성일		: 2017. 2. 7.
	 * - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠  수정
	 * </pre>
	 * @param po
	 */
	public int updateBrandCnts(BrandCntsPO po) {
		return update("brandCnts.updateBrandCnts", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsDao.java
	 * - 작성일		: 2017. 2. 7.
	 * - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 아이템 삭제
	 * </pre>
	 * @param po
	 * @return
	 */	
	public int deleteBrandCntsItem(BrandCntsPO po) {
		return delete("brandCnts.deleteBrandCntsItem", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsDao.java
	 * - 작성일		: 2017. 2. 7.
	 * - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 삭제
	 * </pre>
	 * @param po
	 * @return
	 */	
	public int deleteBrandCnts(BrandCntsPO po) {
		return delete("brandCnts.deleteBrandCnts", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsDao.java
	 * - 작성일		: 2017. 2. 7.
	 * - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 아이템 페이징
	 * </pre>
	 * @param po
	 * @return
	 */	
	public List<BrandCntsItemVO> pageBrandCntsItem(BrandCntsItemSO so) {
		return selectListPage("brandCnts.pageBrandCntsItem", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsDao.java
	 * - 작성일		: 2017. 2. 7.
	 * - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 아이템 리스트
	 * </pre>
	 * @param po
	 * @return
	 */	
//	public List<BrandCntsItemVO> listBrandCntsItem(BrandCntsItemSO so) {
//		return selectListPage("brandCnts.pageBrandCntsItem", so);
//	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsDao.java
	 * - 작성일		: 2017. 2. 7.
	 * - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 아이템 등록
	 * </pre>
	 * @param po
	 */
	public int insertBrandCntsItem(BrandCntsItemPO po) {
		return insert("brandCnts.insertBrandCntsItem", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsDao.java
	 * - 작성일		: 2017. 2. 7.
	 * - 작성자		: hongjun
	 * - 설명		: 브랜드 콘텐츠 아이템 수정
	 * </pre>
	 * @param po
	 */
	public int updateBrandCntsItem(BrandCntsItemPO po) {
		return update("brandCnts.updateBrandCntsItem", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsDao.java
	 * - 작성일		: 2017. 3. 8.
	 * - 작성자		: wyjeong
	 * - 설명		: 브랜드 미니샵 노출 top 컨텐츠
	 * </pre>
	 * @param bndNo
	 */
	public BrandCntsVO getTopBrandCnt(Long bndNo) {
		return (BrandCntsVO)selectOne("brandCnts.getTopBrandCnt", bndNo);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsDao.java
	 * - 작성일		: 2017. 3. 8.
	 * - 작성자		: wyjeong
	 * - 설명		: 브랜드 미니샵 노출 컨텐츠 리스트
	 * </pre>
	 * @param so
	 */
	public List<BrandCntsVO> listBrandCnts(BrandCntsSO so) {
		return selectList("brandCnts.listBrandCnts", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsDao.java
	 * - 작성일		: 2017. 3. 8.
	 * - 작성자		: wyjeong
	 * - 설명		: 브랜드 컨텐츠 조회
	 * </pre>
	 * @param bndCntsNo
	 */
	public BrandCntsVO getBrandCnts(Long bndCntsNo) {
		return (BrandCntsVO)selectOne("brandCnts.getBrandCnts", bndCntsNo);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BrandCntsDao.java
	 * - 작성일		: 2017. 3. 8.
	 * - 작성자		: wyjeong
	 * - 설명		: 브랜드 미니샵 노출 컨텐츠 아이템 리스트
	 * </pre>
	 * @param so
	 */
	public List<BrandCntsItemVO> listBrandCntsItem(BrandCntsItemSO so) {
		return selectList("brandCnts.listBrandCntsItem", so);
	}
}

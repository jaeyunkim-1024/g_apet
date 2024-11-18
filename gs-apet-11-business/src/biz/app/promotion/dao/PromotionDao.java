package biz.app.promotion.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.brand.model.BrandBaseVO;
import biz.app.company.model.CompanyBaseVO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.promotion.model.DisplayPromotionTreeVO;
import biz.app.promotion.model.ExhibitionVO;
import biz.app.promotion.model.PromotionBasePO;
import biz.app.promotion.model.PromotionBaseVO;
import biz.app.promotion.model.PromotionFreebiePO;
import biz.app.promotion.model.PromotionFreebieVO;
import biz.app.promotion.model.PromotionSO;
import biz.app.promotion.model.PromotionTargetPO;
import biz.app.promotion.model.PromotionTargetVO;
import biz.app.st.model.StStdInfoPO;
import biz.app.st.model.StStdInfoVO;
import framework.common.dao.MainAbstractDao;

@Repository
public class PromotionDao extends MainAbstractDao {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PromotionDao.java
	 * - 작성일		: 2016. 3. 18.
	 * - 작성자		: valueFactory
	 * - 설명		: 프로모션 리스트 페이지
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<PromotionBaseVO> pagePromotion(PromotionSO so) {
		return selectListPage("promotion.pagePromotion", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PromotionDao.java
	 * - 작성일		: 2016. 5. 9.
	 * - 작성자		: valueFactory
	 * - 설명		: 프로모션 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public PromotionBaseVO getPromotion(PromotionSO so) {
		return (PromotionBaseVO) selectOne("promotion.getPromotion", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PromotionDao.java
	 * - 작성일		: 2016. 5. 9.
	 * - 작성자		: valueFactory
	 * - 설명		: 프로모션 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertPromotionBase(PromotionBasePO po) {
		return insert("promotion.insertPromotionBase", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PromotionDao.java
	 * - 작성일		: 2016. 5. 9.
	 * - 작성자		: valueFactory
	 * - 설명		: 프로모션 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updatePromotionBase(PromotionBasePO po) {
		return update("promotion.updatePromotionBase", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PromotionDao.java
	 * - 작성일		: 2017. 1. 09.
	 * - 작성자		: 이성용
	 * - 설명		: 사이트와 이벤트 매핑 정보 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertStGiftMap(StStdInfoPO po) {
		
		return insert("promotion.insertStStdGiftMap", po);
	}	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PromotionDao.java
	 * - 작성일		: 2017. 1. 09.
	 * - 작성자		: 이성용
	 * - 설명		: 사이트와 프로모션(사은품) 매핑 정보 삭제
	 * </pre>
	 * @param po
	 * @return
	 */	
	public int deleteStGiftMap(PromotionBasePO po) {
		
		return delete("promotion.deleteStStdGiftMap", po);
	}	

	public List<PromotionTargetVO> listPromotionTarget(PromotionSO so) {
		return selectList("promotion.listPromotionTarget", so);
	}

	public List<PromotionFreebieVO> listPromotionFreebie(PromotionSO so) {
		return selectList("promotion.listPromotionFreebie", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PromotionDao.java
	 * - 작성일		: 2016. 5. 9.
	 * - 작성자		: valueFactory
	 * - 설명		: 프로모션 타겟 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertPromotionTarget(PromotionTargetPO po) {
		return insert("promotion.insertPromotionTarget", po);
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PromotionDao.java
	 * - 작성일		: 2016. 5. 9.
	 * - 작성자		: valueFactory
	 * - 설명		: 프로모션 타겟 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deletePromotionTarget(PromotionTargetPO po) {
		return delete("promotion.deletePromotionTarget", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PromotionDao.java
	 * - 작성일		: 2016. 5. 9.
	 * - 작성자		: valueFactory
	 * - 설명		: 중복 체크
	 * </pre>
	 * @param po
	 * @return
	 */
	public int selectPromotionTargetCheck(PromotionTargetPO po) {
		return (Integer)selectOne("promotion.selectPromotionTargetCheck", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PromotionDao.java
	 * - 작성일		: 2016. 5. 9.
	 * - 작성자		: valueFactory
	 * - 설명		: 프로모션 사은품 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertPromotionFreebie(PromotionFreebiePO po) {
		return insert("promotion.insertPromotionFreebie", po);
	}

	public int deletePromotionFreebie(PromotionFreebiePO po) {
		return update("promotion.deletePromotionFreebie", po);
	}

	public int selectPromotionFreebieCheck(PromotionFreebiePO po) {
		return (Integer)selectOne("promotion.selectPromotionFreebieCheck", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: PromotionDao.java
	* - 작성일		: 2016. 5. 27.
	* - 작성자		: shkim
	* - 설명		: 상품 사은품 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public List<GoodsBaseVO> listGoodsPromotionFreebie(String goodsId) {
		return selectList("promotion.listGoodsPromotionFreebie", goodsId);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PromotionDao.java
	 * - 작성일		: 2016. 9. 05.
	 * - 작성자		: hjko
	 * - 설명		: 프로모션과 매핑된 사이트 정보 전체를 조회한다.
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<StStdInfoVO> listStStdInfoByPromotion(PromotionSO so) {
		
		return selectList("inline.getStStdInfoPrmtById", so);
	}
	
	
	public List<PromotionBaseVO> pagePromotionBase(PromotionSO so) {
		return selectListPage("promotion.pagePromotionBase", so);
	}

	public PromotionBaseVO getPromotionBase(PromotionSO so) {
		return (PromotionBaseVO) selectOne("promotion.getPromotion", so);
	}

 
	/**
	 * 가격할인 프로모션
	 * 상품 리스트
	 * @param so
	 * @return
	 */
	public List<PromotionTargetVO> listPromotionGoods(PromotionSO so) {
		return selectList("promotion.listPromotionTarget", so);
	}
	/**
	 * 가격할인 프로모션
	 * 제외 상품 리스트
	 * @param so
	 * @return
	 */
	public List<PromotionTargetVO> listPromotionGoodsEx(PromotionSO so) {
		return selectList("promotion.listPromotionExTarget", so);
	}
	/**
	 * 가격할인 프로모션
	 * 기획전 전시카테고리 트리 
	 * @param so
	 * @return
	 */
	public List<DisplayPromotionTreeVO> listPromotionDisplayTree(PromotionSO so) {
		return selectList("promotion.listPromotionDisplayTree", so);
	}
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.promotion.dao
	* - 파일명      : PromotionDao.java
	* - 작성일      : 2017. 2. 17.
	* - 작성자      : valuefctory 권성중
	* - 설명      :  가격할인  전시분류 리스트   
	* </pre>
	 */
	public List<DisplayPromotionTreeVO> listPromotionShowDispClsf (Long prmtNo ) {
		return selectList("promotion.listPromotionShowDispClsf", prmtNo );
	}
	
	/**
	 * 가격할인 프로모션
	 * 사이트와 쿠폰 매핑 정보 등록
	 * @param po
	 * @return
	 */
	public int insertStPromotionMap(StStdInfoPO po) {
		return insert("promotion.insertStStdPromotionMap", po);
	}
	/**
	 * 가격할인 프로모션
	 * 제외상품 등록
	 * @param po
	 * @return
	 */
	public int insertPromotionExTarget(PromotionTargetPO po) {
		return insert("promotion.insertPromotionExTarget", po);
	}
	/**
	 * 가격할인 프로모션
	 * 제외상품 삭제
	 * @param po
	 * @return
	 */
	public int deletePromotionExTarget(PromotionBasePO po) {
		return delete("promotion.deletePromotionExTarget", po);
	}
	/**
	 * 가격할인 프로모션 베이스 삭제 
	 * @param po
	 * @return
	 */
	public int deletePromotionBase(PromotionBasePO po) {
		return delete("promotion.deletePromotionBase", po);
	}
	
	public List<CompanyBaseVO> listPromotionTargetCompNo(PromotionSO so) {
		return selectList("promotion.listPromotionTargetCompNo", so);
	}
 
	public List<BrandBaseVO> listPromotionTargetBndNo(PromotionSO so) {
		return selectList("promotion.listPromotionTargetBndNo", so);
	}
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.promotion.dao
	* - 파일명      : PromotionDao.java
	* - 작성일      : 2017. 7. 7.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 기획전 
	* </pre>
	 */
	public List<ExhibitionVO> listPromotionTargetExhbtNo(PromotionSO so) {
		return selectList("promotion.listPromotionTargetExhbtNo", so);
	}
}

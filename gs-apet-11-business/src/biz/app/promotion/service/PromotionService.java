package biz.app.promotion.service;

import java.util.List;

import biz.app.brand.model.BrandBaseVO;
import biz.app.company.model.CompanyBaseVO;
import biz.app.promotion.model.DisplayPromotionTreeVO;
import biz.app.promotion.model.ExhibitionVO;
import biz.app.promotion.model.PromotionBasePO;
import biz.app.promotion.model.PromotionBaseVO;
import biz.app.promotion.model.PromotionFreebieVO;
import biz.app.promotion.model.PromotionSO;
import biz.app.promotion.model.PromotionTargetVO;

/**
 * get업무명		:	단권
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
 * - 패키지명	: biz.app.promotion.service
 * - 파일명		: PromotionService.java
 * - 작성일		: 2016. 3. 18.
 * - 작성자		: valueFactory
 * - 설명		: 프로모션 서비스
 * </pre>
 */
public interface PromotionService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PromotionService.java
	 * - 작성일		: 2016. 3. 18.
	 * - 작성자		: valueFactory
	 * - 설명		: 사은품 리스트 페이지
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<PromotionBaseVO> pagePromotionGift(PromotionSO so);

	
	
	
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PromotionService.java
	 * - 작성일		: 2016. 4. 25.
	 * - 작성자		: valueFactory
	 * - 설명		: 사은품 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public PromotionBaseVO getPromotionGift(PromotionSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PromotionService.java
	 * - 작성일		: 2016. 4. 25.
	 * - 작성자		: valueFactory
	 * - 설명		: 프로모션 등록
	 * </pre>
	 * @param po
	 */
	public void insertPromotionGift(PromotionBasePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PromotionService.java
	 * - 작성일		: 2016. 4. 25.
	 * - 작성자		: valueFactory
	 * - 설명		: 프로모션 수정
	 * </pre>
	 * @param po
	 */
	public void updatePromotionGift(PromotionBasePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PromotionService.java
	 * - 작성일		: 2016. 5. 9.
	 * - 작성자		: valueFactory
	 * - 설명		: 프로모션 대상 상품
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<PromotionTargetVO> listPromotionTarget(PromotionSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: PromotionService.java
	 * - 작성일		: 2016. 5. 9.
	 * - 작성자		: valueFactory
	 * - 설명		: 프로모션 사은품
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<PromotionFreebieVO> listPromotionFreebie(PromotionSO so);
	
	
	
	public List<PromotionBaseVO> pagePromotionBase(PromotionSO so);
	
	public PromotionBaseVO getPromotionBase(PromotionSO so);
	
	/**
	 * 가격할인 프로모션
	 * 상품 리스트
	 */
	public List<PromotionTargetVO> listPromotionGoods(PromotionSO so);
	/**
	 * 가격할인 프로모션
	 * 제외 상품 리스트
	 */
	public List<PromotionTargetVO> listPromotionGoodsEx(PromotionSO so);
	/**
	 * 가격할인 프로모션
	 * 기획전 전시카테고리 트리 
	 */
	public List<DisplayPromotionTreeVO> listPromotionDisplayTree(PromotionSO so);
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.promotion.service
	* - 파일명      : PromotionService.java
	* - 작성일      : 2017. 2. 17.
	* - 작성자      : valuefctory 권성중
	* - 설명      :  가격할인  전시분류 리스트   
	* </pre>
	 */ 
	public List<DisplayPromotionTreeVO> listPromotionShowDispClsf (Long prmtNo );
	/**
	 * 가격할인 프로모션 등록 
	 */
	public void insertPromotion(PromotionBasePO po);
	/**
	 * 가격할인 프로모션 수정 
	 */
	public void updatePromotion(PromotionBasePO po);
	/**
	 * 가격할인 프로모션 삭제 
	 */
	public void deletePromotion(PromotionBasePO po);

	
	public List<CompanyBaseVO> 	listPromotionTargetCompNo(PromotionSO so);
	
	public List<BrandBaseVO> 	listPromotionTargetBndNo(PromotionSO so);
	/**
	 * 
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.promotion.service
	* - 파일명      : PromotionService.java
	* - 작성일      : 2017. 7. 7.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 기획전 목록 
	* </pre>
	 */
	public List<ExhibitionVO> 	listPromotionTargetExhbtNo(PromotionSO so);

}
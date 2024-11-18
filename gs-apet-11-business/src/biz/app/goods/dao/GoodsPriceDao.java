package biz.app.goods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsPricePO;
import biz.app.goods.model.GoodsPriceSO;
import biz.app.goods.model.GoodsPriceVO;
import biz.app.promotion.model.CouponBaseVO;
import framework.common.dao.MainAbstractDao;

@Repository
public class GoodsPriceDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsPrice.";

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//



	//-------------------------------------------------------------------------------------------------------------------------//
	//- 어드민
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 4. 14.
	* - 작성자		: valueFactory
	* - 설명			: 상품 가격 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertGoodsPrice (GoodsPricePO po ) {
		return insert("goodsPrice.insertGoodsPrice", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 5. 2.
	* - 작성자		: valueFactory
	* - 설명			: 상품 현재 가격 정보 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public GoodsPriceVO getCurrentGoodsPrice (String goodsId ) {
		return (GoodsPriceVO)selectOne("goodsPrice.getCurrentGoodsPrice", goodsId );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsPriceDao.java
	* - 작성일		: 2016. 5. 9.
	* - 작성자		: valueFactory
	* - 설명			: 상품가격이력체크(현재 가격)
	* </pre>
	* @param so
	* @return
	*/
	public GoodsPriceVO checkGoodsPriceHistory (GoodsPriceSO so ) {
		return (GoodsPriceVO)selectOne("goodsPrice.checkGoodsPriceHistory", so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsPriceDao.java
	* - 작성일		: 2017.02.09
	* - 작성자		: dev_vf_04
	* - 설명			: 미래 상품가격이력 삭제처리로 갱신
	* </pre>
	* @param so
	* @return
	*/
	public int deleteGoodsPriceHistory (GoodsPricePO po ) {
		return update ("goodsPrice.deleteGoodsPriceHistory", po );
	}
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsPriceDao.java
	* - 작성일		: 2016. 5. 9.
	* - 작성자		: valueFactory
	* - 설명			: 미래 상품가격이력 삭제
	* </pre>
	* @param so
	* @return
	public int deleteGoodsPriceHistory (GoodsPriceSO so ) {
		return delete ("goodsPrice.deleteGoodsPriceHistory", so );
	}
*/
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsPriceDao.java
	* - 작성일		: 2016. 5. 9.
	* - 작성자		: valueFactory
	* - 설명			: 상품가격이력 현재가의 종료일시 수정
	* </pre>
	* @param so
	* @return
	*/
	public int updateNowSale (GoodsPriceSO so ) {
		return update("goodsPrice.updateNowSale", so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsPriceDao.java
	* - 작성일		: 2016. 5. 9.
	* - 작성자		: valueFactory
	* - 설명			: 상품가격이력 현재가의 종료일시 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateGoodsPriceHisEndDateTime (GoodsPricePO po ) {
		return update("goodsPrice.updateGoodsPriceHisEndDateTime", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsPriceDao.java
	* - 작성일	: 2021. 1. 13.
	* - 작성자 	: valfac
	* - 설명 		: 상품 가격 수정
	* </pre>
	*
	* @param po
	* @return
	*/
	public int updateGoodsPrice(GoodsPricePO po) {
		return update("goodsPrice.updateGoodsPrice", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsPriceDao.java
	* - 작성일		: 2016. 5. 9.
	* - 작성자		: valueFactory
	* - 설명			: 상품 이중가 체크
	* </pre>
	* @param so
	* @return
	*/
	public Integer doublePriceCheck (GoodsPriceSO so ) {
		return (Integer)selectOne("goodsPrice.doublePriceCheck", so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsPriceDao.java
	* - 작성일		: 2016. 5. 9.
	* - 작성자		: valueFactory
	* - 설명			: 상품가격이력체크(현재미래날짜연속성)
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsPriceVO> listFutureGoodsPriceHistory (GoodsPriceSO so ) {
		return selectList("goodsPrice.listFutureGoodsPriceHistory", so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsPriceDao.java
	* - 작성일		: 2016. 5. 10.
	* - 작성자		: valueFactory
	* - 설명			: 이전 가격 이력 조회
	* </pre>
	* @param so
	* @return
	*/
	public GoodsPriceVO getbeforeGoodsPriceHistory (GoodsPriceSO so ) {
		return (GoodsPriceVO)selectOne("goodsPrice.getbeforeGoodsPriceHistory", so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsPriceDao.java
	* - 작성일		: 2016. 5. 18.
	* - 작성자		: valueFactory
	* - 설명			: 상품에 적용된 쿠폰 리스트 조회
	* 				상품이 등록전 검사시에는 상품ID가 아니라..
	* 				상품이 등록될 전시 번호[dispClsfNos ]를 가지고 검사한다.
	* 				그 외 검사할 방법 없음.
	* 				so가 NULL 일경우 전체 상품에 적용되는 쿠폰만 조회..
	* </pre>
	* @param so
	* @return
	*/
	public List<CouponBaseVO> listApplyCoupon (GoodsBaseSO so ) {
		return selectList("goodsPrice.listApplyCoupon", so );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsPriceDao.java
	* - 작성일		: 2016. 5. 18.
	* - 작성자		: joeunok
	* - 설명		: 상품 가격 상세
	* </pre>
	* @param so
	* @return
	*/
//	public GoodsPriceVO getGoodsPrice(String goodsId) {
//		return (GoodsPriceVO)selectOne("goodsPrice.getGoodsPrice", goodsId);
//	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsPriceDao.java
	* - 작성일		: 2016. 6. 17.
	* - 작성자		: valueFactory
	* - 설명			: 상품 가격 이력 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public List<GoodsPriceVO> listGoodsPriceHistory (String goodsId ) {
		return selectList("goodsPrice.listGoodsPriceHistory", goodsId );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 9. 09.
	* - 작성자		: hjko
	* - 설명			: 세일 상품의 다음가격 조회
	* </pre>
	* @param po
	* @return
	*/
	public List<GoodsPriceVO> getNextPrice(GoodsPriceSO gpso){
		return selectList("goodsPrice.getNextPrice",gpso);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 9. 08.
	* - 작성자		: hjko
	* - 설명			: 세일 상품 가격종료일시 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateSalePriceEndDtm(GoodsPricePO po) {
		return update("goodsPrice.updateSalePriceEndDtm", po );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 9. 08.
	* - 작성자		: hjko
	* - 설명			:  상품 가격 시작일시 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateNextSalePriceStrtDtm(GoodsPricePO po ) {
		return update("goodsPrice.updateNextSalePriceStrtDtm", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsPriceDao.java
	* - 작성일		: 2017. 2. 01.
	* - 작성자		: les
	* - 설명			: 상품과 관련된 다운로드 가능 쿠폰 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<CouponBaseVO> listDownCoupon (GoodsBaseSO so ) {
		return selectList("goodsPrice.listDownCoupon", so );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2017. 2. 01.
	* - 작성자		: les
	* - 설명			: 상품 프로모션 적용 가격 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsPriceVO> getGoodsPromotionPrice(GoodsBaseSO so) {
		return selectList(BASE_DAO_PACKAGE+"getGoodsPromotionPrice", so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsPriceDao.java
	* - 작성일	: 2021. 1. 13.
	* - 작성자 	: valfac
	* - 설명 		: 상품 가격 삭제
	* </pre>
	*
	* @param po
	* @return
	*/
	public int deleteGoodsPrice(GoodsPricePO po) {
		return delete("goodsPrice.deleteGoodsPrice", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsPriceDao.java
	* - 작성일	: 2021. 1. 13.
	* - 작성자 	: valfac
	* - 설명 		: 상품 가격 리스트
	* </pre>
	*
	* @param so
	* @return
	*/
	public List<GoodsPriceVO> listGoodsPrice(GoodsPriceSO so) {
		return selectList("goodsPrice.listGoodsPrice", so);
	}

	public int updateGoodsPriceCisYn(GoodsPricePO po) {
		return update("goodsPrice.updateGoodsPriceCisYn", po);
	}
}
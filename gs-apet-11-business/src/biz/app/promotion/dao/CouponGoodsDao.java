package biz.app.promotion.dao;

import biz.app.promotion.model.CouponTargetGoodsVO;
import biz.app.promotion.model.CouponTargetSO;
import framework.common.dao.MainAbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.promotion.dao
* - 파일명		: CouponGoodsDao.java
* - 작성일		: 2021. 2. 17.
* - 작성자		: yjs01
* - 설명		: 상품 상세에서 쿠폰 목록 조회
* </pre>
*/
@Repository
public class CouponGoodsDao extends MainAbstractDao {
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: CouponGoodsDao.java
	 * - 작성일		: 2021. 2. 17.
	 * - 작성자		: yjs01
	 * - 설명		: 상품 상세 쿠폰 조회
	 * </pre>
	 * @param sto
	 * @return
	 */
	public List<CouponTargetGoodsVO> listCouponTargetGoodsDetail(CouponTargetSO sto) {
		return selectList("couponGoods.listCouponTargetGoodsDetail", sto);
	}

	public List<CouponTargetGoodsVO> pageCouponTargetGoodsDetail(CouponTargetSO sto) {
		return selectListPage("couponGoods.pageCouponTargetGoodsDetail", sto);
	}
	public int pageCouponTargetGoodsDetailCount(CouponTargetSO sto) {
		return selectOne("couponGoods.pageCouponTargetGoodsDetailCount", sto);
	}
}

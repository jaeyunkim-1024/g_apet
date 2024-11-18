package biz.app.goods.dao;

import biz.app.goods.model.GoodsIoAlmPO;
import biz.app.goods.model.GoodsIoAlmVO;
import biz.app.member.model.MemberIoAlarmSO;
import biz.app.member.model.MemberIoAlarmVO;
import framework.common.dao.MainAbstractDao;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

/**
 * <pre>
 * - 프로젝트명 : 11.business
 * - 패키지명   : biz.app.goods.dao
 * - 파일명     : GoodsAlmDao.java
 * - 작성일     : 2021. 03. 24.
 * - 작성자     : valfac
 * - 설명       : 상품 재입고 알림
 * </pre>
 */

@Repository("goodsIoAlmDao")
public class GoodsIoAlmDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "GoodsIoAlm.";

	/**
	 * 상품 재입고 배치 결과 등록
	 * @param po
	 * @return
	 */
	public int insertIoAlmTgGoods(GoodsIoAlmPO po) {
		return insert(BASE_DAO_PACKAGE + "insertIoAlmTgGoods", po);
	}

	public int insertDupIoAlmTgGoods(GoodsIoAlmPO po) {
		return insert(BASE_DAO_PACKAGE + "insertDupIoAlmTgGoods", po);
	}

	/**
	 * 상품 재입고 배치 재고 업데이트
	 * @param po
	 * @return
	 */
	public int updateIoAlmTgGoods(GoodsIoAlmPO po) {
		return insert(BASE_DAO_PACKAGE + "updateIoAlmTgGoods", po);
	}

	/**
	 *
	 * 상품 재입고 대상 상품 삭제
	 * @param po
	 * @return
	 */
	@Deprecated
	public int updateIoAlmTgGoodsSendComplate(GoodsIoAlmPO po) {
		return insert(BASE_DAO_PACKAGE + "updateIoAlmTgGoodsSendComplate", po);
	}

	/**
	 * [배치] 상품 재입고 대상 상품 목록 조회
	 * @return
	 */
	public List<MemberIoAlarmVO> selectIoAlarmGoodsTargetList() {
		return selectList(BASE_DAO_PACKAGE + "selectIoAlarmGoodsTargetList");
	}


	/**
	 * [배치] 상품 재입고 대상 상품 삭제
	 * @param po
	 * @return
	 */
	public int deleteIoAlarmTargetList(List<String> goodsIds) {
		HashMap params = new HashMap();
		params.put("goodsIds", goodsIds);
		return delete(BASE_DAO_PACKAGE + "deleteIoAlarmTargetList", params);}

	/**
	 * [마이페이지] 상품 재입고 알림 목록 조회
	 * @return
	 */
	public List<GoodsIoAlmVO> selectIoAlarmList(MemberIoAlarmSO so) {
		return selectList(BASE_DAO_PACKAGE + "selectIoAlarmList", so);
	}
}

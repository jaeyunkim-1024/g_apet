package biz.app.goods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsNotifyPO;
import biz.app.goods.model.GoodsNotifySO;
import biz.app.goods.model.GoodsNotifyVO;
import biz.app.goods.model.NotifyInfoPO;
import biz.app.goods.model.NotifyInfoVO;
import biz.app.goods.model.NotifyItemPO;
import biz.app.goods.model.NotifyItemSO;
import biz.app.goods.model.NotifyItemVO;
import framework.common.dao.MainAbstractDao;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.dao
* - 파일명		: GoodsNotifyDao.java
* - 작성일		: 2016. 4. 12.
* - 작성자		: snw
* - 설명		: 상품 고시 DAO
* </pre>
*/
@Repository
public class GoodsNotifyDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsNotify.";

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsNotifyDao.java
	* - 작성일		: 2016. 4. 12.
	* - 작성자		: snw
	* - 설명		: 상품 고시 정보 조회 : 상품의 고시정보 및 값정보
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsNotifyVO> listGoodsNotifyUsed (GoodsNotifySO so){
		return selectList(BASE_DAO_PACKAGE + "listGoodsNotifyUsed", so);
	}

	//-------------------------------------------------------------------------------------------------------------------------//
	//-
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 4. 20.
	* - 작성자		: valueFactory
	* - 설명			: 고시 정보 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertNotifyInfo (NotifyInfoPO po ) {
		return insert("goodsNotify.insertNotifyInfo", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 4. 20.
	* - 작성자		: valueFactory
	* - 설명			: 고시 아이템 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertNotifyItem (NotifyItemPO po ) {
		return insert("goodsNotify.insertNotifyItem", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 4. 20.
	* - 작성자		: valueFactory
	* - 설명			: 상품 고시 정보 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertGoodsNotify (GoodsNotifyPO po ) {
		return insert("goodsNotify.insertGoodsNotify", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 4. 20.
	* - 작성자		: valueFactory
	* - 설명			: 상품 고시 정보 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateGoodsNotify (GoodsNotifyPO po ) {
		return update("goodsNotify.updateGoodsNotify", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 4. 20.
	* - 작성자		: valueFactory
	* - 설명			: 고시정보 코드 조회
	* </pre>
	* @return
	*/
	public List<NotifyInfoVO> listNotifyInfo () {
		return selectList("goodsNotify.listNotifyInfo" );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 4. 20.
	* - 작성자		: valueFactory
	* - 설명			: 고시정보 품목 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<NotifyItemVO> listNotifyItem (NotifyItemSO so ) {
		return selectList("goodsNotify.listNotifyItem", so );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsDao.java
	* - 작성일		: 2016. 4. 20.
	* - 작성자		: tigerfive
	* - 설명			: 고시정보 품목 조회 (API용)
	* </pre>
	* @param so
	* @return
	*/
	public List<biz.app.goods.model.interfaces.NotifyItemVO> listNotifyItemInterface (biz.app.goods.model.interfaces.NotifyItemSO so ) {
		return selectList("goodsNotify.listNotifyItemInterface", so );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsNotifyDao.java
	* - 작성일		: 2016. 5. 12.
	* - 작성자		: valueFactory
	* - 설명			: 상품 고시 정보 삭제
	* </pre>
	* @param goodsId
	* @return
	*/
	public int deleteGoodsNotify (String goodsId ) {
		return delete("goodsNotify.deleteGoodsNotify", goodsId );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsNotifyDao.java
	* - 작성일		: 2016. 5. 16.
	* - 작성자		: valueFactory
	* - 설명			: 상품 고시 정보 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public List<GoodsNotifyVO> listGoodsNotify (String goodsId ) {
		return selectList("goodsNotify.listGoodsNotify", goodsId );
	}

	/**
	 *
	 * @param ntfId
	 * @return
	 */
	public NotifyInfoVO getCheckGoodsNotify(String ntfId) {

		return selectOne(BASE_DAO_PACKAGE+"getCheckGoodsNotify" ,ntfId);
	}

}

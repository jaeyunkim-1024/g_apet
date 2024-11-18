package biz.app.goods.dao;

import biz.app.goods.model.GoodsCommentCountVO;
import biz.app.goods.model.GoodsCommentDetailPO;
import biz.app.goods.model.GoodsCommentDetailPetlogVO;
import biz.app.goods.model.GoodsCommentDetailReplyPO;
import biz.app.goods.model.GoodsCommentDetailReplyVO;
import biz.app.goods.model.GoodsCommentImagePO;
import biz.app.goods.model.GoodsCommentImageVO;
import biz.app.goods.model.GoodsCommentPO;
import biz.app.goods.model.GoodsCommentSO;
import biz.app.goods.model.GoodsCommentVO;
import biz.app.order.model.OrderDetailPO;
import biz.app.system.model.CodeDetailVO;
import framework.common.dao.MainAbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.dao
* - 파일명		: GoodsCommentDao.java
* - 작성일		: 2016. 3. 7.
* - 작성자		: snw
* - 설명		: 상품 평가 DAO
* </pre>
*/
@Repository
public class GoodsCommentDetailDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsCommentDetail.";

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: GoodsCommentDetailDao.java
	* - 작성일	: 2020.01.05
	* - 작성자	: yjs01
	* - 설명		: 상품후기 상세
	* </pre>
	* @param po
	* @return
	*/
	public long updateGoodsCommentDetail(GoodsCommentDetailPO po){
		return update(BASE_DAO_PACKAGE + "updateGoodsCommentDetail", po);
	}
	public long updateGoodsCommentLinkDetail(GoodsCommentDetailPO po){
		return update(BASE_DAO_PACKAGE + "updateGoodsCommentLinkDetail", po);
	}
	public long updateGoodsCommentBestDetail(GoodsCommentDetailPO po){
		//return update(BASE_DAO_PACKAGE + "updateGoodsCommentBestDetail", po);
		return update(BASE_DAO_PACKAGE + "updateGoodsCommentLinkBestDetail", po);
	}

	public List<CodeDetailVO> getGoodsCommentEstmScoreList(){
		return selectList(BASE_DAO_PACKAGE + "getGoodsCommentEstmScoreList");
	}

	public List<GoodsCommentDetailReplyVO> getGoodsCommentEstmReplyList(Long goodsEstmNo){
		return selectList(BASE_DAO_PACKAGE + "getGoodsCommentEstmReplyList", goodsEstmNo);
	}

	public List<GoodsCommentDetailReplyVO> getGoodsCommentRptpRsnInfoList(Long goodsEstmNo){
		return selectList(BASE_DAO_PACKAGE + "getGoodsCommentRptpRsnInfoList", goodsEstmNo);
	}

	public GoodsCommentDetailPetlogVO getGoodsCommentPetlogInfo(String petLogNo){
		return selectOne(BASE_DAO_PACKAGE + "getGoodsCommentPetlogInfo", petLogNo);
	}
	public List<GoodsCommentDetailReplyVO> getPetLogGoodsCommentRptpRsnInfoList(Long goodsEstmNo) {
		return selectList(BASE_DAO_PACKAGE + "getPetLogGoodsCommentRptpRsnInfoList", goodsEstmNo);
	}

}

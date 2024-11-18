package biz.app.goods.service;

import biz.app.goods.model.GoodsCommentCountVO;
import biz.app.goods.model.GoodsCommentDetailPO;
import biz.app.goods.model.GoodsCommentDetailPetlogVO;
import biz.app.goods.model.GoodsCommentDetailReplyPO;
import biz.app.goods.model.GoodsCommentDetailReplyVO;
import biz.app.goods.model.GoodsCommentImageVO;
import biz.app.goods.model.GoodsCommentPO;
import biz.app.goods.model.GoodsCommentSO;
import biz.app.goods.model.GoodsCommentVO;
import biz.app.order.model.OrderDetailPO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.model.OrderSO;
import biz.app.system.model.CodeDetailVO;

import java.util.List;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.goods.service
* - 파일명		: GoodsCommentService.java
* - 작성일		: 2020.01.05.
* - 작성자		: yjs01
* - 설명		: 상품 후기 상세 서비스 Interface
* </pre>
*/
public interface GoodsCommentDetailService {

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin
	//-------------------------------------------------------------------------------------------------------------------------//

	public long updateGoodsCommentDetail(GoodsCommentDetailPO po);
	public long updateGoodsCommentBestDetail(GoodsCommentDetailPO po);
	public List<CodeDetailVO> getGoodsCommentEstmScoreList();
	public List<GoodsCommentDetailReplyVO> getGoodsCommentEstmReplyList(Long goodsEstmNo);
	public List<GoodsCommentDetailReplyVO> getGoodsCommentRptpRsnInfoList(Long goodsEstmNo);
	public GoodsCommentDetailPetlogVO getGoodsCommentPetlogInfo(String petLogNo);
	public void getPetlogInfoImage(List<GoodsCommentImageVO> imageVOList, Long goodsEstmNo, int rownum, String imgPath, String vdYn);
	public List<GoodsCommentDetailReplyVO> getPetLogGoodsCommentRptpRsnInfoList(Long goodsEstmNo);
}
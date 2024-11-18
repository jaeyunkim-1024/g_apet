package biz.app.goods.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.goods.dao.GoodsEstmDao;
import biz.app.goods.model.GoodsEstmQstCtgMapSO;
import biz.app.goods.model.GoodsEstmQstVO;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsEstmServiceImpl.java
* - 작성일	: 2020. 12. 21.
* - 작성자	: valfac
* - 설명 		: 상품평가
* </pre>
*/
@Transactional
@Service("goodsEstmService")
public class GoodsEstmServiceImpl implements GoodsEstmService {

	@Autowired
	private GoodsEstmDao goodsEstmDao;
	
	@Override
	public List<GoodsEstmQstVO> listGoodsEstmQstCtgMap(GoodsEstmQstCtgMapSO so) {
		return goodsEstmDao.listGoodsEstmQstCtgMap(so);
	}


	

}
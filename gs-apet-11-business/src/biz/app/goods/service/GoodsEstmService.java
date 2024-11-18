package biz.app.goods.service;

import java.util.List;

import biz.app.goods.model.GoodsEstmQstCtgMapSO;
import biz.app.goods.model.GoodsEstmQstVO;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsEstmService.java
* - 작성일	: 2020. 12. 21.
* - 작성자	: valfac
* - 설명 		: 상품평가항목
* </pre>
*/
public interface GoodsEstmService {

	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsEstmService.java
	* - 작성일	: 2021. 2. 15.
	* - 작성자 	: valfac
	* - 설명 		: 상품 평가 문항 카테고리 매핑 조회
	* </pre>
	*
	* @param so
	* @return
	*/
	public List<GoodsEstmQstVO> listGoodsEstmQstCtgMap(GoodsEstmQstCtgMapSO so);
	
	
}
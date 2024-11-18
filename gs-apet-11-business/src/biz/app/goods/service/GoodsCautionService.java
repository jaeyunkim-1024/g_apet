package biz.app.goods.service;

import java.util.List;

import biz.app.goods.model.GoodsCautionPO;
import biz.app.goods.model.GoodsCautionSO;
import biz.app.goods.model.GoodsCautionVO;



/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.service
* - 파일명		: GoodsCautionService.java
* - 작성일		: 2016. 3. 3.
* - 작성자		: snw
* - 설명		: 상품 주의사항 서비스 Interface
* </pre>
*/
public interface GoodsCautionService {


	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCautionService.java
	* - 작성일		: 2016. 3. 3.
	* - 작성자		: snw
	* - 설명		: 상품 주의사항 목록 조회
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	List<GoodsCautionVO> listGoodsCaution(GoodsCautionSO so);

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin
	//-------------------------------------------------------------------------------------------------------------------------//


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsCautionService.java
	* - 작성일		: 2016. 6. 14.
	* - 작성자		: valueFactory
	* - 설명			: 상품 주의사항 조회
	* </pre>
	* @param goodsId
	* @return
	*/
	public GoodsCautionVO getGoodsCaution (String goodsId );
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCautionService.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 상품 주의사항 등록
	* </pre>
	*
	* @param goodsId
	* @param goodsCautionPO
	* @return
	*/
	public void insertGoodsCaution (String goodsId, GoodsCautionPO goodsCautionPO);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCautionService.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 주의사항 수정
	* </pre>
	*
	* @param goodsId
	* @param goodsCautionPO
	*/
	public void updateGoodsCaution (String goodsId, GoodsCautionPO goodsCautionPO);

}
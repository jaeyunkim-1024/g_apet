package biz.app.goods.service;

import java.util.List;

import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsCstrtPakPO;
import biz.app.goods.model.GoodsCstrtPakVO;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsCstrtPakService.java
* - 작성일	: 2021. 1. 15.
* - 작성자	: valfac
* - 설명 		: 상품 묶음 구성 서비스
* </pre>
*/
public interface GoodsCstrtPakService {

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtPakService.java
	* - 작성일	: 2021. 1. 15.
	* - 작성자 	: valfac
	* - 설명 		: 묶음 상품 등록
	* </pre>
	*
	* @param GoodsCstrtPakPOList
	* @param goodsId
	*/
	public void insertGoodsCstrtPak(List<GoodsCstrtPakPO> GoodsCstrtPakPOList, String goodsId);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtPakService.java
	* - 작성일	: 2021. 1. 14.
	* - 작성자 	: valfac
	* - 설명 		: 묶음 상품 리스트
	* </pre>
	*
	* @param goodsId
	*/
	public List<GoodsCstrtPakVO> listGoodsCstrtPak(String goodsId);
	

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtPakService.java
	* - 작성일	: 2021. 1. 14.
	* - 작성자 	: valfac
	* - 설명 		: 묶음 상품 리스트
	* </pre>
	*
	* @param GoodsCstrtPakPO
	*/
	public List<GoodsCstrtPakVO> listPakGoodsCstrtPak(GoodsCstrtPakPO po);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtPakService.java
	* - 작성일	: 2021. 1. 14.
	* - 작성자 	: valfac
	* - 설명 		: 옵션 상품 리스트
	* </pre>
	*
	* @param goodsId
	*/
	public List<GoodsCstrtPakVO> listOptionGoodsCstrtPak(GoodsCstrtPakPO po);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtPakService.java
	* - 작성일	: 2021. 2. 24.
	* - 작성자 	: valfac
	* - 설명 		: 묶음 상품 삭제
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	public int deleteGoodsCstrtPak(String goodsId);

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCstrtPakService.java
	* - 작성일		: 2021. 4. 2.
	* - 작성자		: pcm
	* - 설명		: 상품 후기 정렬 옵션 조회
	* </pre>
	* @param goodsBaseSO
	* @return
	*/
	public List<GoodsBaseVO> getCommentCstrtList(GoodsBaseSO goodsBaseSO);
	
	
	// '대표'상품의 배송정책번호 조회. 대표상품 재고 없을경우, 다음 상품으로 조회함.
	public int getMainDlvrcPlcNo(String goodsId);
	
	
	// 상품id로 배송정책 가져오기
	public int getDlvrcPlcNo(String goodsId);


}
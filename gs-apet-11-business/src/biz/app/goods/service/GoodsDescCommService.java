package biz.app.goods.service;

import java.util.List;

import biz.app.goods.model.GoodsDescCommPO;
import biz.app.goods.model.GoodsDescCommSO;
import biz.app.goods.model.GoodsDescCommVO;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsDescCommService.java
* - 작성일	: 2021. 1. 4.
* - 작성자	: valfac
* - 설명 		: 상품 설명 공통 서비스
* </pre>
*/
public interface GoodsDescCommService {

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDescCommService.java
	* - 작성일	: 2021. 1. 4.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 공통 페이지
	* </pre>
	*
	* @param goodsDescCommSO
	* @return
	*/
	public List<GoodsDescCommVO> pageGoodsDescComm(GoodsDescCommSO goodsDescCommSO);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDescCommService.java
	* - 작성일	: 2021. 1. 4.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 공통 등록
	* </pre>
	*
	* @param goodsDescCommPO
	* @return
	*/
	public int insertGoodsDescComm(GoodsDescCommPO goodsDescCommPO);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDescCommService.java
	* - 작성일	: 2021. 1. 4.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 공통 수정
	* </pre>
	*
	* @param goodsDescCommPO
	* @return
	*/
	public int updateGoodsDescComm(GoodsDescCommPO goodsDescCommPO);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDescCommService.java
	* - 작성일	: 2021. 1. 4.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 공통 정보 조회
	* </pre>
	*
	* @param goodsDescCommPO
	* @return
	*/
	public GoodsDescCommVO getGoodsDescComm(GoodsDescCommPO goodsDescCommPO);
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDescCommService.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 중복 체크
	* </pre>
	*
	* @param goodsDescCommPO
	* @return
	*/
	public int checkDescComm(GoodsDescCommSO goodsDescCommSO);
	
}
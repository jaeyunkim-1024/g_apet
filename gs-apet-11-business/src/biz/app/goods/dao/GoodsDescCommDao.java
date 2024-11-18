package biz.app.goods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsDescCommPO;
import biz.app.goods.model.GoodsDescCommSO;
import biz.app.goods.model.GoodsDescCommVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.dao
* - 파일명 	: GoodsDescCommDao.java
* - 작성일	: 2021. 1. 4.
* - 작성자	: valfac
* - 설명 		: 상품 설명 공통 Dao
* </pre>
*/
@Repository
public class GoodsDescCommDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsDescComm.";

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDescCommDao.java
	* - 작성일	: 2021. 1. 4.
	* - 작성자 	: valfac
	* - 설명 		: 상품 공통 설명 등록
	* </pre>
	*
	* @param goodsDescCommPO
	* @return
	*/
	public int insertGoodsDescComm (GoodsDescCommPO goodsDescCommPO) {
		return insert(BASE_DAO_PACKAGE + "insertGoodsDescComm", goodsDescCommPO);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDescCommDao.java
	* - 작성일	: 2021. 1. 4.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 공통 수정
	* </pre>
	*
	* @param goodsDescCommPO
	* @return
	*/
	public int updateGoodsDescComm (GoodsDescCommPO goodsDescCommPO) {
		return update(BASE_DAO_PACKAGE + "updateGoodsDescComm", goodsDescCommPO);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDescCommDao.java
	* - 작성일	: 2021. 1. 4.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 공통 페이지 리스트
	* </pre>
	*
	* @param goodsDescCommSO
	* @return
	*/
	public List<GoodsDescCommVO> pageGoodsDescComm(GoodsDescCommSO goodsDescCommSO) {
		return selectListPage(BASE_DAO_PACKAGE + "pageGoodsDescComm", goodsDescCommSO);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDescCommDao.java
	* - 작성일	: 2021. 1. 4.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 공통 단건 조회
	* </pre>
	*
	* @param goodsDescCommPO
	* @return
	*/
	public GoodsDescCommVO getGoodsDescComm(GoodsDescCommPO goodsDescCommPO) {
		return selectOne(BASE_DAO_PACKAGE + "getGoodsDescComm", goodsDescCommPO);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDescCommDao.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 중복 체크
	* </pre>
	*
	* @param goodsDescCommPO
	* @return
	*/
	public int checkDescComm(GoodsDescCommSO goodsDescCommSO) {
		return selectOne(BASE_DAO_PACKAGE + "pageGoodsDescCommCount", goodsDescCommSO);
	}
}

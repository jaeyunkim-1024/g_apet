package biz.app.goods.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsCstrtPakPO;
import biz.app.goods.model.GoodsCstrtPakVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.dao
* - 파일명 	: GoodsCstrtPakDao.java
* - 작성일	: 2021. 1. 15.
* - 작성자	: valfac
* - 설명 		: 상품 묶음 구성 dao
* </pre>
*/
@Repository
public class GoodsCstrtPakDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "goodsCstrtPak.";

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtPakDao.java
	* - 작성일	: 2021. 1. 15.
	* - 작성자 	: valfac
	* - 설명 		: 상품 묶음 구성 등록
	* </pre>
	*
	* @param goodsCstrtPakPO
	*/
	public int insertGoodsCstrtPak(GoodsCstrtPakPO goodsCstrtPakPO) {
		return insert(BASE_DAO_PACKAGE + "insertGoodsCstrtPak", goodsCstrtPakPO);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtPakDao.java
	* - 작성일	: 2021. 1. 15.
	* - 작성자 	: valfac
	* - 설명 		: 상품 묶음 리스트
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	public List<GoodsCstrtPakVO> listGoodsCstrtPak(String goodsId) {
		return selectList(BASE_DAO_PACKAGE + "listGoodsCstrtPak", goodsId);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtPakDao.java
	* - 작성일	: 2021. 1. 15.
	* - 작성자 	: valfac
	* - 설명 		: 상품 묶음 리스트
	* </pre>
	*
	* @param GoodsCstrtPakPO
	* @return
	*/
	public List<GoodsCstrtPakVO> listPakGoodsCstrtPak(GoodsCstrtPakPO goodsCstrtPakPO) {
		return selectList(BASE_DAO_PACKAGE + "listPakGoodsCstrtPak", goodsCstrtPakPO);
	}
	
	
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtPakDao.java
	* - 작성일	: 2021. 1. 15.
	* - 작성자 	: valfac
	* - 설명 		: 옵션 상품 리스트
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	public List<GoodsCstrtPakVO> listOptionGoodsCstrtPak(GoodsCstrtPakPO goodsCstrtPakPO) {
		return selectList(BASE_DAO_PACKAGE + "listOptionGoodsCstrtPak", goodsCstrtPakPO);
	}
	
	
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtPakDao.java
	* - 작성일	: 2021. 2. 24.
	* - 작성자 	: valfac
	* - 설명 		: 상품 묶음 삭제
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	public int deleteGoodsCstrtPak(String goodsId) {
		return delete(BASE_DAO_PACKAGE + "deleteGoodsCstrtPak", goodsId);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명		: GoodsCstrtPakDao.java
	* - 작성일		: 2021. 4. 2.
	* - 작성자		: pcm
	* - 설명		: 상품 후기 정렬 옵션 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<GoodsBaseVO> getCommentCstrtList(GoodsBaseSO so) {
		return selectList(BASE_DAO_PACKAGE + "getCommentCstrtList", so);
	}
	
	// 대표상품의 배송정책번호 조회. 대표상품 재고 없을경우, 다음 상품으로 조회함.
	public int getMainDlvrcPlcNo(String goodsId) {
		
		Integer integerMainDlvrPlcNo = selectOne(BASE_DAO_PACKAGE + "getMainDlvrcPlcNo", goodsId);
		if ( integerMainDlvrPlcNo == null ) {
			return 0;
		}
		return integerMainDlvrPlcNo.intValue();
	}
	
	// 상품id로 배송정책 가져오기
	public int getDlvrcPlcNo(String goodsId) {
		
		Integer integerDlvrPlcNo = selectOne(BASE_DAO_PACKAGE + "getDlvrcPlcNo", goodsId);
		if ( integerDlvrPlcNo == null ) {
			return 0;
		}
		return integerDlvrPlcNo.intValue();
	}
}

package biz.app.goods.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import biz.app.goods.dao.GoodsCstrtPakDao;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.model.GoodsCstrtPakPO;
import biz.app.goods.model.GoodsCstrtPakVO;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsCstrtPakServiceImpl.java
* - 작성일	: 2021. 1. 15.
* - 작성자	: valfac
* - 설명 		: 상품 묶음 구성 서비스 impl
* </pre>
*/
@Transactional
@Service("goodsCstrtPakService")
public class GoodsCstrtPakServiceImpl implements GoodsCstrtPakService {

	@Autowired
	private GoodsCstrtPakDao goodsCstrtPakDao;

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtPakServiceImpl.java
	* - 작성일	: 2021. 1. 15.
	* - 작성자 	: valfac
	* - 설명 		: 묶음 상품 등록
	* </pre>
	*
	* @param GoodsCstrtPakPOList
	* @param goodsId
	*/
	@Override
	public void insertGoodsCstrtPak(List<GoodsCstrtPakPO> goodsCstrtPakPOList, String goodsId) {
		
		int result = 0;
		
		if(CollectionUtils.isNotEmpty(goodsCstrtPakPOList)) {
			int rank = 1;
			for(GoodsCstrtPakPO po : goodsCstrtPakPOList) {
				po.setGoodsId(goodsId);
				po.setDispPriorRank(rank++);
				result += goodsCstrtPakDao.insertGoodsCstrtPak(po);				
			}
		}
		
		if(result < 1) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtPakServiceImpl.java
	* - 작성일	: 2021. 1. 15.
	* - 작성자 	: valfac
	* - 설명 		: 묶음 상품 리스트
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	@Override
	public List<GoodsCstrtPakVO> listGoodsCstrtPak(String goodsId) {
		return goodsCstrtPakDao.listGoodsCstrtPak(goodsId);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtPakServiceImpl.java
	* - 작성일	: 2021. 1. 15.
	* - 작성자 	: valfac
	* - 설명 		: 묶음 상품 리스트
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List<GoodsCstrtPakVO> listPakGoodsCstrtPak(GoodsCstrtPakPO po) {
		return goodsCstrtPakDao.listPakGoodsCstrtPak(po);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtPakServiceImpl.java
	* - 작성일	: 2021. 1. 15.
	* - 작성자 	: valfac
	* - 설명 		: 묶음 상품 리스트
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	@Override
	public List<GoodsCstrtPakVO> listOptionGoodsCstrtPak(GoodsCstrtPakPO po) {
		return goodsCstrtPakDao.listOptionGoodsCstrtPak(po);
	}
	
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtPakServiceImpl.java
	* - 작성일	: 2021. 2. 24.
	* - 작성자 	: valfac
	* - 설명 		: 묶음 상품 삭제
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	@Override
	public int deleteGoodsCstrtPak(String goodsId) {
		
		int result = goodsCstrtPakDao.deleteGoodsCstrtPak(goodsId);
		
		if(result < 1) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
		
		return result;
	}

	@Override
	@Transactional(readOnly = true, isolation = Isolation.READ_UNCOMMITTED, propagation = Propagation.SUPPORTS)
	public List<GoodsBaseVO> getCommentCstrtList(GoodsBaseSO so) {
		return goodsCstrtPakDao.getCommentCstrtList(so);
	}
	
	// 대표상품의 배송정책번호 조회. 대표상품 재고 없을경우, 다음 상품으로 조회함.
	@Override
	public int getMainDlvrcPlcNo(String goodsId){
		return goodsCstrtPakDao.getMainDlvrcPlcNo(goodsId);
	}
	
	
	@Override
	public int getDlvrcPlcNo(String goodsId){
		return goodsCstrtPakDao.getDlvrcPlcNo(goodsId);
	}
	
	
	
	
	
}
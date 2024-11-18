package biz.app.goods.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.goods.dao.GoodsCstrtSetDao;
import biz.app.goods.model.GoodsCstrtSetPO;
import biz.app.goods.model.GoodsCstrtSetVO;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsCstrtSetServiceImpl.java
* - 작성일	: 2021. 1. 8.
* - 작성자	: valfac
* - 설명 		: 상품 세트 구성 서비스 impl
* </pre>
*/
@Transactional
@Service("goodsCstrtSetService")
public class GoodsCstrtSetServiceImpl implements GoodsCstrtSetService {

	@Autowired
	private GoodsCstrtSetDao goodsCstrtSetDao;

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtSetServiceImpl.java
	* - 작성일	: 2021. 1. 8.
	* - 작성자 	: valfac
	* - 설명 		: 세트 상품 등록
	* </pre>
	*
	* @param goodsCstrtSetPOList
	* @param goodsId
	*/
	@Override
	public void insertGoodsCstrtSet(List<GoodsCstrtSetPO> goodsCstrtSetPOList, String goodsId) {
		
		int result = 0;
		
		if(CollectionUtils.isNotEmpty(goodsCstrtSetPOList)) {
			int rank = 1;
			for(GoodsCstrtSetPO po : goodsCstrtSetPOList) {
				po.setGoodsId(goodsId);
				po.setDispPriorRank(rank++);
				result += goodsCstrtSetDao.insertGoodsCstrtSet(po);
				
			}
		}

		if(result < 1) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
		
		
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtSetServiceImpl.java
	* - 작성일	: 2021. 1. 15.
	* - 작성자 	: valfac
	* - 설명 		: 세트 상품 리스트
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	@Override
	public List<GoodsCstrtSetVO> listGoodsCstrtSet(String goodsId) {
		return goodsCstrtSetDao.listGoodsCstrtSet(goodsId);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsCstrtSetServiceImpl.java
	* - 작성일	: 2021. 2. 25.
	* - 작성자 	: valfac
	* - 설명 		: 세트 상품 삭제
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	@Override
	public int deleteGoodsCstrtSet(String goodsId) {
		
		int result = goodsCstrtSetDao.deleteGoodsCstrtSet(goodsId);
		
		if(result < 1) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
		
		return result;
	}
	
	
	
}
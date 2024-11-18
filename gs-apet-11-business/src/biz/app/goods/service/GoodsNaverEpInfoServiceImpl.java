package biz.app.goods.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.goods.dao.GoodsNaverEpInfoDao;
import biz.app.goods.model.GoodsNaverEpInfoPO;
import biz.app.goods.model.GoodsNaverEpInfoVO;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsNaverEpInfoServiceImpl.java
* - 작성일	: 2021. 1. 18.
* - 작성자	: valfac
* - 설명 		: 상품 네이버 EP 정보 공통 서비스
* </pre>
*/
@Transactional
@Service("goodsNaverEpInfoService")
public class GoodsNaverEpInfoServiceImpl implements GoodsNaverEpInfoService {

	@Autowired
	private GoodsNaverEpInfoDao goodsNaverEpInfoDao;


	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsNaverEpInfoServiceImpl.java
	* - 작성일	: 2021. 1. 18.
	* - 작성자 	: valfac
	* - 설명 		: 상품 네이버 EP 정보
	* </pre>
	*
	* @param goodsId
	* @return
	*/
	@Override
	public GoodsNaverEpInfoVO getGoodsNaverEpInfo(String goodsId) {
		return goodsNaverEpInfoDao.getGoodsNaverEpInfo(goodsId);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsNaverEpInfoServiceImpl.java
	* - 작성일	: 2021. 1. 18.
	* - 작성자 	: valfac
	* - 설명 		: 상품 네이버 EP 정보 등록
	* </pre>
	*
	* @param goodsNaverEpInfoPO
	* @param goodsId
	* @return
	*/
	@Override
	public int insertGoodsNaverEpInfo(GoodsNaverEpInfoPO goodsNaverEpInfoPO, String goodsId) {
		
		goodsNaverEpInfoPO.setGoodsId(goodsId);
		
		int result = goodsNaverEpInfoDao.insertGoodsNaverEpInfo(goodsNaverEpInfoPO);
		
		if(result < 1) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
		
		return result;
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsNaverEpInfoServiceImpl.java
	* - 작성일	: 2021. 1. 18.
	* - 작성자 	: valfac
	* - 설명 		: 상품 네이버 EP 정보 수정
	* </pre> 
	*
	* @param goodsNaverEpInfoPO
	* @param goodsId
	* @return
	*/
	@Override
	public int updateGoodsNaverEpInfo(GoodsNaverEpInfoPO goodsNaverEpInfoPO) {
		
		int result = goodsNaverEpInfoDao.updateGoodsNaverEpInfo(goodsNaverEpInfoPO);

		if(result < 1) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
		
		return result;
	}

}
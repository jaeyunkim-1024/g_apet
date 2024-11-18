package biz.app.goods.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.goods.dao.GoodsDescCommDao;
import biz.app.goods.model.GoodsDescCommPO;
import biz.app.goods.model.GoodsDescCommSO;
import biz.app.goods.model.GoodsDescCommVO;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsDescCommServiceImpl.java
* - 작성일	: 2021. 1. 4.
* - 작성자	: valfac
* - 설명 		: 상품 설명 공통 서비스
* </pre>
*/
@Transactional
@Service("goodsDescCommService")
public class GoodsDescCommServiceImpl implements GoodsDescCommService {

	@Autowired
	private GoodsDescCommDao goodsDescCommDao;
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDescCommServiceImpl.java
	* - 작성일	: 2021. 1. 4.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 공통 페이지 리스트
	* </pre>
	*
	* @param goodsDescCommSO
	* @return
	*/
	@Override
	public List<GoodsDescCommVO> pageGoodsDescComm(GoodsDescCommSO goodsDescCommSO) {
		return goodsDescCommDao.pageGoodsDescComm(goodsDescCommSO);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDescCommServiceImpl.java
	* - 작성일	: 2021. 1. 4.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 공통 단건 정보 조회
	* </pre>
	*
	* @param goodsDescCommPO
	* @return
	*/
	@Override
	public GoodsDescCommVO getGoodsDescComm(GoodsDescCommPO goodsDescCommPO) {
		return goodsDescCommDao.getGoodsDescComm(goodsDescCommPO);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDescCommServiceImpl.java
	* - 작성일	: 2021. 1. 4.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 공통 등록
	* </pre>
	*
	* @param goodsDescCommPO
	* @return
	*/
	@Override
	public int insertGoodsDescComm(GoodsDescCommPO goodsDescCommPO) {
		
		int result = 0;
		
		result = goodsDescCommDao.insertGoodsDescComm(goodsDescCommPO);
		
		if(result < 1) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
		
		return result;
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDescCommServiceImpl.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 중복 체크
	* </pre>
	*
	* @param goodsDescCommPO
	* @return
	*/
	@Override
	public int checkDescComm(GoodsDescCommSO goodsDescCommSO) {
		goodsDescCommSO.setIsCheckReDuplication(true);
		return goodsDescCommDao.checkDescComm(goodsDescCommSO);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDescCommServiceImpl.java
	* - 작성일	: 2021. 1. 4.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 공통 수정
	* </pre>
	*
	* @param goodsDescCommPO
	* @return
	*/
	@Override
	public int updateGoodsDescComm(GoodsDescCommPO goodsDescCommPO) {
		
		int result = goodsDescCommDao.updateGoodsDescComm(goodsDescCommPO);

		if(result < 1) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
		
		return result;
	}

}
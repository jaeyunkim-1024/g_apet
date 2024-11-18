package biz.app.goods.service;

import java.lang.reflect.InvocationTargetException;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.goods.dao.GoodsDescDao;
import biz.app.goods.model.GoodsDescHistPO;
import biz.app.goods.model.GoodsDescPO;
import biz.app.goods.model.GoodsDescSO;
import biz.app.goods.model.GoodsDescVO;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.goods.service
* - 파일명		: GoodsDescServiceImpl.java
* - 작성일		: 2016. 3. 3.
* - 작성자		: snw
* - 설명		: 상품 설명 서비스
* </pre>
*/
@Transactional
@Service("goodsDescService")
public class GoodsDescServiceImpl implements GoodsDescService {

	@Autowired private GoodsDescDao goodsDescDao;

	/*
	 * 상품 설명 상세 조회
	 * @see biz.app.goods.service.GoodsDescService#getGoodsDesc(biz.app.goods.model.GoodsDescSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public GoodsDescVO getGoodsDesc(GoodsDescSO so) {
		return this.goodsDescDao.getGoodsDesc(so);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDescServiceImpl.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 등록
	* </pre>
	*
	* @param goodsId
	* @param goodsPO
	* @return
	*/
	@Override
	public void insertGoodsDesc(String goodsId, List<GoodsDescPO> goodsDescPOList) {
		
		try {
			if(CollectionUtils.isNotEmpty(goodsDescPOList)) {
				for(GoodsDescPO po : goodsDescPOList) {
					po.setGoodsId(goodsId );
					goodsDescDao.insertGoodsDesc(po);
					// 이력 등록
					GoodsDescHistPO goodsDescHistPO = new GoodsDescHistPO();
					BeanUtils.copyProperties(goodsDescHistPO, po);
					goodsDescDao.insertGoodsDescHist(goodsDescHistPO);
				}
			}
		} catch (IllegalAccessException | InvocationTargetException e) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
		
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsDescServiceImpl.java
	* - 작성일	: 2021. 1. 7.
	* - 작성자 	: valfac
	* - 설명 		: 상품 설명 수정
	* </pre>
	*
	* @param goodsId
	* @param goodsDescPOList
	*/
	@Override
	public void updateGoodsDesc(String goodsId, List<GoodsDescPO> goodsDescPOList) {
		
		try {
			if(CollectionUtils.isNotEmpty(goodsDescPOList)) {
				for(GoodsDescPO po : goodsDescPOList ) {
					GoodsDescSO gdso = new GoodsDescSO();
					gdso.setGoodsId(goodsId);
					gdso.setSvcGbCd(po.getSvcGbCd());
					GoodsDescVO gdvo = goodsDescDao.getGoodsDesc(gdso);
					if(gdvo != null ){
						po.setGoodsId(goodsId );
						goodsDescDao.updateGoodsDesc(po );
					}else{
						po.setGoodsId(goodsId );
						po.setSvcGbCd(po.getSvcGbCd());
						goodsDescDao.insertGoodsDesc( po );
					}
					// 이력 등록
					GoodsDescHistPO goodsDescHistPO = new GoodsDescHistPO();
					BeanUtils.copyProperties(goodsDescHistPO, po );
					goodsDescDao.insertGoodsDescHist(goodsDescHistPO );
				}
			}
		} catch (IllegalAccessException | InvocationTargetException e) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
		
	}
	
	

}
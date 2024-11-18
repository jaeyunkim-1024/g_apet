package biz.app.goods.service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import biz.app.system.model.CodeDetailVO;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.goods.dao.GoodsIconDao;
import biz.app.goods.model.GoodsIconPO;
import biz.app.goods.model.GoodsIconVO;


/**
* <pre>
* - 프로젝트명	: gs-apet-11-business
* - 패키지명 	: biz.app.goods.service
* - 파일명 	: GoodsIconServiceImpl.java
* - 작성일	: 2020. 12. 29.
* - 작성자	: valfac
* - 설명 		: 상품 아이콘 serviceImpl
* </pre>
*/
@Transactional
@Service("goodsIconService")
public class GoodsIconServiceImpl implements GoodsIconService {

	@Autowired
	private GoodsIconDao goodsIconDao;
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsIconServiceImpl.java
	* - 작성일	: 2020. 12. 29.
	* - 작성자 	: valfac
	* - 설명 		: 아이콘 리스트 조회
	* </pre>
	*
	* @return
	*/
	@Override
	@Transactional(readOnly=true)
	public List<GoodsIconVO> listGoodsIcon(String goodsId) {
		return goodsIconDao.listGoodsIcon(goodsId);
	}

	@Override
	public List<CodeDetailVO> listGoodsIconByGoodsId(String goodsId) {
		return goodsIconDao.listGoodsIconByGoodsId(goodsId);
	}

	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: GoodsIconServiceImpl.java
	* - 작성일	: 2021. 1. 6.
	* - 작성자 	: valfac
	* - 설명 		: 아이콘 등록
	* </pre>
	*
	* @param goodsId
	* @param goodsIconList
	* @return
	*/
	@Override
	public void insertGoodsIcon(String goodsId, List<GoodsIconPO> goodsIconList) {
		
		if(CollectionUtils.isNotEmpty(goodsIconList)) {
			for(GoodsIconPO po : goodsIconList ) {
				po.setGoodsId(goodsId );
				po.setCodes(new String[] {po.getGoodsIconCd()});
				goodsIconDao.insertGoodsIcon(po);
			}
		}
	}

	public int saveGoodsIcon(List<String> goodsIds, List<GoodsIconPO> goodsIconList, String usrDfn1Val, String usrDfn2Val) {
		if (goodsIconList == null) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		Session session = AdminSessionUtil.getSession();

		//수동 아이콘 삭제
		goodsIconDao.deleteGoodsIcon(goodsIds, usrDfn1Val, usrDfn2Val);

		int result = 0;
		for(GoodsIconPO po : goodsIconList) {
			if(po.getCodes().length > 0) {
				po.setSysRegrNo(session.getUsrNo());
				goodsIconDao.insertGoodsIcon(po);

				result ++;
			}
		}

		return result;
	}
}
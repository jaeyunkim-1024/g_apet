package biz.app.shop.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.shop.model.ShopEnterFileSO;
import biz.app.shop.model.ShopEnterFileVO;
import biz.app.shop.model.ShopEnterPO;
import biz.app.shop.model.ShopEnterSO;
import biz.app.shop.model.ShopEnterVO;
import framework.common.dao.MainAbstractDao;

@Repository
public class ShopEnterDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "shopEnter.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: ShopEnterDao.java
	* - 작성일	: 2016. 4. 18.
	* - 작성자	: jangjy
	* - 설명		: 입점문의 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertShopEnter (ShopEnterPO po ) {
		return insert(BASE_DAO_PACKAGE + "insertShopEnter", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ShopEnterDao.java
	* - 작성일		: 2016. 9. 06.
	* - 작성자		: muelKim
	* - 설명			: 입점문의목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<ShopEnterVO> pageContectList(ShopEnterSO so){
		return selectListPage(BASE_DAO_PACKAGE + "pageContectList", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: ShopEnterDao.java
	* - 작성일		: 2016. 9. 06.
	* - 작성자		: muelKim
	* - 설명			: 입점문의상세
	* </pre>
	* @param so
	* @return
	*/
	public List<ShopEnterVO> listShopEnterDetail(ShopEnterSO so){
		return selectList(BASE_DAO_PACKAGE + "listShopEnterDetail", so);
	}
	
	public List<ShopEnterFileVO> listShopEnterFile(ShopEnterFileSO sefso){
		return selectList(BASE_DAO_PACKAGE + "listShopEnterFile", sefso);
	}
}
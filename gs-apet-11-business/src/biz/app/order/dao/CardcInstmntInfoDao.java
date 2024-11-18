package biz.app.order.dao;

import org.springframework.stereotype.Repository;

import biz.app.order.model.CardcInstmntInfoPO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.dao
* - 파일명		: CardcInstmntInfoDao.java
* - 작성일		: 2021. 4. 7.
* - 작성자		: kek01
* - 설명			: 카드사 할부 정보
* </pre>
*/
@Repository
public class CardcInstmntInfoDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "cardcInstmntInfo.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CardcInstmntInfoDao.java
	* - 작성일		: 2021. 4. 7.
	* - 작성자		: kek01
	* - 설명			: 카드사 할부 정보 등록
	* </pre>
	* @param po
	* @return
	*/
	public int mergeCardcInstmntInfo(CardcInstmntInfoPO po){
		return insert(BASE_DAO_PACKAGE + "mergeCardcInstmntInfo", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: CardcInstmntInfoDao.java
	* - 작성일		: 2021. 4. 7.
	* - 작성자		: kek01
	* - 설명			: 카드사 할부 정보 삭제
	* </pre>
	* @return
	*/
	public int deleteCardcInstmntInfo(CardcInstmntInfoPO po){
		return delete(BASE_DAO_PACKAGE + "deleteCardcInstmntInfo", po);
	}
	
}

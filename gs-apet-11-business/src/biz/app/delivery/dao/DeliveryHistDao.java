package biz.app.delivery.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.delivery.model.DeliveryHistPO;
import biz.app.delivery.model.DeliveryHistSO;
import biz.app.delivery.model.DeliveryHistVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.delivery.dao
* - 파일명		: DeliveryHistDao.java
* - 작성일		: 2017. 1. 12.
* - 작성자		: snw
* - 설명			: 배송 이력 DAO
* </pre>
*/
@Repository
public class DeliveryHistDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "deliveryHist.";
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryHistDao.java
	* - 작성일		: 2017. 1. 12.
	* - 작성자		: snw
	* - 설명			: 배송 이력 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertDeliveryHist( DeliveryHistPO po ) {
		return insert( BASE_DAO_PACKAGE + "insertDeliveryHist", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-11-business
	* - 파일명	: DeliveryHistDao.java
	* - 작성일	: 2021. 9. 8.
	* - 작성자 	: valfac
	* - 설명 		: 배송 이력 목록
	* </pre>
	*
	* @param so
	* @return
	*/
	public List<DeliveryHistVO> pageDeliveryHist( DeliveryHistSO so ) {
		return selectListPage(BASE_DAO_PACKAGE + "pageDeliveryHist", so );
	}

}

package biz.app.delivery.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.company.model.CompanySO;
import biz.app.delivery.model.DeliveryChargePolicyPO;
import biz.app.delivery.model.DeliveryChargePolicySO;
import biz.app.delivery.model.DeliveryChargePolicyVO;
import framework.common.dao.MainAbstractDao;

@Repository
public class DeliveryChargePolicyDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "deliveryChargePolicy.";

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryChargePolicyDao.java
	* - 작성일		: 2017. 3. 14.
	* - 작성자		: snw
	* - 설명			: 배송비 정책 단건 조회
	* </pre>
	* @param so
	* @return
	*/
	public DeliveryChargePolicyVO getDeliveryChargePolicy(DeliveryChargePolicySO so){
		return selectOne(BASE_DAO_PACKAGE + "getDeliveryChargePolicy", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryChargePolicyDao.java
	* - 작성일		: 2017. 3. 14.
	* - 작성자		: snw
	* - 설명			: 배송비 정책 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<DeliveryChargePolicyVO> listDeliveryChargePolicy(DeliveryChargePolicySO so) {
		return selectList( BASE_DAO_PACKAGE + "listDeliveryChargePolicy", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryChargePolicyDao.java
	* - 작성일		: 2017. 3. 14.
	* - 작성자		: snw
	* - 설명			: 배송비 정책 등록 - 승인전
	* </pre>
	* @param po
	* @return
	*/
	public int insertDeliveryChargePolicyHistory(DeliveryChargePolicyPO po) {
		return insert( BASE_DAO_PACKAGE + "insertDeliveryChargePolicyHistory", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryChargePolicyDao.java
	* - 작성일		: 2017. 3. 14.
	* - 작성자		: snw
	* - 설명			: 배송비 정책 등록 - 승인완료
	* </pre>
	* @param po
	* @return
	*/
	public int insertDeliveryChargePolicy(DeliveryChargePolicyPO po) {
		return insert( BASE_DAO_PACKAGE + "insertDeliveryChargePolicy", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryChargePolicyDao.java
	* - 작성일		: 2017. 3. 14.
	* - 작성자		: snw
	* - 설명			: 배송비 정책 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateDeliveryChargePolicy(DeliveryChargePolicyPO po) {
		return insert( BASE_DAO_PACKAGE + "updateDeliveryChargePolicy", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryChargePolicyDao.java
	* - 작성일		: 2017. 3. 14.
	* - 작성자		: snw
	* - 설명			: 배송비 정책 삭제
	* </pre>
	* @param po
	* @return
	*/
	public int deleteDeliveryChargePolicy(DeliveryChargePolicyPO po) {
		return update( BASE_DAO_PACKAGE + "deleteDeliveryChargePolicy", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryChargePolicyDao.java
	* - 작성일		: 2017. 3. 14.
	* - 작성자		: snw
	* - 설명			: 배송비 정책 이력 삭제(업데이트)
	* </pre>
	* @param po
	* @return
	*/
	public int deleteDeliveryChargePolicyHistory(DeliveryChargePolicyPO po) {
		return update( BASE_DAO_PACKAGE + "deleteDeliveryChargePolicyHistory", po);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.delivery.dao
	* - 파일명      : DeliveryChargePolicyDao.java
	* - 작성일      : 2017. 5. 11.
	* - 작성자      : valuefactory 권성중
	* - 설명      :홈 > 업체 관리 > 업체 정책 변경 관리
	* </pre>
	 */
	public List<DeliveryChargePolicyVO> pageDeliveryChargePolicyHistory(CompanySO so) {
		return selectListPage( BASE_DAO_PACKAGE + "pageDeliveryChargePolicyHistory", so);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.delivery.dao
	* - 파일명      : DeliveryChargePolicyDao.java
	* - 작성일      : 2017. 5. 11.
	* - 작성자      : valuefactory 권성중
	* - 설명      :홈 > 업체 관리 > 업체 정책 변경 관리 상세
	* </pre>
	 */
	public DeliveryChargePolicyVO getDeliveryChargePolicyHistory(DeliveryChargePolicySO so){
		return selectOne(BASE_DAO_PACKAGE + "getDeliveryChargePolicyHistory", so);
	}
	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.delivery.dao
	* - 파일명      : DeliveryChargePolicyDao.java
	* - 작성일      : 2017. 5. 11.
	* - 작성자      : valuefactory 권성중
	* - 설명      :홈 > 업체 관리 > 업체 정책 변경 관리   승인
	* </pre>
	 */
	public int updateDeliveryChargePolicyHistory(DeliveryChargePolicyPO po) {
		return insert( BASE_DAO_PACKAGE + "updateDeliveryChargePolicyHistory", po);
	}
}

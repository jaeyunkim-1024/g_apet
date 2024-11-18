package biz.app.delivery.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.company.model.CompanySO;
import biz.app.delivery.dao.DeliveryChargePolicyDao;
import biz.app.delivery.model.DeliveryChargePolicyPO;
import biz.app.delivery.model.DeliveryChargePolicySO;
import biz.app.delivery.model.DeliveryChargePolicyVO;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.delivery.service
* - 파일명		: DeliveryChargePolicyServiceImpl.java
* - 작성일		: 2017. 3. 14.
* - 작성자		: snw
* - 설명			: 배송비 정책 서비스 Impl
* </pre>
*/
@Slf4j
@Transactional
@Service("deliveryChargePolicyService")
public class DeliveryChargePolicyServiceImpl implements DeliveryChargePolicyService {

	@Autowired private DeliveryChargePolicyDao deliveryChargePolicyDao;

	/*
	 * 배송비 정책 목록 조회
	 * @see biz.app.delivery.service.DeliveryChargePolicyService#listDeliveryChargePolicy(biz.app.delivery.model.DeliveryChargePolicySO)
	 */
	@Override
	public List<DeliveryChargePolicyVO> listDeliveryChargePolicy(DeliveryChargePolicySO so) {
		return this.deliveryChargePolicyDao.listDeliveryChargePolicy(so);
	}

	/*
	 * 배송비 정책 상세 조회
	 * @see biz.app.delivery.service.DeliveryChargePolicyService#getDeliveryChargePolicy(biz.app.delivery.model.DeliveryChargePolicySO)
	 */
	@Override
	public DeliveryChargePolicyVO getDeliveryChargePolicy(DeliveryChargePolicySO so) {
		return this.deliveryChargePolicyDao.getDeliveryChargePolicy(so);
	}

	@Override
	public int deleteDeliveryChargePolicy(DeliveryChargePolicyPO po){
		// 1. 배송정책 기본 테이블 정보 업데이트
		this.deliveryChargePolicyDao.deleteDeliveryChargePolicy(po);

		// 2. 배송정책 이력 테이블 정보 업데이트
		return this.deliveryChargePolicyDao.deleteDeliveryChargePolicyHistory(po);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.delivery.service
	* - 파일명      : DeliveryChargePolicyServiceImpl.java
	* - 작성일      : 2017. 5. 11.
	* - 작성자      : valuefactory 권성중
	* - 설명      :홈 > 업체 관리 > 업체 정책 변경 관리
	* </pre>
	 */
	@Override
	public List<DeliveryChargePolicyVO> pageDeliveryChargePolicyHistory(CompanySO so) {
		return this.deliveryChargePolicyDao.pageDeliveryChargePolicyHistory(so);
	}
/**
 *
* <pre>
* - 프로젝트명   : 11.business
* - 패키지명   : biz.app.delivery.service
* - 파일명      : DeliveryChargePolicyServiceImpl.java
* - 작성일      : 2017. 5. 11.
* - 작성자      : valuefactory 권성중
* - 설명      :홈 > 업체 관리 > 업체 정책 변경 관리  상세보기
* </pre>
 */
	@Override
	public DeliveryChargePolicyVO getDeliveryChargePolicyHistory(DeliveryChargePolicySO so) {
		return this.deliveryChargePolicyDao.getDeliveryChargePolicyHistory(so);
	}
}


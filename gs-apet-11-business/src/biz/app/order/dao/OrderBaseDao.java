package biz.app.order.dao;

import org.springframework.stereotype.Repository;

import biz.app.order.model.OrderBasePO;
import biz.app.order.model.OrderBaseSO;
import biz.app.order.model.OrderBaseVO;
import framework.common.constants.CommonConstants;
import framework.common.dao.MainAbstractDao;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.order.dao
 * - 파일명		: OrderBaseDao.java
 * - 작성일		: 2017. 1. 9.
 * - 작성자		: snw
 * - 설명		: 주문 기본 DAO
 * </pre>
 */
@Repository
public class OrderBaseDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "orderBase.";

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderBaseDao.java
	 * - 작성일		: 2017. 1. 31.
	 * - 작성자		: snw
	 * - 설명		: 주문번호 생성
	 * </pre>
	 * 
	 * @return
	 */
	public String getOrderNo() {
		return selectOne(BASE_DAO_PACKAGE + "getOrderNo");
	}

	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderBaseDao.java
	 * - 작성일		: 2017. 1. 13.
	 * - 작성자		: snw
	 * - 설명		: 주문 기본 등록
	 * </pre>
	 * 
	 * @param po
	 * @return
	 */
	public int insertOrderBase(OrderBasePO po) {
		if (po.getOrdrTel() != null && !"".equals(po.getOrdrTel())) {
			po.setOrdrTel(po.getOrdrTel().replaceAll("-", ""));
		}
		if (po.getOrdrMobile() != null && !"".equals(po.getOrdrMobile())) {
			po.setOrdrMobile(po.getOrdrMobile().replaceAll("-", ""));
		}
		
		return insert(BASE_DAO_PACKAGE + "insertOrderBase", po);
	}

	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderBaseDao.java
	 * - 작성일		: 2017. 1. 9.
	 * - 작성자		: snw
	 * - 설명		: 주문 기본 단건 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	public OrderBaseVO getOrderBase(OrderBaseSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getOrderBase", so);
	}

	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderBaseDao.java
	 * - 작성일		: 2017. 1. 31.
	 * - 작성자		: snw
	 * - 설명		: 주문 기본 수정
	 * </pre>
	 * 
	 * @param po
	 * @return
	 */
	public int updateOrderBase(OrderBasePO po) {

		// 주문상태가 접수일 경우 접수일자 등록 처리
		if (CommonConstants.ORD_STAT_10.equals(po.getOrdStatCd())) {
			po.setOrdAcptDtmYn(CommonConstants.COMM_YN_Y);
		}

		// 주문상태가 완료일 경우 완료일자 등록 처리
		if (CommonConstants.ORD_STAT_20.equals(po.getOrdStatCd())) {
			po.setOrdAcptDtmYn(CommonConstants.COMM_YN_Y);
			po.setOrdCpltDtmYn(CommonConstants.COMM_YN_Y);
		}

		return update(BASE_DAO_PACKAGE + "updateOrderBase", po);
	}
	

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: OrderBaseDao.java
	 * - 작성일		: 
	 * - 작성자		: snw
	 * - 설명		: 주문 기본 수정
	 * </pre>
	 * 
	 * @param po
	 * @return
	 */
	public int updateOrderBaseStatus(OrderBasePO po) {		

		return update(BASE_DAO_PACKAGE + "updateOrderBaseStatus", po);
	}

}

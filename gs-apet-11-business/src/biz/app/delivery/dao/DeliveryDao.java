package biz.app.delivery.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.delivery.model.DeliveryListVO;
import biz.app.delivery.model.DeliveryPO;
import biz.app.delivery.model.DeliverySO;
import biz.app.delivery.model.DeliveryVO;
import biz.app.order.model.OrdDtlCstrtDlvrMapPO;
import biz.app.order.model.OrderSO;
import biz.interfaces.goodsflow.model.request.data.DeliveryGoodsSO;
import biz.interfaces.goodsflow.model.request.data.DeliveryGoodsVO;
import biz.interfaces.goodsflow.model.response.data.DlvrGoodsFlowMapPO;
import biz.interfaces.goodsflow.model.response.data.GoodsFlowDeliveryPO;
import biz.interfaces.goodsflow.model.response.data.GoodsFlowDeliveryResultPO;
import framework.common.dao.MainAbstractDao;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.delivery.dao
* - 파일명		: DeliveryDao.java
* - 작성일		: 2017. 1. 12.
* - 작성자		: snw
* - 설명			: 배송 DAO
 * </pre>
 */
@Repository
public class DeliveryDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "delivery.";

	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryDao.java
	* - 작성일		: 2017. 1. 12.
	* - 작성자		: snw
	* - 설명			: 배송정보 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	public DeliveryVO getDelivery(DeliverySO so) {
		return (DeliveryVO) selectOne(BASE_DAO_PACKAGE + "getDelivery", so);
	}

	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryDao.java
	* - 작성일		: 2017. 3. 10.
	* - 작성자		: kek01
	* - 설명			: 배송정보 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	public List<DeliveryVO> listDelivery(DeliverySO so) {
		return selectList(BASE_DAO_PACKAGE + "listDelivery", so);
	}
	
	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryDao.java
	* - 작성일		: 2017. 1. 12.
	* - 작성자		: snw
	* - 설명			: 배송 정보 수정
	 * </pre>
	 * 
	 * @param po
	 * @return
	 */
	public int updateDelivery(DeliveryPO po) {
		return update(BASE_DAO_PACKAGE + "updateDelivery", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.app.delivery.dao
	 * - 작성일		: 2021. 03. 19.
	 * - 작성자		: JinHong
	 * - 설명		: 배송 정보수정 - 주문번호, 주문상세번호
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateDeliveryOrder(DeliveryPO po) {
		return update(BASE_DAO_PACKAGE + "updateDeliveryOrder", po);
	}
	
	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryDao.java
	* - 작성일		: 2017. 1. 12.
	* - 작성자		: snw
	* - 설명			: 배송 정보 등록
	 * </pre>
	 * 
	 * @param po
	 * @return
	 */
	public int insertDelivery(DeliveryPO po) {
		return insert(BASE_DAO_PACKAGE + "insertDelivery", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DeliveryDao.java
	 * - 작성일		: 2021. 4. 2.
	 * - 작성자		: kek01
	 * - 설명		: 배송 정보 복사
	 * </pre>
	 * 
	 * @param po
	 * @return
	 */
	public int insertDeliveryCopy(OrdDtlCstrtDlvrMapPO po) {
		return insert(BASE_DAO_PACKAGE + "insertDeliveryCopy", po);
	}

	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryDao.java
	* - 작성일		: 2017. 3. 10.
	* - 작성자		: snw
	* - 설명			: 배송관련 주문/클레임 목록 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	public List<DeliveryVO> listDeliveryOrderClaim(DeliverySO so) {
		return selectList(BASE_DAO_PACKAGE + "listDeliveryOrderClaim", so);
	}
	
	
	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryDao.java
	* - 작성일		: 2021. 4. 25.
	* - 작성자		: ssmvf01
	* - 설명			: 배송완료된 주문/클레임 목록
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	public List<DeliveryVO> listDeliveryInDlvrCpltYFromOrderClaim(DeliverySO so) {
		return selectList(BASE_DAO_PACKAGE + "listDeliveryInDlvrCpltYFromOrderClaim", so);
	}
	

	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryDao.java
	* - 작성일		: 2017. 6. 13.
	* - 작성자		: Administrator
	* - 설명			: 배송 목록 조회(페이징)
	 * </pre>
	 * 
	 * @param orderSO
	 * @return
	 */
	public List<DeliveryListVO> pageDeliveryList(OrderSO orderSO) {
		return selectListPage("delivery.pageDeliveryList", orderSO);
	}

	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryDao.java
	* - 작성일		: 2017. 6. 15.
	* - 작성자		: WilLee
	* - 설명			: 굿스플로 배송 연동 가능 여부 조회
	 * </pre>
	 * 
	 * @param dlvrNo
	 * @return
	 */
	public String getFlagGoodsFlowDelivery(Long dlvrNo) {
		return (String) selectOne(BASE_DAO_PACKAGE + "getFlagGoodsFlowDelivery", dlvrNo);
	}

	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryDao.java
	* - 작성일		: 2017. 6. 14.
	* - 작성자		: WilLee
	* - 설명			: 굿스플로 배송 정보 조회
	 * </pre>
	 * 
	 * @param dlvrNo
	 * @return
	 */
	public biz.interfaces.goodsflow.model.request.data.DeliveryVO getGoodsFlowDelivery(Long dlvrNo) {
		return (biz.interfaces.goodsflow.model.request.data.DeliveryVO) selectOne(BASE_DAO_PACKAGE + "getGoodsFlowDelivery", dlvrNo);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DeliveryDao.java
	 * - 작성일		: 2017. 6. 14.
	 * - 작성자		: WilLee
	 * - 설명		: 굿스플로 배송 정보 조회 (교환 재배송)
	 * </pre>
	 * 
	 * @param dlvrNo
	 * @return
	 */
	public biz.interfaces.goodsflow.model.request.data.DeliveryVO getGoodsFlowDeliveryClaim(Long dlvrNo) {
		return (biz.interfaces.goodsflow.model.request.data.DeliveryVO) selectOne(BASE_DAO_PACKAGE + "getGoodsFlowDeliveryClaim", dlvrNo);
	}
	
	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryDao.java
	* - 작성일		: 2017. 6. 15.
	* - 작성자		: WilLee
	* - 설명			: 굿스플로 회수 정보 조회
	 * </pre>
	 * 
	 * @param dlvrNo
	 * @return
	 */
	public biz.interfaces.goodsflow.model.request.data.DeliveryVO getGoodsFlowReturn(Long dlvrNo) {
		return (biz.interfaces.goodsflow.model.request.data.DeliveryVO) selectOne(BASE_DAO_PACKAGE + "getGoodsFlowReturn", dlvrNo);
	}

	/**
	 * 
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryDao.java
	* - 작성일		: 2017. 6. 14.
	* - 작성자		: WilLee
	* - 설명			: 굿스플로 배송 상품 정보 조회
	 * </pre>
	 * 
	 * @param dlvrNo
	 * @return
	 */
	public List<DeliveryGoodsVO> getGoodsFlowDeliveryGoods(DeliveryGoodsSO so) {
		return selectList(BASE_DAO_PACKAGE + "getGoodsFlowDeliveryGoods", so);
	}

	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryDao.java
	* - 작성일		: 2017. 6. 15.
	* - 작성자		: WilLee
	* - 설명			: 굿스플로 회수 상품 정보 조회
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	public List<DeliveryGoodsVO> getGoodsFlowReturnGoods(DeliveryGoodsSO so) {
		return selectList(BASE_DAO_PACKAGE + "getGoodsFlowReturnGoods", so);
	}

	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryDao.java
	* - 작성일		: 2017. 6. 14.
	* - 작성자		: WilLee
	* - 설명			: 굿스플로 배송 저장
	 * </pre>
	 * 
	 * @param po
	 * @return
	 */
	public int insertGoodsFlowDelivery(GoodsFlowDeliveryPO po) {
		return insert(BASE_DAO_PACKAGE + "insertGoodsFlowDelivery", po);
	}
	
	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryDao.java
	* - 작성일		: 2017. 6. 14.
	* - 작성자		: WilLee
	* - 설명			: 굿스플로 배송 저장
	 * </pre>
	 * 
	 * @param po
	 * @return
	 */
	public int saveGoodsFlowDelivery(GoodsFlowDeliveryPO po) {
		return insert(BASE_DAO_PACKAGE + "saveGoodsFlowDelivery", po);
	}
	
	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryDao.java
	* - 작성일		: 2017. 6. 14.
	* - 작성자		: WilLee
	* - 설명			: 굿스플로 배송 저장
	 * </pre>
	 * 
	 * @param po
	 * @return
	 */
	public int saveDlvrGoodsFlowMap(DlvrGoodsFlowMapPO po) {
		return insert(BASE_DAO_PACKAGE + "saveDlvrGoodsFlowMap", po);
	}

	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryDao.java
	* - 작성일		: 2017. 6. 23.
	* - 작성자		: WilLee
	* - 설명			: 굿스폴로 배송 결과 저장
	 * </pre>
	 * 
	 * @param po
	 * @return
	 */
	public int insertGoodsFlowDeliveryResult(GoodsFlowDeliveryResultPO po) {
		return insert(BASE_DAO_PACKAGE + "insertGoodsFlowDeliveryResult", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryDao.java
	* - 작성일		: 2017. 6. 23.
	* - 작성자		: WilLee
	* - 설명			: 배송 번호 조회
	* </pre>
	* @param itemUniqueCode
	* @return
	 */
	public Long getDeliveryNoByItemUniqueCode(String itemUniqueCode) {
		return (Long) selectOne(BASE_DAO_PACKAGE + "getDeliveryNoByItemUniqueCode", itemUniqueCode);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryDao.java
	* - 작성일		: 2017. 6. 23.
	* - 작성자		: WilLee
	* - 설명			: 배송 번호 조회
	* </pre>
	* @param itemUniqueCode
	* @return
	 */
	public List<Long> getDeliveryNoByItemUniqueCodeList(String itemUniqueCode) {
		return selectList(BASE_DAO_PACKAGE + "getDeliveryNoByItemUniqueCodeList", itemUniqueCode);
	}

	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryDao.java
	* - 작성일		: 2017. 6. 15.
	* - 작성자		: 
	* - 설명		: 굿스플로 배송 조회 링크를 위한 고유번호 조회 (FO,MO 사용)
	 * </pre>
	 * 
	 * @param so
	 * @return
	 */
	public DeliveryVO getGoodsFlowCode(OrderSO orderSO) {
		return selectOne(BASE_DAO_PACKAGE + "getGoodsFlowCode", orderSO);
	}
	
	/**
	 * <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryDao.java
	* - 작성일		: 2019. 7. 1.
	* - 작성자		: siete
	* - 설명		: 굿스플로 배송 연동 등록 대상 조회
	 * </pre>
	 *
	 * @param dlvrNo
	 * @return
	 */
	public List<DeliveryVO> getGoodsFlowRequestTraceList(DeliverySO so){
		return selectList(BASE_DAO_PACKAGE + "getGoodsFlowRequestTraceList", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DeliveryDao.java
	 * - 작성일		: 2021. 04. 22.
	 * - 작성자		: ssmvf01
	 * - 설명		: 굿스플로 연동을 위한 배송 번호 조회
	 * </pre>
	 * @return
	 */
	public List<Integer> getDlvrNoForGoodsFlowTraceList() {
		return selectList(BASE_DAO_PACKAGE + "getDlvrNoForGoodsFlowTraceList");
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DeliveryDao.java
	 * - 작성일		: 2021. 04. 22.
	 * - 작성자		: ssmvf01
	 * - 설명		: 굿스플로 연동 데이타 조회
	 * </pre>
	 * @return
	 */
	public List<biz.interfaces.goodsflow.model.request.data.DeliveryVO> getGoodsFlowForTraceList(Integer dlvrNo) {
		return selectList(BASE_DAO_PACKAGE + "getGoodsFlowForTraceList", dlvrNo);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DeliveryDao.java
	 * - 작성일		: 2021. 09. 02.
	 * - 작성자		: ksy02
	 * - 설명		: 위탁업체 배송 안내 알림톡 발송
	 * </pre>
	 * @return
	 */
	public List<biz.app.delivery.model.DeliveryVO> listDeliveryConsignComp(biz.app.delivery.model.DeliveryVO so) {
		return selectList(BASE_DAO_PACKAGE + "listDeliveryConsignComp", so);
	}
}

package biz.app.order.service.interfaces;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.claim.dao.ClaimBaseDao;
import biz.app.claim.dao.ClaimDetailDao;
import biz.app.claim.dao.ClmDtlCstrtDao;
import biz.app.claim.dao.ClmDtlCstrtDlvrMapDao;
import biz.app.claim.model.ClaimBasePO;
import biz.app.claim.model.ClaimDetailPO;
import biz.app.claim.model.ClmDtlCstrtDlvrMapPO;
import biz.app.claim.model.ClmDtlCstrtPO;
import biz.app.delivery.dao.DeliveryDao;
import biz.app.delivery.dao.DeliveryHistDao;
import biz.app.delivery.model.DeliveryHistPO;
import biz.app.delivery.model.DeliveryPO;
import biz.app.delivery.model.DeliverySO;
import biz.app.delivery.model.DeliveryVO;
import biz.app.order.dao.OrdDtlCstrtDao;
import biz.app.order.dao.OrdDtlCstrtDlvrMapDao;
import biz.app.order.dao.OrderDetailDao;
import biz.app.order.model.OrdDtlCstrtDlvrMapPO;
import biz.app.order.model.OrdDtlCstrtDlvrMapSO;
import biz.app.order.model.OrdDtlCstrtPO;
import biz.app.order.model.OrderDetailPO;
import biz.app.order.model.interfaces.CisOrderDeliveryCmdVO;
import biz.app.order.model.interfaces.CisOrderDeliveryStateChgVO;
import biz.app.order.service.OrderService;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import biz.interfaces.cis.model.request.order.OrderInsertItemPO;
import biz.interfaces.cis.model.response.order.OrderInquiryExptVO;
import biz.interfaces.cis.model.response.order.OrderInquiryItemVO;
import biz.interfaces.cis.model.response.order.OrderInsertItemVO;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.service.interfaces.ob
* - 파일명		: CisOrderDeliveryServiceImpl.java
* - 작성일		: 2020. 2. 2.
* - 작성자		: kek01
* - 설명			: CIS 배송 서비스 Impl
* </pre>
*/
@Slf4j
@Service
@Transactional
public class CisOrderDeliveryServiceImpl implements CisOrderDeliveryService {

	@Autowired private BizService bizService;
	@Autowired private DeliveryDao deliveryDao;
	@Autowired private OrderDetailDao orderDetailDao;
	@Autowired private OrdDtlCstrtDao ordDtlCstrtDao;
	@Autowired private OrdDtlCstrtDlvrMapDao ordDtlCstrtDlvrMapDao;
	@Autowired private ClaimDetailDao claimDetailDao;
	@Autowired private ClmDtlCstrtDao clmDtlCstrtDao;
	@Autowired private ClaimBaseDao claimBaseDao;
	@Autowired private ClmDtlCstrtDlvrMapDao clmDtlCstrtDlvrMapDao;
	@Autowired Properties bizConfig;
	@Autowired private CacheService cacheService;
	@Autowired private OrderService orderService;
	@Autowired private DeliveryHistDao deliveryHistDao;
	
	
	/** CIS 배송지시 대상 주문 조회 */
	@Override
	public List<CisOrderDeliveryCmdVO> listCisDeliveryCmd() {
		OrdDtlCstrtPO po = new OrdDtlCstrtPO();
		po.setCisApiOwnrCd(bizConfig.getProperty("cis.api.goods.ownrCd"));
		po.setCisApiWareCd(bizConfig.getProperty("cis.api.goods.wareCd"));
		return ordDtlCstrtDao.listOrdDtlCstrtForSendCis(po);
	}

	
	/** CIS 배송지시 후처리 DB변경 */
	@Override
	@Transactional
	public int updateCisDeliveryCmdAfter(List<OrderInsertItemVO> resItems, String dlvrPrcsTpCd, Long ordDlvraNo, String clmDlvrYn, List<OrderInsertItemPO> paramItems) {

		int count = 0;
		Long newDlvrNo = 0L;		//배송번호
		int  currOrdCstrtSeq = 0;	//주문구성순번
		
		for(OrderInsertItemPO opo : paramItems) {
			
			// 응답받은 값이 있을 경우 insert로 변경 2021.07.08
			if(resItems.stream().anyMatch(resItem -> resItem.getShopOrdrNo().equals(opo.getShopOrdrNo())
					&& StringUtils.isNotEmpty(resItem.getShopSortNo())
					&&  ObjectUtils.equals(Integer.parseInt(StringUtil.split(opo.getShopSortNo(), "_")[0]), Integer.parseInt(StringUtil.split(resItem.getShopSortNo(), "_")[0]))
					&&  ObjectUtils.equals(Integer.parseInt(StringUtil.split(opo.getShopSortNo(), "_")[1]), Integer.parseInt(StringUtil.split(resItem.getShopSortNo(), "_")[1]))
					)) {
				
				currOrdCstrtSeq = Integer.parseInt(StringUtil.split(opo.getShopSortNo(), "_")[1]);
				
				if(currOrdCstrtSeq == 1) {
					//배송 INSERT
					//----------------------------
					newDlvrNo = insertDelivery(clmDlvrYn, ordDlvraNo, opo.getDlvtTpCd());
				}
				
				if(CommonConstants.COMM_YN_N.equals(clmDlvrYn)) {
					//----------------------------
					//주문 상세 구성 배송 매핑 INSERT
					//----------------------------
					OrdDtlCstrtDlvrMapPO ordDtlCstrtDlvrMapOutPO = new OrdDtlCstrtDlvrMapPO();
					ordDtlCstrtDlvrMapOutPO.setOrdDtlCstrtNo(opo.getOrdDtlCstrtNo());
					ordDtlCstrtDlvrMapOutPO.setDlvrNo(newDlvrNo);
					ordDtlCstrtDlvrMapOutPO.setDlgtYn(CommonConstants.COMM_YN_Y);
					ordDtlCstrtDlvrMapDao.insertOrdDtlCstrtDlvrMap(ordDtlCstrtDlvrMapOutPO);
				}else {
					//----------------------------
					//클레임 상세 구성 배송 매핑 INSERT
					//----------------------------
					ClmDtlCstrtDlvrMapPO clmDtlCstrtDlvrMapSelfPO = new ClmDtlCstrtDlvrMapPO();
					clmDtlCstrtDlvrMapSelfPO.setClmDtlCstrtNo(opo.getOrdDtlCstrtNo());
					clmDtlCstrtDlvrMapSelfPO.setDlvrNo(newDlvrNo);
					clmDtlCstrtDlvrMapSelfPO.setDlgtYn(CommonConstants.COMM_YN_Y);
					clmDtlCstrtDlvrMapDao.insertClmDtlCstrtDlvrMap(clmDtlCstrtDlvrMapSelfPO);
				}
			}
		}
		
		if(CommonConstants.COMM_YN_N.equals(clmDlvrYn)) {
			for(OrderInsertItemVO resItem : resItems) {
				//----------------------------
				//주문 상세 구성 UPDATE
				//----------------------------
				OrdDtlCstrtPO po = new OrdDtlCstrtPO();
				po.setOrdNo(resItem.getShopOrdrNo());
				po.setOrdDtlSeq(Integer.parseInt(StringUtil.split(resItem.getShopSortNo(), "_")[0]));
				po.setOrdCstrtSeq(Integer.parseInt(StringUtil.split(resItem.getShopSortNo(), "_")[1]));
				
				po.setCisOrdNo(resItem.getOrdrNo());
				po.setCisOrdDtlSeq(resItem.getSortNo());
				count += ordDtlCstrtDao.updateOrdDtlCstrt(po);
				
				//----------------------------
				//주문 상세 UPDATE
				//----------------------------
				OrderDetailPO dpo = new OrderDetailPO();
				dpo.setOrdNo(resItem.getShopOrdrNo());
				dpo.setOrdDtlSeq(Integer.parseInt(StringUtil.split(resItem.getShopSortNo(), "_")[0]));
				dpo.setOrdDtlStatCd(CommonConstants.ORD_DTL_STAT_130);
				orderDetailDao.updateOrderDetail(dpo);
			}
		}else {
			for(OrderInsertItemVO resItem : resItems) {
				//----------------------------
				//클레임 상세 구성 UPDATE
				//----------------------------
				ClmDtlCstrtPO po = new ClmDtlCstrtPO();
				po.setClmNo(resItem.getShopOrdrNo());
				po.setClmDtlSeq(Integer.parseInt(StringUtil.split(resItem.getShopSortNo(), "_")[0]));
				po.setClmCstrtSeq(Integer.parseInt(StringUtil.split(resItem.getShopSortNo(), "_")[1]));
				
				po.setCisClmNo(resItem.getOrdrNo());
				po.setCisClmDtlSeq(resItem.getSortNo());
				count += clmDtlCstrtDao.updateClmDtlCstrt(po);
				
				//--------------------
				//클레임 상세 UPDATE
				//--------------------
				ClaimDetailPO dpo = new ClaimDetailPO();
				dpo.setClmNo(resItem.getShopOrdrNo());
				dpo.setClmDtlSeq(Integer.parseInt(StringUtil.split(resItem.getShopSortNo(), "_")[0]));
				dpo.setClmDtlStatCd(CommonConstants.CLM_DTL_STAT_420);
				claimDetailDao.updateClaimDetailStatus(dpo);
			}
		}
		
		return count;
	}
	
	
	/** CIS 배송 상태 변경 대상 주문 조회 */
	@Override
	public List<CisOrderDeliveryStateChgVO> listCisDeliveryStateChg() {
		return ordDtlCstrtDao.listOrdDtlCstrtForChkCisDlvrStateChg();
	}

	
//	/**
//	 * 상세구성별 모든 상품이 동일 송장번호,출고번호로 출고되었나 체크
//	 * @param vo
//	 * @param cisItems
//	 * @return
//	 */
//	public boolean exptAllOrdDtlCstrt(CisOrderDeliveryStateChgVO vo, List<OrderInquiryItemVO> cisItems) {
//		List<String> filter = new ArrayList<String>();
//		for(OrderInquiryItemVO item : cisItems) {
//			if(item.getShopOrdrNo().equals(vo.getOrdNo()) &&
//			   Integer.parseInt(StringUtil.split(item.getShopSortNo(), "_")[0]) == vo.getOrdDtlSeq()	){
//				filter.add(StringUtil.nvl(item.getCompNo(),"0")
//						  .concat("_")
//						  .concat(StringUtil.isEmpty(param.getDlvrcNo())? "0":String.valueOf(param.getDlvrcNo()))); //외부업체코드-배송비번호
//				
//			}
//		}
//		return count;
//	}
	
	/**
	 * CIS 배송 상태 변경 후처리
	 * @param vo		: 주문 상태 변경 대상 (주문 상세 구성) 단건
	 * @param cisItems	: CIS 에서 주문번호 단위로 조회한 상품들 정보
	 */
	@Override
	@Transactional
	public OrderInquiryItemVO updateCisDeliveryStateChgAfter(CisOrderDeliveryStateChgVO vo, List<OrderInquiryItemVO> cisItems) {
		OrderInquiryItemVO resultVo = null;
		
		if(cisItems != null) {
			for(OrderInquiryItemVO cisItem : cisItems) {
				/**************************************************
				 * CIS ItemList에서 (주문 상세 구성) 1건을 찾아서 처리
				 **************************************************/
				if(cisItem.getShopOrdrNo().equals(vo.getOrdNo()) && cisItem.getShopSortNo().equals(vo.getOrdDtlSeq()+"_"+vo.getOrdCstrtSeq())) {
					
					List<OrderInquiryExptVO> exptListChk = cisItem.getExptList();	//CIS ExptList 출고리스트 GET
					
					//------------------------------------------------------------------------------------------
					//2021.04.26 업무 변경 - kek01
					//당일/새벽  배송일때 dawnCmplYn=N 이면 배송중이고 dawnCmplYn=Y 이면 배송완료 이다
					//택배 배송일때 dawnCmplYn=null or "" 이면 배송중이다
					boolean isDlvrEnd = true;
					if(CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_05.equals(cisItem.getStatCd())) {
						for(OrderInquiryExptVO exptVO : exptListChk) {
							if(exptVO.getDawnCmplYn() == null || "".equals(exptVO.getDawnCmplYn()) || "N".equals(exptVO.getDawnCmplYn())) {
								isDlvrEnd = false;
							}
						}
						if(exptListChk == null) {
							isDlvrEnd = false;
						}else {
							if(exptListChk.size() == 0) {
								isDlvrEnd = false;
							}
						}
					}else {
						isDlvrEnd = false;
					}
					if(CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_05.equals(cisItem.getStatCd())) {
						if(!isDlvrEnd) {
							cisItem.setStatCd(CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_04); //출고확정(배송중) 수동으로 SET
						}
					}
					//------------------------------------------------------------------------------------------
					//클레임일때 배송완료로 수신된 경우, 회수상태가 360:교환회수승인완료 or 350:교환회수거부완료 가 아니면 배송완료로 UPDATE 치지 않는다 - 2021.05.21 kek01 (유준희 요청)
//					if(CommonConstants.COMM_YN_Y.equals(vo.getClmDlvrYn())) {
//						if(cisItem.getStatCd().equals(CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_05)) {
//							ClaimDetailSO cdso = new ClaimDetailSO();
//							cdso.setClmNo(vo.getOrdNo());
//							cdso.setOrdNo(vo.getClmOrdNo());
//							cdso.setOrdDtlSeq(vo.getClmOrdDtlSeq());
//							cdso.setClmDtlTpCd(CommonConstants.CLM_DTL_TP_30);
//							List<ClaimDetailVO> cdvoList = claimDetailDao.listClaimDetail(cdso);
//							
//							for(ClaimDetailVO cdvo : cdvoList) {
//								if(CommonConstants.CLM_DTL_STAT_350.equals(cdvo.getClmDtlStatCd()) || CommonConstants.CLM_DTL_STAT_360.equals(cdvo.getClmDtlStatCd())) {
//								}else {
//									cisItem.setStatCd(CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_04); //출고확정(배송중) 수동으로 SET
//									break;
//								}
//							}
//							
//						}
//					}
					
					
					//------------------------------------------------------------------------------------------
					//CIS 상태코드 변경 안된 경우 SKIP
					if(!isModifiedCisState(cisItem.getStatCd(), vo.getOrdDtlStatCd(), vo.getClmDlvrYn())) {
						log.info("### CIS 상태코드 변경 안된 경우 SKIP : "+vo.getOrdNo()+" , "+vo.getOrdDtlSeq()+" , "+vo.getOrdCstrtSeq());
						return null;
					}
					
					//출고확정(배송중) / 배송완료 상태인데 출고정보(송장번호)가 없으면 SKIP 한다 - 2021.04.18 긴급배포
					if(CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_04.equals(cisItem.getStatCd()) || CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_05.equals(cisItem.getStatCd())) {
						if(exptListChk == null) {
							log.info("### 출고확정 / 배송완료 상태인데 출고정보가 Null 이면 SKIP : "+vo.getOrdNo()+" , "+vo.getOrdDtlSeq()+" , "+vo.getOrdCstrtSeq());
							return null;
						}else {
							if(exptListChk.size() == 0) {
								log.info("### 출고확정 / 배송완료 상태인데 출고정보 건수가 0 이면 SKIP : "+vo.getOrdNo()+" , "+vo.getOrdDtlSeq()+" , "+vo.getOrdCstrtSeq());
								return null;
							}
							for(OrderInquiryExptVO exptVO : exptListChk) {
								if(exptVO.getInvcNo() == null || "".equals(exptVO.getInvcNo())) {
									log.info("### 출고확정 / 배송완료 상태인데 출고정보 송장번호가 없으면 SKIP : "+vo.getOrdNo()+" , "+vo.getOrdDtlSeq()+" , "+vo.getOrdCstrtSeq());
									return null;
								}
							}
						}
					}
					
					
					int countDtlCstrt = getCountOrdDtlCstrt(vo, cisItems);		//단건상품 or 세트/사은품 여부 체크
					List<OrderInquiryExptVO> exptList = cisItem.getExptList();	//CIS ExptList 출고리스트 GET
					boolean isProcess = isExptUpdate(vo.getOrdDtlStatCd(), cisItem.getStatCd(), vo.getClmDlvrYn());
					
					// CSR-1533 배송지시 시 중복으로 들어간 ordDtlCstrtDlvrMap 삭제 후 다시 insert 처리 (대표 번호 제외 삭제 처리)
					if(isProcess && exptList != null && StringUtils.isNotEmpty(vo.getDlvrNos()) && StringUtils.isNotEmpty(vo.getOrdNo()) && vo.getOrdDtlSeq() > 0 && vo.getOrdCstrtSeq() < Integer.valueOf(2)) {
						orderService.deleteOrdDtlCstrtDlvrMap(vo.getOrdNo(), Long.valueOf(vo.getOrdDtlSeq()));
						log.info("### deleteOrdDtlCstrtDlvrMap (배송 대표 번호 제외 삭제 처리) : "+vo.getOrdNo()+" , "+vo.getOrdDtlSeq());
					}
					
					//단건 상품일때
					if(countDtlCstrt == 1) {
						if(isProcess && exptList != null) {
							int exptCnt = 1;
							for(OrderInquiryExptVO exptVO : exptList) {
								//-------------------------------------------
								//배송, 주문(클레임)상세구성배송매핑 테이블 저장
								//-------------------------------------------
								saveDeliveryAndOrdDtlCstrtDlvrMap(exptCnt, (exptCnt == 1)? true:false, vo, exptVO, 0L);
								exptCnt++;
							}
						}
						//-------------------------------------------
						//주문(클레임)상세구성, 주문(클레임)상세 테이블 저장
						//-------------------------------------------
						resultVo = saveOrdDtlCstrtAndOrdDtl(vo, cisItem, exptList);

					}else {
//우선은 적용하지 않는다 복잡 - 2021.04.18 
//						//세트상품끼리 송장번호가 모두 동일여부 체크 
//						boolean isSameAllInvcNoOfSetGoods = getSameAllInvcNoOfSetGoods(vo, cisItems); 
						
						
						
						//-----------------------------------------------------------------------------------------------------------------------						
						//배송정보 조회
						List<DeliveryVO> dlvrList = listDelivery(CommonConstants.COMM_YN_N.equals(vo.getClmDlvrYn())? vo.getOrdNo():null,
												CommonConstants.COMM_YN_N.equals(vo.getClmDlvrYn())? vo.getOrdDtlSeq():0,
								                CommonConstants.COMM_YN_Y.equals(vo.getClmDlvrYn())? vo.getOrdNo():null,
								                CommonConstants.COMM_YN_Y.equals(vo.getClmDlvrYn())? vo.getOrdDtlSeq():0);
						
						//현재 배송번호(배송지시때 생성한 원 배송번호)가 다른 상세랑 매핑된것이 있나 체크
						OrdDtlCstrtDlvrMapSO so = new OrdDtlCstrtDlvrMapSO();
						so.setClmDlvrYn(vo.getClmDlvrYn());
						so.setOrdNo(vo.getOrdNo());
						so.setOrdDtlSeq(vo.getOrdDtlSeq());
						so.setOrdDtlCstrtNo(vo.getOrdDtlCstrtNo());
						so.setDlvrNo(Long.parseLong(StringUtil.split(vo.getDlvrNos(), ",")[0]));
						int dlvrNoOtherMapCount = ordDtlCstrtDlvrMapDao.getDlvrNoUseCount(so);
						
						if(isProcess && exptList != null) {
							int exptCnt = 1;
							boolean existDlvrNoUse = true;
							DeliveryVO dlvrSameVo = null;
							
							for(OrderInquiryExptVO exptVO : exptList) {						
								dlvrSameVo = findSameDlvr(exptVO, dlvrList);	//CIS 응답 송장번호 로 동일 배송정보가 존재여부 체크
								
								if(dlvrSameVo.getDlvrNo() == null) {			//동일 배송정보 미존재시
									//-------------------------------------------
									//배송, 주문(클레임)상세구성배송매핑 테이블 INSERT
									//-------------------------------------------
									if(dlvrNoOtherMapCount == 0) { //현재 배송번호로 다른 매핑이 없으므로, 현재 배송번호로 UPDATE
										saveDeliveryAndOrdDtlCstrtDlvrMap(exptCnt, (existDlvrNoUse)? true:false, vo, exptVO, 0L); //배송 UPDATE  //주문 상세 구성 배송 매핑 UPDATE
										existDlvrNoUse = false;
									}else {
										saveDeliveryAndOrdDtlCstrtDlvrMap(exptCnt, false, vo, exptVO, 0L);
									}
								}else {
									//-------------------------------------------
									//배송, 주문(클레임)상세구성배송매핑 테이블 INSERT
									//-------------------------------------------
									saveDeliveryAndOrdDtlCstrtDlvrMap(exptCnt, false, vo, exptVO, dlvrSameVo.getDlvrNo()); //주문 상세 구성 배송 매핑 INSERT 실행 (exptCnt==1:UPDATE, 그외:INSERT)
								}
								exptCnt++;
							}
						}
						//-------------------------------------------
						//주문(클레임)상세구성, 주문(클레임)상세 테이블 저장
						//-------------------------------------------
						resultVo = saveOrdDtlCstrtAndOrdDtl(vo, cisItem, exptList);
					}
					break;
				} //end-if
			}//end-for
			
		}
		
		return resultVo;
	}

	/**
	 * 배송정보 조회
	 */
	@Override
	public List<DeliveryVO> listDelivery(String ordNo, int ordDtlSeq, String clmNo, int clmDtlSeq) {
		DeliverySO so = new DeliverySO();
		so.setOrdNo(ordNo);
		so.setOrdDtlSeq(ordDtlSeq);
		so.setClmNo(clmNo);
		so.setClmDtlSeq(clmDtlSeq);
		return deliveryDao.listDelivery(so);
	}
	
	
	/**
	 * 주문(클레임) 상세 구성 배송 매핑 테이블 변경
	 * @param vo
	 * @param exptCnt
	 * @param myDlvrNo
	 * @param cisDlvEa
	 */
	public void modifyOrdDtlCstrtDlvrMapTbl(CisOrderDeliveryStateChgVO vo, int exptCnt, Long myDlvrNo, Long cisDlvEa, Long newDlvrNo) {
		if(CommonConstants.COMM_YN_N.equals(vo.getClmDlvrYn())){
			//---------------------------------------
			//주문 상세 구성 배송 매핑 UPDATE or INSERT
			//---------------------------------------
			OrdDtlCstrtDlvrMapPO ordDtlCstrtDlvrMapPO = new OrdDtlCstrtDlvrMapPO();
			ordDtlCstrtDlvrMapPO.setOrdDtlCstrtNo(vo.getOrdDtlCstrtNo());
			ordDtlCstrtDlvrMapPO.setCisOoQty(cisDlvEa); //CIS 출고 수량
			
			if(exptCnt == 1) { //exptList의 첫번째 항목
				//UPDATE
				ordDtlCstrtDlvrMapPO.setDlvrNo(myDlvrNo);
				ordDtlCstrtDlvrMapPO.setNewDlvrNo(newDlvrNo);
				ordDtlCstrtDlvrMapPO.setDlgtYn(CommonConstants.COMM_YN_Y); //대표여부
				ordDtlCstrtDlvrMapDao.updateOrdDtlCstrtDlvrMap(ordDtlCstrtDlvrMapPO);
			}else{
				//INSERT
				ordDtlCstrtDlvrMapPO.setDlvrNo(newDlvrNo);
				ordDtlCstrtDlvrMapPO.setDlgtYn(CommonConstants.COMM_YN_N);
				ordDtlCstrtDlvrMapDao.insertOrdDtlCstrtDlvrMap(ordDtlCstrtDlvrMapPO);
			}
		}else{
			//---------------------------------------
			//클레임 상세 구성 배송 매핑 UPDATE or INSERT
			//---------------------------------------
			ClmDtlCstrtDlvrMapPO clmDtlCstrtDlvrMapPO = new ClmDtlCstrtDlvrMapPO();
			clmDtlCstrtDlvrMapPO.setClmDtlCstrtNo(vo.getOrdDtlCstrtNo());
			clmDtlCstrtDlvrMapPO.setCisOoQty(cisDlvEa); //CIS 출고 수량
			
			if(exptCnt == 1) {
				//UPDATE
				clmDtlCstrtDlvrMapPO.setDlvrNo(myDlvrNo);
				clmDtlCstrtDlvrMapPO.setNewDlvrNo(newDlvrNo);
				clmDtlCstrtDlvrMapPO.setDlgtYn(CommonConstants.COMM_YN_Y); //대표여부
				clmDtlCstrtDlvrMapDao.updateClmDtlCstrtDlvrMap(clmDtlCstrtDlvrMapPO);
			}else{
				//INSERT
				clmDtlCstrtDlvrMapPO.setDlvrNo(newDlvrNo);
				clmDtlCstrtDlvrMapPO.setDlgtYn(CommonConstants.COMM_YN_N);
				clmDtlCstrtDlvrMapDao.insertClmDtlCstrtDlvrMap(clmDtlCstrtDlvrMapPO);
			}
		}
	}
	
	/**
	 * 
	 * @param isUpdate
	 * @param vo
	 * @param exptVO
	 */
	public void saveDeliveryAndOrdDtlCstrtDlvrMap(int exptCnt, boolean isUpdate, CisOrderDeliveryStateChgVO vo, OrderInquiryExptVO exptVO, 
													Long existDlvrNo) {
		
		Long dlvrNo = null;
		
		if(StringUtils.isNotEmpty(vo.getDlvrNos())) {
			
			dlvrNo = Long.parseLong(StringUtil.split(vo.getDlvrNos(), ",")[0]);
		
			if(isUpdate) {
				//----------------------------
				//배송 UPDATE
				//----------------------------
				DeliveryPO dayDlvrPO = new DeliveryPO();
				dayDlvrPO.setDlvrNo(dlvrNo);
				
				dayDlvrPO.setHdcCd(convertCisDlvCmpyCdToAboutPet(exptVO.getDlvCmpyCd())); //택배사코드
				dayDlvrPO.setInvNo(exptVO.getInvcNo());					//송장번호
				dayDlvrPO.setOoCplt("Y");								//출고완료일시
				dayDlvrPO.setCisOoYn((exptVO.getExptNo() != null)? CommonConstants.COMM_YN_Y:null); //CIS출고여부
				dayDlvrPO.setCisOoNo(exptVO.getExptNo());				//CIS출고번호
				dayDlvrPO.setCisHdcCd(exptVO.getDlvCmpyCd());			//CIS택배사코드
				dayDlvrPO.setCisInvNo(exptVO.getInvcNo());				//CIS송장번호
				dayDlvrPO.setCisDlvrCpltPicUrl(exptVO.getDawnImgSrc()); //CIS 배송 완료 사진 URL
				dayDlvrPO.setCisDlvrCpltYn(exptVO.getDawnCmplYn()); 	//CIS 배송 완료 여부
				deliveryDao.updateDelivery(dayDlvrPO);
				
				//----------------------------
				//주문 상세 구성 배송 매핑 UPDATE
				//----------------------------
				modifyOrdDtlCstrtDlvrMapTbl(vo, exptCnt, dayDlvrPO.getDlvrNo(), exptVO.getDlvEa(), null);
				
			}else {
				if(existDlvrNo == 0L) {
					//----------------------------
					//배송 Copy INSERT 후 UPDATE
					//----------------------------
					Long newDlvrNo = bizService.getSequence(CommonConstants.SEQUENCE_DLVR_NO_SEQ);
					OrdDtlCstrtDlvrMapPO dpo = new OrdDtlCstrtDlvrMapPO();
					dpo.setNewDlvrNo(newDlvrNo);
					dpo.setDlvrNo(dlvrNo);
					deliveryDao.insertDeliveryCopy(dpo);
					
					//----------------------------
					//배송 UPDATE
					//----------------------------
					DeliveryPO dayDlvrPO = new DeliveryPO();
					dayDlvrPO.setDlvrNo(newDlvrNo);
					
					dayDlvrPO.setHdcCd(convertCisDlvCmpyCdToAboutPet(exptVO.getDlvCmpyCd())); //택배사코드
					dayDlvrPO.setInvNo(exptVO.getInvcNo());					//송장번호
					dayDlvrPO.setOoCplt("Y");								//출고완료일시
					dayDlvrPO.setCisOoYn((exptVO.getExptNo() != null)? CommonConstants.COMM_YN_Y:null); //CIS출고여부
					dayDlvrPO.setCisOoNo(exptVO.getExptNo());				//CIS출고번호
					dayDlvrPO.setCisHdcCd(exptVO.getDlvCmpyCd());			//CIS택배사코드
					dayDlvrPO.setCisInvNo(exptVO.getInvcNo());				//CIS송장번호
					dayDlvrPO.setCisDlvrCpltPicUrl(exptVO.getDawnImgSrc()); //CIS 배송 완료 사진 URL
					dayDlvrPO.setCisDlvrCpltYn(exptVO.getDawnCmplYn()); 	//CIS 배송 완료 여부
					deliveryDao.updateDelivery(dayDlvrPO);
					
					existDlvrNo = newDlvrNo;
					
				}
				
				modifyOrdDtlCstrtDlvrMapTbl(vo, exptCnt, dlvrNo, exptVO.getDlvEa(), existDlvrNo);
				
			}
		}
	}
	
	/**
	 * 
	 * @param vo
	 * @param cisItem
	 * @param exptList
	 * @return
	 */
	public OrderInquiryItemVO saveOrdDtlCstrtAndOrdDtl(CisOrderDeliveryStateChgVO vo, OrderInquiryItemVO cisItem, List<OrderInquiryExptVO> exptList) {
		int count = 0;
		String cisCmplImgUrl = null;
		String cisCmplYn = null;
		
		if(CommonConstants.COMM_YN_N.equals(vo.getClmDlvrYn())){
			//----------------------------
			//주문 상세 구성 UPDATE
			//----------------------------
			OrdDtlCstrtPO po = new OrdDtlCstrtPO();
			po.setOrdNo(vo.getOrdNo());
			po.setOrdDtlSeq(vo.getOrdDtlSeq());
			po.setOrdCstrtSeq(Integer.parseInt(StringUtil.split(cisItem.getShopSortNo(), "_")[1]));
			
			po.setCisStatCd(cisItem.getStatCd()); //CIS 상태 코드
			count += ordDtlCstrtDao.updateOrdDtlCstrt(po);
		}else {
			//----------------------
			//클레임 상세 구성 UPDATE
			//----------------------
			ClmDtlCstrtPO po = new ClmDtlCstrtPO();
			po.setClmNo(vo.getOrdNo());
			po.setClmDtlSeq(vo.getOrdDtlSeq());
			po.setClmCstrtSeq(Integer.parseInt(StringUtil.split(cisItem.getShopSortNo(), "_")[1]));
			
			po.setCisStatCd(cisItem.getStatCd()); //CIS 상태 코드
			count += clmDtlCstrtDao.updateClmDtlCstrt(po);
		}
		
		//------------------------------
		//배송완료일때 배송 UPDATE
		//------------------------------
		if(cisItem.getStatCd().equals(CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_05)) {
			for(OrderInquiryExptVO exptVO : exptList) {
				DeliveryPO dvvo = new DeliveryPO();
				DeliveryHistPO deliveryHistPO = new DeliveryHistPO();
				
				if(CommonConstants.COMM_YN_N.equals(vo.getClmDlvrYn())){
					dvvo.setOrdDtlCstrtNo(vo.getOrdDtlCstrtNo());
					dvvo.setSearchInvNo(exptVO.getInvcNo()); //CIS출고정보의 송장번호 (조회조건)
					dvvo.setOrdDlvrCpltExe(CommonConstants.COMM_YN_Y);
					dvvo.setCisDlvrCpltPicUrl(exptVO.getDawnImgSrc());
					dvvo.setCisDlvrCpltYn(exptVO.getDawnCmplYn());
					deliveryDao.updateDelivery(dvvo);
					
					deliveryHistPO.setOrdDtlCstrtNo(vo.getOrdDtlCstrtNo());
					deliveryHistPO.setSearchInvNo(exptVO.getInvcNo()); //CIS출고정보의 송장번호 (조회조건)
					deliveryHistDao.insertDeliveryHist(deliveryHistPO);
				}else{
					dvvo.setClmDtlCstrtNo(vo.getOrdDtlCstrtNo());
					dvvo.setSearchInvNo(exptVO.getInvcNo()); //CIS출고정보의 송장번호 (조회조건)
					dvvo.setClmDlvrCpltExe(CommonConstants.COMM_YN_Y);
					dvvo.setCisDlvrCpltPicUrl(exptVO.getDawnImgSrc());
					dvvo.setCisDlvrCpltYn(exptVO.getDawnCmplYn());
					deliveryDao.updateDelivery(dvvo);
					
					deliveryHistPO.setClmDtlCstrtNo(vo.getOrdDtlCstrtNo());
					deliveryHistPO.setSearchInvNo(exptVO.getInvcNo()); //CIS출고정보의 송장번호 (조회조건)
					deliveryHistDao.insertDeliveryHist(deliveryHistPO);
				}
			}
		}

		//배송완료일때, 배송 완료 사진 URL
		if(cisItem.getStatCd().equals(CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_05)) {
			for(OrderInquiryExptVO exptVO : exptList) {
				cisCmplYn = exptVO.getDawnCmplYn();
				if(StringUtil.nvl(exptVO.getDawnCmplYn()).equals(CommonConstants.COMM_YN_Y)){
					cisCmplImgUrl = exptVO.getDawnImgSrc();
					break;
				}
			}
		}
		if(CommonConstants.COMM_YN_N.equals(vo.getClmDlvrYn())){
			//----------------------------
			//주문 상세 UPDATE
			//----------------------------
			OrderDetailPO dpo = new OrderDetailPO();
			dpo.setOrdNo(vo.getOrdNo());
			dpo.setOrdDtlSeq(vo.getOrdDtlSeq());
			dpo.setOrdDtlStatCd(convertCisStateToAboutPet(cisItem.getStatCd(), vo.getClmDlvrYn()));	//주문 상세 상태 코드
			dpo.setDlvrCpltPicUrl(cisCmplImgUrl); //배송완료일때, 배송 완료 사진 URL
			dpo.setDlvrCpltYn(cisCmplYn);
			orderDetailDao.updateOrderDetail(dpo);
		}else {
			//----------------------
			//클레임 상세 UPDATE
			//----------------------
			ClaimDetailPO dpo = new ClaimDetailPO();
			dpo.setClmNo(vo.getOrdNo());
			dpo.setClmDtlSeq(vo.getOrdDtlSeq());
			dpo.setClmDtlStatCd(convertCisStateToAboutPet(cisItem.getStatCd(), vo.getClmDlvrYn())); //클레임 상세 상태 코드
			dpo.setDlvrCpltPicUrl(cisCmplImgUrl); //배송완료일때, 배송 완료 사진 URL
			dpo.setDlvrCpltYn(cisCmplYn);
			claimDetailDao.updateClaimDetail(dpo);
		}
		
		//-------------------------------------------
		//클레임 상세가 모두 완료시 클레임기본T-클레임상태코드:03완료 UPDATE - 2021.04.23 kek01 (맨 마지막에 실행해야됨)
		//-------------------------------------------
		if(cisItem.getStatCd().equals(CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_05)) {
			if(CommonConstants.COMM_YN_Y.equals(vo.getClmDlvrYn())) {
				ClaimBasePO cbpo = new ClaimBasePO();
				cbpo.setClmNo(vo.getOrdNo());
				cbpo.setClmStatCd(CommonConstants.CLM_STAT_30);
				cbpo.setCpltrNo(CommonConstants.COMMON_BATCH_USR_NO);
				cbpo.setCheckClmDtlStatAllEndYn("Y"); //클레임상세가 모두 처리된 경우에만 클레임상태를 완료 UPDATE
				claimBaseDao.updateClaimBase(cbpo);
			}
		}
		log.info("### 배송중,배송완료 상태 변경  - count:"+count);
		
		OrderInquiryItemVO resultVo = null;
		if (CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_04.equals(cisItem.getStatCd()) || CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_05.equals(cisItem.getStatCd())) {
			resultVo = cisItem;
			log.info("### 배송중,배송완료 알림톡 발송 목록 추가  - 확인:"+StringUtil.isNotEmpty(resultVo));
		}
		
		return resultVo;
	}
	
	/**
	 * 배송 등록
	 * @param clmDlvrYn
	 * @param ordDlvraNo
	 * @param dlvrPrcsTpCd
	 * @return 신규 생성된 배송 번호
	 */
	public Long insertDelivery(String clmDlvrYn, Long ordDlvraNo, String dlvrPrcsTpCd) {
		//--------------
		//배송 INSERT
		//--------------
		Long dlvrNo = bizService.getSequence(CommonConstants.SEQUENCE_DLVR_NO_SEQ);
		DeliveryPO deliveryPO = new DeliveryPO();
		deliveryPO.setDlvrNo		( dlvrNo );
		deliveryPO.setOrdClmGbCd	( CommonConstants.COMM_YN_Y.equals(clmDlvrYn)? CommonConstants.ORD_CLM_GB_20 : CommonConstants.ORD_CLM_GB_10 );	/* 주문 클레임 구분 코드 */
		deliveryPO.setDlvrGbCd		( CommonConstants.DLVR_GB_10 );		/* 배송 구분 코드 */
		deliveryPO.setDlvrTpCd		( CommonConstants.COMM_YN_Y.equals(clmDlvrYn)? CommonConstants.DLVR_TP_120 : CommonConstants.DLVR_TP_110 );		/* 배송 유형 코드 */
		deliveryPO.setDlvrPrcsTpCd	( dlvrPrcsTpCd );					/* 배송 처리 유형 코드	 */
		deliveryPO.setOrdDlvraNo	( ordDlvraNo );						/* 주문 배송지 번호 */
		deliveryPO.setDlvrCmdDtm	( DateUtil.getTimestamp() );		/* 배송 지시 일시 */
		deliveryDao.insertDelivery(deliveryPO);
		
		return dlvrNo;
	}
	
	/**
	 * CIS 상태코드를 AboutPet 코드로 변환
	 * @param cisStateCd
	 * @param clmDlvrYn
	 * @return
	 */
	public String convertCisStateToAboutPet(String cisStateCd, String clmDlvrYn){
		String result = "";
		if(CommonConstants.COMM_YN_N.equals(clmDlvrYn)){
			if(CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_02.equals(cisStateCd))		{ result = CommonConstants.ORD_DTL_STAT_130; }
			else if(CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_03.equals(cisStateCd))	{ result = CommonConstants.ORD_DTL_STAT_140; }
			else if(CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_04.equals(cisStateCd))	{ result = CommonConstants.ORD_DTL_STAT_150; }
			else if(CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_05.equals(cisStateCd))	{ result = CommonConstants.ORD_DTL_STAT_160; }
		}else{
			if(CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_02.equals(cisStateCd))		{ result = CommonConstants.CLM_DTL_STAT_420; }
			else if(CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_03.equals(cisStateCd))	{ result = CommonConstants.CLM_DTL_STAT_430; }
			else if(CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_04.equals(cisStateCd))	{ result = CommonConstants.CLM_DTL_STAT_440; }
			else if(CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_05.equals(cisStateCd))	{ result = CommonConstants.CLM_DTL_STAT_450; }
		}
		return result;
	}
	
	/**
	 * CIS 택배사코드를 AboutPet 코드로 변환
	 * @param dlvCmpyCd
	 * @return
	 */
	public String convertCisDlvCmpyCdToAboutPet(String cisDlvCmpyCd){
		String result = "";
//		if("CJ".equals(cisDlvCmpyCd))		{ result = CommonConstants.HDC_01; }
//		else if("HJ".equals(cisDlvCmpyCd))	{ result = CommonConstants.HDC_05; }
//		else if("KD".equals(cisDlvCmpyCd))	{ result = CommonConstants.HDC_11; }
//		else if("GS".equals(cisDlvCmpyCd))	{ result = CommonConstants.HDC_36; }
		
		if(!StringUtil.isEmpty(cisDlvCmpyCd)) {
			List<CodeDetailVO> codeDtlList = cacheService.listCodeCache(CommonConstants.HDC, "", cisDlvCmpyCd, "", "", "");
			if(codeDtlList != null && codeDtlList.size() > 0) {
				result = codeDtlList.get(0).getDtlCd();
			}
		}
		
		return result;
	}
	
	/**
	 * CIS 상태코드 변경여부
	 * @param cisStateCd
	 * @param apStateCd
	 * @return
	 */
	public boolean isModifiedCisState(String cisStateCd, String apStateCd, String clmDlvrYn){
		boolean rslt = true;
		String curCisStatCd = convertCisStateToAboutPet(cisStateCd, clmDlvrYn);
		if("".equals(curCisStatCd)) {
			rslt = false;
		}else {
			if(Integer.parseInt(curCisStatCd) <= Integer.parseInt(apStateCd)) { //상태가 진전했을때만 실행한다
				rslt = false;
			}
		}
		return rslt;
	}
	
	/**
	 * CIS 출고번호,송장번호가 배송TBL에 존재하는지 찾기
	 * @param exptVO
	 * @param dlvrList
	 * @return
	 */
	public DeliveryVO findSameDlvr(OrderInquiryExptVO cisExptVO, List<DeliveryVO> dlvrList) {
		DeliveryVO rvo = new DeliveryVO();
		if(dlvrList != null) {
			DeliveryVO mvo = new DeliveryVO();
			for(DeliveryVO vo : dlvrList) {
				mvo = vo;
//				if(StringUtil.nvl(vo.getCisOoNo()).equals(StringUtil.nvl(cisExptVO.getExptNo())) && 
//				   StringUtil.nvl(vo.getCisInvNo()).equals(StringUtil.nvl(cisExptVO.getInvcNo()))) { //동일 배송정보 존재시 리턴
				if(StringUtil.nvl(vo.getCisInvNo()).equals(StringUtil.nvl(cisExptVO.getInvcNo()))) { //동일 송장번호 존재시 리턴
					rvo = vo;
					break;
				}
			}
			//동일 배송정보 미존시, 배송지시일시 set 하여 리턴
			if(rvo.getDlvrNo() == null) {
				rvo.setDlvrCmdDtm(mvo.getDlvrCmdDtm());
			}
		}
		return rvo;
	}
	
//	/**
//	 * 요청ItemList 에 자사상품이 존재하는지 체크
//	 * @param resShopOrdrNo
//	 * @param resShopSortNo
//	 * @param paramItems
//	 * @param isInsDlvrChk
//	 * @return
//	 */
//	public boolean existGoodOfSelfCompany(String resShopOrdrNo, String resShopSortNo, List<OrderInsertItemPO> paramItems, boolean isInsDlvrChk) {
//		boolean rslt = false;
//		if(isInsDlvrChk) {
//			for(OrderInsertItemPO param : paramItems) {
//				if(param.getCompGbCd().equals(CommonConstants.COMP_GB_10)) { //자사상품이 1개라도 존재하면
//					rslt = true;
//					break;
//				}
//			}
//		}else {
//			for(OrderInsertItemPO param : paramItems) {
//				if(resShopOrdrNo.equals(param.getShopOrdrNo()) && resShopSortNo.equals(param.getShopSortNo())) { 
//					if(param.getCompGbCd().equals(CommonConstants.COMP_GB_10)) { //해당 상품이 자사상품이라면
//						rslt = true;
//					}
//					break;
//				}
//			}
//		}
//		return rslt;
//	}
	
//	/**
//	 * 요청ItemList 에 외부업체 일때 업부업체코드+배송비번호 를 필터 (중복제거)
//	 * @param paramItems
//	 * @return
//	 */
//	public List<String> filterOutsideCompanyDlvrc(List<OrderInsertItemPO> paramItems){
//		List<String> filter = new ArrayList<String>();
//		for(OrderInsertItemPO param : paramItems) {
//			if(param.getCompGbCd().equals(CommonConstants.COMP_GB_20)) { //외부업체이면
//				filter.add(StringUtil.nvl(param.getCompNo(),"0")
//						  .concat("_")
//						  .concat(StringUtil.isEmpty(param.getDlvrcNo())? "0":String.valueOf(param.getDlvrcNo()))); //외부업체코드-배송비번호
//			}
//		}
//		//중복제거
//		List<String> rslt = new ArrayList<String>();
//		for(int i=0; i<filter.size(); i++) {
//			if(!rslt.contains(filter.get(i))) {
//				rslt.add(filter.get(i));
//			}
//		}
//		return rslt;
//	}
//
	/**
	 * 출고정보 저장실행 여부 리턴 (배송지시 또는 상품준비중 -> 배송완료로 상태가 변경된 경우에 출고정보를 저장해야됨) 
	 * @param currStatCd
	 * @param cisStatCd
	 * @param clmDlvrYn
	 * @return
	 */
	public boolean isExptUpdate(String currStatCd, String cisStatCd, String clmDlvrYn) {
		boolean rslt = false;
		
		//CIS 상태가 출고확정 일때
		if(cisStatCd.equals(CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_04)) {
			rslt = true;
		}
		//CIS 상태가 배송완료 일때 (배송지시 또는 상품준비중 -> 배송완료로 상태가 변경된 경우에 출고정보를 저장해야됨) 
		else if(cisStatCd.equals(CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_05)) {
			if(CommonConstants.COMM_YN_N.equals(clmDlvrYn)){ //주문
				if(CommonConstants.ORD_DTL_STAT_130.equals(currStatCd) || CommonConstants.ORD_DTL_STAT_140.equals(currStatCd)) { //현재 상태가 배송지시 또는 상품준비중 일때
					rslt = true;
				}
			}else { //클레임
				if(CommonConstants.CLM_DTL_STAT_420.equals(currStatCd) || CommonConstants.CLM_DTL_STAT_430.equals(currStatCd)) { //현재 상태가 배송지시 또는 상품준비중 일때
					rslt = true;
				}
			}
		}
		return rslt;
	}
	
	
	/**
	 * 단건상품 or 세트/사은품 여부 체크
	 * @param vo
	 * @param cisItems
	 * @return
	 */
	public int getCountOrdDtlCstrt(CisOrderDeliveryStateChgVO vo, List<OrderInquiryItemVO> cisItems) {
		int count = 0;
		for(OrderInquiryItemVO item : cisItems) {
			if(item.getShopOrdrNo().equals(vo.getOrdNo()) &&
			   Integer.parseInt(StringUtil.split(item.getShopSortNo(), "_")[0]) == vo.getOrdDtlSeq()	){
				count++;
			}
		}
		return count;
	}
	
	/**
	 * 세트상품들의 모든 송장번호가 동일한가 체크
	 * @param vo
	 * @param cisItems
	 * @return
	 */
	public boolean getSameAllInvcNoOfSetGoods(CisOrderDeliveryStateChgVO vo, List<OrderInquiryItemVO> cisItems) {
		boolean result = true;
		List<String> filter = new ArrayList<String>();
		for(OrderInquiryItemVO item : cisItems) {
			if(item.getShopOrdrNo().equals(vo.getOrdNo()) && Integer.parseInt(StringUtil.split(item.getShopSortNo(), "_")[0]) == vo.getOrdDtlSeq()	){
				
				List<OrderInquiryExptVO> exptList = item.getExptList(); //출고정보
				if(exptList == null) { //미출고가 1건이라도 있으면 false 리턴 //모두 동일하지 않다는 의미
					result = false;
				}else {
					for(OrderInquiryExptVO exptVO : exptList) {
						filter.add(exptVO.getInvcNo());
					}
				}
				
			}
		}
		if(result) {
			//중복제거
			List<String> rslt = new ArrayList<String>();
			for(int i=0; i<filter.size(); i++) {
				if(!rslt.contains(filter.get(i))) {
					rslt.add(filter.get(i));
				}
			}
			if(rslt.size() > 1) {result = false;} //모두 동일하지 않다는 의미
		}
		
		return result;
	}
	
	/**
	 * 주문 상품 송장번호 별 알림톡 발송
	 * @param vo
	 * @param cisItems
	 * @return
	 */
	@Override
	public void allInvcNoGoodsSendMessage(CisOrderDeliveryStateChgVO vo, List<OrderInquiryItemVO> cisItems) {
		// 배송중 or 배송완료 일 경우 알림톡 발송 (20210707 당일배송은 GSF에서 발송하여 알림톡 발송 안 하고 새벽배송만 알림톡 발송)
		List<Integer> ordDtlSeq04 = new ArrayList<Integer>(); // 배송중 상태의 주문상세순번
		List<Integer> ordDtlSeqReal04 = new ArrayList<Integer>(); // 배송중 상태의 주문상세순번
		List<Integer> ordDtlSeq05 = new ArrayList<Integer>(); // 배송완료 상태의 주문상세순번
		List<Integer> ordDtlSeqReal05 = new ArrayList<Integer>(); // 배송완료 상태의 주문상세순번
		
		for(OrderInquiryItemVO cisItem : cisItems) {
			if (StringUtil.isNotEmpty(cisItem) && StringUtil.equals(cisItem.getStatCd(), CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_04)) { // 배송중 (새벽배송,일반배송)
				ordDtlSeq04.add(Integer.parseInt(StringUtil.split(cisItem.getShopSortNo(), "_")[0]));
				for(Integer ordDtlSeqStr : ordDtlSeq04) {
					if (!ordDtlSeqReal04.contains(ordDtlSeqStr)) {
						ordDtlSeqReal04.add(Integer.parseInt(StringUtil.split(cisItem.getShopSortNo(), "_")[0]));
					}
				}
			} else if (StringUtil.isNotEmpty(cisItem) && StringUtil.equals(cisItem.getStatCd(), CommonConstants.CIS_API_SELECT_ORDR_STAT_CD_05)) { // 배송완료 (새벽배송, 일반배송은 굿스플로 배치에서 발송)
				ordDtlSeq05.add(Integer.parseInt(StringUtil.split(cisItem.getShopSortNo(), "_")[0]));
				for(Integer ordDtlSeqStr : ordDtlSeq05) {
					if (!ordDtlSeqReal05.contains(ordDtlSeqStr)) {
						ordDtlSeqReal05.add(Integer.parseInt(StringUtil.split(cisItem.getShopSortNo(), "_")[0]));
					}
				}
			}
		}
		
		if (CollectionUtils.isNotEmpty(ordDtlSeqReal04)) {
			Integer[] arrOrdDtlSeq04 = ordDtlSeqReal04.toArray(new Integer[ordDtlSeqReal04.size()]);
			
			log.info("### 배송중(04) 알림톡 발송 정보 END : "+vo.getDlvrPrcsTpCd()+" , "+vo.getOrdNo());
			
			if (StringUtil.equals(vo.getDlvrPrcsTpCd(), CommonConstants.DLVR_PRCS_TP_21)) {
				orderService.sendMessage(vo.getOrdNo(), "", "K_M_ord_00015" , null, arrOrdDtlSeq04);
			} else if (StringUtil.equals(vo.getDlvrPrcsTpCd(), CommonConstants.DLVR_PRCS_TP_10)) {
				orderService.sendMessage(vo.getOrdNo(), "", "K_M_ord_0016" , null, arrOrdDtlSeq04);
			}
		}
		if (CollectionUtils.isNotEmpty(ordDtlSeqReal05)) {
			Integer[] arrOrdDtlSeq05 = ordDtlSeqReal05.toArray(new Integer[ordDtlSeqReal05.size()]);
			
			log.info("### 배송완료(05) 알림톡 발송 정보 END : "+vo.getDlvrPrcsTpCd()+" , "+vo.getOrdNo());
			
			if (StringUtil.equals(vo.getDlvrPrcsTpCd(), CommonConstants.DLVR_PRCS_TP_21)) {
				orderService.sendMessage(vo.getOrdNo(), "", "K_M_ord_0017" , null, arrOrdDtlSeq05);
			}
		}
		
	}


}


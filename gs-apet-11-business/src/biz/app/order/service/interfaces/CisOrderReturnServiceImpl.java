package biz.app.order.service.interfaces;

import java.util.List;

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
import biz.app.delivery.model.DeliveryPO;
import biz.app.delivery.model.DeliverySO;
import biz.app.delivery.model.DeliveryVO;
import biz.app.order.model.interfaces.CisOrderReturnCmdVO;
import biz.app.order.model.interfaces.CisOrderReturnStateChgVO;
import biz.app.order.service.OrderService;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import biz.interfaces.cis.model.request.order.ReturnInsertItemPO;
import biz.interfaces.cis.model.response.order.ReturnInquiryItemVO;
import biz.interfaces.cis.model.response.order.ReturnInsertItemVO;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.service.interfaces.ob
* - 파일명		: CisOrderReturnServiceImpl.java
* - 작성일		: 2020. 3. 10.
* - 작성자		: KEK01
* - 설명			: CIS 회수 서비스 Impl
* </pre>
*/
@Slf4j
@Service
@Transactional
public class CisOrderReturnServiceImpl implements CisOrderReturnService {

	@Autowired private BizService bizService;
	@Autowired private DeliveryDao deliveryDao;
	@Autowired private ClaimBaseDao claimBaseDao;
	@Autowired private ClaimDetailDao claimDetailDao;
	@Autowired private ClmDtlCstrtDao clmDtlCstrtDao;
	@Autowired private ClmDtlCstrtDlvrMapDao clmDtlCstrtDlvrMapDao;
	@Autowired private OrderService orderService;
	@Autowired private CacheService cacheService;
	
	
	/** CIS 회수지시 대상 주문 조회 */
	@Override
	public List<CisOrderReturnCmdVO> listCisReturnCmd() {
		return clmDtlCstrtDao.listClmDtlCstrtForSendCis();
	}
	
	/** CIS 회수지시 후처리 DB변경 */
	@Override
	@Transactional
	public int updateCisReturnCmdAfter(List<ReturnInsertItemVO> resItems, String dlvrPrcsTpCd, Long ordDlvraNo, String exchgRtnYn, List<ReturnInsertItemPO> paramItems)	{	
		int count = 0;
		Long newDlvrNo = 0L;		//배송번호
		int  currClmCstrtSeq = 0;	//클레임구성순번
		
		for(ReturnInsertItemPO opo : paramItems) {
			currClmCstrtSeq = Integer.parseInt(StringUtil.split(opo.getShopSortNo(), "_")[1]);
			if(currClmCstrtSeq == 1) {
				//----------------------------
				//배송 INSERT
				//----------------------------
				newDlvrNo = insertDelivery(exchgRtnYn, ordDlvraNo, opo.getDlvtTpCd());
			}
			
			//----------------------------
			//클레임 상세 구성 배송 매핑 INSERT
			//----------------------------
			ClmDtlCstrtDlvrMapPO clmDtlCstrtDlvrMapSelfPO = new ClmDtlCstrtDlvrMapPO();
			clmDtlCstrtDlvrMapSelfPO.setClmDtlCstrtNo(opo.getClmDtlCstrtNo());
			clmDtlCstrtDlvrMapSelfPO.setDlvrNo(newDlvrNo);
			clmDtlCstrtDlvrMapSelfPO.setDlgtYn(CommonConstants.COMM_YN_Y);
			clmDtlCstrtDlvrMapDao.insertClmDtlCstrtDlvrMap(clmDtlCstrtDlvrMapSelfPO);
		}
		
		ClmDtlCstrtPO reqvo = null;
		for(ReturnInsertItemVO resItem : resItems) {
				reqvo = null;
				reqvo = filterClmKeyInfo(resItem, paramItems);
				//----------------------------
				//클레임 상세 구성 UPDATE
				//----------------------------
				ClmDtlCstrtPO po = new ClmDtlCstrtPO();
				po.setClmNo(reqvo.getClmNo());
				po.setClmDtlSeq(reqvo.getClmDtlSeq());
				po.setClmCstrtSeq(reqvo.getClmCstrtSeq());
				
				po.setCisClmNo(resItem.getRtnsNo());
				po.setCisClmDtlSeq(resItem.getItemNo());
				count += clmDtlCstrtDao.updateClmDtlCstrt(po);
				
				//--------------------
				//클레임 상세 UPDATE
				//--------------------
				ClaimDetailPO dpo = new ClaimDetailPO();
				dpo.setClmNo(reqvo.getClmNo());
				dpo.setClmDtlSeq(reqvo.getClmDtlSeq());

				if(CommonConstants.COMM_YN_Y.equals(exchgRtnYn)) {
					dpo.setClmDtlStatCd(CommonConstants.CLM_DTL_STAT_320);
				}else {
					dpo.setClmDtlStatCd(CommonConstants.CLM_DTL_STAT_220);
				}
				claimDetailDao.updateClaimDetailStatus(dpo);
		}
		
		//----------------------------------------
		//클레임 기본 UPDATE
		//----------------------------------------
		ClaimBasePO bpo = new ClaimBasePO();
		bpo.setClmNo(reqvo.getClmNo());
		bpo.setClmStatCd(CommonConstants.CLM_STAT_20); //진행
		claimBaseDao.updateClaimBase(bpo);
		
		return count;
	}
	
	public ClmDtlCstrtPO filterClmKeyInfo(ReturnInsertItemVO resItem, List<ReturnInsertItemPO> paramItems) {
		ClmDtlCstrtPO vo = new ClmDtlCstrtPO();
		for(ReturnInsertItemPO param : paramItems) {
			if(param.getShopOrdrNo().equals(resItem.getShopOrdrNo()) && param.getShopSortNo().equals(resItem.getShopSortNo())) {
				vo.setClmNo(param.getClmNo());
				vo.setClmDtlSeq(param.getClmDtlSeq());
				vo.setClmCstrtSeq(param.getClmCstrtSeq());
				break;
			}
		}
		return vo;
	}
	
	/** CIS 회수 상태 변경 대상 주문 조회 */
	@Override
	public List<CisOrderReturnStateChgVO> listCisReturnStateChg() {
		return clmDtlCstrtDao.listClmDtlCstrtForChkCisDlvrStateChg();
	}

	@Override
	@Transactional
	public int updateCisReturnStateChgAfter(CisOrderReturnStateChgVO vo, List<ReturnInquiryItemVO> cisItems) {
		int count = 0;
		
		if(cisItems != null) {
			for(ReturnInquiryItemVO cisItem : cisItems) {
				/**************************************************
				 * CIS ItemList에서 (클레임 상세 구성) 1건을 찾아서 처리
				 **************************************************/
				if(cisItem.getRtnsNo().equals(vo.getCisClmNo()) && cisItem.getItemNo() == vo.getCisClmDtlSeq()) {	
					
					//CIS 상태코드 변경 안된 경우 SKIP
					if(!isModifiedCisState(cisItem.getStatCd(), vo.getClmDtlStatCd(), vo.getExchgRtnYn())) {
						log.info("회수상태변경 배치 - CIS 상태코드 변경 안된 경우 SKIP : "+vo.getClmNo()+" , "+vo.getClmDtlSeq()+" , "+vo.getClmCstrtSeq());
						return 0;
					}
					
					//----------------------
					//클레임 상세 UPDATE
					//----------------------
					if(vo.getClmCstrtSeq() == 1) {
						ClaimDetailPO dpo = new ClaimDetailPO();
						dpo.setClmNo(vo.getClmNo());
						dpo.setClmDtlSeq(vo.getClmDtlSeq().intValue());
						dpo.setClmDtlStatCd(convertCisStateToAboutPet(cisItem.getStatCd(), vo.getExchgRtnYn())); //클레임 상세 상태 코드
						claimDetailDao.updateClaimDetail(dpo);
					}
					//----------------------
					//클레임 상세 구성 UPDATE
					//----------------------
					ClmDtlCstrtPO po = new ClmDtlCstrtPO();
					po.setClmNo(vo.getClmNo());
					po.setClmDtlSeq(vo.getClmDtlSeq().intValue());
					po.setClmCstrtSeq(vo.getClmCstrtSeq());
					po.setCisStatCd(cisItem.getStatCd()); //CIS 상태 코드
					count += clmDtlCstrtDao.updateClmDtlCstrt(po);
					
					if(StringUtil.isNotEmpty(vo.getDlvrNos())) {
						//----------------------
						//배송 UPDATE
						//----------------------
						DeliveryPO dayDlvrPO = new DeliveryPO();
						dayDlvrPO.setDlvrNo(Long.parseLong(StringUtil.split(vo.getDlvrNos(),",")[0]));
						dayDlvrPO.setHdcCd(convertCisDlvCmpyCdToAboutPet(cisItem.getDlvCmpyCd())); //택배사코드
						if(CommonConstants.CIS_API_SELECT_RTNS_STAT_CD_02.equals(cisItem.getStatCd())) {
							//출고완료일시
							dayDlvrPO.setOoCplt("Y");
						}
						if(CommonConstants.CIS_API_SELECT_RTNS_STAT_CD_03.equals(cisItem.getStatCd())) {
							if(vo.getClmDtlStatCd().equals(CommonConstants.CLM_DTL_STAT_220) || vo.getClmDtlStatCd().equals(CommonConstants.CLM_DTL_STAT_320)) {
								//출고완료일시
								dayDlvrPO.setOoCplt("Y");
							}
							//배송완료일시
							dayDlvrPO.setClmDtlCstrtNo(vo.getClmDtlCstrtNo());
							dayDlvrPO.setClmDlvrCpltExe(CommonConstants.COMM_YN_Y);
						}
						dayDlvrPO.setCisHdcCd(cisItem.getDlvCmpyCd());			//CIS 택배사코드
						deliveryDao.updateDelivery(dayDlvrPO);

						//---------------------------------------
						//클레임 상세 구성 배송 매핑 UPDATE
						//---------------------------------------
						ClmDtlCstrtDlvrMapPO clmDtlCstrtDlvrMapPO = new ClmDtlCstrtDlvrMapPO();
						clmDtlCstrtDlvrMapPO.setClmDtlCstrtNo(vo.getClmDtlCstrtNo());
						clmDtlCstrtDlvrMapPO.setDlvrNo(dayDlvrPO.getDlvrNo());
						clmDtlCstrtDlvrMapPO.setCisOoQty(new Long(cisItem.getEa())); //CIS 출고 수량
						clmDtlCstrtDlvrMapPO.setDlgtYn(CommonConstants.COMM_YN_Y); //대표여부
						clmDtlCstrtDlvrMapDao.updateClmDtlCstrtDlvrMap(clmDtlCstrtDlvrMapPO);
					}
					
					//-------------------------------------------
					//클레임 상세가 모두 완료시 클레임기본T-클레임상태코드:03완료 UPDATE - 2021.04.23 kek01 (맨 마지막에 실행해야됨)
					//2021.05.21 kek01 - 회수상태변경 배치에서는 클레임상태 변경을 실행하지 않기로 업무 변경됨 (유준희 요청)
					//-------------------------------------------
//					ClaimBasePO cbpo = new ClaimBasePO();
//					cbpo.setClmNo(vo.getClmNo());
//					cbpo.setClmStatCd(CommonConstants.CLM_STAT_30);
//					cbpo.setCpltrNo(CommonConstants.COMMON_BATCH_USR_NO);
//					cbpo.setCheckClmDtlStatAllEndYn("Y"); //클레임상세가 모두 처리된 경우에만 클레임상태를 완료 UPDATE
//					claimBaseDao.updateClaimBase(cbpo);
					
					break;
				} //end-if
			}//end-for
		}
		
		return count;		
	}


	/**
	 * 배송정보 조회
	 */
	@Override
	public List<DeliveryVO> listDelivery(String clmNo, int clmDtlSeq) {
		DeliverySO so = new DeliverySO();
		so.setClmNo(clmNo);
		so.setClmDtlSeq(clmDtlSeq);
		so.setCompGbCd(CommonConstants.COMP_GB_10); //자사만
		return deliveryDao.listDelivery(so);
	}
	
	
	/**
	 * 배송 등록
	 * @param exchgRtnYn
	 * @param ordDlvraNo
	 * @param dlvrPrcsTpCd
	 * @return 신규 생성된 배송 번호
	 */
	public Long insertDelivery(String exchgRtnYn, Long ordDlvraNo, String dlvrPrcsTpCd) {
		//--------------
		//배송 INSERT
		//--------------
		Long dlvrNo = bizService.getSequence(CommonConstants.SEQUENCE_DLVR_NO_SEQ);
		DeliveryPO deliveryPO = new DeliveryPO();
		deliveryPO.setDlvrNo		( dlvrNo );
		deliveryPO.setOrdClmGbCd	( CommonConstants.ORD_CLM_GB_20 );	/* 주문 클레임 구분 코드 */
		deliveryPO.setDlvrGbCd		( CommonConstants.DLVR_GB_20 );		/* 배송 구분 코드 */
		deliveryPO.setDlvrTpCd		( CommonConstants.COMM_YN_Y.equals(exchgRtnYn)? CommonConstants.DLVR_TP_220 : CommonConstants.DLVR_TP_210 ); /* 배송 유형 코드 */
		deliveryPO.setDlvrPrcsTpCd	( dlvrPrcsTpCd );					/* 배송 처리 유형 코드	 */
		deliveryPO.setOrdDlvraNo	( ordDlvraNo );						/* 주문 배송지 번호 */
		deliveryPO.setDlvrCmdDtm	( DateUtil.getTimestamp() );		/* 배송 지시 일시 */
		deliveryDao.insertDelivery(deliveryPO);
		
		return dlvrNo;
	}
	
	/**
	 * CIS 상태코드를 AboutPet 코드로 변환
	 * @param cisStateCd
	 * @param exchgRtnYn
	 * @return
	 */
	public String convertCisStateToAboutPet(String cisStateCd, String exchgRtnYn){
		String result = "";
		if(CommonConstants.COMM_YN_N.equals(exchgRtnYn)){ //반품회수
			if(CommonConstants.CIS_API_SELECT_RTNS_STAT_CD_01.equals(cisStateCd))		{ result = CommonConstants.CLM_DTL_STAT_220; }
			else if(CommonConstants.CIS_API_SELECT_RTNS_STAT_CD_02.equals(cisStateCd))	{ result = CommonConstants.CLM_DTL_STAT_230; }
			else if(CommonConstants.CIS_API_SELECT_RTNS_STAT_CD_03.equals(cisStateCd))	{ result = CommonConstants.CLM_DTL_STAT_240; }
		}else{ //교환회수
			if(CommonConstants.CIS_API_SELECT_RTNS_STAT_CD_01.equals(cisStateCd))		{ result = CommonConstants.CLM_DTL_STAT_320; }
			else if(CommonConstants.CIS_API_SELECT_RTNS_STAT_CD_02.equals(cisStateCd))	{ result = CommonConstants.CLM_DTL_STAT_330; }
			else if(CommonConstants.CIS_API_SELECT_RTNS_STAT_CD_03.equals(cisStateCd))	{ result = CommonConstants.CLM_DTL_STAT_340; }
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
	public boolean isModifiedCisState(String cisStateCd, String apStateCd, String ExchgRtnYn){
		boolean rslt = true;
		String curCisStatCd = convertCisStateToAboutPet(cisStateCd, ExchgRtnYn);
		if("".equals(curCisStatCd)) {
			rslt = false;
		}else {
			if(Integer.parseInt(curCisStatCd) <= Integer.parseInt(apStateCd)) { //상태가 진전했을때만 실행한다
				rslt = false;
			}
		}
		return rslt;
	}

}


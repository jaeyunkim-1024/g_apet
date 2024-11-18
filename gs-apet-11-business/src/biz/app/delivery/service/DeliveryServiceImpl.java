package biz.app.delivery.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Properties;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.claim.dao.ClmDtlCstrtDlvrMapDao;
import biz.app.claim.model.ClmDtlCstrtDlvrMapPO;
import biz.app.claim.service.ClaimDetailService;
import biz.app.claim.service.ClaimService;
import biz.app.delivery.dao.DeliveryChargeDao;
import biz.app.delivery.dao.DeliveryDao;
import biz.app.delivery.dao.DeliveryHistDao;
import biz.app.delivery.model.DeliveryHistPO;
import biz.app.delivery.model.DeliveryHistSO;
import biz.app.delivery.model.DeliveryHistVO;
import biz.app.delivery.model.DeliveryListVO;
import biz.app.delivery.model.DeliveryPO;
import biz.app.delivery.model.DeliverySO;
import biz.app.delivery.model.DeliveryVO;
import biz.app.order.dao.OrdDtlCstrtDlvrMapDao;
import biz.app.order.dao.OrderBaseDao;
import biz.app.order.dao.OrderDetailDao;
import biz.app.order.model.OrdDtlCstrtDlvrMapPO;
import biz.app.order.model.OrderDetailPO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.model.OrderSO;
import biz.app.order.service.OrderDetailService;
import biz.app.order.service.OrderDlvraService;
import biz.app.order.service.OrderService;
import biz.app.st.dao.StDao;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import biz.interfaces.goodsflow.model.request.data.DeliveryGoodsSO;
import biz.interfaces.goodsflow.model.request.data.DeliveryGoodsVO;
import biz.interfaces.goodsflow.model.request.data.InvoiceVO;
import biz.interfaces.goodsflow.model.response.data.GoodsFlowDeliveryPO;
import biz.interfaces.goodsflow.model.response.data.GoodsFlowDeliveryResultPO;
import biz.interfaces.goodsflow.service.GoodsFlowService;
import framework.admin.constants.AdminConstants;
import framework.common.connect.UrlConnect;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.delivery.service
 * - 파일명		: DeliveryServiceImpl.java
 * - 작성일		: 2016. 4. 22.
 * - 작성자		: dyyoun
 * - 설명		: 주문 배송 서비스 Impl
 * </pre>
 */
@Slf4j
@Transactional
@Service("deliveryService")
public class DeliveryServiceImpl implements DeliveryService {

	@Autowired
	private DeliveryDao deliveryDao;
	
	@Autowired
	private DeliveryHistDao deliveryHistDao;

	@Autowired
	private OrderBaseDao orderBaseDao;

	@Autowired
	private OrderDetailDao orderDetailDao;

	@Autowired
	private ClaimDetailService claimDetailService;

	@Autowired
	private ClaimService claimService;

	@Autowired
	private MessageSourceAccessor message;

	@Autowired
	private Properties 	bizConfig;



	@Autowired 	private CacheService cacheService;
	/**
	 * 공통 서비스
	 */
	@Autowired
	private BizService bizService;

	@Autowired
	private OrderDetailService orderDetailService;

	@Autowired private OrderService orderService;

	@Autowired private OrderDlvraService orderDlvraService;

	@Autowired private DeliveryChargeDao deliveryChargeDao;

	@Autowired private StDao stDao;

	@Autowired private GoodsFlowService goodsFlowService;

	@Autowired private OrdDtlCstrtDlvrMapDao ordDtlCstrtDlvrMapDao;
	@Autowired private ClmDtlCstrtDlvrMapDao clmDtlCstrtDlvrMapDao;
	
	
	/**
	 * dlvrNo 단위로 1건씩 배송정보를 처리한다.
	 */
	@Override
	public void processDeliveryInvNo(Long dlvrNo, String hdcCd, String invNo){

		// 1. 주문/클래임 상태가 송장번호 등록 가능한지 확인
		DeliverySO deliverySO = new DeliverySO();
		deliverySO.setDlvrNo(dlvrNo);
		// 하나의 배송번호는 주문이나 클레임 한쪽에만 존재하고, 배송번호가 같은 주문 또는 크레임 정보들은 상태가 같으므로 LIMIT 1 조건을 추가할 때 사용함.
		deliverySO.setOnlyOne(Boolean.TRUE);
		List<DeliveryVO> listDeliveryOrderClaim = deliveryDao.listDeliveryOrderClaim(deliverySO);

		// 조회조건이 LIMIT 1 이므로 결과 갯수는 항상 1개임.
		DeliveryVO deliveryVO = listDeliveryOrderClaim.get(0);

		// 송장번호를 등록할 수 없는 상태일 때
		if (! isValidStatus(deliveryVO)) {
			log.error("주문, 클래임 상태가 송장번호 등록할 수 없는 상태 : DeliveryServiceImpl.process::isValidStatus : {}", deliveryVO);
			throw new CustomException(ExceptionConstants.ERROR_DELIVERY_INVALID_ORDCLM_STATUS);
		}

		// 자사상품일때 등록불가
		if (CommonConstants.COMP_GB_10.equals(deliveryVO.getCompGbCd())) {
			log.error("주문, 클래임 상태가 송장번호 등록할 수 없는 상태 : DeliveryServiceImpl.process::자사상품이라서 등록불가: {}", deliveryVO);
			throw new CustomException(ExceptionConstants.ERROR_DELIVERY_INVALID_ORDCLM_STATUS);
		}
		
		// 2. 택배사 코드 확인
		CodeDetailVO codeDetail = cacheService.getCodeCache(CommonConstants.HDC, hdcCd);

		// 등록되지 않은 택배사 코드인 경우
		if (codeDetail == null || StringUtils.isEmpty(codeDetail.getUsrDfn1Val())) {
			log.error("주문, 클래임 상태가 송장번호 등록할 수 없는 상태 : DeliveryServiceImpl.process::cacheService.getCodeCache : {}", deliveryVO);
			throw new CustomException(ExceptionConstants.ERROR_DELIVERY_INVALID_HDCCD);
		}

		// 3. 송장번호 유효성 확인 연동, 배송정보 저장, 송장번호(배송) 추적 연동
		List<InvoiceVO> invoices = new ArrayList<>();

		// 송장번호 split 하여 담음 - 2021.03.03 by kek01
		String[] invNos = StringUtil.split(invNo, ",");
		for(String myInvNo : invNos) {
			InvoiceVO invoice = new InvoiceVO();
			invoice.setInvoiceNo(myInvNo);
			invoice.setLogisticsCode(codeDetail.getUsrDfn1Val());

			invoices.add(invoice);
		}

		// 굿스플로우와 송장유효성 확인 연동
		List<biz.interfaces.goodsflow.model.response.data.InvoiceVO> goodsFlowResult = goodsFlowService.checkInvoiceNo(invoices);
		if (Objects.isNull(goodsFlowResult)) {
			// 굿스플로우 연동 중 에러 발생한 경우
			throw new CustomException(ExceptionConstants.ERROR_DELIVERY_GOODSFLOW_ERROR);
		}

		// 굿스플로우 연동 결과 유효한 송장번호일 때
		if (goodsFlowResult.get(0).isOk()) {

			// 배송정보 저장, 아래 송장번호 추적 연동 실패하면 롤백되어야 함.
			ordClmInvoiceOneCreateExec(dlvrNo, hdcCd, invNo);

			// 송장번호(배송) 추적 연동
			boolean successSendTrace = false;
			successSendTrace = goodsFlowService.sendTraceRequest(dlvrNo);

			if (! successSendTrace) {
				log.error("굿스플로우 송장번호(배송) 추적 연동 실패 : DeliveryServiceImpl.process::goodsFlowService.sendTraceRequest : dlvrNo {}, hdcCd {}, invNo{}", dlvrNo, hdcCd, invNo);
				throw new CustomException(ExceptionConstants.ERROR_DELIVERY_REQUEST_TRACE);
			}
			
			/*
			 * [ OUTBOUND API LOGIC ]
			 * added by tigerfive, 2017-10-10, 송장번호 등록 시 아웃바운드 API를 호출한다.
			 */
			if(StringUtils.isNotEmpty(deliveryVO.getOutsideOrdDtlNo())
					&& CommonConstants.OPENMARKET_11ST_CHANNEL_ID.equals(deliveryVO.getChnlId())) {
				// 아웃바운드 주문인 경우
				String apiUrl = bizConfig.getProperty("interface.ob.base.uri") + "/api/11st/order/complete";
				UrlConnect urlConnect = new UrlConnect(apiUrl, "GET", "utf-8");
				
				// 만약 같은 로직이 다른 곳에도 쓰인다면 공통모듈로 옮겨라
				String dlvEtprsCd = "00099";
				switch(hdcCd) {
				case CommonConstants.HDC_03:
					dlvEtprsCd = "00001"; // KG로지스
					break;
					
				case CommonConstants.HDC_02:
					dlvEtprsCd = "00002"; // 로젠택배
					break;
					
				case CommonConstants.HDC_04:
					dlvEtprsCd = "00007"; // 우체국택배
					break;
					
				case CommonConstants.HDC_05:
					dlvEtprsCd = "00011";  // 한진택배
					break;
					
				case CommonConstants.HDC_06:
					dlvEtprsCd = "00012"; // 롯데(현대)택배
					break;
					
				case CommonConstants.HDC_09:
					dlvEtprsCd = "00021"; // 대신택배
					break;
					
				case CommonConstants.HDC_10:
					dlvEtprsCd = "00022"; // 일양로지스
					break;
					
				case CommonConstants.HDC_21:
					dlvEtprsCd = "00023"; // ACI
					break;
					
				case CommonConstants.HDC_11:
					dlvEtprsCd = "00026"; // 경동택배
					break;
					
				case CommonConstants.HDC_13:
					dlvEtprsCd = "00027"; // 천일택배
					break;
					
				case CommonConstants.HDC_30:
					dlvEtprsCd = "00028"; // KGL(해외배송)
					break;
					
				case CommonConstants.HDC_08:
					dlvEtprsCd = "00033"; // GTX택배
					break;
					
				case CommonConstants.HDC_01:
					dlvEtprsCd = "00034"; // CJ대한통운
					break;
					
				case CommonConstants.HDC_12:
					dlvEtprsCd = "00035"; // 합동택배
					break;
					
				case CommonConstants.HDC_32:
					dlvEtprsCd = "00037"; // 건영택배
					break;
				default :
					 break;
				}
			
				try {
					String params = String.format("ordNo=%s&shopOrdNo=%s&sendDt=%s&dlvMthdCd=%s&dlvEtprsCd=%s&invcNo=%s&dlvNo=%d", 
							deliveryVO.getOutsideOrdDtlNo(),
							deliveryVO.getOrdNo(),
							DateUtil.calDate("yyyyMMddHHmm"),
							"01",
							dlvEtprsCd,
							invNo,
							dlvrNo);
					
					String response = urlConnect.connect(params);
					log.debug("response : " + response);
				} catch (Exception e) {
					log.debug(e.getLocalizedMessage());
				}
			}
		} else {
			log.error("굿스플로우 송장번호 유효성 확인 연동 실패 : DeliveryServiceImpl.process::goodsFlowService.checkInvoiceNo : {}", invoices);
			throw new CustomException(ExceptionConstants.ERROR_DELIVERY_INVALID_INVNO);
		}
	}

	/*
	 * 주문, 클래임 상태가 송장번호를 등록할 수 있는지 확인한다.
	 */
	private boolean isValidStatus(DeliveryVO deliveryVO) {
		boolean isValidStatus = false;

		if (StringUtils.equals(CommonConstants.ORD_CLM_GB_10, deliveryVO.getOrdClmGbCd())
				&& StringUtils.equals(CommonConstants.ORD_DTL_STAT_140, deliveryVO.getOrdDtlStatCd())
				&& deliveryVO.getOrdQty() > 0) {

			// 주문이고 상태값이 상품준비중 140 일 때 송장번호 등록가능함.
			isValidStatus = true;
		} else if (StringUtils.equals(CommonConstants.ORD_CLM_GB_20, deliveryVO.getOrdClmGbCd())
				&& (StringUtils.equals(CommonConstants.CLM_DTL_STAT_220, deliveryVO.getClmDtlStatCd())
						|| StringUtils.equals(CommonConstants.CLM_DTL_STAT_320, deliveryVO.getClmDtlStatCd())
						|| StringUtils.equals(CommonConstants.CLM_DTL_STAT_430, deliveryVO.getClmDtlStatCd()))) {

			// 클래임이고 상태값이 220, 320, 430 일 때 송장번호 등록가능함.
			isValidStatus = true;
		}

		return isValidStatus;
	}

	/*
	 * 배송 단건 조회
	 * @see biz.app.delivery.service.DeliveryService#getDelivery(biz.app.delivery.model.DeliverySO)
	 */
	@Override
	@Transactional( readOnly = true )
	public DeliveryVO getDelivery( Long dlvrNo ){
		DeliverySO deliverySO = new DeliverySO();
		deliverySO.setDlvrNo(dlvrNo);
		return deliveryDao.getDelivery( deliverySO );
	}

//	원본주석처리 - 2021.03.15 by kek01
//	/*
//	 * 배송 목록 조회 (페이징)
//	 * @see biz.app.delivery.service.DeliveryService#pageDeliveryList(biz.app.order.model.OrderSO)
//	 */
//	@Override
//	@Transactional(readOnly=true)
//	public List<DeliveryListVO> pageDeliveryList( OrderSO orderSO ) {
//		Integer rownum = 0;
//		List<DeliveryListVO> baseData  = deliveryDao.pageDeliveryList( orderSO ) ;
//		List<DeliveryListVO> returnData = new ArrayList<>();
//		for ( DeliveryListVO deliveryListVO : baseData){
//
//			int cnt  = deliveryListVO.getDeliveryDetailList().size()  ;
//			rownum = 0 ;
//			for (DeliveryListVO deliveryDetailListVO : deliveryListVO.getDeliveryDetailList() ){
//					rownum++;
//					deliveryDetailListVO.setOrdDtlRowNum(rownum);
//					deliveryDetailListVO.setOrdDtlCnt(cnt);
//
//					deliveryDetailListVO.setDlvrNo       ( deliveryListVO.getDlvrNo       () );
//					deliveryDetailListVO.setOrdClmGbCd   ( deliveryListVO.getOrdClmGbCd   () );
//					deliveryDetailListVO.setDlvrTpCd     ( deliveryListVO.getDlvrTpCd     () );
//					deliveryDetailListVO.setOrdCpltDtm   ( deliveryListVO.getOrdCpltDtm   () );
//					deliveryDetailListVO.setDlvrCmdDtm   ( deliveryListVO.getDlvrCmdDtm   () );
//					deliveryDetailListVO.setOoCpltDtm    ( deliveryListVO.getOoCpltDtm    () );
//					deliveryDetailListVO.setDlvrGbCd     ( deliveryListVO.getDlvrGbCd     () );
//					deliveryDetailListVO.setDlvrPrcsTpCd ( deliveryListVO.getDlvrPrcsTpCd () );
//					deliveryDetailListVO.setDlvrPrcsTpNm ( deliveryListVO.getDlvrPrcsTpNm () );
//					deliveryDetailListVO.setHdcCd        ( deliveryListVO.getHdcCd        () );
//					deliveryDetailListVO.setInvNo        ( deliveryListVO.getInvNo        () );
//					deliveryDetailListVO.setDlvrCpltDtm  ( deliveryListVO.getDlvrCpltDtm  () );
//					deliveryDetailListVO.setAdrsNm       ( deliveryListVO.getAdrsNm       () );
//					deliveryDetailListVO.setTel          ( deliveryListVO.getTel          () );
//					deliveryDetailListVO.setMobile       ( deliveryListVO.getMobile       () );
//					deliveryDetailListVO.setPostNoOld    ( deliveryListVO.getPostNoOld    () );
//					deliveryDetailListVO.setPrclAddr     ( deliveryListVO.getPrclAddr     () );
//					deliveryDetailListVO.setPrclDtlAddr  ( deliveryListVO.getPrclDtlAddr  () );
//					deliveryDetailListVO.setPostNoNew    ( deliveryListVO.getPostNoNew    () );
//					deliveryDetailListVO.setRoadAddr     ( deliveryListVO.getRoadAddr	  () );
//					deliveryDetailListVO.setRoadDtlAddr  ( deliveryListVO.getRoadDtlAddr  () );
//					deliveryDetailListVO.setDlvrMemo     ( deliveryListVO.getDlvrMemo     () );
//					returnData.add(deliveryDetailListVO);
//					log.debug( "deliveryDetailListVO >>>> = {}", deliveryDetailListVO );
//			}
//		}
//
//
//		return returnData;
//
//	}
//		
	/*
	 * 배송 목록 조회 (페이징)
	 * @see biz.app.delivery.service.DeliveryService#pageDeliveryList(biz.app.order.model.OrderSO)
	 * 2021.03.15 by kek01
	 */
	@Override
	@Transactional(readOnly=true)
	public List<DeliveryListVO> pageDeliveryList( OrderSO orderSO ) {
		List<DeliveryListVO> returnData  = deliveryDao.pageDeliveryList( orderSO ) ;
		if(returnData != null && returnData.size() > 0 && CommonConstants.ORD_CLM_GB_20.equals(orderSO.getOrdClmGbCd())) { //클레임배송관리 조회일때 목록 총갯수 SET - 2021.06.10 by kek01
			orderSO.setTotalCount(returnData.get(0).getTotalCnt());
		}
		return returnData;
	}

	public DeliveryPO returnCopyDeliveryPO(DeliveryVO target) {
		DeliveryPO source = new DeliveryPO();
        source.setOrdClmGbCd   ( target.getOrdClmGbCd  ()     );
        source.setDlvrGbCd     ( target.getDlvrGbCd    ()     );
        source.setDlvrTpCd     ( target.getDlvrTpCd    ()     );
        source.setDlvrPrcsTpCd ( target.getDlvrPrcsTpCd()     );
        source.setOrdDlvraNo   ( target.getOrdDlvraNo  ()     );
        source.setHdcCd        ( target.getHdcCd       ()     );
        source.setInvNo        ( target.getInvNo       ()     );
        source.setDlvrCmdDtm   ( target.getDlvrCmdDtm  ()     );
        source.setOoCpltDtm    ( target.getOoCpltDtm   ()     );
        source.setCisOoYn      ( target.getCisOoYn     ()     );
        source.setCisOoNo      ( target.getCisOoNo     ()     );
        source.setCisHdcCd     ( target.getCisHdcCd    ()     );
        source.setCisInvNo     ( target.getCisInvNo    ()     );
		return source;
	}
	
	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.delivery.service
	* - 파일명      : DeliveryServiceImpl.java
	* - 작성일      : 2017. 3. 10.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  주문클라임 송장 단일 등록
	* </pre>
	 */
	@Override
	public void ordClmInvoiceOneCreateExec(Long dlvrNo,String hdcCd, String invNo ) {

		/**********************************
		 * 배송 내역조회
		 **********************************/
		DeliverySO dso = new DeliverySO();
		dso.setDlvrNo(dlvrNo);
		DeliveryVO delivery = this.deliveryDao.getDelivery(dso);

		if(delivery == null){
			throw new CustomException(ExceptionConstants.ERROR_DELIVERY_NO_EXISTS); //배송정보가 존재하지 않습니다.
		}

		if (StringUtils.isNotEmpty(delivery.getHdcCd()) && StringUtils.isNotEmpty(delivery.getInvNo())) {
			throw new CustomException(ExceptionConstants.ERROR_DELIVERY_ALREADY_USED); //배송정보가 기 등록된 건입니다.
		}
		
		// 송장번호 여러개 처리 - 2021.03.03 by kek01
		String[] invNos = StringUtil.split(invNo, ",");
		List<Long> newDlvrNos = new ArrayList<Long>();
		int resultStep01 = 0;
		int index = 0;
		for(String myInvNo : invNos) {
			index++;
			if(index == 1) {
				/**********************************
				 * 배송테이블의 배송정보 수정
				 **********************************/
				DeliveryPO deliveryPO = new DeliveryPO();
				deliveryPO.setDlvrNo(dlvrNo);
				deliveryPO.setHdcCd(hdcCd);
				deliveryPO.setInvNo(myInvNo);
				deliveryPO.setOoCplt("Y");     //송장등록시 출고 완료 일시 등록
				resultStep01 += this.deliveryDao.updateDelivery( deliveryPO );
			}else{
				/**********************************
				 * 배송테이블의 배송정보 등록
				 **********************************/
				Long newDlvrNo = bizService.getSequence(CommonConstants.SEQUENCE_DLVR_NO_SEQ);
				DeliveryPO deliveryPO = new DeliveryPO();
				deliveryPO = returnCopyDeliveryPO(delivery);
				deliveryPO.setDlvrNo(newDlvrNo); //신규 배송번호
				deliveryPO.setHdcCd(hdcCd);
				deliveryPO.setInvNo(myInvNo);
				deliveryPO.setOoCpltDtm(DateUtil.getTimestamp());     //송장등록시 출고 완료 일시 등록
				resultStep01 += this.deliveryDao.insertDelivery( deliveryPO );
				newDlvrNos.add(newDlvrNo);
			}
		}
		if ( resultStep01 == 0 ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
		
		/********************************************************
		 * 주문 상세 구성 배송 매핑 또는 클레임 상세 구성 배송 매핑 등록
		 ********************************************************/
		if(AdminConstants.ORD_CLM_GB_10.equals(delivery.getOrdClmGbCd())){ //주문
			for(Long newMyDlvrNo : newDlvrNos) {
				OrdDtlCstrtDlvrMapPO po = new OrdDtlCstrtDlvrMapPO();
				po.setNewDlvrNo(newMyDlvrNo);
				po.setDlvrNo(dlvrNo);
				ordDtlCstrtDlvrMapDao.insertOrdDtlCstrtDlvrMapByDlvrNo(po);
			}
		}else{//클레임
			for(Long newMyDlvrNo : newDlvrNos) {
				ClmDtlCstrtDlvrMapPO po = new ClmDtlCstrtDlvrMapPO();
				po.setNewDlvrNo(newMyDlvrNo);
				po.setDlvrNo(dlvrNo);
				clmDtlCstrtDlvrMapDao.insertClmDtlCstrtDlvrMapByDlvrNo(po);
			}
		}
		
		/**********************************
		 * 배송과 연계된 주문상세 또는 클레임상세 목록조회
		 **********************************/
		DeliverySO   deliverySO = new DeliverySO();
		deliverySO.setDlvrNo(dlvrNo);
		List<DeliveryVO> listDeliveryOrderClaim = this.deliveryDao.listDeliveryOrderClaim(  deliverySO );

		/**********************************
		 * 주문상세 또는 클레임상세의 상태값 수정
		 **********************************/
		String  clmNo = null;
		Integer clmDtlSeq= 0;
		String  clmDtlStatCd = null;

		String ordNo = null;
		String ordClmGbCd = null;

		for (DeliveryVO deliveryVO :listDeliveryOrderClaim) {
			// 주문이고 상태값이 상품준비중 140 이면 업데이트 하라!
			if (   AdminConstants.ORD_CLM_GB_10.equals(deliveryVO.getOrdClmGbCd())
				&& AdminConstants.ORD_DTL_STAT_140.equals(deliveryVO.getOrdDtlStatCd() )
				&& deliveryVO.getOrdQty() > 0
			   ){
				// 주문 상세 변경 - 주문상세 상태코드
				this.orderDetailService.updateOrderDetailStatus( deliveryVO.getOrdNo(), deliveryVO.getOrdDtlSeq(), AdminConstants.ORD_DTL_STAT_150 );
				
				// 일반배송/업체배송건 '배송중'로 상태 변경 시 //TODO 송장번호 단위 발송으로 변경되어 배치에서 발송됨 2021.09.02 by ksy02
//				if(StringUtils.equals(deliveryVO.getDlvrPrcsTpCd(), CommonConstants.DLVR_PRCS_TP_10)) {
//					orderService.sendMessage(deliveryVO.getOrdNo(), "", "K_M_ord_0016" , deliveryVO.getOrdDtlSeq());
//				}

			}
	 		// 주문이고 상태값이   220 , 320, 430  이면 업데이트 하라!
			else if (   AdminConstants.ORD_CLM_GB_20.equals(deliveryVO.getOrdClmGbCd())
				&& ( 	AdminConstants.CLM_DTL_STAT_220.equals(deliveryVO.getClmDtlStatCd())
				     || AdminConstants.CLM_DTL_STAT_320.equals(deliveryVO.getClmDtlStatCd())
				     || AdminConstants.CLM_DTL_STAT_430.equals(deliveryVO.getClmDtlStatCd())
				   )
				){

				// 클레임 상세 변경 - 주문상세 상태코드
				clmNo = deliveryVO.getClmNo() ;
 				clmDtlSeq = deliveryVO.getClmDtlSeq() ;
				if (AdminConstants.CLM_DTL_STAT_220.equals(deliveryVO.getClmDtlStatCd()) ) {
					clmDtlStatCd   = AdminConstants.CLM_DTL_STAT_230 ;
				}else if (AdminConstants.CLM_DTL_STAT_320.equals(deliveryVO.getClmDtlStatCd()) ) {
					clmDtlStatCd   = AdminConstants.CLM_DTL_STAT_330 ;
				}else if (AdminConstants.CLM_DTL_STAT_430.equals(deliveryVO.getClmDtlStatCd()) ) {
					clmDtlStatCd   = AdminConstants.CLM_DTL_STAT_440 ;
				}
				claimDetailService.updateClaimDetailStatus(  clmNo,   clmDtlSeq,   clmDtlStatCd);
			}

			ordNo = deliveryVO.getOrdNo();
			ordClmGbCd =deliveryVO.getOrdClmGbCd();
		}

		// 주문일 경우만 이메일을 보냄 - //TODO 이메일/SMS 보류 2021.03.03 by kek01
//		if(  AdminConstants.ORD_CLM_GB_10.equals(ordClmGbCd)  ){


//			delivery = this.deliveryDao.getDelivery(dso);
//
//			//주문정보
//			OrderBaseSO orderBaseSO = new OrderBaseSO();
//			orderBaseSO.setOrdNo(ordNo);
//			OrderBaseVO orderBaseVO  = orderBaseDao.getOrderBase(orderBaseSO);
//
//
//			/*log.debug( "==================================================" );
//			log.debug( "   orderBaseVO>>>" +orderBaseVO.toString() );
//			log.debug( "==================================================" );
//			*/
//
//			//배송정보
//			OrderDlvraSO orderDlvraSO = new OrderDlvraSO();
//			orderDlvraSO.setOrdNo(  ordNo   );
//			OrderDlvraVO deliveryInfo  = orderDlvraService.getOrderDlvra(orderDlvraSO);
//
//
//
//			/*log.debug( "==================================================" );
//			log.debug( "   deliveryInfo>>>" +deliveryInfo.toString() );
//			log.debug( "==================================================" );
//
//			*/
//			//택배사코드
//			List<CodeDetailVO> hdcList = this.cacheService.listCodeCache(AdminConstants.HDC, null, null, null, null, null) ;
//
//
//			EmailSend email = new EmailSend();
//
//
//			//email.setReceiverNm(orderBaseVO.getOrdrId());
//			email.setReceiverNm(orderBaseVO.getOrdNm());
//			email.setReceiverEmail(orderBaseVO.getOrdrEmail());
//			email.setMbrNo(orderBaseVO.getMbrNo());
//			email.setStId(orderBaseVO.getStId());
//			email.setEmailTpCd(CommonConstants.EMAIL_TP_230);
//
//
//			email.setMap01(ordNo);
//			email.setMap02(DateUtil.getTimestampToString(orderBaseVO.getOrdAcptDtm(), "yyyy-MM-dd HH:mm"));
//			// 택배사명 뒤에 우체국택배 (발송일:2017.03.03)
//			email.setMap03( returnToName(hdcCd,hdcList)+ " (발송일:"+DateUtil.getTimestampToString(delivery.getOoCpltDtm(), "yyyy.MM.dd")+")" );
//			email.setMap04( invNo );
//
//
//			email.setMap08( deliveryInfo.getAdrsNm() );
//			email.setMap09( deliveryInfo.getMobile()   );
//			email.setMap10( deliveryInfo.getRoadAddr()  +" "+ deliveryInfo.getRoadDtlAddr()  );
//			email.setMap11( deliveryInfo.getDlvrMemo()  );
//			email.setMap12( HumusonConstants.EMAIL_DLVR_TP_01 );
//			List<EmailSendMap> mapList  = new ArrayList<>();
//
//
//			OrderDetailSO orderDetailSO = new OrderDetailSO();
//			//orderDetailSO.setOrdNo(ordNo);
//			orderDetailSO.setDlvrNo(dlvrNo);
//			//주문상세목록
//			List<OrderDetailVO> orderDetailVO = orderDetailService.listOrderDetail(orderDetailSO);
//			String goodsNm = "";
//			int goodsCnt  = 0 ;
//			for (OrderDetailVO vo : orderDetailVO)
//			{   if( vo.getRmnOrdQty() > 0 )   {
//					EmailSendMap emailSendMap  = new EmailSendMap() ;
//					goodsNm = vo.getGoodsNm();
//					emailSendMap.setMap01(GoodsUtil.getGoodsImageSrc(bizConfig.getProperty("image.domain"), vo.getImgPath(), vo.getGoodsId(), vo.getImgSeq(), ImageGoodsSize.SIZE_70.getSize()));
//					emailSendMap.setMap02("["+vo.getBndNmKo()+"]"+vo.getGoodsNm());
//					emailSendMap.setMap03(vo.getItemNm()+" / "+  vo.getOrdQty() + "개");
//
//					mapList.add(emailSendMap);
//					goodsCnt = goodsCnt +1 ;
//				}
//			}
//
//			bizService.sendEmail(email,mapList);
//
//
//			StStdInfoVO stInfo =  this.stDao.getStStdInfo(orderBaseVO.getStId());
//
//			LmsSendPO lmsPO = new LmsSendPO();
//			lmsPO.setSendPhone(stInfo.getCsTelNo());
//			lmsPO.setReceivePhone( orderBaseVO.getOrdrMobile()   );
//			lmsPO.setReceiveName( orderBaseVO.getOrdNm() );
//
//			if (goodsCnt -1 > 0 ){
//				goodsNm = goodsNm +"외"+ ( goodsCnt -1 ) +"개" ;
//			}
//
//			CodeDetailVO title = cacheService.getCodeCache(AdminConstants.SMS_TP, AdminConstants.SMS_TP_230);
//			String subject = title.getUsrDfn2Val();    // 제목
//			String msg = title.getUsrDfn3Val();    // 내용
//			subject = StringUtil.replaceAll(subject, CommonConstants.SMS_TITLE_ARG_MALL_NAME, orderBaseVO.getStNm());
//			msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_MALL_NAME,  orderBaseVO.getStNm());
//			msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_ORD_NO,  ordNo);
//			msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_GOODS_NM,  goodsNm);
//			msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_HDC_NM,  returnToName(hdcCd,hdcList)    );
//			msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_INV_NO,  invNo);
//
//			lmsPO.setSubject(subject);
//			lmsPO.setMsg(msg);
//			//StringUtil.cutText(lmsPO.getMsg() , 30, true)
//			bizService.sendLms(lmsPO);



//		}



	}

	public String returnToName(String inCode ,List<CodeDetailVO> listdata){
		String returnName = null;
		for ( CodeDetailVO codeDetailVO : listdata ) {
				if( inCode != null && !"".equals(inCode) && codeDetailVO.getDtlCd().trim().equals(inCode.trim())){
					returnName = codeDetailVO.getDtlNm();
				}
		}
		return returnName;
	}



	/**
	 * 배송완료 처리
	 */
	@Override
	public void deliveryFinalExec( Long[] arrDlvrNo,Long mbrNo  ) {
		List<Long> resultArray  = new ArrayList<>();
		
		//보안 진단. 불필요한 코드 (비어있는 IF문)
		/*if(arrDlvrNo == null){
		}else{*/
		if(arrDlvrNo != null) {
			  //for(int i=0; i < arrDlvrNo.length;i++){
			  for(long longdlvrNo : arrDlvrNo ){
				  Long el = longdlvrNo;
			  	  int idx = -1;
				 /*if(resultArray == null ||   el == null  ){
				 }else{*/
			  	  //보안 진단. 불필요한 코드 (비어있는 IF문)
			  	  if(resultArray != null && el != null) {
					  for(int j=0;j < resultArray.size() ;j++){
						   if(resultArray.get(j).equals(el)){
						   idx = j;
						    break;
						   }
					  }
				 }
			   	if( idx   ==  -1 ) {
					   resultArray.add( el);
				}
			 }
		 }
		//arrDlvrNo = null ;
		arrDlvrNo = resultArray.toArray(new Long[resultArray.size()]);

		if(arrDlvrNo != null && arrDlvrNo.length > 0){
			
			boolean deliveryHistFlag = false;
			
			for (int i = 0; i < arrDlvrNo.length; i++) {

				// 배송정보  업데이트
				DeliveryPO deliveryPO = new DeliveryPO();
				deliveryPO.setDlvrNo( arrDlvrNo[i] );
				deliveryPO.setDlvrCplt("Y");
				deliveryDao.updateDelivery( deliveryPO );

				DeliverySO deliverySO = new DeliverySO();
				deliverySO.setDlvrNo( arrDlvrNo[i] );
				List<DeliveryVO> listdeliveryVO  = deliveryDao.listDeliveryInDlvrCpltYFromOrderClaim(deliverySO );
				
				String prvOrderNo = "";
				List<Integer> filterList = new ArrayList<Integer>();
				List<Integer> ordDtlSeqList = new ArrayList<Integer>();
				deliveryHistFlag = false;
				
				if (listdeliveryVO != null && listdeliveryVO.size() > 0) {
					for ( DeliveryVO deliveryVO : listdeliveryVO ) {
						
						if (CommonConstants.ORD_DTL_STAT_150.equals(deliveryVO.getOrdDtlStatCd()) || AdminConstants.CLM_DTL_STAT_440.equals(deliveryVO.getClmDtlStatCd())) {
							deliveryHistFlag = true;
						}
						
						if (!CommonConstants.COMM_YN_Y.equals(deliveryVO.getDlvrCpltYn())) {
							continue;
						}
						
						if (!StringUtil.equals(prvOrderNo, deliveryVO.getOrdNo())) {
							if (CollectionUtils.isNotEmpty(filterList)) {
								for(Integer filterOrdDtlSeq : filterList) {
									if (!ordDtlSeqList.contains(filterOrdDtlSeq)) {
										ordDtlSeqList.add(filterOrdDtlSeq);
									}
								}
								
								if (CollectionUtils.isNotEmpty(ordDtlSeqList)) {
									Integer[] arrOrdDtlSeq = ordDtlSeqList.toArray(new Integer[ordDtlSeqList.size()]);
									orderService.sendMessage(prvOrderNo, "", "K_M_ord_0018", null, arrOrdDtlSeq);
									filterList.clear();
									ordDtlSeqList.clear();
								}
							}
						}
						
						if (AdminConstants.ORD_CLM_GB_10.equals(deliveryVO.getOrdClmGbCd())) {
							if (CommonConstants.ORD_DTL_STAT_150.equals(deliveryVO.getOrdDtlStatCd())) {
								// 배송완료
								this.orderDetailService.updateOrderDetailStatusDlvrCplt( deliveryVO.getOrdNo(), deliveryVO.getOrdDtlSeq(), AdminConstants.ORD_DTL_STAT_160 );
								
								// 일반배송/업체배송건 '배송완료'로 상태 변경 시
								if(StringUtils.equals(deliveryVO.getDlvrPrcsTpCd(), CommonConstants.DLVR_PRCS_TP_10)
									&& !StringUtils.equals(deliveryVO.getCompGbCd(), CommonConstants.COMP_GB_20)
										) {
									prvOrderNo = deliveryVO.getOrdNo();
									filterList.add(deliveryVO.getOrdDtlSeq());
								}
							}
						} else if (AdminConstants.ORD_CLM_GB_20.equals(deliveryVO.getOrdClmGbCd())) {
							if (AdminConstants.CLM_DTL_STAT_230.equals(deliveryVO.getClmDtlStatCd())) {
								// 반품 회수완료
								claimDetailService.updateClaimDetailStatusDlvrCplt(  deliveryVO.getClmNo(),deliveryVO.getClmDtlSeq()  ,AdminConstants.CLM_DTL_STAT_240);
							} else if (AdminConstants.CLM_DTL_STAT_330.equals(deliveryVO.getClmDtlStatCd())) {
								// 교환 회수완료
								claimDetailService.updateClaimDetailStatusDlvrCplt(  deliveryVO.getClmNo(),deliveryVO.getClmDtlSeq()  ,AdminConstants.CLM_DTL_STAT_340);
							} else if (AdminConstants.CLM_DTL_STAT_440.equals(deliveryVO.getClmDtlStatCd())) {
								// 교환 배송완료
								int result = claimDetailService.updateClaimDetailStatusDlvrCplt(  deliveryVO.getClmNo(),deliveryVO.getClmDtlSeq()  ,AdminConstants.CLM_DTL_STAT_450);
								if(result > 0) {
									claimService.completeClaim(deliveryVO.getClmNo() , mbrNo);
								}
							}
						}

					}
				}

				if (i == arrDlvrNo.length-1) {
					if (CollectionUtils.isNotEmpty(filterList)) {
						for(Integer filterOrdDtlSeq : filterList) {
							if (!ordDtlSeqList.contains(filterOrdDtlSeq)) {
								ordDtlSeqList.add(filterOrdDtlSeq);
							}
						}
						
						if (CollectionUtils.isNotEmpty(ordDtlSeqList)) {
							Integer[] arrOrdDtlSeq = ordDtlSeqList.toArray(new Integer[ordDtlSeqList.size()]);
							orderService.sendMessage(prvOrderNo, "", "K_M_ord_0018", null, arrOrdDtlSeq);
							filterList.clear();
							ordDtlSeqList.clear();
						}
					}
				}
				
				// 배송 히스토리 등록(배송완료) - 일반 배송완료, 교환배송완료
				if(deliveryHistFlag) {
					DeliveryHistPO deliveryHistPO = new DeliveryHistPO();
					deliveryHistPO.setDlvrNo(deliverySO.getDlvrNo());
					insertDeliveryHist(deliveryHistPO);
				}

			}
		}

		//========================================================================
		// Email 그리고 LMS 보내기  - //TODO 보류 이메일발송 공통함수 변경해야됨, 2021.03.04 by kek01
		//========================================================================

//		Long   dlvrNo = 0L;
//		String ordNo ="";
//		String hdcCd ="";
//		String invNo ="";
//		//택배사코드
//		List<CodeDetailVO> hdcList = this.cacheService.listCodeCache(AdminConstants.HDC, null, null, null, null, null) ;
//		if(arrDlvrNo != null && arrDlvrNo.length > 0){
//			int cnt = 0;
//			for (int i = 0; i < arrDlvrNo.length; i++) {
//				cnt = 1 ;
//				DeliverySO deliverySO = new DeliverySO();
//				deliverySO.setDlvrNo( arrDlvrNo[i] );
//				DeliveryVO    deliveryVO  = deliveryDao.getDelivery( deliverySO );
//
//				//log.debug( "= ★★★★1★     arrDlvrNo[i] i >>>>>{},{}",i,arrDlvrNo[i] );
//
//				if(deliveryVO != null  
//					&& AdminConstants.ORD_CLM_GB_10.equals(deliveryVO.getOrdClmGbCd())
//					&&	cnt == 1 && !dlvrNo.equals(arrDlvrNo[i])){
//					cnt = cnt +1 ;
//
//					dlvrNo = arrDlvrNo[i];
//					ordNo = deliveryVO.getOrdNo();
//					hdcCd = deliveryVO.getHdcCd();
//					invNo = deliveryVO.getInvNo();
//
//					//log.debug( "= ★★★★2★     ordNo >>>>>{}",ordNo );
//					//log.debug( "= ★★★★3★     dlvrNo >>>>>{}",dlvrNo );
//
//					//주문정보
//					OrderBaseSO orderBaseSO = new OrderBaseSO();
//					orderBaseSO.setOrdNo(ordNo);
//					OrderBaseVO orderBaseVO  = orderBaseDao.getOrderBase(orderBaseSO);
//					//배송정보
//					OrderDlvraSO orderDlvraSO = new OrderDlvraSO();
//					orderDlvraSO.setOrdNo(  ordNo   );
//					OrderDlvraVO deliveryInfo  = orderDlvraService.getOrderDlvra(orderDlvraSO);
//
//
//					EmailSend email = new EmailSend();
//					//email.setReceiverNm(orderBaseVO.getOrdrId());
//					email.setReceiverNm(orderBaseVO.getOrdNm());
//					email.setReceiverEmail(orderBaseVO.getOrdrEmail());
//					email.setMbrNo(orderBaseVO.getMbrNo());
//					email.setStId(orderBaseVO.getStId());
//					email.setEmailTpCd(CommonConstants.EMAIL_TP_240);
//					email.setMap01(ordNo);
//					email.setMap02(DateUtil.getTimestampToString(orderBaseVO.getOrdAcptDtm(), "yyyy-MM-dd HH:mm"));
//					// 택배사명 뒤에 우체국택배 (발송일:2017.03.03)
//					email.setMap03( returnToName(hdcCd,hdcList)+ " (발송일:"+DateUtil.getTimestampToString(deliveryVO.getOoCpltDtm(), "yyyy.MM.dd")+")" );
//
//
//					email.setMap04( invNo );
//
//					email.setMap08( deliveryInfo.getAdrsNm() );
//					email.setMap09( deliveryInfo.getMobile()   );
//					email.setMap10( deliveryInfo.getRoadAddr()  +" "+ deliveryInfo.getRoadDtlAddr()  );
//					email.setMap11( deliveryInfo.getDlvrMemo()  );
//					email.setMap12( HumusonConstants.EMAIL_DLVR_TP_02 );
//
//					List<EmailSendMap> mapList  = new ArrayList<>();
//					OrderDetailSO orderDetailSO = new OrderDetailSO();
//					orderDetailSO.setDlvrNo(dlvrNo);
//					//주문상세목록
//					List<OrderDetailVO> orderDetailVO = orderDetailService.listOrderDetail(orderDetailSO);
//					String goodsNm = "";
//					int goodsCnt  = 0 ;
//					for (OrderDetailVO vo : orderDetailVO)
//					{   if( vo.getRmnOrdQty() > 0 )   {
//							EmailSendMap emailSendMap  = new EmailSendMap() ;
//							goodsNm = vo.getGoodsNm();
//							emailSendMap.setMap01(GoodsUtil.getGoodsImageSrc(bizConfig.getProperty("image.domain"), vo.getImgPath(), vo.getGoodsId(), vo.getImgSeq(), ImageGoodsSize.SIZE_70.getSize()));
//							emailSendMap.setMap02("["+vo.getBndNmKo()+"]"+vo.getGoodsNm());
//							emailSendMap.setMap03(vo.getItemNm()+" / "+  vo.getOrdQty() + "개" );
//
//
//
//							mapList.add(emailSendMap);
//
//							goodsCnt = goodsCnt +1 ;
//
//						}
//					}
//
//					bizService.sendEmail(email,mapList);
//
//					StStdInfoVO stInfo =  this.stDao.getStStdInfo(orderBaseVO.getStId());
//
//					LmsSendPO lmsPO = new LmsSendPO();
//					lmsPO.setSendPhone(stInfo.getCsTelNo());
//					lmsPO.setReceivePhone( orderBaseVO.getOrdrMobile()   );
//					lmsPO.setReceiveName( orderBaseVO.getOrdNm() );
//
//					if (goodsCnt -1 > 0 ){
//						StringBuilder bld = new StringBuilder();
//						bld.append(goodsNm).append("외").append("( goodsCnt -1 )").append("개");
//						goodsNm = bld.toString();
//					}
//
//
//					CodeDetailVO title = cacheService.getCodeCache(AdminConstants.SMS_TP, AdminConstants.SMS_TP_240);
//					String subject = title.getUsrDfn2Val();    // 제목
//					String msg = title.getUsrDfn3Val();    // 내용
//					subject = StringUtil.replaceAll(subject,CommonConstants.SMS_TITLE_ARG_MALL_NAME, orderBaseVO.getStNm());
//					msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_MALL_NAME,  orderBaseVO.getStNm());
//					msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_GOODS_NM,  goodsNm);
//					msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_HDC_NM,  returnToName(hdcCd,hdcList)    );
//					msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_INV_NO,  invNo);
//					msg = StringUtil.replaceAll(msg,CommonConstants.SMS_MSG_ARG_DLVR_CPLT_DTM,  DateUtil.getTimestampToString(deliveryVO.getDlvrCpltDtm(), "yyyy-MM-dd HH:mm") );
//
//					lmsPO.setSubject(subject);
//					lmsPO.setMsg(msg);
//					bizService.sendLms(lmsPO);
//
//				}
//
//			}
//		}


		//throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );

	}


	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.order.service
	* - 파일명      : OrderDetailService.java
	* - 작성일      : 2017. 3. 15.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 배송분리
	* </pre>
	 */
	@Override
	public void deliveryDivision( String[] arrOrdNo, Integer[] arrOrdDtlSeq   ) {

		Long newDlvrNo = this.bizService.getSequence(CommonConstants.SEQUENCE_DLVR_NO_SEQ) ;
		//Long oldDlvrNo = 0L;
		if(arrOrdNo != null && arrOrdNo.length > 0){
			DeliveryVO deliveryVO = new DeliveryVO();
			for (int i = 0; i < arrOrdNo.length; i++) {

				OrderDetailVO orderDetail = this.orderDetailService.getOrderDetail(arrOrdNo[i], arrOrdDtlSeq[i]);
				if(orderDetail != null
						&& ( CommonConstants.ORD_DTL_STAT_130.equals(orderDetail.getOrdDtlStatCd())
								   || CommonConstants.ORD_DTL_STAT_140.equals(orderDetail.getOrdDtlStatCd()) )){

					//if(oldDlvrNo != orderDetail.getDlvrNo()  ){
						/**********************************
						 * 기존 배송정보
						 **********************************/
						DeliverySO so  = new DeliverySO();
						so.setDlvrNo( orderDetail.getDlvrNo());
						deliveryVO = deliveryDao.getDelivery(so);
						log.debug( "================================" );
						log.debug( "= deliveryVO{}",deliveryVO );
						log.debug( "================================" );
						/**********************************
						 * 배송테이블의 배송정보 오더디테일 수정
						 **********************************/
						// 주문 배송번호 수정
						OrderDetailPO odpo = new OrderDetailPO();
						odpo.setOrdNo( arrOrdNo[i] );
						odpo.setOrdDtlSeq(arrOrdDtlSeq[i]);
						odpo.setDlvrNo(newDlvrNo);
						int result = this.orderDetailDao.updateOrderDetail(odpo);
						if ( result == 0 ) {
							throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
						}
					//}
				}
				//oldDlvrNo = orderDetail.getDlvrNo();
			}

			/**********************************
			 * 배송테이블의 배송정보 신규등록
			 **********************************/
			DeliveryPO deliveryPO = new DeliveryPO();
			deliveryPO.setDlvrNo(   newDlvrNo   );
			deliveryPO.setOrdClmGbCd	( deliveryVO.getOrdClmGbCd()	);	/* 주문 클레임 구분 코드    */
			deliveryPO.setDlvrGbCd		( deliveryVO.getDlvrGbCd()		);	/* 배송 구분 코드	    */
			deliveryPO.setDlvrTpCd		( deliveryVO.getDlvrTpCd()		);	/* 배송 유형 코드	    */
			deliveryPO.setDlvrPrcsTpCd	( deliveryVO.getDlvrPrcsTpCd()	);	/* 배송 처리 유형 코드	    */
			deliveryPO.setOrdDlvraNo	( deliveryVO.getOrdDlvraNo()	);	/* 주문 배송지 번호	    */
			//deliveryPO.setHdcCd  		( deliveryVO.getHdcCd()  	    );	/* 택배사 코드		    */
			//deliveryPO.setInvNo	    ( deliveryVO.getInvNo()	        );	/* 송장 번호		    */
			deliveryPO.setDlvrCmdDtm	( deliveryVO.getDlvrCmdDtm()	);	/* 배송 지시 일시	    */
			deliveryPO.setOoCpltDtm		( deliveryVO.getOoCpltDtm()	    );	/* 출고 완료 일시	    */
			deliveryPO.setDlvrCpltDtm	( deliveryVO.getDlvrCpltDtm()	);	/* 배송 완료 일시	    */
			log.debug( "================================" );
			log.debug( "= deliveryPO{}",deliveryPO );
			log.debug( "================================" );

			int result = this.deliveryDao.insertDelivery(deliveryPO);
			if ( result == 0 ) {
				throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
			}


		}


	}
	/**
	 *
	* <pre>
	* - 프로젝트명   : 11.business
	* - 패키지명   : biz.app.delivery.service
	* - 파일명      : DeliveryServiceImpl.java
	* - 작성일      : 2017. 5. 16.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 송장 단순 수정
	* </pre>
	 */
	@Override
	public void deliveryInvoiceUpdateExec(Long dlvrNo,String hdcCd, String invNo ) {

			/**********************************
			 * 배송테이블의 배송정보 수정
			 **********************************/
			DeliveryPO deliveryPO = new DeliveryPO();
			deliveryPO.setDlvrNo(dlvrNo);
			deliveryPO.setHdcCd(hdcCd);
			deliveryPO.setInvNo(invNo);

			int resultStep01 = this.deliveryDao.updateDelivery( deliveryPO );
			if ( resultStep01 == 0 ) {
				throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
			}
	}


	@Override
	public boolean checkGoodsFlowDelivery(Long dlvrNo) {
		return StringUtils.equals(deliveryDao.getFlagGoodsFlowDelivery(dlvrNo), CommonConstants.COMM_YN_Y);
	}

	@Override
	public biz.interfaces.goodsflow.model.request.data.DeliveryVO getGoodsFlowDelivery(Long dlvrNo) {
		DeliveryVO vo = getDelivery(dlvrNo);
		biz.interfaces.goodsflow.model.request.data.DeliveryVO rsltVO = new biz.interfaces.goodsflow.model.request.data.DeliveryVO();
		
		if(CommonConstants.DLVR_TP_120.equals(vo.getDlvrTpCd())) { //교환출고일때 적용 - 2021.05.17 by kek01
			rsltVO = StringUtils.equals(vo.getDlvrGbCd(), CommonConstants.DLVR_GB_10) ? deliveryDao.getGoodsFlowDeliveryClaim(dlvrNo) : deliveryDao.getGoodsFlowReturn(dlvrNo);
		}else {
			rsltVO = StringUtils.equals(vo.getDlvrGbCd(), CommonConstants.DLVR_GB_10) ? deliveryDao.getGoodsFlowDelivery(dlvrNo) : deliveryDao.getGoodsFlowReturn(dlvrNo);
		}
		return rsltVO;
	}

	@Override
	public List<DeliveryGoodsVO> getGoodsFlowDeliveryGoods(DeliveryGoodsSO so) {
		return StringUtils.equals(so.getDlvrGbCd(), CommonConstants.DLVR_GB_10) ? deliveryDao.getGoodsFlowDeliveryGoods(so) : deliveryDao.getGoodsFlowReturnGoods(so);
	}

	@Override
	public int insertGoodsFlowDelivery(GoodsFlowDeliveryPO po) {
		return deliveryDao.insertGoodsFlowDelivery(po);
	}

	@Override
	public int insertGoodsFlowDeliveryResult(GoodsFlowDeliveryResultPO po) {
		return deliveryDao.insertGoodsFlowDeliveryResult(po);
	}

	@Override
	public Long getDeliveryNoByItemUniqueCode(String itemUniqueCode) {
		return deliveryDao.getDeliveryNoByItemUniqueCode(itemUniqueCode);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: DeliveryService.java
	* - 작성일		: 2017. 6. 15.
	* - 작성자		:
	* - 설명		: 굿스플로 배송 조회 링크를 위한 고유번호 조회 (FO,MO 사용)
	* </pre>
	* @param so
	* @return
	 */
	@Override
	public DeliveryVO getGoodsFlowCode(OrderSO orderSO){
		return deliveryDao.getGoodsFlowCode(orderSO);
	}
	
	@Override
	public List<DeliveryVO> getGoodsFlowRequestTraceList(DeliverySO so){
		return deliveryDao.getGoodsFlowRequestTraceList(so);
	}

	@Override
	public List<DeliveryVO> listDeliveryConsignComp(DeliveryVO so){
		return deliveryDao.listDeliveryConsignComp(so);
	}

	@Override
	public int insertDeliveryHist(DeliveryHistPO po) {
		return deliveryHistDao.insertDeliveryHist(po);
	}

	@Override
	public List<DeliveryHistVO> pageDeliveryHist(DeliveryHistSO so) {
		return deliveryHistDao.pageDeliveryHist(so);
	}
	
	
	
}
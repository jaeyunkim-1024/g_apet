package biz.interfaces.goodsflow.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Properties;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.util.ObjectUtils;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import biz.app.delivery.dao.DeliveryDao;
import biz.app.delivery.model.DeliverySO;
import biz.app.delivery.service.DeliveryService;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.CacheService;
import biz.interfaces.goodsflow.model.TraceResult;
import biz.interfaces.goodsflow.model.request.RequestData;
import biz.interfaces.goodsflow.model.request.RequestForm;
import biz.interfaces.goodsflow.model.request.data.DeliveryGoodsSO;
import biz.interfaces.goodsflow.model.request.data.DeliveryGoodsVO;
import biz.interfaces.goodsflow.model.request.data.DeliveryVO;
import biz.interfaces.goodsflow.model.request.data.InvoiceVO;
import biz.interfaces.goodsflow.model.response.ResponseForm;
import biz.interfaces.goodsflow.model.response.data.DlvrGoodsFlowMapPO;
import biz.interfaces.goodsflow.model.response.data.GoodsFlowDeliveryPO;
import biz.interfaces.goodsflow.model.response.data.GoodsFlowDeliveryResultPO;
import biz.interfaces.goodsflow.model.response.data.TraceVO;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.ObjectUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.goodsflow.service
* - 파일명		: GoodsFlowServiceImpl.java
* - 작성일		: 2017. 5. 31.
* - 작성자		: WilLee
* - 설명			:
 * </pre>
 */
@Slf4j
//2017.9.29, 굿스플로우 연동 중단 처리, 확장 클래스 생성함.
//@Service
public class GoodsFlowServiceImpl implements GoodsFlowService {

	@Autowired private Properties bizConfig;
	@Autowired private DeliveryService deliveryService;
	@Autowired private CacheService cacheService;
	@Autowired private DeliveryDao deliveryDao;

	private HttpEntity<?> getHttpEntity(String appType, Object params) {

		HttpHeaders requestHeaders = new HttpHeaders();
		requestHeaders.set(bizConfig.getProperty("goodsflow.api.key.name"), bizConfig.getProperty("goodsflow.api.key.value"));
		requestHeaders.set("Content-Type", "application/" + appType);

		if (params == null)
			return new HttpEntity<>(requestHeaders);
		else
			return new HttpEntity<>(params, requestHeaders);
	}

	private RestTemplate getTemplate() {

		RestTemplate restTemplate = new RestTemplate();
		MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
		restTemplate.getMessageConverters().add(converter);

		return restTemplate;
	}

	@Override
	public List<biz.interfaces.goodsflow.model.response.data.InvoiceVO> checkInvoiceNo(List<InvoiceVO> invoices) {

		try {
			String apiUri = bizConfig.getProperty("goodsflow.api.uri.check.invoice");

			log.info("### Check invoice URI :: {}", apiUri);

			RequestForm<InvoiceVO> form = new RequestForm<>();
			form.setData(new RequestData<InvoiceVO>());
			form.getData().setItems(invoices);

			HttpEntity<?> requestEntity = getHttpEntity("json", form);
			log.info("### request body :: {} ", requestEntity.getBody());

			ResponseEntity<ResponseForm<biz.interfaces.goodsflow.model.response.data.InvoiceVO>> responseEntity = getTemplate()
					.exchange(apiUri, HttpMethod.POST, requestEntity, new ParameterizedTypeReference<ResponseForm<biz.interfaces.goodsflow.model.response.data.InvoiceVO>>() {
					}, bizConfig.getProperty("goodsflow.api.code.member"));
			log.info("### response body {}", responseEntity.getBody());

			return responseEntity.getBody().isSuccess() ? responseEntity.getBody().getData().getItems() : null;
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			return null;
		}

	}

	@Override
	public boolean sendTraceRequest(Long dlvrNo) {

		try {
			if (!deliveryService.checkGoodsFlowDelivery(dlvrNo)) {
				log.info("### checkGoodsFlowDelivery [{}] : false", dlvrNo);
				return false;
			}

			DeliveryVO delivery = deliveryService.getGoodsFlowDelivery(dlvrNo);

			DeliveryGoodsSO so = new DeliveryGoodsSO();
			so.setTransUniqueCode(delivery.getTransUniqueCode());
			so.setDlvrNo(dlvrNo);
			so.setDlvrGbCd(delivery.getDlvrGbCd());

			delivery.setRequestDetails(deliveryService.getGoodsFlowDeliveryGoods(so));

			log.debug("delivery :: {}", delivery);

			List<DeliveryVO> items = new ArrayList<>();
			items.add(delivery);

			String apiUri = bizConfig.getProperty("goodsflow.api.uri.send.trace.request");

			log.info("### Send trace request URI :: {}", apiUri);

			RequestForm<DeliveryVO> form = new RequestForm<>();
			form.setData(new RequestData<DeliveryVO>());
			form.getData().setItems(items);

			HttpEntity<?> requestEntity = getHttpEntity("json", form);
			log.info("### request body :: {} ", requestEntity.getBody());

			ResponseEntity<ResponseForm<DeliveryVO>> responseEntity = getTemplate().exchange(apiUri, HttpMethod.POST, requestEntity,
					new ParameterizedTypeReference<ResponseForm<DeliveryVO>>() {
					}, bizConfig.getProperty("goodsflow.api.code.member"));
			log.info("### response body {}", responseEntity.getBody());

			GoodsFlowDeliveryPO po = new GoodsFlowDeliveryPO();
			po.setDlvrNo(dlvrNo);
			po.setLnkRstCd(responseEntity.getBody().getError().getStatus());
			if (responseEntity.getBody().isSuccess()) {
				po.setLnkRstMsg(responseEntity.getBody().getError().getMessage());
			} else {
				List<Map<String, String>> details = responseEntity.getBody().getError().getDetails();
				po.setLnkRstMsg(details != null ? details.get(0).get("message") : responseEntity.getBody().getError().getMessage());
			}

			Session session = AdminSessionUtil.getSession();
			if (session != null) {
				po.setSysRegrNo(session.getUsrNo());
				po.setSysUpdrNo(session.getUsrNo());
			} else {
				po.setSysRegrNo(1L);
				po.setSysUpdrNo(1L);
			}

			for (DeliveryGoodsVO vo : delivery.getRequestDetails()) {
				po.setItemUniqueCode(vo.getItemUniqueCode());
				po.setDtlSeq(vo.getOrdLineNo());

				deliveryService.insertGoodsFlowDelivery(po);
			}
			return responseEntity.getBody().isSuccess();

		} catch (Exception e) {

			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			return false;

		}
	}
	
	@Override
	public TraceResult receiveTraceResult() {

		TraceResult result = new TraceResult();
		List<TraceVO> items = new ArrayList<>();

		try {
			String apiUri = bizConfig.getProperty("goodsflow.api.uri.receive.trace.result");

			log.info("### Receive trace result URI :: {}", apiUri);

			RequestForm<?> form = new RequestForm<>();

			HttpEntity<?> requestEntity = getHttpEntity("json", form);
			log.info("### request body :: {} ", requestEntity.getBody());

			ResponseEntity<ResponseForm<TraceVO>> responseEntity = getTemplate().exchange(apiUri, HttpMethod.POST, requestEntity,
					new ParameterizedTypeReference<ResponseForm<TraceVO>>() {
					}, bizConfig.getProperty("goodsflow.api.code.member"));

			log.info("### response body {}", responseEntity.getBody());

			String lnkRstCd = responseEntity.getBody().getError().getStatus();
			String lnkRstMsg = responseEntity.getBody().getError().getMessage();
			result.setStatus(lnkRstCd);

			if (StringUtils.equals(lnkRstCd, CommonConstants.GOODS_FLOW_STATUS_SUCCESS)) {

				GoodsFlowDeliveryResultPO po = new GoodsFlowDeliveryResultPO();
				po.setLnkDtm(new Timestamp(System.currentTimeMillis()));

				List<biz.interfaces.goodsflow.model.request.data.TraceVO> traceList = new ArrayList<>();

				items = responseEntity.getBody().getData().getItems();

				for (TraceVO vo : items) {

					log.debug("### TraceVO : {}", vo);

					// GOODS_FLOW_DELIVERY_RESULT Insert
					po.setItemUniqueCode(vo.getItemUniqueCode());
					po.setPrcsSrlNo(vo.getSeq());
					po.setDlvrStatCd(vo.getDlvStatCode());
					po.setDlvrPrcsDtm(vo.getProcDateTime());
					po.setLnkRstCd(StringUtils.isEmpty(vo.getErrorCode()) ? lnkRstCd : vo.getErrorCode());
					po.setLnkRstMsg(StringUtils.isEmpty(vo.getErrorName()) ? lnkRstMsg : vo.getErrorName());
					po.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
					po.setSysUpdrNo(CommonConstants.COMMON_BATCH_USR_NO);

					deliveryService.insertGoodsFlowDeliveryResult(po);

					// 배송완료 처리
					if (StringUtils.equals(vo.getDlvStatCode(), CommonConstants.DLVR_STAT_70)) {
						Long dlvrNo = deliveryService.getDeliveryNoByItemUniqueCode(vo.getItemUniqueCode());
						if (dlvrNo != null) {
							log.debug("### Process delivery complete :: {}", dlvrNo);
							deliveryService.deliveryFinalExec(new Long[] { dlvrNo }, CommonConstants.COMMON_BATCH_USR_NO);
						}
					}

					// create Trace Request VO
					biz.interfaces.goodsflow.model.request.data.TraceVO traceVO = new biz.interfaces.goodsflow.model.request.data.TraceVO();
					traceVO.setItemUniqueCode(vo.getItemUniqueCode());
					traceVO.setSeq(vo.getSeq());
					traceList.add(traceVO);

				}

				// 배송결과수신 응답처리
				if (!traceList.isEmpty() && StringUtils.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {

					apiUri = bizConfig.getProperty("goodsflow.api.uri.send.trace.result.response");
					RequestForm<biz.interfaces.goodsflow.model.request.data.TraceVO> form2 = new RequestForm<>();
					form2.setData(new RequestData<biz.interfaces.goodsflow.model.request.data.TraceVO>());
					form2.getData().setItems(traceList);
					requestEntity = getHttpEntity("json", form2);
					log.info("### request body :: {} ", requestEntity.getBody());

					ResponseEntity<ResponseForm<biz.interfaces.goodsflow.model.request.data.TraceVO>> responseEntity2 = getTemplate()
							.exchange(apiUri, HttpMethod.POST, requestEntity, new ParameterizedTypeReference<ResponseForm<biz.interfaces.goodsflow.model.request.data.TraceVO>>() {
							}, bizConfig.getProperty("goodsflow.api.code.member"));

					log.info("### response body {}", responseEntity2.getBody());

				}

			}

			result.setItems(items);

		} catch (Exception e) {

			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			result.setStatus(CommonConstants.GOODS_FLOW_STATUS_UNKOWN);
		}

		return result;
	}
	
	@Override
	public TraceResult receiveTraceResultV3() {

		TraceResult result = new TraceResult();
		List<TraceVO> items = new ArrayList<TraceVO>();

		long success	=0;	// 성공 건수
		long fail 		=0;	// 실패 건수
		try {
			String apiUri = bizConfig.getProperty("goodsflow.api.uri.receive.trace.result");
			log.debug("GoodsFlow Receive trace result URI :: {}", apiUri);

			RequestForm<?> form = new RequestForm<>();
			HttpEntity<?> requestEntity = getHttpEntity("json;charset=UTF-8", form);
			log.debug("GoodsFlow 배송결과 request body :: {} ", requestEntity.getBody());

			ResponseEntity<ResponseForm<TraceVO>> responseEntity = getTemplate().exchange(apiUri, HttpMethod.POST, requestEntity,
					new ParameterizedTypeReference<ResponseForm<TraceVO>>() {
					}, bizConfig.getProperty("goodsflow.api.code.member"));
			log.info("GoodsFlow 배송결과 response body {}", responseEntity.getBody());

			String lnkRstCd = responseEntity.getBody().getError().getStatus();
			String lnkRstMsg = responseEntity.getBody().getError().getMessage();
			result.setStatus(lnkRstCd);

			if (StringUtils.equals(lnkRstCd, CommonConstants.GOODS_FLOW_STATUS_SUCCESS)) {

				GoodsFlowDeliveryResultPO po = new GoodsFlowDeliveryResultPO();
				po.setLnkDtm(new Timestamp(System.currentTimeMillis()));

				List<biz.interfaces.goodsflow.model.request.data.TraceVO> traceList = new ArrayList<biz.interfaces.goodsflow.model.request.data.TraceVO>();
				items = responseEntity.getBody().getData().getItems();
				for (TraceVO vo : items) {
					log.debug("GoodsFlow 배송결과 TraceVO : {}", vo);

					// GOODS_FLOW_DELIVERY_RESULT Insert
					//po.setItemUniqueCode(vo.getItemUniqueCode());//2.0
					po.setItemUniqueCode(vo.getTransUniqueCode());//3.0에서는 response data에 transUniqueCode로 넘어옴
					po.setPrcsSrlNo(vo.getSeq());
//					po.setDlvrStatCd(vo.getDlvStatCode());	// 2.0
					po.setDlvrStatCd(vo.getDlvStatType());	// 3.0
					po.setDlvrPrcsDtm(vo.getProcDateTime());
					po.setLnkRstCd(StringUtils.isEmpty(vo.getErrorCode()) ? lnkRstCd : vo.getErrorCode());
					po.setLnkRstMsg(StringUtils.isEmpty(vo.getErrorName()) ? lnkRstMsg : vo.getErrorName());
					po.setSysRegrNo(CommonConstants.COMMON_BATCH_USR_NO);
					po.setSysUpdrNo(CommonConstants.COMMON_BATCH_USR_NO);
					int saveResult = deliveryService.insertGoodsFlowDeliveryResult(po);

					// 건수 추가 
					if(StringUtils.isEmpty(vo.getErrorCode()) && saveResult == 1){
						success++;
					} else {
						fail++;
					}
					
					// 배송완료 처리  3.0
					if (StringUtils.equals(vo.getDlvStatType(), CommonConstants.DLVR_STAT_70)) {
						//Long dlvrNo = deliveryService.getDeliveryNoByItemUniqueCode(vo.getTransUniqueCode());
						List<Long> dlvrNos = deliveryDao.getDeliveryNoByItemUniqueCodeList(vo.getTransUniqueCode());
						if (dlvrNos != null && dlvrNos.size() > 0) {
							log.info("GoodsFlow Process delivery complete :: {}", dlvrNos);
							deliveryService.deliveryFinalExec(dlvrNos.stream().toArray(Long[]::new), CommonConstants.COMMON_BATCH_USR_NO);
						}
					}					

					if (saveResult == 1) {
						// create Trace Request VO
						biz.interfaces.goodsflow.model.request.data.TraceVO traceVO = new biz.interfaces.goodsflow.model.request.data.TraceVO();
//						traceVO.setItemUniqueCode(vo.getItemUniqueCode());	// 2.0
						traceVO.setTransUniqueCode(vo.getTransUniqueCode());  // 3.0
						traceVO.setSeq(vo.getSeq());
						traceList.add(traceVO);
						log.debug("GoodsFlow 배송결과응답 VO :: {} ", traceVO);
					}
				}

				// 배송결과수신 응답처리
				// TODO, 2021.04.24, 서성민, 임시로 막음
				receiveTraceResultV3(traceList);

			}

			result.setItems(items);
			result.setTotal(items !=null ? Long.valueOf(items.size()) : 0);
			result.setSuccess(success);
			result.setFail(fail);

		} catch (Exception e) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			log.error("receiveTraceResultV3", e);
			result.setStatus(CommonConstants.GOODS_FLOW_STATUS_UNKOWN);
		}

		log.debug("GoodsFlow receiveTraceResult result :: {} ", result);
		return result;
	}	
	
	protected void receiveTraceResultV3(List<biz.interfaces.goodsflow.model.request.data.TraceVO> traceList) {
		// 배송결과수신 응답처리 :: 응답처리하면 굿스플로에서 재수신 안됨

//		if (traceList.size() > 0 && StringUtils.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
//		if (traceList.size() > 0) {
		if(ObjectUtil.isNotEmpty(traceList)) {

			String apiUri = bizConfig.getProperty("goodsflow.api.uri.send.trace.result.response");
			RequestForm<biz.interfaces.goodsflow.model.request.data.TraceVO> form2 = new RequestForm<biz.interfaces.goodsflow.model.request.data.TraceVO>();
			form2.setData(new RequestData<biz.interfaces.goodsflow.model.request.data.TraceVO>());
			form2.getData().setItems(traceList);
			HttpEntity<?> requestEntity = getHttpEntity("json;charset=UTF-8", form2);
			log.debug("GoodsFlow 배송결과응답 request body :: {} ", requestEntity.getBody());

			ResponseEntity<ResponseForm<biz.interfaces.goodsflow.model.request.data.TraceVO>> responseEntity2 = getTemplate()
					.exchange(apiUri, HttpMethod.POST, requestEntity, new ParameterizedTypeReference<ResponseForm<biz.interfaces.goodsflow.model.request.data.TraceVO>>() {
					}, bizConfig.getProperty("goodsflow.api.code.member"));
			log.info("GoodsFlow 배송결과응답 response body {}", responseEntity2.getBody());
		}
		
	}
	
	@Override
	public TraceResult requestTraceV3() throws RestClientException {

		// 개발/운영 분리
//		String envmtGb = bizConfig.getProperty("envmt.gb");
//		if(!(StringUtils.equals(envmtGb, CommonConstants.ENVIRONMENT_GB_OPER) || StringUtils.equals(envmtGb, CommonConstants.ENVIRONMENT_GB_QA))) {
//			return new TraceResult();
//		}
		
		TraceResult result = new TraceResult();
		int success = 0;
		int fail = 0;
		
		// 배송추적 요청 대상 목록 
		DeliverySO so = new DeliverySO();		// 대상건 추가 조건 필요시 사용
		List<biz.app.delivery.model.DeliveryVO> requestList = deliveryService.getGoodsFlowRequestTraceList(so);
		if (ObjectUtils.isEmpty(requestList)) {
			log.info("GoodsFlow 배송추적 요청 대상 없음.");
		} else {
			result.setTotal(Long.valueOf(requestList.size()));
		}
		
		// 배송추적 요청
		for (biz.app.delivery.model.DeliveryVO row : requestList) {
			// 송장 유효성 확인
			if (!this.checkInvoiceNo(row.getHdcCd(), row.getInvNo())) {
//				if(StringUtils.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_OPER)) {
				log.error("GoodsFlow 배송추적 요청 :: 유효한 송장번호가 아님 :: DLVR_NO[{}], HDC_CDD[{}], INV_NO[{}]", row.getDlvrNo(), row.getHdcCd(), row.getInvNo());
//				}
				fail++;
				continue;
			}
			
			// 송장번호 추적 요청 대상 송신
			boolean requestResult = this.sendTraceRequestV3(row.getDlvrNo());
			if(requestResult) {
				success++;
			} else {
				fail++;
			}
			
			// DDOS 오해 방지
			try { 
				Thread.sleep(200);
			} catch(Exception e) {
				// 보안성 진단. 오류메시지를 통한 정보노출
				log.error("Thread sleep", e);
			}
		}
		
		result.setSuccess(Long.valueOf(success));
		result.setFail(Long.valueOf(fail));
		return result;
	}
	
	@Override
	public boolean sendTraceRequestV3(Long dlvrNo) {

		// 개발/운영 분리 :: 배송쪽 로직 확인 후 제거
//		String envmtGb = bizConfig.getProperty("envmt.gb");
//		if(!(StringUtils.equals(envmtGb, CommonConstants.ENVIRONMENT_GB_OPER) || StringUtils.equals(envmtGb, CommonConstants.ENVIRONMENT_GB_QA))) {
//			return this.sendTraceRequest(dlvrNo);
//		}
//		
		try {
			if (!deliveryService.checkGoodsFlowDelivery(dlvrNo)) {
				log.info("checkGoodsFlowDelivery [{}] : false", dlvrNo);
				return false;
			}

			// 배송정보 조회 : 주문(getGoodsFlowDelivery), 클레임(getGoodsFlowReturn)
			DeliveryVO delivery = deliveryService.getGoodsFlowDelivery(dlvrNo);

			// TransUniqueCode 생성 V2.0 기준 itemUniqueCode와 매핑
			String transUniqueCode = DateUtil.toDate(CommonConstants.COMMON_DATE_STRING_FORMAT) 
					               + StringUtil.randomNumeric(3)
					               + "-"
					               + String.valueOf(dlvrNo);
			delivery.setTransUniqueCode(transUniqueCode);
			
			// 주문/클레임 별 요청 데이타 생성
			DeliveryGoodsSO so = new DeliveryGoodsSO();
//			so.setTransUniqueCode(delivery.getTransUniqueCode());
			so.setDlvrNo(dlvrNo);
			so.setDlvrGbCd(delivery.getDlvrGbCd());
			/*
			 *requestDetails 하위  
			 * String orderNo
			 * String orderLine
			 * String itemName
			 * int itemQty
			 * String orderDate YYYYMMDDHHMMSS 20090101083000
			 * String paymentDate
			 */
			List<DeliveryGoodsVO> deliveryGoodsVOList = deliveryService.getGoodsFlowDeliveryGoods(so);

			if( !CommonConstants.ENVIRONMENT_GB_OPER.contentEquals(bizConfig.getProperty("envmt.gb")) ) {
				//개발/검증계 연동 테스트를 위한 주문일자/결제일자 세팅
				String testDate = "20210301123030";
				for(int i=0;i<deliveryGoodsVOList.size();i++) {
					deliveryGoodsVOList.get(i).setOrdDate(testDate);
					deliveryGoodsVOList.get(i).setPaymentDate(testDate);
				}
			}
			delivery.setRequestDetails(deliveryGoodsVOList);	// 주문(getGoodsFlowDeliveryGoods), 클레임(getGoodsFlowReturnGoods)

			log.debug("GoodsFlow delivery :: {}", delivery);
			List<DeliveryVO> items = new ArrayList<DeliveryVO>();
			items.add(delivery);

			// 배송추적 요청 (송장전송)
			String apiUri = bizConfig.getProperty("goodsflow.api.uri.send.trace.request");
			log.debug("GoodsFlow Send trace request URI :: {}", apiUri);

			RequestForm<DeliveryVO> form = new RequestForm<>();
			form.setData(new RequestData<DeliveryVO>());
			form.getData().setItems(items);

			HttpEntity<?> requestEntity = getHttpEntity("json;charset=UTF-8", form);
			log.debug("GoodsFlow request body :: {} ", requestEntity.getBody());

			// 결과 Response
			ResponseEntity<ResponseForm<DeliveryVO>> responseEntity = getTemplate().exchange(apiUri, HttpMethod.POST, requestEntity,
					new ParameterizedTypeReference<ResponseForm<DeliveryVO>>() {
					}, bizConfig.getProperty("goodsflow.api.code.member"));
			log.debug("GoodsFlow response body {}", responseEntity.getBody());

			GoodsFlowDeliveryPO po = new GoodsFlowDeliveryPO();
			po.setDlvrNo(dlvrNo);
			po.setLnkRstCd(responseEntity.getBody().getError().getStatus());
			if (responseEntity.getBody().isSuccess()) {
				po.setLnkRstMsg(responseEntity.getBody().getError().getMessage());
			} else {
				List<Map<String, String>> details = responseEntity.getBody().getError().getDetails();
				po.setLnkRstMsg(details != null ? details.get(0).get("message") : responseEntity.getBody().getError().getMessage());
			}

			// 배송추적 요청 결과 저장
			Session session = AdminSessionUtil.getSession();
			if (session != null) {
				po.setSysRegrNo(session.getUsrNo());
				po.setSysUpdrNo(session.getUsrNo());
			} else {
				po.setSysRegrNo(CommonConstants.INTERFACE_USR_NO);
				po.setSysUpdrNo(CommonConstants.INTERFACE_USR_NO);
			}

			po.setItemUniqueCode(transUniqueCode);	// 3.0		
			for (DeliveryGoodsVO vo : delivery.getRequestDetails()) {
//				po.setItemUniqueCode(vo.getItemUniqueCode());	// 2.0
				po.setDtlSeq(vo.getOrderLine());

				deliveryService.insertGoodsFlowDelivery(po);
			}
			return responseEntity.getBody().isSuccess();

		} catch (Exception e) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			log.error("sendTraceRequestV3", e);
			return false;

		}
	}
	
	@Override
	public TraceResult requestTraceV3New() throws RestClientException {
		TraceResult result = new TraceResult();
		int total = 0;
		int success = 0;
		int fail = 0;
		
		/* 굿스플로 연동 대상 dlvrNo 조희 */
		List<Integer> dlvrNoList = deliveryDao.getDlvrNoForGoodsFlowTraceList();
		
		if (ObjectUtils.isEmpty(dlvrNoList)) {
			log.info("GoodsFlow 배송추적 요청 대상 없음.");
			result.setTotal(Long.valueOf(total));
			result.setSuccess(Long.valueOf(success));
			result.setFail(Long.valueOf(fail));
			return result;
		}
		
		total = dlvrNoList.size();
		
		/* dlvrNo기준 굿스플로 데이타 조회, SendTraceRequest API - Request Data Object 구조와 동일 */
		List<biz.interfaces.goodsflow.model.request.data.DeliveryVO> goodsFlowForTraceList;
		GoodsFlowDeliveryPO flowDeliveryPO = new GoodsFlowDeliveryPO();
		DlvrGoodsFlowMapPO dlvrGoodsFlowMapPO = new DlvrGoodsFlowMapPO(); 
		for (Integer dlvrNo : dlvrNoList) {
			goodsFlowForTraceList = deliveryDao.getGoodsFlowForTraceList(dlvrNo);
			if (ObjectUtils.isEmpty(goodsFlowForTraceList)) {
				log.info("GoodsFlow 대상이 아님, dlvrNo:{}", dlvrNo);
				continue;
			}
			
			log.debug("goodsFlowForTraceList:{}", goodsFlowForTraceList);
			
			for (biz.interfaces.goodsflow.model.request.data.DeliveryVO goodsFlowTrace : goodsFlowForTraceList) {
				flowDeliveryPO.setItemUniqueCode(goodsFlowTrace.getTransUniqueCode());
				dlvrGoodsFlowMapPO.setItemUniqueCode(goodsFlowTrace.getTransUniqueCode());
				
				// 1. invoice 체크
				if (!checkInvoiceNoNew(goodsFlowTrace.getLogisticsCode(), goodsFlowTrace.getInvoiceNo())) {
					log.error("GoodsFlow 배송추적 요청 :: 유효한 송장번호가 아님 :: DLVR_NO[{}], LOGISTICS_CODE[{}], INV_NO[{}]", goodsFlowTrace.getRequestDetails().get(0).getDlvrNo(), goodsFlowTrace.getLogisticsCode(), goodsFlowTrace.getInvoiceNo());
					
					// flow 저장
					flowDeliveryPO.setLnkRstCd("999");		/* 999:유효한 송장번호가 아님 */
					flowDeliveryPO.setLnkRstMsg("유효한 송장번호가 아님");
					flowDeliveryPO.setDlvrNo(0L);
					deliveryDao.saveGoodsFlowDelivery(flowDeliveryPO);
					
					// flow map 저장, 유효한 송장이 아니더라도 기록은 함
					goodsFlowTrace.getRequestDetails().forEach(v -> {
						dlvrGoodsFlowMapPO.setDlvrNo(v.getDlvrNo());
						deliveryDao.saveDlvrGoodsFlowMap(dlvrGoodsFlowMapPO);
					});
					
					/*
					for (biz.interfaces.goodsflow.model.request.data.DeliveryGoodsVO requestDetails : goodsFlowTrace.getRequestDetails()) {
						dlvrGoodsFlowMapPO.setDlvrNo(requestDetails.getDlvrNo());
						
						deliveryDao.saveDlvrGoodsFlowMap(dlvrGoodsFlowMapPO);
					}
					*/
					
					fail++;
					continue;
				}
				
				// 2. SendTraceRequest 호출
				boolean requestResult = this.sendTraceRequestV3New(goodsFlowTrace);
				if(requestResult) {
					success++;
				} else {
					fail++;
				}
				
				// DDOS 오해 방지
				try { 
					Thread.sleep(200);
				} catch(Exception e) {
					// 보안성 진단. 오류메시지를 통한 정보노출
					log.error("Thread sleep", e);
				}
			} 
		}
		
		result.setTotal(Long.valueOf(total));
		result.setSuccess(Long.valueOf(success));
		result.setFail(Long.valueOf(fail));
		return result;
	}
	
	@Override
	public boolean sendTraceRequestV3New(biz.interfaces.goodsflow.model.request.data.DeliveryVO goodsFlowTrace) {
		try {
			
			if( !CommonConstants.ENVIRONMENT_GB_OPER.contentEquals(bizConfig.getProperty("envmt.gb")) ) {
				String testDate = "20210301123030";
				goodsFlowTrace.getRequestDetails().stream().forEach(v -> {
					v.setOrdDate(testDate);
					v.setPaymentDate(testDate);
				});
			}
			
			List<DeliveryVO> items = new ArrayList<DeliveryVO>();
			items.add(goodsFlowTrace);			

			log.debug("GoodsFlow delivery :: {}", goodsFlowTrace);

			// 배송추적 요청 (송장전송)
			String apiUri = bizConfig.getProperty("goodsflow.api.uri.send.trace.request");
			log.debug("GoodsFlow Send trace request URI :: {}", apiUri);

			RequestForm<DeliveryVO> form = new RequestForm<>();
			form.setData(new RequestData<DeliveryVO>());
			form.getData().setItems(items);

			HttpEntity<?> requestEntity = getHttpEntity("json;charset=UTF-8", form);
			log.debug("GoodsFlow request body :: {} ", requestEntity.getBody());

			// 결과 Response
			ResponseEntity<ResponseForm<DeliveryVO>> responseEntity = getTemplate().exchange(apiUri, HttpMethod.POST, requestEntity,
					new ParameterizedTypeReference<ResponseForm<DeliveryVO>>() {
					}, bizConfig.getProperty("goodsflow.api.code.member"));
			log.debug("GoodsFlow response body {}", responseEntity.getBody());
			
			GoodsFlowDeliveryPO flowDeliveryPO = new GoodsFlowDeliveryPO();
			DlvrGoodsFlowMapPO dlvrGoodsFlowMapPO = new DlvrGoodsFlowMapPO();
			flowDeliveryPO.setItemUniqueCode(goodsFlowTrace.getTransUniqueCode());
			dlvrGoodsFlowMapPO.setItemUniqueCode(goodsFlowTrace.getTransUniqueCode());
			flowDeliveryPO.setDlvrNo(0L);
			
			flowDeliveryPO.setLnkRstCd(responseEntity.getBody().getError().getStatus());
			if (responseEntity.getBody().isSuccess()) {
				flowDeliveryPO.setLnkRstMsg(responseEntity.getBody().getError().getMessage());
			} else {
				List<Map<String, String>> details = responseEntity.getBody().getError().getDetails();
				flowDeliveryPO.setLnkRstMsg(details != null ? details.get(0).get("message") : responseEntity.getBody().getError().getMessage());
			}
			
			flowDeliveryPO.setSysRegrNo(CommonConstants.INTERFACE_USR_NO);
			flowDeliveryPO.setSysUpdrNo(CommonConstants.INTERFACE_USR_NO);
			
			deliveryDao.saveGoodsFlowDelivery(flowDeliveryPO);
			
			// flow map 저장, 유효한 송장이 아니더라도 기록은 함
			goodsFlowTrace.getRequestDetails().forEach(v -> {
				dlvrGoodsFlowMapPO.setDlvrNo(v.getDlvrNo());
				deliveryDao.saveDlvrGoodsFlowMap(dlvrGoodsFlowMapPO);
			});
			
			return responseEntity.getBody().isSuccess();

		} catch (Exception e) {
			// 보안성 진단. 오류메시지를 통한 정보노출
			log.error("sendTraceRequestV3New", e);
			return false;
		}
	}
	
	// 유효성 확인
	private boolean checkInvoiceNo(String hdcCd, String invNo) {
		CodeDetailVO codeDetail = cacheService.getCodeCache(CommonConstants.HDC, hdcCd);
		
		List<InvoiceVO> invoices = new ArrayList<InvoiceVO>();
		InvoiceVO invoice = new InvoiceVO();
		invoice.setInvoiceNo(invNo);
		invoice.setLogisticsCode(codeDetail.getUsrDfn1Val());

		invoices.add(invoice);

		// 굿스플로우와 송장유효성 확인 연동
		List<biz.interfaces.goodsflow.model.response.data.InvoiceVO> goodsFlowResult =this.checkInvoiceNoV3(invoices);	// 3.0
		if (Objects.isNull(goodsFlowResult)) {
			// 굿스플로우 연동 중 에러 발생한 경우
			throw new CustomException(ExceptionConstants.ERROR_DELIVERY_GOODSFLOW_ERROR);
		}

		// 굿스플로우 연동 결과 유효한 송장번호일 때
		if (goodsFlowResult.get(0).isOk()) {
			return true;
		} else {
			return false;
		}
	}
	
	// 유효성 확인
	private boolean checkInvoiceNoNew(String logisticsCode, String invNo) {
		List<InvoiceVO> invoices = new ArrayList<InvoiceVO>();
		InvoiceVO invoice = new InvoiceVO();
		invoice.setInvoiceNo(invNo);
		invoice.setLogisticsCode(logisticsCode);

		invoices.add(invoice);

		// 굿스플로우와 송장유효성 확인 연동
		List<biz.interfaces.goodsflow.model.response.data.InvoiceVO> goodsFlowResult =this.checkInvoiceNoV3(invoices);	// 3.0
		if (Objects.isNull(goodsFlowResult)) {
			// 굿스플로우 연동 중 에러 발생한 경우
			throw new CustomException(ExceptionConstants.ERROR_DELIVERY_GOODSFLOW_ERROR);
		}

		// 굿스플로우 연동 결과 유효한 송장번호일 때
		if (goodsFlowResult.get(0).isOk()) {
			return true;
		} else {
			return false;
		}
	}
	
	@Override
	public List<biz.interfaces.goodsflow.model.response.data.InvoiceVO> checkInvoiceNoV3(List<InvoiceVO> invoices) {

		// 개발/운영 분리
//		String envmtGb = bizConfig.getProperty("envmt.gb");
//		if(!(StringUtils.equals(envmtGb, CommonConstants.ENVIRONMENT_GB_OPER) || StringUtils.equals(envmtGb, CommonConstants.ENVIRONMENT_GB_QA))) {
//			return this.checkInvoiceNo(invoices);
//		}
		
		try {
			//String apiUri = bizConfig.getProperty("goodsflow.api.uri.check.invoice").replaceAll("\\{memberCode\\}", bizConfig.getProperty("goodsflow.api.code.member"));
			String apiUri = bizConfig.getProperty("goodsflow.api.uri.check.invoice");
			log.debug("GoodsFlow Check invoice URI :: {}", apiUri);
			
			RequestForm<InvoiceVO> form = new RequestForm<>();
			form.setData(new RequestData<InvoiceVO>());
			form.getData().setItems(invoices);

			log.debug("GoodsFlow request form :: {} ", form);
			HttpEntity<?> requestEntity = getHttpEntity("json;charset=UTF-8", form);
			log.debug("GoodsFlow request body :: {} ", requestEntity.getBody());

			ResponseEntity<ResponseForm<biz.interfaces.goodsflow.model.response.data.InvoiceVO>> responseEntity = getTemplate()
					.exchange(apiUri, HttpMethod.POST, requestEntity, new ParameterizedTypeReference<ResponseForm<biz.interfaces.goodsflow.model.response.data.InvoiceVO>>() {
					}, bizConfig.getProperty("goodsflow.api.code.member"));
			log.debug("GoodsFlow response body :: {}", responseEntity.getBody());

			return responseEntity.getBody().isSuccess() ? responseEntity.getBody().getData().getItems() : null;
		} catch(RestClientException rce) {
			log.error("invoices :: <{}>", invoices);
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, rce);
			// 통신장애는 로그만 남기고 성공으로 처리하자
			return getInvoiceNoForceTrue(invoices);
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			return null;
		}
	}
	
	// 후계근 출고확정시 PG취소와 굿스플로의 2가지 위부 I/F가 발생하기 때문에 
	// 수기처리가 가능한 굿스플로에서 장애가 발생하더라도 정상처리 되도록 ...
	private List<biz.interfaces.goodsflow.model.response.data.InvoiceVO> getInvoiceNoForceTrue(List<InvoiceVO> invoices){
		List<biz.interfaces.goodsflow.model.response.data.InvoiceVO> list = new ArrayList<biz.interfaces.goodsflow.model.response.data.InvoiceVO>();
		for(InvoiceVO invoice : invoices) {
			biz.interfaces.goodsflow.model.response.data.InvoiceVO vo = new biz.interfaces.goodsflow.model.response.data.InvoiceVO();
			vo.setIsOk(Boolean.TRUE.booleanValue());
			vo.setInvoiceNo(invoice.getInvoiceNo());
			vo.setLogisticsCode(invoice.getLogisticsCode());
			list.add(vo);
		}
		return list;
	}
	
	@Override
	public int requestTraceV3NewForOnce(Long dlvrNo) throws RestClientException{
		
		int success = 0;
		GoodsFlowDeliveryPO flowDeliveryPO = new GoodsFlowDeliveryPO();
		DlvrGoodsFlowMapPO dlvrGoodsFlowMapPO = new DlvrGoodsFlowMapPO();
		
		List<biz.interfaces.goodsflow.model.request.data.DeliveryVO> goodsFlowForTraceList = deliveryDao.getGoodsFlowForTraceList(dlvrNo.intValue());
		
		if (ObjectUtils.isEmpty(goodsFlowForTraceList)) {
			log.info("GoodsFlow 대상이 아님, dlvrNo:{}", dlvrNo);
		}
		
		for (biz.interfaces.goodsflow.model.request.data.DeliveryVO goodsFlowTrace : goodsFlowForTraceList) {
			flowDeliveryPO.setItemUniqueCode(goodsFlowTrace.getTransUniqueCode());
			dlvrGoodsFlowMapPO.setItemUniqueCode(goodsFlowTrace.getTransUniqueCode());
			
			// 1. invoice 체크
			if (!checkInvoiceNoNew(goodsFlowTrace.getLogisticsCode(), goodsFlowTrace.getInvoiceNo())) {
				log.error("GoodsFlow 배송추적 요청 :: 유효한 송장번호가 아님 :: DLVR_NO[{}], LOGISTICS_CODE[{}], INV_NO[{}]", goodsFlowTrace.getRequestDetails().get(0).getDlvrNo(), goodsFlowTrace.getLogisticsCode(), goodsFlowTrace.getInvoiceNo());
				
				// flow 저장
				flowDeliveryPO.setLnkRstCd("999");		/* 999:유효한 송장번호가 아님 */
				flowDeliveryPO.setLnkRstMsg("유효한 송장번호가 아님");
				flowDeliveryPO.setDlvrNo(0L);
				deliveryDao.saveGoodsFlowDelivery(flowDeliveryPO);
				
				// flow map 저장, 유효한 송장이 아니더라도 기록은 함
				goodsFlowTrace.getRequestDetails().forEach(v -> {
					dlvrGoodsFlowMapPO.setDlvrNo(v.getDlvrNo());
					deliveryDao.saveDlvrGoodsFlowMap(dlvrGoodsFlowMapPO);
				});
				
				continue;
			}
			
			// 2. SendTraceRequest 호출
			boolean requestResult = this.sendTraceRequestV3New(goodsFlowTrace);
			if(requestResult) {
				success++;
			}
			
			// DDOS 오해 방지
			try { 
				Thread.sleep(200);
			} catch(Exception e) {
				// 보안성 진단. 오류메시지를 통한 정보노출
				log.error("Thread sleep", e);
			}
		}
		
		return success;
	}
}

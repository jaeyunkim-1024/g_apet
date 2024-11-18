package biz.app.market.service;

import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import biz.app.market.dao.MarketOrderBaseDao;
import biz.app.market.dao.MarketOrderDao;
import biz.app.market.model.MarketOrderConfirmPO;
import biz.app.market.model.MarketOrderConfirmVO;
import biz.app.market.model.MarketOrderListSO;
import biz.app.market.model.MarketOrderListVO;
import biz.app.order.dao.OrderBaseDao;
import biz.common.service.BizService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.market.service
* - 파일명		: MarketOrderServiceImpl.java
* - 작성일		: 2017. 9. 21.
* - 작성자		: kimdp
* - 설명			: 오픈마켓 주문 서비스 Impl
* </pre>
*/
@Slf4j
@Service
@Transactional
public class MarketOrderServiceImpl implements MarketOrderService {

	@Autowired 
	private BizService bizService;

	@Autowired	
	private MarketOrderBaseDao marketOrderBaseDao;	
	
	@Autowired	
	private MarketOrderDao marketOrderDao;	
	
	@Autowired	
	private OrderBaseDao orderBaseDao;
	
	@Autowired 
	private Properties bizConfig;
	
	/*
	 * 원주문 목록 페이징 조회
	 * @see biz.app.market.service.MarketOrderService#pageMarketOrderOrg(biz.app.market.model.MarketOrderListSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<MarketOrderListVO> pageMarketOrderOrg(MarketOrderListSO so) {
		return this.marketOrderBaseDao.pageMarketOrderOrg(so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketOrderServiceImpl.java
	* - 작성일	: 2017. 9. 27.
	* - 작성자	: schoi
	* - 설명		: Outbound API 주문 등록
	* </pre>
	* @param marketOrderConfirmPO
	* @return
	*/
	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED)
	public void insertMarketOrderConfirm (MarketOrderConfirmPO marketOrderConfirmPO) {

		if(marketOrderConfirmPO.getArrOrdSeq() != null && marketOrderConfirmPO.getArrOrdSeq().length > 0) {
			String ordNo = null;
			String preOrdNo = null;
			Integer ordDtlSeq = 0;
			Long ordDlvraNo = null;
			Long preOrdDlvraNo = null;
			Long dlvrcNo = null;
			Long preDlvrcNo = null;
			String goodsId = null;
			String goodsNm = null;
			String itemNm = null;

			for(Long ordSeq : marketOrderConfirmPO.getArrOrdSeq()){
				marketOrderConfirmPO.setOrdSeq(ordSeq);

				/* 동일 주문 번호 유무 확인 */
				int checkOrdNoCnt = this.marketOrderDao.checkOrdNoCnt(marketOrderConfirmPO);
				
				if(checkOrdNoCnt == 0) { // 동일 주문 번호 없는 경우
					/* 주문 번호 생성 */
					ordNo = this.orderBaseDao.getOrderNo();
	
					/* 주문 기본 정보 */
					marketOrderConfirmPO.setOrdSeq(ordSeq);
					marketOrderConfirmPO.setOrdNo(ordNo); // 주문 번호
					marketOrderConfirmPO.setStId(1); // 사이트 ID
					marketOrderConfirmPO.setMbrNo(0); // 회원 번호
					marketOrderConfirmPO.setChnlId(2); // 채널 ID
					marketOrderConfirmPO.setOrdStatCd(CommonConstants.ORD_STAT_20); // 주문 상태 코드
					marketOrderConfirmPO.setOrdMdaCd(CommonConstants.ORD_MDA_10); // 주문 매체 코드
					marketOrderConfirmPO.setOrdPrcsRstCd(CommonConstants.ORD_PRCS_RST_0000); // 주문 처리 결과 코드
					marketOrderConfirmPO.setOrdPrcsRstMsg("정상처리"); // 주문 처리 결과 메세지
					marketOrderConfirmPO.setDataStatCd(CommonConstants.DATA_STAT_01); // 데이터 상태 코드
				
					/* 주문 기본 정보 등록 */
					int insertMarketOrderBaseResult = this.marketOrderDao.insertMarketOrderBase(marketOrderConfirmPO);
					
					if(insertMarketOrderBaseResult != 1){
						/* 주문 처리 상태 변경 */
						marketOrderConfirmPO.setProcCd("29"); // 처리상태(10:주문수집,19:주문수집에러,20:주문등록,29:주문등록에러
						this.marketOrderDao.updateObOrderProcCd(marketOrderConfirmPO);
						
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}

					/* 주문 배송지 번호 생성 */
					ordDlvraNo = this.bizService.getSequence(CommonConstants.SEQUENCE_ORDER_DLVRA_NO); 
					
					/* 주문 배송지 정보 */
					marketOrderConfirmPO.setOrdDlvraNo(ordDlvraNo); // 주문 배송지 번호
					
					/* 주문 배송지 정보 등록 */
					int insertMarketOrderDeliveryResult = this.marketOrderDao.insertMarketOrderDelivery(marketOrderConfirmPO);
					
					if(insertMarketOrderDeliveryResult != 1){
						/* 주문 처리 상태 변경 */
						marketOrderConfirmPO.setProcCd("29"); // 처리상태(10:주문수집,19:주문수집에러,20:주문등록,29:주문등록에러
						this.marketOrderDao.updateObOrderProcCd(marketOrderConfirmPO);
						
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
					
					/* 배송비 번호 생성 */
					dlvrcNo = this.bizService.getSequence(CommonConstants.SEQUENCE_DLVRC_NO_SEQ);

					/* 배송비 정보 */				
					marketOrderConfirmPO.setDlvrcNo(dlvrcNo); // 배송비 번호
					marketOrderConfirmPO.setCostGbCd(CommonConstants.COST_GB_10); // 배송비 구분 코드
					marketOrderConfirmPO.setCncYn(CommonConstants.COMM_YN_N); // 취소 여부

					/* 배송비 정보 등록 */
					int insertMarketDeliveryChargeResult = this.marketOrderDao.insertMarketDeliveryCharge(marketOrderConfirmPO);
					
					if(insertMarketDeliveryChargeResult != 1){
						/* 주문 처리 상태 변경 */
						marketOrderConfirmPO.setProcCd("29"); // 처리상태(10:주문수집,19:주문수집에러,20:주문등록,29:주문등록에러
						this.marketOrderDao.updateObOrderProcCd(marketOrderConfirmPO);
						
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}

				} else { // 동일 주문 번호 존재 하는 경우
					/* 기존 주문 번호 */
					preOrdNo = this.marketOrderDao.checkOrdNo(marketOrderConfirmPO);
					marketOrderConfirmPO.setOrdNo(preOrdNo);
					/* 기존 주문 배송지 번호 */
					preOrdDlvraNo = this.marketOrderDao.checkOrdDlvraNo(marketOrderConfirmPO);
					marketOrderConfirmPO.setOrdDlvraNo(preOrdDlvraNo);
					/* 기존 주문 배송지 번호 */
					preDlvrcNo = this.marketOrderDao.checkDlvrcNo(marketOrderConfirmPO);
					marketOrderConfirmPO.setDlvrcNo(preDlvrcNo);
				}
		
				/* 주문 상세 정보  */
				ordDtlSeq++;

				marketOrderConfirmPO.setOrdDtlSeq(ordDtlSeq); // 주문 상세 순번
				marketOrderConfirmPO.setOrdDtlStatCd(CommonConstants.ORD_DTL_STAT_120);  // 주문 상태 코드
				marketOrderConfirmPO.setCncQty(0); // 취소 수량
				marketOrderConfirmPO.setRtnQty(0); // 반품 수량
				marketOrderConfirmPO.setRmnPayAmt(0L); // 잔여 결제 금액
				marketOrderConfirmPO.setHotDealYn(CommonConstants.COMM_YN_N); // 핫딜 상품 여부
				marketOrderConfirmPO.setGoodsEstmRegYn(CommonConstants.COMM_YN_N); // 상품평 등록 여부
				marketOrderConfirmPO.setTaxGbCd(CommonConstants.TAX_GB_10); // 과세 구분 코드
				
				/* 주문 상세 정보 등록 */
				int insertMarketOrderDetailResult = this.marketOrderDao.insertMarketOrderDetail(marketOrderConfirmPO);
				
				if(insertMarketOrderDetailResult != 1){
					/* 주문 처리 상태 변경 */
					marketOrderConfirmPO.setProcCd("29"); // 처리상태(10:주문수집,19:주문수집에러,20:주문등록,29:주문등록에러
					this.marketOrderDao.updateObOrderProcCd(marketOrderConfirmPO);
					
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				
				List<MarketOrderConfirmVO> marketOrderConfirmVO = this.marketOrderDao.selectOrderConfirmGoodsInfo(marketOrderConfirmPO);
				
				if(marketOrderConfirmVO != null && !marketOrderConfirmVO.isEmpty()){
					for(MarketOrderConfirmVO ocvo : marketOrderConfirmVO){
						if(ocvo.getGoodsId() != null){
							goodsId = ocvo.getGoodsId();
							goodsNm = ocvo.getGoodsNm();
							itemNm = ocvo.getItemNm();
						}
					}
				}
				
				/* 주문 처리 상태 변경 */
				marketOrderConfirmPO.setShopPrdNo(goodsId);
				marketOrderConfirmPO.setShopPrdNm(goodsNm);
				marketOrderConfirmPO.setShopPrdOptNm(itemNm);
				marketOrderConfirmPO.setProcCd("20"); // 처리상태(10:주문수집,19:주문수집에러,20:주문등록,29:주문등록에러
				
				this.marketOrderDao.updateObOrderProcCd(marketOrderConfirmPO);

			}

		} else {
			/* 주문 처리 상태 변경 */
			marketOrderConfirmPO.setProcCd("29"); // 처리상태(10:주문수집,19:주문수집에러,20:주문등록,29:주문등록에러
			this.marketOrderDao.updateObOrderProcCd(marketOrderConfirmPO);
			
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketOrderServiceImpl.java
	* - 작성일	: 2017. 10. 23.
	* - 작성자	: schoi
	* - 설명		: Outbound API 주문 수집
	* </pre>
	* @param String startDtm, String endDtm
	* @return
	*/
	@Override
	public void marketGetOrder(String startDtm, String endDtm) {
		try {
			/* 로컬 테스트 시 */
			URL apiUrl = new URL("http://localhost:9090/api/11st/order/gets/"+startDtm+"/"+endDtm);
			/* 운영 적용 시 */
//			URL apiUrl = new URL(bizConfig.getProperty("interface.ob.base.uri")+"/api/11st/order/gets/"+startDtm+"/"+endDtm);
			log.debug("apiUrl: " + apiUrl);
			HttpURLConnection con = (HttpURLConnection)apiUrl.openConnection();
			
			con.setRequestMethod("GET");
			con.setDoInput(true);
			con.setDoOutput(true);	

			int resCode = con.getResponseCode();
			log.debug("resCode: " + resCode);
			con.disconnect();
		} catch (Exception e) {
			log.debug(e.getLocalizedMessage());
		}
	}
	

}

package biz.app.market.service;

import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import biz.app.claim.dao.ClaimBaseDao;
import biz.app.market.dao.MarketClaimBaseDao;
import biz.app.market.dao.MarketClaimDao;
import biz.app.market.model.MarketClaimConfirmPO;
import biz.app.market.model.MarketClaimConfirmVO;
import biz.app.market.model.MarketClaimListSO;
import biz.app.market.model.MarketClaimListVO;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.market.service
* - 파일명	: MarketClaimServiceImpl.java
* - 작성일	: 2017. 9. 21.
* - 작성자	: kimdp
* - 설명		: 오픈마켓 클레임 서비스 Impl
* </pre>
*/
@Slf4j
@Service
@Transactional
public class MarketClaimServiceImpl implements MarketClaimService {

	@Autowired	
	private MarketClaimBaseDao marketClaimBaseDao;	
	
	@Autowired	
	private MarketClaimDao marketClaimDao;	
	
	@Autowired	
	private ClaimBaseDao claimBaseDao;	
	
	/*
	 * 원주문 목록 페이징 조회
	 * @see biz.app.market.service.MarketOrderService#pageMarketOrderOrg(biz.app.market.model.MarketClaimListSO)
	 */
	@Override
	@Transactional(readOnly=true)
	public List<MarketClaimListVO> pageMarketClaimOrg(MarketClaimListSO so) {
		return this.marketClaimBaseDao.pageMarketClaimOrg(so);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketClaimServiceImpl.java
	* - 작성일	: 2017. 10. 17.
	* - 작성자	: schoi
	* - 설명		: Outbound API 주문 취소
	* </pre>
	* @param marketClaimConfirmPO
	* @return
	*/
	@Override
	@Transactional(propagation=Propagation.NOT_SUPPORTED)
	public void insertMarketClaimCancelConfirm (MarketClaimConfirmPO marketClaimConfirmPO) {

		if(marketClaimConfirmPO.getArrClmSeq() != null && marketClaimConfirmPO.getArrClmSeq().length > 0) {
			String clmNo = null;
			String ordNo = null;
			String preClmNo = null;
			Integer clmDtlSeq = 0;
			String goodsId = "";
			//String goodsNm = "";
			//String itemNm = "";

			for(Long clmSeq : marketClaimConfirmPO.getArrClmSeq()){
				marketClaimConfirmPO.setClmSeq(clmSeq);
				
				/* 동일 클레임 번호 유무 확인 */
				int checkClmNoCnt = this.marketClaimDao.checkClmNoCnt(marketClaimConfirmPO);

				/* 기존 주문 번호 */
				ordNo = this.marketClaimDao.getOrdNo(marketClaimConfirmPO);
				marketClaimConfirmPO.setOrdNo(ordNo);

				if(checkClmNoCnt == 0) { // 동일 클레임 번호 없는 경우
					
					/* 클레임 번호 생성 */
					clmNo = this.claimBaseDao.getClaimNo(ordNo);
					
					marketClaimConfirmPO.setClmNo(clmNo);
					marketClaimConfirmPO.setStId(1);
					marketClaimConfirmPO.setMbrNo(0);
					marketClaimConfirmPO.setClmTpCd(CommonConstants.CLM_TP_10);
					marketClaimConfirmPO.setClmStatCd(CommonConstants.CLM_STAT_30);
					marketClaimConfirmPO.setOrdMdaCd(CommonConstants.ORD_MDA_10);
					marketClaimConfirmPO.setChnlId(2);
					marketClaimConfirmPO.setSwapYn("N");
					
					/* 클레임 취소 기본 정보 등록 */
					int insertMarketClaimCancelBaseResult = this.marketClaimDao.insertMarketClaimCancelBase(marketClaimConfirmPO);
					
					if(insertMarketClaimCancelBaseResult != 1){
						/* 클레임 취소 처리 상태 변경 */
						marketClaimConfirmPO.setClmStat("01");
						marketClaimConfirmPO.setSellerPrdCd(goodsId);
						marketClaimConfirmPO.setProcCd("19");
						
						this.marketClaimDao.updateObClaimCancelProcCd(marketClaimConfirmPO);	
						
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
					
				} else { // 동일 클레임 번호 존재 하는 경우
					
					/* 기존 클레임 번호 */
					preClmNo = this.marketClaimDao.checkClmNo(marketClaimConfirmPO);
					marketClaimConfirmPO.setClmNo(preClmNo);
					
				}
				
				/* 클레임 상세 순번  */
				clmDtlSeq++;
				marketClaimConfirmPO.setClmDtlSeq(clmDtlSeq); 	// 클레임 상세 순번 (미사용)
				
				/* 클레임 취소 상세 정보  */
				marketClaimConfirmPO.setClmDtlTpCd(CommonConstants.CLM_DTL_TP_10);
				marketClaimConfirmPO.setClmDtlStatCd(CommonConstants.CLM_DTL_STAT_120);
				marketClaimConfirmPO.setRmnPayAmt(0L);
				marketClaimConfirmPO.setTaxGbCd(CommonConstants.TAX_GB_10); // 과세 구분 코드
				
				/* 클레임 취소 상세 정보 등록 */
				int insertMarketClaimCancelDetailResult = this.marketClaimDao.insertMarketClaimCancelDetail(marketClaimConfirmPO);
				
				if(insertMarketClaimCancelDetailResult != 1){
					/* 클레임 취소 처리 상태 변경 */
					marketClaimConfirmPO.setClmStat("01");
					marketClaimConfirmPO.setSellerPrdCd(goodsId);
					marketClaimConfirmPO.setProcCd("19");
					
					this.marketClaimDao.updateObClaimCancelProcCd(marketClaimConfirmPO);					

					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				
				/* 클레임 상품 정보 조회 */
				List<MarketClaimConfirmVO> marketClaimConfirmVO = this.marketClaimDao.selectClaimConfirmGoodsInfo(marketClaimConfirmPO);
				
				if(marketClaimConfirmVO != null && !marketClaimConfirmVO.isEmpty()){
					for(MarketClaimConfirmVO ccvo : marketClaimConfirmVO){
						if(ccvo.getGoodsId() != null){
							goodsId = ccvo.getGoodsId();
							//goodsNm = ccvo.getGoodsNm();
							//itemNm = ccvo.getItemNm();
						}
					}
				}
				
				/* 클레임 취소 처리 상태 변경 */
				marketClaimConfirmPO.setClmStat("02");
				marketClaimConfirmPO.setSellerPrdCd(goodsId);
				marketClaimConfirmPO.setProcCd("13"); // 처리상태(10:취소수집,11:취소승인,12:취소거부,13:취소완료,19:취소수집에러,20:반품수집,21:반품승인,22:반품거부,23:반품완료,29:반품수집에러,30:교환수집,31:교환승인,32:교환거부,33:교환보류,34:교환완료,39:교환수집에러)
				
				this.marketClaimDao.updateObClaimCancelProcCd(marketClaimConfirmPO);
			}
		}
		

	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명	: MarketClaimServiceImpl.java
	* - 작성일	: 2017. 10. 23.
	* - 작성자	: schoi
	* - 설명		: Outbound API 클레임 취소 수집
	* </pre>
	* @param String startDtm, String endDtm
	* @return
	*/
	@Override
	public void marketGetClaimCancel(String startDtm, String endDtm) {
		try {
			/* 로컬 테스트 시 */
			URL apiUrl = new URL("http://localhost:9090/api/11st/claim/cancel/gets/"+startDtm+"/"+endDtm);
			/* 운영 적용 시 */
//			URL apiUrl = new URL(bizConfig.getProperty("interface.ob.base.uri")+"/api/11st/claim/cancel/gets/"+startDtm+"/"+endDtm);
			log.debug("apiUrl: " + apiUrl);
			HttpURLConnection con = (HttpURLConnection)apiUrl.openConnection();
			
			con.setRequestMethod("GET");
			con.setDoInput(true);
			con.setDoOutput(true);
//			InputStream in = con.getInputStream();
//			OutputStream out = con.getOutputStream();
			int resCode = con.getResponseCode();
			log.debug("resCode: " + resCode);
			con.disconnect();
		} catch (Exception e) {
			log.debug(e.getLocalizedMessage());
		}
	}

}

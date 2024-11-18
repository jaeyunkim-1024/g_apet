package biz.app.pay.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

 
import biz.app.pay.dao.PayBaseDao;
import biz.app.pay.dao.PayCashRefundDao;
import biz.app.pay.model.PayBasePO;
import biz.app.pay.model.PayCashRefundPO;
import biz.app.pay.model.PayCashRefundSO;
import biz.app.pay.model.PayCashRefundVO;
import biz.common.service.BizService;
import biz.config.constants.BizConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.pay.service
* - 파일명		: PayBaseServiceImpl.java
* - 작성일		: 2017. 1. 12.
* - 작성자		: snw
* - 설명			: 결제 기본 서비스 Impl
* </pre>
*/
/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.pay.service
* - 파일명		: PayCashRefundServiceImpl.java
* - 작성일		: 2017. 1. 31.
* - 작성자		: snw
* - 설명			: 
* </pre>
*/
@Slf4j
@Service("payCashRefundService")
@Transactional
public class PayCashRefundServiceImpl implements PayCashRefundService {

	@Autowired	private PayBaseDao payBaseDao;

	@Autowired	private PayCashRefundDao payCashRefundDao;

	@Autowired private BizService bizService;
	
	/*
	 * 결제 현금 환불 완료 처리
	 * @see biz.app.pay.service.PayCashRefundService#compeltePayCashRefund(biz.app.pay.model.PayCashRefundPO)
	 */
	@Override
	public void compeltePayCashRefund(PayCashRefundPO po) {

		/*****************************
		 * 결제 현금 환불 조회
		 *****************************/
		PayCashRefundSO pcrso = new PayCashRefundSO();
		pcrso.setCashRfdNo(po.getCashRfdNo());
		PayCashRefundVO payCashRefund = this.payCashRefundDao.getPayCashRefund(pcrso);
		
		
		if(payCashRefund != null){
			
			if(CommonConstants.RFD_STAT_20.equals(payCashRefund.getRfdStatCd())){

				/*****************************
				 * 결제 현금 환불 > '완료' 처리
				 *****************************/
				po.setRfdStatCd(CommonConstants.RFD_STAT_30);
				int result = this.payCashRefundDao.updatePayCashRefundStatus(po);
				
				if(result == 1){

					/*****************************
					 * 결제 기본 상태 >  '완료' 처리
					 *****************************/
					PayBasePO pbpo = new PayBasePO();
					pbpo.setPayNo(payCashRefund.getPayNo());
					this.payBaseDao.updatePayBaseComplete(pbpo);

					/*****************************
					 * SMS or Email 발송
					 ******************************/
					//========================================================================
					// SMS 발송
					//========================================================================
//					OrderBaseSO orderBaseSO = new OrderBaseSO();
//					orderBaseSO.setOrdNo(orderSO.getOrdNo());		
//					OrderBaseVO getOrderBaseVO = orderBaseDao.getOrderBase( orderBaseSO );
//
//					SmsSendPO po = new SmsSendPO();
//					po.setReceiveName( getOrderBaseVO.getOrdNm() );
//					po.setReceivePhone( getOrderBaseVO.getOrdrMobile() );
//					po.setMsg( this.message.getMessage( "business.sms.pay.refund.msg", new String[]{ getOrderBaseVO.getOrdNo() } ) );
//					po.setSysRegrNo( getOrderBaseVO.getMbrNo() );
//					this.bizService.sendSms( po );

					//========================================================================
					// Email 발송
					//========================================================================
//					EmailSendPO eSPo = new EmailSendPO();
//
//					eSPo.setAuthKey( BizConstants.BIZMAILER_AUTH_KEY_ORDER_REFUND );
//					eSPo.setEmail( getOrderBaseVO.getOrdrEmail() );
//					eSPo.setNm( getOrderBaseVO.getOrdNm() );
//					eSPo.setMobile( getOrderBaseVO.getOrdrMobile() );
//
//					eSPo.setMemo1( getOrderBaseVO.getOrdrId() );
//					eSPo.setMemo2( getOrderBaseVO.getOrdNo() );
////					eSPo.setMemo3( finalRfdAmt.toString() );
//
//					bizService.sendEmail(eSPo);
					
				}else{
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}else{
				throw new CustomException(ExceptionConstants.ERROR_PAY_CASHE_REFUND_COMPLETE_STATUS);
			}
		}else{
			throw new CustomException(ExceptionConstants.ERROR_PAY_CASHE_REFUND_NO_EXISTS);
		}
		
	}
	
	
	@Override
	@Transactional( readOnly = true )
	public PayCashRefundVO getPayCashRefund( PayCashRefundSO so ) {
		return payCashRefundDao.getPayCashRefund( so );
	}

/**
 * 
* <pre>
* - 프로젝트명   : 11.business
* - 패키지명   : biz.app.pay.service
* - 파일명      : PayCashRefundServiceImpl.java
* - 작성일      : 2017. 3. 16.
* - 작성자      : valuefactory 권성중
* - 설명      : 홈 > 주문 관리 > 클레임 관리 > 환불 목록
* </pre>
 */
	@Override
	@Transactional( readOnly = true )
	public List<PayCashRefundVO> pagePayCashRefund( PayCashRefundSO so ) {
		return payCashRefundDao.pagePayCashRefund( so );
	}




}


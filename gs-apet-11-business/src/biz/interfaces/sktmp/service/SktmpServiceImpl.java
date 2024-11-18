package biz.interfaces.sktmp.service;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Optional;
import java.util.Properties;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;

import biz.app.appweb.dao.TermsDao;
import biz.app.member.dao.MemberBaseDao;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.model.TermsRcvHistoryPO;
import biz.app.order.dao.OrderBaseDao;
import biz.app.order.model.OrderBaseSO;
import biz.app.order.model.OrderBaseVO;
import biz.app.pay.dao.PayBaseDao;
import biz.app.system.model.PntInfoSO;
import biz.app.system.model.PntInfoVO;
import biz.app.system.service.PntInfoService;
import biz.common.service.BizService;
import biz.interfaces.sktmp.client.SktmpApiClient;
import biz.interfaces.sktmp.client.SktmpSocketApiClient;
import biz.interfaces.sktmp.constants.SktmpConstants;
import biz.interfaces.sktmp.dao.SktmpDao;
import biz.interfaces.sktmp.model.SktmpCardInfoPO;
import biz.interfaces.sktmp.model.SktmpCardInfoSO;
import biz.interfaces.sktmp.model.SktmpCardInfoVO;
import biz.interfaces.sktmp.model.SktmpLnkHistSO;
import biz.interfaces.sktmp.model.SktmpLnkHistVO;
import biz.interfaces.sktmp.model.request.MpPntApproveReqVO;
import biz.interfaces.sktmp.model.request.MpPntCancelReqVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00102ReqVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00108ReqVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00110ReqVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00114ReqVO;
import biz.interfaces.sktmp.model.response.MpPntApproveResVO;
import biz.interfaces.sktmp.model.response.MpPntCancelResVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00102ResVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00108ResVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00110ResVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00114ResVO;
import biz.interfaces.sktmp.util.SktmpConvertUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.service
 * - 파일명		: SktmpServiceImpl.java
 * - 작성일		: 2021. 07. 22.
 * - 작성자		: JinHong
 * - 설명		: SKT MP 서비스 구현
 * </pre>
 */
@Slf4j
@Service
@Transactional
public class SktmpServiceImpl implements SktmpService{
    @Autowired private SktmpDao sktmpDao;
    @Autowired private BizService bizService;
    @Autowired private Properties webConfig;
    @Autowired private Properties bizConfig;
    @Autowired private PntInfoService pntInfoService;
    @Autowired private TermsDao termsDao;
    @Autowired private MessageSourceAccessor message;
    @Autowired private PayBaseDao payBaseDao;
    @Autowired private OrderBaseDao orderBaseDao;
    @Autowired private MemberBaseDao memberBaseDao;
    
    
    
	@Override
	@Transactional(readOnly = true)
	public List<SktmpLnkHistVO> pageSktmpLnkHist(SktmpLnkHistSO so) {
		List<SktmpLnkHistVO> list = sktmpDao.pageSktmpLnkHist(so);
		for(SktmpLnkHistVO vo : list) {
			if(vo != null) {
				vo.setCardNo(bizService.twoWayDecrypt(vo.getCardNo()));
				vo.setPinNo(bizService.twoWayDecrypt(vo.getPinNo()));
				
				if(vo.getResCd() != null && !SktmpConstants.RES_SUCCESS_CODE.equals(vo.getResCd())) {
					vo.setCfmRstMsg(this.message.getMessage(CommonConstants.EXCEPTION_MESSAGE_COMMON + "SKTMP"+vo.getResCd()));
				}
			}
		}
		return list;
	}
	@Override
	@Transactional(readOnly = true)
	public List<SktmpLnkHistVO> listSktmpLnkHist(SktmpLnkHistSO so){
		return sktmpDao.listSktmpLnkHist(so);
	}
	
	@Override
	@Transactional(readOnly = true)
	public SktmpLnkHistVO getSktmpLnkHist(SktmpLnkHistSO so) {
		SktmpLnkHistVO vo = sktmpDao.getSktmpLnkHist(so);
		if(vo != null) {
			vo.setCardNo(bizService.twoWayDecrypt(vo.getCardNo()));
			vo.setPinNo(bizService.twoWayDecrypt(vo.getPinNo()));
		}
		return vo;
	}
	
	@Override
	@Transactional(readOnly = true)
	public SktmpLnkHistVO getSktmpPntHistTotal(SktmpLnkHistSO so) {
		return sktmpDao.getSktmpPntHistTotal(so);
	}
	
	@Override
	public void insertSktmpLnkHist(SktmpLnkHistVO vo) {
		int result = sktmpDao.insertSktmpLnkHist(encryptSktmpLnkHist(vo));
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	@Override
	public void updateSktmpLnkHist(SktmpLnkHistVO vo) {
		int result = sktmpDao.updateSktmpLnkHist(encryptSktmpLnkHist(vo));
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	@Override
	public void reqMpApprove(SktmpLnkHistVO vo, String ordClmGbCd, String errorCd) {
		
		SktmpSocketApiClient client = new SktmpSocketApiClient();
		
		MpPntApproveReqVO req = new MpPntApproveReqVO();
		Timestamp now = DateUtil.getTimestamp();
		String dealNum = "67".concat(StringUtils.leftPad(Long.toString(vo.getMpLnkHistNo()), 10, "0"));
		req.setDealGbCd(SktmpConstants.DEAL_GB_APPROVE);
		req.setDealAmt(Long.toString(vo.getDealAmt()));
		req.setUseMpPnt(Long.toString(Optional.ofNullable(vo.getUsePnt()).orElse(0L)));
		req.setMsgSndDtm(DateUtil.getTimestampToString(now, "yyyyMMddHHmmss"));
		req.setCardNum(vo.getCardNo());
		req.setDealNum(dealNum);
		req.setGoodsType(vo.getIfGoodsCd());
		
		if(vo.getUserIdGbCd() == null) {
			if(CommonConstants.ORD_CLM_GB_10.equals(ordClmGbCd)) {
				if(req.getUseMpPnt().getIntValue() == 0) {
					req.setUserIdGbCd(SktmpConstants.USER_ID_GB_07);
				}else {
					req.setUserIdGbCd(SktmpConstants.USER_ID_GB_08);
				}
			}else{
				//재요청 시 PIN 번호 변경될 경우가 있기 때문에 07로 요청
				req.setUserIdGbCd(SktmpConstants.USER_ID_GB_07);
			}
		}else {
			//재전송 시 07로 요청
			req.setUserIdGbCd(vo.getUserIdGbCd());
		}
		
		req.setPinNum(vo.getPinNo());
		req.setIfInfo(vo.getCiCtfVal());
		
		Gson gson = new Gson();
		vo.setReqJson(gson.toJson(req));
		vo.setReqDtm(now);
		vo.setDealNo(dealNum);
		
		
		SktmpConvertUtil<MpPntApproveReqVO, MpPntApproveResVO> util = new SktmpConvertUtil<>();
		String reqStr = util.getReqData(req);
		
		vo.setReqString(reqStr);
		String resStr = "";
		MpPntApproveResVO res = new MpPntApproveResVO();
		
		if(StringUtil.isEmpty(errorCd)) {
			try {
				resStr = client.getResponse(reqStr);
			} catch (Exception e) {
				//소켓통신중 에러가 발생했습니다.
				e.printStackTrace();
			}
			
			util.getResData(resStr, res);
		}else {
			//에러코드 있는경우 호출안함. 오류 처리(추후 재요청)
			res.setResCd(errorCd);
		}
		
		//Res setting
		vo.setRealUsePnt(res.getUseMpPnt().getValue() == null ? 0L : Long.parseLong(res.getUseMpPnt().getValue()));
		vo.setBoostUpPnt(res.getBoostUpPnt().getValue() == null ? 0L : Long.parseLong(res.getBoostUpPnt().getValue()));
		vo.setSavePnt(res.getAccumMpPnt().getValue() == null ? 0L : Long.parseLong(res.getAccumMpPnt().getValue()));
		vo.setResCd(res.getResCd().getValue());
		vo.setResDtlCd(res.getResDtlCd().getValue());
		vo.setCfmNo(res.getApprNum().getValue());
		vo.setResString(resStr);
		vo.setResJson(gson.toJson(res));
		vo.setResDtm(DateUtil.getTimestamp());
		
		if(vo.getResCd() == null ) {
			vo.setResCd(ExceptionConstants.ERROR_SKTMP_RE_REQ_DEFAULT);
		}

		vo.setResCd(vo.getResCd().replace("SKTMP", ""));
		if(!SktmpConstants.RES_SUCCESS_CODE.equals(vo.getResCd())) {
			vo.setCfmRstMsg(this.message.getMessage(CommonConstants.EXCEPTION_MESSAGE_COMMON + "SKTMP"+vo.getResCd()));
		}
		
		//이력 등록
		int result = 0;
		result = sktmpDao.updateResSktmpLnkHist(encryptSktmpLnkHist(vo));
		
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	@Override
	public void cancelMpApprove(SktmpLnkHistVO cncVO, String errorCd) {
		SktmpSocketApiClient client = new SktmpSocketApiClient();
		
		Timestamp now = DateUtil.getTimestamp();
		String dealNum = "67".concat(StringUtils.leftPad(Long.toString(cncVO.getMpLnkHistNo()), 10, "0"));
		MpPntCancelReqVO cncReq = new MpPntCancelReqVO();
		cncReq.setDealAmt(Long.toString(Optional.ofNullable(cncVO.getDealAmt()).orElse(0L)));
		cncReq.setUseMpPnt(Long.toString(Optional.ofNullable(cncVO.getUsePnt()).orElse(0L)));
		cncReq.setMsgSndDtm(DateUtil.getTimestampToString(now, "yyyyMMddHHmmss"));
		cncReq.setCardNum(cncVO.getCardNo());
		cncReq.setDealNum(dealNum);
		cncReq.setGoodsType(cncVO.getIfGoodsCd());
		cncReq.setApprNum(cncVO.getCncCfmNo());
		cncReq.setUserIdGbCd(SktmpConstants.USER_ID_GB_07);
		cncReq.setIfInfo(cncVO.getCiCtfVal());
		
		Gson gson = new Gson();
		cncVO.setReqJson(gson.toJson(cncReq));
		cncVO.setReqDtm(now);
		cncVO.setDealNo(dealNum);
		
		
		SktmpConvertUtil<MpPntCancelReqVO, MpPntCancelResVO> util = new SktmpConvertUtil<>();
		String reqStr = util.getReqData(cncReq);
		
		cncVO.setReqString(reqStr);
		
		String resStr = "";
		
		MpPntCancelResVO res = new MpPntCancelResVO();
		
		if(StringUtil.isEmpty(errorCd)) {
			try {
				resStr = client.getResponse(reqStr);
			} catch (IOException e) {
				//소켓통신중 에러가 발생했습니다.
				e.printStackTrace();
			}
			
			util.getResData(resStr, res);
		}else {
			//에러코드 있는경우 호출안함. 오류 처리(추후 재요청)
			res.setResCd(errorCd);
		}
		
		//Res setting
		cncVO.setRealUsePnt(res.getUseMpPnt().getValue() == null ? 0L : Long.parseLong(res.getUseMpPnt().getValue()));
		cncVO.setSavePnt(res.getAccumMpPnt().getValue() == null ? 0L : Long.parseLong(res.getAccumMpPnt().getValue()));
		cncVO.setResCd(res.getResCd().getValue());
		cncVO.setCfmNo(res.getApprNum().getValue());
		cncVO.setResString(resStr);
		cncVO.setResJson(gson.toJson(res));
		cncVO.setResDtm(DateUtil.getTimestamp());
		
		if(cncVO.getResCd() == null ) {
			cncVO.setResCd(ExceptionConstants.ERROR_SKTMP_RE_REQ_DEFAULT);
		}
		cncVO.setResCd(cncVO.getResCd().replace("SKTMP", ""));
		if(!SktmpConstants.RES_SUCCESS_CODE.equals(cncVO.getResCd())) {
			cncVO.setCfmRstMsg(this.message.getMessage(CommonConstants.EXCEPTION_MESSAGE_COMMON + "SKTMP"+cncVO.getResCd()));
		}
		//취소 이력 등록
		int result = 0;
		result = sktmpDao.updateResSktmpLnkHist(encryptSktmpLnkHist(cncVO));
		
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	@Override
	public void saveSktmpCardInfo(SktmpCardInfoPO po) {
		int result = 0;
		
		po.setCardInfoNo(bizService.getSequence(CommonConstants.SEQUENCE_SKTMP_CARD_INFO_SEQ));
		po.setCardNo(bizService.twoWayEncrypt(po.getCardNo()));
		po.setPinNo(bizService.twoWayEncrypt(po.getPinNo()));
		po.setUseYn(CommonConstants.COMM_YN_Y);
		result = sktmpDao.insertSktmpCardInfo(po);
		
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		} else {
			//우주 멤버십 약관 동의 이력 등록
			if (po.getTermsNo() != null) {
				for(int i=0; i<po.getTermsNo().length; i++) {
					TermsRcvHistoryPO trhpo = new TermsRcvHistoryPO();
					Long termsHistNo = this.bizService.getSequence(CommonConstants.SEQUENCE_TERMS_RCV_HISTORY_SEQ);
					trhpo.setTermsAgreeHistNo(termsHistNo);
					trhpo.setMbrNo(po.getMbrNo());
					trhpo.setTermsNo(Integer.parseInt(po.getTermsNo()[i]));
					trhpo.setRcvYn(CommonConstants.COMM_YN_Y);
					
					termsDao.insertCommonTermsRcvHistory(trhpo);
				}
			}
		}
	}

	@Override
	@Transactional(readOnly = true)
	public SktmpCardInfoVO getSktmpCardInfo(SktmpCardInfoSO so) {
		return sktmpDao.getSktmpCardInfo(so);
	}
	
	@Override
	@Transactional(readOnly = true)
	public SktmpLnkHistVO encryptSktmpLnkHist(SktmpLnkHistVO cncVO){
		cncVO.setCardNo(bizService.twoWayEncrypt(cncVO.getCardNo()));
		cncVO.setPinNo(bizService.twoWayEncrypt(cncVO.getPinNo()));
		return cncVO;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.sktmp.service
	 * - 작성일		: 2021. 08. 09.
	 * - 작성자		: hjh
	 * - 설명		: SKT MP PIN 번호 체크
	 * </pre>
	 * @param vo
	 * @return
	 */
	@Override
	@Transactional(readOnly = true)
	public ISR3K00102ResVO sktmpPinNoCheck(SktmpCardInfoVO vo) {
		ISR3K00102ReqVO usePsbReqVO = new ISR3K00102ReqVO();
		usePsbReqVO.setEBC_NUM(vo.getCardNo());
		usePsbReqVO.setPIN_NUMBER(vo.getPinNo());
		
		SktmpApiClient client = new SktmpApiClient();
		ISR3K00102ResVO resvo = client.getResponse(SktmpConstants.SKT_MP_API_HUB_ISR3K00102, usePsbReqVO, ISR3K00102ResVO.class);
		
		return resvo;
		
	}
	
	@Override
	@Transactional(readOnly = true)
	public ISR3K00108ResVO getUsableMpPnt(ISR3K00108ReqVO vo) {
		PntInfoSO pntSO = new PntInfoSO();
		pntSO.setPntTpCd(CommonConstants.PNT_TP_MP);
		PntInfoVO mpPntVO = pntInfoService.getPntInfo(pntSO);
		ISR3K00108ResVO res = null;
		if(mpPntVO != null) {
			SktmpApiClient client = new SktmpApiClient();
			vo.setCO_CD(SktmpConstants.PRTNR_CODE);
			vo.setGOODS_CD(mpPntVO.getIfGoodsCd());
			res = client.getResponse(SktmpConstants.SKT_MP_API_HUB_ISR3K00108, vo, ISR3K00108ResVO.class);
		}
		
		return res;
	}
	
	@Override
	@Transactional(readOnly = true)
	public ISR3K00110ResVO getMpSaveRmnCount(ISR3K00110ReqVO vo) {
		SktmpApiClient client = new SktmpApiClient();
		vo.setCO_CD(SktmpConstants.PRTNR_CODE);
		ISR3K00110ResVO res = client.getResponse(SktmpConstants.SKT_MP_API_HUB_ISR3K00110, vo, ISR3K00110ResVO.class);
		
		return res;
	}
	
	@Override
	@Transactional(readOnly = true)
	public ISR3K00114ResVO getEqualCheckCiAndCardNo(ISR3K00114ReqVO vo) {
		SktmpApiClient client = new SktmpApiClient();
		ISR3K00114ResVO res = client.getResponse(SktmpConstants.SKT_MP_API_HUB_ISR3K00114, vo, ISR3K00114ResVO.class);
		
		return res;
	}
	

	@Override
	public SktmpLnkHistVO reReqSktmpLnkHist(SktmpLnkHistSO so) {
		SktmpLnkHistVO vo = sktmpDao.getSktmpLnkHist(so);
		
		if(vo != null ) {
			PntInfoSO pntSO = new PntInfoSO();
			pntSO.setPntTpCd(CommonConstants.PNT_TP_MP);
			PntInfoVO mpPntVO = pntInfoService.getPntInfo(pntSO);
			
			vo.setCardNo(bizService.twoWayDecrypt(vo.getCardNo()));
			vo.setPinNo(bizService.twoWayDecrypt(vo.getPinNo()));
			
			OrderBaseSO orderSO = new OrderBaseSO();
			orderSO.setOrdNo(vo.getOrdNo());
			OrderBaseVO orderVO = orderBaseDao.getOrderBase(orderSO);
			MemberBaseSO memberSO = new MemberBaseSO();
			memberSO.setMbrNo(orderVO.getMbrNo());
			MemberBaseVO memberVO = memberBaseDao.getMemberBase(memberSO);
			
			vo.setCiCtfVal(memberVO.getCiCtfVal());
			//취소 요청
			if(CommonConstants.MP_REAL_LNK_GB_20.equals(vo.getMpRealLnkGbCd())) {
				SktmpLnkHistSO orgSO = new SktmpLnkHistSO();
				orgSO.setMpLnkHistNo(vo.getOrgMpLnkHistNo());
				SktmpLnkHistVO orgVO = sktmpDao.getSktmpLnkHist(orgSO);
				
				vo.setCncCfmNo(orgVO.getCfmNo());
				this.cancelMpApprove(vo, null);
			}else {
				//재결제 시 대체 상품코드로 요청
				SktmpLnkHistSO payMpSO = new SktmpLnkHistSO();
				payMpSO.setPayOrdNo(vo.getOrdNo());
				SktmpLnkHistVO orgPayMpVO = sktmpDao.getSktmpLnkHist(payMpSO);
				
				String nowDateStr = DateUtil.getNowDate();
				String reqDateStr = DateUtil.getTimestampToString(orgPayMpVO.getReqDtm());
				
				//오늘 재요청을 할 경우 상품코드로 보냄 else -> 대체 상품코드
				if(nowDateStr.equals(reqDateStr)) {
					vo.setIfGoodsCd(mpPntVO.getIfGoodsCd());
				}else {
					vo.setIfGoodsCd(mpPntVO.getAltIfGoodsCd());
				}
				
				vo.setUserIdGbCd(SktmpConstants.USER_ID_GB_07);
				if(vo.getSaveSchdPnt() != null &&  vo.getSaveSchdPnt() > 0) {
					ISR3K00110ReqVO saveReq = new ISR3K00110ReqVO();
					saveReq.setEBC_NUM1(vo.getCardNo());
					saveReq.setGOODS_CD(vo.getIfGoodsCd());
					ISR3K00110ResVO saveRes = this.getMpSaveRmnCount(saveReq);
					
					//적립횟수 안되는경우
					if(saveRes != null && Integer.valueOf(saveRes.getACCUM_CNT()) == 0) {
						throw new CustomException(ExceptionConstants.ERROR_SKTMP_OVER_ACCUM);
					}
				}
				
				//재결제 - update 
				this.reqMpApprove(vo, CommonConstants.ORD_CLM_GB_10, null);
			}
			
		}
		
		return vo;
	}
}

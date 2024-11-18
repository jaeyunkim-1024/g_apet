package admin.web.view.sample.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberService;
import biz.app.order.model.OrderBaseSO;
import biz.app.order.model.OrderBaseVO;
import biz.app.order.service.OrderBaseService;
import biz.common.service.BizService;
import biz.interfaces.sktmp.client.SktmpApiClient;
import biz.interfaces.sktmp.constants.SktmpConstants;
import biz.interfaces.sktmp.model.SktmpLnkHistSO;
import biz.interfaces.sktmp.model.SktmpLnkHistVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00101ReqVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00102ReqVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00105ReqVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00106ReqVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00107ReqVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00108ReqVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00109ReqVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00110ReqVO;
import biz.interfaces.sktmp.model.request.apihub.ISR3K00114ReqVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00101ResVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00102ResVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00105ResVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00106ResVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00107ResVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00108ResVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00109ResVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00110ResVO;
import biz.interfaces.sktmp.model.response.apihub.ISR3K00114ResVO;
import biz.interfaces.sktmp.service.SktmpService;
import framework.common.constants.CommonConstants;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("samplesktmp")
public class SampleSktMpController {
	@Autowired private SktmpService sktmpService;
	@Autowired private BizService bizService;
	@Autowired private MemberService memberService;
	@Autowired private OrderBaseService orderBaseService;
	@RequestMapping(value = "apiHubISR3K00101.do", method = RequestMethod.POST)
	@ResponseBody
	public  ISR3K00101ResVO apiHubISR3K00101(ISR3K00101ReqVO param) throws Exception{
		SktmpApiClient client = new SktmpApiClient();
		ISR3K00101ResVO vo = client.getResponse(SktmpConstants.SKT_MP_API_HUB_ISR3K00101, param, ISR3K00101ResVO.class);
		
		return vo;
	}
	
	@RequestMapping(value = "apiHubISR3K00102.do", method = RequestMethod.POST)
	@ResponseBody
	public  ISR3K00102ResVO apiHubISR3K00102(ISR3K00102ReqVO param) throws Exception{
		SktmpApiClient client = new SktmpApiClient();
		ISR3K00102ResVO vo = client.getResponse(SktmpConstants.SKT_MP_API_HUB_ISR3K00102, param, ISR3K00102ResVO.class);
		
		return vo;
	}
	@RequestMapping(value = "apiHubISR3K00105.do", method = RequestMethod.POST)
	@ResponseBody
	public  ISR3K00105ResVO apiHubISR3K00105(ISR3K00105ReqVO param) throws Exception{
		SktmpApiClient client = new SktmpApiClient();
		ISR3K00105ResVO vo = client.getResponse(SktmpConstants.SKT_MP_API_HUB_ISR3K00105, param, ISR3K00105ResVO.class);
		
		return vo;
	}
	
	@RequestMapping(value = "apiHubISR3K00106.do", method = RequestMethod.POST)
	@ResponseBody
	public  ISR3K00106ResVO apiHubISR3K00106(ISR3K00106ReqVO param) throws Exception{
		SktmpApiClient client = new SktmpApiClient();
		ISR3K00106ResVO vo = client.getResponse(SktmpConstants.SKT_MP_API_HUB_ISR3K00106, param, ISR3K00106ResVO.class);
		
		return vo;
	}
	
	@RequestMapping(value = "apiHubISR3K00107.do", method = RequestMethod.POST)
	@ResponseBody
	public  ISR3K00107ResVO apiHubISR3K00107(ISR3K00107ReqVO param) throws Exception{
		SktmpApiClient client = new SktmpApiClient();
		ISR3K00107ResVO vo = client.getResponse(SktmpConstants.SKT_MP_API_HUB_ISR3K00107, param, ISR3K00107ResVO.class);
		
		return vo;
	}
	
	@RequestMapping(value = "apiHubISR3K00108.do", method = RequestMethod.POST)
	@ResponseBody
	public  ISR3K00108ResVO apiHubISR3K00108(ISR3K00108ReqVO param) throws Exception{
		SktmpApiClient client = new SktmpApiClient();
		ISR3K00108ResVO vo = client.getResponse(SktmpConstants.SKT_MP_API_HUB_ISR3K00108, param, ISR3K00108ResVO.class);
		
		return vo;
	}
	
	@RequestMapping(value = "apiHubISR3K00109.do", method = RequestMethod.POST)
	@ResponseBody
	public  ISR3K00109ResVO apiHubISR3K00109(ISR3K00109ReqVO param) throws Exception{
		SktmpApiClient client = new SktmpApiClient();
		ISR3K00109ResVO vo = client.getResponse(SktmpConstants.SKT_MP_API_HUB_ISR3K00109, param, ISR3K00109ResVO.class);
		
		return vo;
	}
	@RequestMapping(value = "apiHubISR3K00110.do", method = RequestMethod.POST)
	@ResponseBody
	public  ISR3K00110ResVO apiHubISR3K00110(ISR3K00110ReqVO param) throws Exception{
		SktmpApiClient client = new SktmpApiClient();
		ISR3K00110ResVO vo = client.getResponse(SktmpConstants.SKT_MP_API_HUB_ISR3K00110, param, ISR3K00110ResVO.class);
		
		return vo;
	}
	
	@RequestMapping(value = "apiHubISR3K00114.do", method = RequestMethod.POST)
	@ResponseBody
	public  ISR3K00114ResVO apiHubISR3K00114(ISR3K00114ReqVO param) throws Exception{
		SktmpApiClient client = new SktmpApiClient();
		ISR3K00114ResVO vo = client.getResponse(SktmpConstants.SKT_MP_API_HUB_ISR3K00114, param, ISR3K00114ResVO.class);
		
		return vo;
	}
	
	@RequestMapping(value = "cancelMpPoint.do", method = RequestMethod.POST)
	@ResponseBody
	public  SktmpLnkHistVO apiHubISR3K00110(SktmpLnkHistSO so) throws Exception{
		
		SktmpLnkHistVO mpVO =  sktmpService.getSktmpLnkHist(so);
		OrderBaseSO orderBaseSO = new OrderBaseSO();
		orderBaseSO.setOrdNo(mpVO.getOrdNo());;
		OrderBaseVO orderVO = orderBaseService.getOrderBase(orderBaseSO);
		MemberBaseSO memberSO = new MemberBaseSO();
		memberSO.setMbrNo(orderVO.getMbrNo());
		MemberBaseVO memberVO = memberService.getMemberBase(memberSO);
		//취소 요청
		SktmpLnkHistVO cncVO = new SktmpLnkHistVO();
		cncVO.setMpLnkHistNo(this.bizService.getSequence(CommonConstants.SEQUENCE_SKTMP_LNK_HIST_SEQ));
		cncVO.setPntNo(mpVO.getPntNo());
		cncVO.setOrdNo(mpVO.getOrdNo());
		cncVO.setClmNo("FORCE_CANCEL");
		cncVO.setOrgMpLnkHistNo(mpVO.getMpLnkHistNo());
		if(CommonConstants.MP_LNK_GB_10.equals(mpVO.getMpLnkGbCd())) {
			cncVO.setMpLnkGbCd(CommonConstants.MP_LNK_GB_20);
		}else {
			cncVO.setMpLnkGbCd(CommonConstants.MP_LNK_GB_40);
		}
		cncVO.setMpRealLnkGbCd(CommonConstants.MP_REAL_LNK_GB_20);
		cncVO.setIfGoodsCd(mpVO.getIfGoodsCd());
		cncVO.setCncCfmNo(mpVO.getCfmNo());
		cncVO.setDealAmt(mpVO.getDealAmt());
		cncVO.setUsePnt(mpVO.getUsePnt());
		cncVO.setAddUsePnt(mpVO.getAddUsePnt());
		cncVO.setSaveSchdPnt(mpVO.getSaveSchdPnt());
		cncVO.setAddSaveSchdPnt(mpVO.getAddSaveSchdPnt());
		cncVO.setCiCtfVal(memberVO.getCiCtfVal());
		
		
		sktmpService.insertSktmpLnkHist(cncVO);
		
		cncVO.setCardNo(mpVO.getCardNo());
		cncVO.setPinNo(mpVO.getPinNo());
		sktmpService.cancelMpApprove(cncVO, null);
		
		return cncVO;
	}
}
package biz.app.order.service;

import java.sql.Timestamp;
import java.util.Optional;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberService;
import biz.app.order.dao.OrdSavePntDao;
import biz.app.order.model.GsPntHistPO;
import biz.app.order.model.OrdSavePntPO;
import biz.app.order.model.OrdSavePntSO;
import biz.app.order.model.OrdSavePntVO;
import biz.interfaces.gsr.model.GsrMemberPointPO;
import biz.interfaces.gsr.model.GsrMemberPointVO;
import biz.interfaces.gsr.service.GsrService;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;


/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.order.service
 * - 파일명		: OrdSavePntServiceImpl.java
 * - 작성일		: 2021. 03. 15.
 * - 작성자		: JinHong
 * - 설명		: 주문 포인트 서비스 구현
 * </pre>
 */
@Slf4j
@Service
@Transactional
public class OrdSavePntServiceImpl implements OrdSavePntService {
	
	@Autowired	private OrdSavePntDao ordSavePntDao;
	
	@Autowired	private GsrService gsrService;
	
	@Autowired	private MemberService memberService;
	
	
	@Override
	public void accumOrdGsPoint(OrdSavePntPO po) {
		MemberBaseSO memberSo = new MemberBaseSO();
		memberSo.setMbrNo(po.getMbrNo());
		MemberBaseVO memberVo =  memberService.getMemberBase(memberSo);
		String gsptNo = Optional.ofNullable(memberVo.getGsptNo()).orElseGet(()->gsrService.getGsptNo(po.getMbrNo()));
		memberVo.setGsptNo(gsptNo);

		//2021-05-14 CI 값이 있을 경우 포인트 발급 요청
		if(StringUtil.isNotEmpty(memberVo.getGsptNo())) {

			GsrMemberPointPO gsrPointPO = new GsrMemberPointPO();
			gsrPointPO.setMbrNo(po.getMbrNo());
			gsrPointPO.setPntRsnCd(CommonConstants.PNT_RSN_ORDER);
			gsrPointPO.setRcptNo(po.getRcptNo());
			gsrPointPO.setPoint(Optional.ofNullable(po.getPnt()).orElse(0).toString());
			gsrPointPO.setSaleAmt(Optional.ofNullable(po.getSaleAmt()).orElse(0L).toString());
			gsrPointPO.setSaleDate(po.getSaleDtm() == null ? null : DateUtil.getTimestampToString(po.getSaleDtm()));
			gsrPointPO.setSaleEndDt(po.getSaleDtm() == null ? null : DateUtil.getTimestampToString(po.getSaleDtm(), "HHmmss"));
			
			GsrMemberPointVO gsrPointVO = gsrService.accumGsPoint(gsrPointPO);
			if(StringUtil.isNotEmpty(Optional.ofNullable(gsrPointVO.getApprNo()).orElseGet(()->""))){
				po.setSaveUseGbCd(CommonConstants.SAVE_USE_GB_10);
				po.setDealGbCd(CommonConstants.DEAL_GB_10);
				po.setMbrNo(po.getMbrNo());
				po.setGspntNo(memberVo.getGsptNo());

				po.setPayAmt(Optional.ofNullable(po.getSaleAmt()).orElse(0L));
				po.setOrdSavePnt(po.getPnt());
				po.setDealNo(gsrPointVO.getApprNo());
				po.setDealDtm(StringUtils.isEmpty(gsrPointVO.getApprDate()) ? null :  DateUtil.getTimestamp(gsrPointVO.getApprDate(), "yyyyMMdd"));

				ordSavePntDao.insertOrdSavePntInfo(po);
				po.setDealDtm(po.getSaleDtm());
				ordSavePntDao.insertGsPntHist(po);
			}
		}
	}

	@Override
	public void accumReOrdGsPoint(OrdSavePntPO po) {
		
		
		MemberBaseSO memberSo = new MemberBaseSO();
		memberSo.setMbrNo(po.getMbrNo());
		MemberBaseVO memberVo =  memberService.getMemberBase(memberSo);

		String gsptNo = Optional.ofNullable(memberVo.getGsptNo()).orElseGet(()->gsrService.getGsptNo(po.getMbrNo()));
		memberVo.setGsptNo(gsptNo);
		
		//2021-05-14 CI 값이 있을 경우 포인트 발급 요청
		if(StringUtil.isNotEmpty(memberVo.getGsptNo())) {
			OrdSavePntSO so = new OrdSavePntSO();
			so.setOrdNo(po.getOrdNo());
			so.setOrdDtlSeq(po.getOrdDtlSeq());
			
			OrdSavePntVO vo = ordSavePntDao.getOrdSavePntInfo(so);
			
			if(vo != null && Integer.compare(vo.getOrdSavePnt(), po.getPnt()) != 0) {
				//주문적립이 된 경우, 재지급 할 포인트가 지급한 포인트와 다른 경우
				
				//포인트 지급 취소
				GsrMemberPointPO cancelPO = new GsrMemberPointPO();
				cancelPO.setPntRsnCd(CommonConstants.PNT_RSN_ORDER);
				cancelPO.setMbrNo(po.getMbrNo());
				cancelPO.setRcptNo(po.getRcptNo());
				cancelPO.setPoint(Optional.ofNullable(vo.getOrdSavePnt()).orElse(0).toString());
				cancelPO.setSaleDate(po.getSaleDtm() == null ? null : DateUtil.getTimestampToString(po.getSaleDtm()));
				cancelPO.setSaleEndDt(po.getSaleDtm() == null ? null : DateUtil.getTimestampToString(po.getSaleDtm(), "HHmmss"));
				cancelPO.setOrgApprNo(Optional.ofNullable(vo.getDealNo()).orElseGet(()->""));
				cancelPO.setOrgApprDate(vo.getDealDtm() == null ? null : DateUtil.getTimestampToString(vo.getDealDtm(), "yyyyMMdd"));
				GsrMemberPointVO cancelPointVO =  gsrService.accumCancelGsPoint(cancelPO);

				if(StringUtil.isNotEmpty(Optional.ofNullable(cancelPointVO.getApprNo()).orElseGet(()->""))){
					OrdSavePntPO histPO = new OrdSavePntPO();
					histPO.setSaveUseGbCd(CommonConstants.SAVE_USE_GB_20);
					histPO.setOrgGsPntHistNo(vo.getGsPntHistNo());
					histPO.setDealGbCd(CommonConstants.DEAL_GB_20);
					histPO.setMbrNo(po.getMbrNo());

					String gspntNo = memberVo.getGsptNo();
					histPO.setGspntNo(gspntNo);
					histPO.setPayAmt(Optional.ofNullable(po.getSaleAmt()).orElse(0L));

					histPO.setPnt(vo.getOrdSavePnt());
					histPO.setDealNo(cancelPointVO.getApprNo());
					histPO.setDealDtm(StringUtil.isEmpty(cancelPointVO.getApprDate()) ? null : DateUtil.getTimestamp(cancelPointVO.getApprDate(), "yyyyMMdd"));
					histPO.setOrdNo(po.getOrdNo());
					histPO.setOrdDtlSeq(po.getOrdDtlSeq());
					histPO.setClmNo(po.getClmNo());
					histPO.setClmDtlSeq(po.getClmDtlSeq());

					ordSavePntDao.insertGsPntHist(histPO);

					//지급포인트가 0일경우 발급 X (전체 취소,반품일 경우)
					if(po.getPnt() > 0) {
						//포인트 재지급
						GsrMemberPointPO gsrPointPO = new GsrMemberPointPO();
						gsrPointPO.setPntRsnCd(CommonConstants.PNT_RSN_ORDER);
						gsrPointPO.setMbrNo(po.getMbrNo());
						gsrPointPO.setRcptNo(po.getRcptNo());
						gsrPointPO.setPoint(Optional.ofNullable(po.getPnt()).orElse(0).toString());
						gsrPointPO.setSaleAmt(Optional.ofNullable(po.getSaleAmt()).orElse(0L).toString());
						gsrPointPO.setSaleDate(po.getSaleDtm() == null ? null : DateUtil.getTimestampToString(po.getSaleDtm()));
						gsrPointPO.setSaleEndDt(po.getSaleDtm() == null ? null : DateUtil.getTimestampToString(po.getSaleDtm(), "HHmmss"));

						GsrMemberPointVO gsrPointVO = gsrService.accumGsPoint(gsrPointPO);
						if(StringUtil.isNotEmpty(Optional.ofNullable(gsrPointVO.getApprNo()).orElseGet(()->""))){
							po.setSaveUseGbCd(CommonConstants.SAVE_USE_GB_10);
							po.setDealGbCd(CommonConstants.DEAL_GB_10);
							po.setGspntNo(gspntNo);
							po.setPayAmt(Optional.ofNullable(po.getSaleAmt()).orElse(0L));
							po.setPnt(po.getPnt());
							po.setOrdSavePnt(po.getPnt());
							po.setDealNo(gsrPointVO.getApprNo());
							po.setDealDtm(StringUtil.isEmpty(gsrPointVO.getApprDate()) ? null : DateUtil.getTimestamp(gsrPointVO.getApprDate(), "yyyyMMdd"));
							po.setOrdNo(po.getOrdNo());
							po.setOrdDtlSeq(po.getOrdDtlSeq());
							po.setClmNo(po.getClmNo());
							po.setClmDtlSeq(po.getClmDtlSeq());

							po.setOrdSavePnt(po.getPnt());
							ordSavePntDao.updateOrdSavePntInfo(po);
							po.setOrdSavePnt(null);
							po.setDealDtm(po.getSaleDtm());
							ordSavePntDao.insertGsPntHist(po);
						}
					}
				}
			}
		}
	}
}


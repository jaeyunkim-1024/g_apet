package admin.web.view.claim.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import framework.common.util.MaskingUtil;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.ibatis.cache.CacheException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.claim.model.ClaimBaseVO;
import biz.app.claim.model.ClaimDetailSO;
import biz.app.claim.model.ClaimDetailVO;
import biz.app.claim.model.ClaimListVO;
import biz.app.claim.model.ClaimRefundVO;
import biz.app.claim.model.ClaimRegist;
import biz.app.claim.model.ClaimRegist.ClaimSub;
import biz.app.claim.model.ClaimSO;
import biz.app.claim.model.ClmDtlCstrtPO;
import biz.app.claim.service.ClaimAcceptService;
import biz.app.claim.service.ClaimBaseService;
import biz.app.claim.service.ClaimDetailService;
import biz.app.claim.service.ClaimService;
import biz.app.counsel.model.CounselPO;
import biz.app.counsel.model.CounselProcessPO;
import biz.app.delivery.model.DeliveryChargeSO;
import biz.app.delivery.model.DeliveryChargeVO;
import biz.app.delivery.service.DeliveryChargePolicyService;
import biz.app.delivery.service.DeliveryChargeService;
import biz.app.goods.model.ItemSO;
import biz.app.goods.model.ItemVO;
import biz.app.goods.service.ItemService;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberService;
import biz.app.order.model.OrderBaseVO;
import biz.app.order.model.OrderDetailSO;
import biz.app.order.model.OrderDetailVO;
import biz.app.order.model.OrderDlvraSO;
import biz.app.order.model.OrderDlvraVO;
import biz.app.order.model.OrderMemoPO;
import biz.app.order.model.OrderMemoSO;
import biz.app.order.model.OrderMemoVO;
import biz.app.order.model.OrderSO;
import biz.app.order.service.OrderBaseService;
import biz.app.order.service.OrderDetailService;
import biz.app.order.service.OrderDlvraService;
import biz.app.order.service.OrderMemoService;
import biz.app.pay.model.PayBaseSO;
import biz.app.pay.model.PayBaseVO;
import biz.app.pay.service.PayBaseService;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ClaimController {

	@Autowired private CacheService cacheService;
	
	@Autowired	private ClaimService claimService;

	@Autowired	private ClaimBaseService claimBaseService;

	@Autowired	private ClaimDetailService claimDetailService;

	@Autowired	private OrderBaseService orderBaseService;

	@Autowired	private OrderDetailService orderDetailService;

	@Autowired private OrderDlvraService orderDlvraService;

	@Autowired private PayBaseService payBaseService;

	@Autowired private MemberService memberService;

	@Autowired private ItemService itemService;

	@Autowired private DeliveryChargeService deliveryChargeService;
	
	@Autowired private OrderMemoService orderMemoService;
	
	@Autowired private DeliveryChargePolicyService deliveryChargePolicyService;
	
	@Autowired private BizService bizService;
	
	@Autowired private ClaimAcceptService claimAcceptService;
	
	//-------------------------------------------------------------------------------------------------------------------------//
	//- 클레임 신청 관련
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: ClaimController.java
	* - 작성일		: 2017. 3. 21.
	* - 작성자		: snw
	* - 설명			: 주문 취소 신청 팝업
	* </pre>
	* @param model
	* @param orderDetailSO
	* @return
	*/
	@RequestMapping("/claim/claimCancelAcceptPopView.do")
	public String claimCancelAcceptPopView(Model model, OrderDetailSO orderDetailSO) {

		if(orderDetailSO.getArrOrdDtlSeq() == null){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}

		/********************************
		 * 주문 기본 정보
		 ********************************/
		OrderBaseVO orderBase = this.orderBaseService.getOrderBase(orderDetailSO.getOrdNo());
		model.addAttribute( "orderBase", orderBase );

		/********************************
		 * 회원정보 정보
		 ********************************/
		MemberBaseVO memberBase = null;

		if(!CommonConstants.NO_MEMBER_NO.equals(orderBase.getMbrNo())){
			MemberBaseSO mbso = new MemberBaseSO();
			mbso.setMbrNo(orderBase.getMbrNo());
			memberBase = this.memberService.getMemberBase(mbso);
			//복호화		
			memberBase.setMbrNm(bizService.twoWayDecrypt(memberBase.getMbrNm()));			
		}
		model.addAttribute( "memberBase", memberBase );

		/***************************
		 * 코드 목록
		 ***************************/
		List<CodeDetailVO> clmRsnList = this.cacheService.listCodeCache(AdminConstants.CLM_RSN, AdminConstants.CLM_TP_10, null, null, null, null);
				
		model.addAttribute("clmRsnList", clmRsnList);
		
		

		/********************************
		 * 취소상품 목록 정보
		 ********************************/
		List<OrderDetailVO> listOrderDetail = orderDetailService.listOrderDetail( orderDetailSO );
		model.addAttribute( "listOrderDetail", listOrderDetail );

		return "/claim/claimCancelAcceptPopView";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: ClaimController.java
	* - 작성일		: 2017. 7. 28.
	* - 작성자		: Administrator
	* - 설명			: 주문취소 환불예정금액 조회
	* </pre>
	* @param clmRegist
	* @param arrOrdDtlSeq
	* @param clmRsnCd
	* @param arrClmQty
	* @return
	*/
	@RequestMapping("/claim/claimCancelExpt.do")
	public String claimCancelExpt(ModelMap map, ClaimRegist clmRegist, Integer[] arrOrdDtlSeq, String clmRsnCd, Integer[] arrClmQty) {
		Session session = AdminSessionUtil.getSession();

		/********************************
		 * 클레임 접수 데이터 생성
		 ********************************/
		clmRegist.setClmTpCd(AdminConstants.CLM_TP_10);
		clmRegist.setAcptrNo(session.getUsrNo());
		clmRegist.setOrdMdaCd(CommonConstants.ORD_MDA_10);

		if(arrOrdDtlSeq != null && arrOrdDtlSeq.length > 0){
			List<ClaimSub> claimSubList = new ArrayList<>();

			for(int i=0; i<arrOrdDtlSeq.length; i++){
				ClaimSub claimSub = new ClaimSub();
				claimSub.setOrdDtlSeq(arrOrdDtlSeq[i]);

				if(arrClmQty != null){
					claimSub.setClmQty(arrClmQty[i]);
				}
				claimSubList.add(claimSub);
			}
			clmRegist.setClaimSubList(claimSubList);
		}

		/********************************
		 * 환불예상금액 조회
		 ********************************/
		ClaimRefundVO claimRefund = this.claimService.getClaimRefundExcpect(clmRegist, CommonConstants.CLM_TP_10);

		map.put("claimRefund", claimRefund);
		
		return View.jsonView();
	}
	

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: ClaimController.java
	* - 작성일		: 2017. 3. 21.
	* - 작성자		: snw
	* - 설명			: 주문 취소
	* </pre>
	* @param clmRegist
	* @param arrOrdDtlSeq
	* @param clmRsnCd
	* @param arrClmQty
	* @return
	*/
	@RequestMapping("/claim/claimCancelExc.do")
	public String claimCancelExc(	ClaimRegist clmRegist, Integer[] arrOrdDtlSeq, String clmRsnCd, Integer[] arrClmQty) {
		Session session = AdminSessionUtil.getSession();

		/********************************
		 * 클레임 접수 데이터 생성
		 ********************************/
		clmRegist.setClmTpCd(AdminConstants.CLM_TP_10);
		clmRegist.setAcptrNo(session.getUsrNo());
		clmRegist.setOrdMdaCd(CommonConstants.ORD_MDA_10);

		if(arrOrdDtlSeq != null && arrOrdDtlSeq.length > 0){
			List<ClaimSub> claimSubList = new ArrayList<>();

			for(int i=0; i<arrOrdDtlSeq.length; i++){
				ClaimSub claimSub = new ClaimSub();
				claimSub.setOrdDtlSeq(arrOrdDtlSeq[i]);

				if(arrClmQty != null){
					claimSub.setClmQty(arrClmQty[i]);
				}
				claimSubList.add(claimSub);
			}
			clmRegist.setClaimSubList(claimSubList);
		}

		/********************************
		 * 클레임 접수 호출
		 ********************************/
		String clmNo = this.claimAcceptService.acceptClaim(clmRegist);
		
		return View.jsonView();
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: ClaimController.java
	* - 작성일		: 2017. 3. 21.
	* - 작성자		: snw
	* - 설명			: 반품 접수 팝업
	* </pre>
	* @param model
	* @param orderDetailSO
	* @return
	*/
	@RequestMapping("/claim/claimReturnAcceptPopView.do")
	public String claimReturnAcceptPopView(Model model, OrderDetailSO orderDetailSO) {

		if(orderDetailSO.getArrOrdDtlSeq() == null){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}

		/************************
		 *  주문 기본 정보
		 ************************/
		OrderBaseVO orderBase = this.orderBaseService.getOrderBase(orderDetailSO.getOrdNo());
		model.addAttribute( "orderBase", orderBase );

		/************************
		 *  반품상품 목록 정보
		 ************************/
		List<OrderDetailVO> listOrderDetail = orderDetailService.listOrderClaimDetail( orderDetailSO );
		model.addAttribute( "listOrderDetail", listOrderDetail );

		/********************************
		 * 회원정보 정보
		 ********************************/
		MemberBaseVO memberBase = null;

		if(!CommonConstants.NO_MEMBER_NO.equals(orderBase.getMbrNo())){
			MemberBaseSO mbso = new MemberBaseSO();
			mbso.setMbrNo(orderBase.getMbrNo());
			memberBase = this.memberService.getMemberBase(mbso);
		}
		model.addAttribute( "memberBase", memberBase );

		/************************
		 *  배송지 정보
		 ************************/
		OrderDlvraSO odso = new OrderDlvraSO();
		odso.setOrdNo(orderDetailSO.getOrdNo());
		OrderDlvraVO orderDlvra =  this.orderDlvraService.getOrderDlvra(odso);
		model.addAttribute( "orderDlvra", orderDlvra);

		/***************************
		 * 코드 목록
		 ***************************/
		List<CodeDetailVO> clmRsnList = this.cacheService.listCodeCache(AdminConstants.CLM_RSN, AdminConstants.CLM_TP_20, null, null, null, null);
				
		model.addAttribute("clmRsnList", clmRsnList);

		
		return "/claim/claimReturnAcceptPopView";

	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: ClaimController.java
	* - 작성일		: 2017. 7. 28.
	* - 작성자		: Administrator
	* - 설명			: 반품 환불 예정금액 조회
	* </pre>
	* @param map
	* @param clmRegist
	* @param arrOrdDtlSeq
	* @param clmRsnCd
	* @param arrClmQty
	* @return
	*/
	@RequestMapping("/claim/claimReturnExpt.do")
	public String claimReturnExpt(	ModelMap map, ClaimRegist clmRegist, Integer[] arrOrdDtlSeq, String clmRsnCd, Integer[] arrClmQty) {
		Session session = AdminSessionUtil.getSession();

		/********************************
		 * 클레임 접수 데이터 생성
		 ********************************/
		clmRegist.setClmTpCd(AdminConstants.CLM_TP_20);
		clmRegist.setAcptrNo(session.getUsrNo());
		clmRegist.setOrdMdaCd(CommonConstants.ORD_MDA_10);

		if(arrOrdDtlSeq != null && arrOrdDtlSeq.length > 0){
			List<ClaimSub> claimSubList = new ArrayList<>();

			for(int i=0; i<arrOrdDtlSeq.length; i++){
				ClaimSub claimSub = new ClaimSub();
				claimSub.setOrdDtlSeq(arrOrdDtlSeq[i]);

				if(arrClmQty != null){
					claimSub.setClmQty(arrClmQty[i]);
				}
				claimSubList.add(claimSub);
			}
			clmRegist.setClaimSubList(claimSubList);
		}

		/********************************
		 * 환불예상금액 조회
		 ********************************/
		ClaimRefundVO claimRefund = this.claimService.getClaimRefundExcpect(clmRegist, CommonConstants.CLM_TP_20);

		map.put("claimRefund", claimRefund);

		return View.jsonView();
	}

	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: ClaimController.java
	* - 작성일		: 2017. 3. 21.
	* - 작성자		: snw
	* - 설명			: 반품 접수 처리
	* </pre>
	* @param clmRegist
	* @param arrOrdDtlSeq
	* @param clmRsnCd
	* @param arrClmQty
	* @return
	*/
	@RequestMapping("/claim/claimReturnExc.do")
	public String claimReturnExc(	ClaimRegist clmRegist, Integer[] arrOrdDtlSeq, Integer[] arrClmQty) {
		Session session = AdminSessionUtil.getSession();

		/********************************
		 * 클레임 접수 데이터 생성
		 ********************************/
		clmRegist.setClmTpCd(AdminConstants.CLM_TP_20);
		clmRegist.setAcptrNo(session.getUsrNo());
		clmRegist.setOrdMdaCd(CommonConstants.ORD_MDA_10);

		if(arrOrdDtlSeq != null && arrOrdDtlSeq.length > 0){
			List<ClaimSub> claimSubList = new ArrayList<>();

			for(int i=0; i<arrOrdDtlSeq.length; i++){
				ClaimSub claimSub = new ClaimSub();
				claimSub.setOrdDtlSeq(arrOrdDtlSeq[i]);

				if(arrClmQty != null){
					claimSub.setClmQty(arrClmQty[i]);
				}
				claimSubList.add(claimSub);
			}
			clmRegist.setClaimSubList(claimSubList);
		}

		/********************************
		 * 클레임 접수 호출
		 ********************************/
		String clmNo = this.claimAcceptService.acceptClaim(clmRegist);
		
		return View.jsonView();
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: ClaimController.java
	* - 작성일		: 2017. 3. 21.
	* - 작성자		: snw
	* - 설명			: 교환 접수 팝업
	* </pre>
	* @param model
	* @param orderDetailSO
	* @return
	*/
	@RequestMapping("/claim/claimExchangeAcceptPopView.do")
	public String claimExchangeAcceptPopView(Model model, OrderDetailSO orderDetailSO) {

		if(orderDetailSO.getArrOrdDtlSeq() == null){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}


		/************************
		 *  주문 정보
		 ************************/
		OrderBaseVO orderBase = this.orderBaseService.getOrderBase(orderDetailSO.getOrdNo());
		model.addAttribute( "orderBase", orderBase );


		/************************
		 *  교환상품 목록 정보
		 ************************/
		List<OrderDetailVO> listOrderDetail = orderDetailService.listOrderClaimDetail( orderDetailSO );
		model.addAttribute( "listOrderDetail", listOrderDetail );
		
		
		/************************
		 *  수거지, 교환배송지 정보
		 ************************/
		OrderDlvraSO odso = new OrderDlvraSO();
		odso.setOrdNo(orderDetailSO.getOrdNo());
		OrderDlvraVO orderDlvra =  this.orderDlvraService.getOrderDlvra(odso);
		model.addAttribute( "orderDlvra", orderDlvra);

		/***************************
		 * 코드 목록
		 ***************************/
		List<CodeDetailVO> clmRsnList = this.cacheService.listCodeCache(AdminConstants.CLM_RSN, AdminConstants.CLM_TP_30, null, null, null, null);
				
		model.addAttribute("clmRsnList", clmRsnList);
		
		return "/claim/claimExchangeAcceptPopView";

	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: ClaimController.java
	* - 작성일		: 2017. 5. 8.
	* - 작성자		: Administrator
	* - 설명			: 단품 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="/claim/itemListGrid.do", method=RequestMethod.POST )
	public GridResponse itemListGrid(ItemSO so) {

		so.setItemStatCd(CommonConstants.ITEM_STAT_10);
		List<ItemVO> list = itemService.listItem(so);

		return new GridResponse( list, so );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: ClaimController.java
	* - 작성일		: 2017. 7. 28.
	* - 작성자		: Administrator
	* - 설명			: 교환 환불 예정 금액 조회
	* </pre>
	* @param clmRegist
	* @param ordDtlSeqs
	* @param arrOrdDtlSeq
	* @param arrExcItemNo
	* @param arrExcQty
	* @return
	*/
	/**교환 배송비 계산 없음. 업체 귀책 교환*/
	@Deprecated
	@RequestMapping("/claim/claimExchangeExpt.do")
	public String claimExchangeExpt(ModelMap map, ClaimRegist clmRegist, Integer[] ordDtlSeqs, Integer[] arrOrdDtlSeq, Long[] arrExcItemNo, Integer[] arrExcQty) {
		Session session = AdminSessionUtil.getSession();

		/********************************
		 * 클레임 접수 데이터 생성
		 ********************************/
		clmRegist.setClmTpCd(AdminConstants.CLM_TP_30);
		clmRegist.setAcptrNo(session.getUsrNo());
		clmRegist.setOrdMdaCd(CommonConstants.ORD_MDA_10);

		Integer clmQty = 0;
		Integer excSize = 0;

		if(ordDtlSeqs != null && ordDtlSeqs.length > 0){
			List<ClaimSub> claimSubList = new ArrayList<>();

			for(int i=0; i<ordDtlSeqs.length; i++){
				clmQty = 0;
				StringBuilder arrOrdExcItemNoStr = new StringBuilder(1024);
				StringBuilder arrOrdExcQtyStr = new StringBuilder(1024);
				excSize = 0;

				ClaimSub claimSub = new ClaimSub();
				claimSub.setOrdDtlSeq(ordDtlSeqs[i]);

				for(int j=0; j <arrOrdDtlSeq.length; j++ ){
					if(ordDtlSeqs[i].equals(arrOrdDtlSeq[j])){
						clmQty += arrExcQty[j];
						excSize++;

						if(excSize == 1){
							arrOrdExcItemNoStr.append(arrExcItemNo[j]);
							arrOrdExcQtyStr.append(arrExcQty[j]);
						}else{
							arrOrdExcItemNoStr.append("^" + arrExcItemNo[j]);
							arrOrdExcQtyStr.append("^" + arrExcQty[j]);
						}

					}
				}

				String[] arrOrdExcItemNo =arrOrdExcItemNoStr.toString().split("\\^");
				String[] arrOrdExcQty = arrOrdExcQtyStr.toString().split("\\^");


				Long[] excItemNo = new Long[arrOrdExcItemNo.length];
				Integer[] excQty = new Integer[arrOrdExcQty.length];

				for(int k=0; k<arrOrdExcItemNo.length; k++){
					excItemNo[k] = Long.valueOf(arrOrdExcItemNo[k]);
					excQty[k] = Integer.valueOf(arrOrdExcQty[k]);
				}

				claimSub.setClmQty(clmQty);
				claimSub.setArrExcItemNo(excItemNo);
				claimSub.setArrExcQty(excQty);

				claimSubList.add(claimSub);
			}
			clmRegist.setClaimSubList(claimSubList);
		}


		/********************************
		 * 환불예상금액 조회
		 ********************************/
		ClaimRefundVO claimRefund = this.claimService.getClaimRefundExcpect(clmRegist, CommonConstants.CLM_TP_30);

		map.put("claimRefund", claimRefund);

		return View.jsonView();
	}
	
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: ClaimController.java
	* - 작성일		: 2017. 3. 21.
	* - 작성자		: snw
	* - 설명			: 교환 접수 처리
	* </pre>
	* @param clmRegist
	* @param arrOrdDtlSeq
	* @param clmRsnCd
	* @param arrClmQty
	* @return
	*/
	@RequestMapping("/claim/claimExchangeExc.do")
	public String claimExchangeExc(	ClaimRegist clmRegist, Integer[] arrOrdDtlSeq, Integer[] arrClmQty, String encloseYn, String refundAmt) {
		Session session = AdminSessionUtil.getSession();

		/********************************
		 * 클레임 접수 데이터 생성
		 ********************************/
		String orgClmRsnCd = clmRegist.getClmRsnCd();
		
		clmRegist.setClmTpCd(AdminConstants.CLM_TP_30);
		clmRegist.setAcptrNo(session.getUsrNo());
		clmRegist.setOrdMdaCd(CommonConstants.ORD_MDA_10);

		if(CommonConstants.COMM_YN_Y.equals(encloseYn)){
			clmRegist.setClmRsnCd(CommonConstants.CLM_RSN_370);
		}

		if(arrOrdDtlSeq != null && arrOrdDtlSeq.length > 0){
			List<ClaimSub> claimSubList = new ArrayList<>();

			for(int i=0; i<arrOrdDtlSeq.length; i++){
				ClaimSub claimSub = new ClaimSub();
				claimSub.setOrdDtlSeq(arrOrdDtlSeq[i]);

				if(arrClmQty != null){
					claimSub.setClmQty(arrClmQty[i]);
				}
				claimSubList.add(claimSub);
			}
			clmRegist.setClaimSubList(claimSubList);
		}

		/********************************
		 * 클레임 접수 호출
		 ********************************/
		String clmNo = this.claimAcceptService.acceptClaim(clmRegist);

		/********************************
		 * 배송비 동봉일 경우 주문메모에 이력 남기기
		 *********************************/
		if(CommonConstants.CLM_RSN_370.equals(clmRegist.getClmRsnCd())){
			OrderMemoPO ompo = new OrderMemoPO();
			ompo.setOrdNo(clmRegist.getOrdNo());
			
			String memoContent = "";
			
			String beforeRsnNm = this.cacheService.getCodeName(CommonConstants.CLM_RSN, orgClmRsnCd);
			memoContent += "클레임번호[" + clmNo +"]는 클레임사유가 "+beforeRsnNm+"로 인해 교환배송비("+StringUtil.formatNum(refundAmt)+")가 발생하였으나, 고객요청에 의해 교환배송비금액을 교환회수시 동봉처리하였습니다.";
			
			ompo.setMemoContent(memoContent);
			this.orderMemoService.insertOrderMemo(ompo);
		}
		
		return View.jsonView();
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: ClaimController.java
	* - 작성일		: 2017. 6. 7.
	* - 작성자		: Administrator
	* - 설명			: 클레임상세화면
	* </pre>
	* @param model
	* @param clmNo
	* @param viewGb
	* @param request
	* @return
	*/
	@RequestMapping(	value ="/*/claimDetailView.do")
	public String claimDetailView(Model model, String clmNo, String viewGb, HttpServletRequest request
		, @RequestParam(value="maskingUnlock",required = false)String maskingUnlock
		, @RequestParam(value="cnctHistNo",required = false)Long cnctHistNo
		) {

		if ( clmNo == null ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		StringBuilder execSqlBuilder = new StringBuilder();
		maskingUnlock = Optional.ofNullable(maskingUnlock).orElseGet(()->AdminConstants.COMM_YN_N);

		/**************************
		 * 클레임 기본 조회
		 ***************************/
		ClaimBaseVO claimBase = this.claimBaseService.getClaimBase(clmNo);

		if(claimBase == null){
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}

		if(StringUtil.equals(maskingUnlock,AdminConstants.COMM_YN_N)){
			claimBase.setOrdNm(MaskingUtil.getName(claimBase.getOrdNm()));
			claimBase.setOrdrId(MaskingUtil.getId(claimBase.getOrdrId()));
		}
		
		model.addAttribute("claimBase", claimBase);
		execSqlBuilder.append(claimBase.getExecSql());

		/**************************
		 * 클레임 상세 조회
		 ***************************/
		ClaimDetailSO cdso = new ClaimDetailSO();
		cdso.setClmNo(clmNo);
		List<ClaimDetailVO> claimDetailList = this.claimDetailService.listClaimDetail(cdso);
		
		if(CollectionUtils.isEmpty(claimDetailList)){
			throw new CustomException(ExceptionConstants.ERROR_CLAIM_NOT_EXISTS);
		}
		
		/*************************** 
		 * 클레임 상세 사유 
		 ***************************/
		model.addAttribute("clmRsnContent", claimDetailList.get(0).getClmRsnContent());
		
		/***************************
		 * 클레임 상세 사유 이미지 목록 조회 
		 ***************************/
		List<ClaimDetailVO> claimDetailImageList = this.claimDetailService.listClaimDetailImage(cdso);
		
		model.addAttribute("claimDetailImageList", claimDetailImageList);
		
		/***************************
		 * 클레임 접수 취소 버튼 
		 ***************************/
		boolean cancelBtn = this.claimService.cancelClaimPossible(claimBase, claimDetailList);
		
		model.addAttribute("cancelBtn", cancelBtn);
		
		/***************************
		 * 반품 - 입금 정보 조회
		 ***************************/
		if(CommonConstants.CLM_TP_20.equals(claimBase.getClmTpCd())) {
			PayBaseSO paySO = new PayBaseSO();
			paySO.setOrdClmGbCd(CommonConstants.ORD_CLM_GB_20);
			paySO.setPayGbCd(CommonConstants.PAY_GB_30);
			paySO.setPayMeansCd(CommonConstants.PAY_MEANS_30);
			paySO.setClmNo(clmNo);
			PayBaseVO payVO = payBaseService.getPayBase(paySO);

			if(StringUtil.equals(maskingUnlock,AdminConstants.COMM_YN_N) && payVO != null){
				String acctNo = Optional.ofNullable(payVO.getAcctNo()).orElseGet(()->"");
				if(StringUtil.isNotEmpty(acctNo)){
					payVO.setAcctNo(MaskingUtil.getBankNo(acctNo));
				}

				String ooaNm = Optional.ofNullable(payVO.getOoaNm()).orElseGet(()->"");
				if(StringUtil.isNotEmpty(ooaNm)){
					payVO.setOoaNm(MaskingUtil.getName(ooaNm));
				}
			}
			
			model.addAttribute( "depositInfo", payVO);
		}
		
		/************************
		 *  주문 메모
		 ***********************/
		OrderMemoSO omso = new OrderMemoSO();
		omso.setOrdNo(claimBase.getOrdNo());
		List<OrderMemoVO> orderMemoList = this.orderMemoService.listOrderMemo(omso);
		model.addAttribute("orderMemoList", orderMemoList);

		// URI
		model.addAttribute( "getHeader", request.getHeader("REFERER") );

		// LayOut 설정
		String layOut = AdminConstants.LAYOUT_DEFAULT;

		if(AdminConstants.VIEW_GB_POP.equals(viewGb)){
			layOut = AdminConstants.LAYOUT_POP;
		}
		model.addAttribute("layout", layOut);
		
		/****************************
		 * 세션 정보
		 ****************************/
		Session session = AdminSessionUtil.getSession();
		model.addAttribute("session", session);
		model.addAttribute("maskingUnlock",maskingUnlock);
		model.addAttribute("cnctHistNo",Optional.ofNullable(cnctHistNo).orElseGet(()->0L));
		model.addAttribute("execSql", StringEscapeUtils.escapeEcmaScript(execSqlBuilder.toString()));
		
		return "/claim/claimDetailView";
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: ClaimController.java
	* - 작성일		: 2017. 6. 27.
	* - 작성자		: Administrator
	* - 설명			: 클레임 접수 취소
	* </pre>
	* @param clmRegist
	* @param ordDtlSeqs
	* @param arrOrdDtlSeq
	* @param arrExcItemNo
	* @param arrExcQty
	* @return
	*/
	@RequestMapping("/claim/claimAcceptCancel.do")
	public String claimAcceptCancel(String clmNo) {

		Session session = AdminSessionUtil.getSession();

		/********************************
		 * 클레임 접수 취소 호출
		 ********************************/
		this.claimService.cancelClaim(clmNo, session.getUsrNo());

		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명		: gs-apet-11-business
	 * - 메서드명		: claimReactPgCancel
	 * - 작성일		: 2021. 05. 12.
	 * - 작성자		: sorce
	 * - 설명			: PG 재환불
	 * </pre>
	 * @param clmNo
	 * @return
	 */
	@RequestMapping("/claim/claimReactPgCancel.do")
	public String claimReactPgCancel(	String clmNo) {

		Session session = AdminSessionUtil.getSession();

		/********************************
		 * 클레임 접수 취소 호출
		 ********************************/
		this.claimService.claimReactPgCancel(clmNo, session.getUsrNo());

		return View.jsonView();
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: ClaimController.java
	* - 작성일		: 2017. 6. 7.
	* - 작성자		: Administrator
	* - 설명		 	: 결제 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="/claim/payBaseListGrid.do", method=RequestMethod.POST )
	public GridResponse payBaseListGrid(PayBaseSO so,String maskingUnlock) {

		so.setOrdClmGbCd(AdminConstants.ORD_CLM_GB_20);
		so.setOrder("payNo");
		List<PayBaseVO> list = this.payBaseService.listPayBase(so);

		for(PayBaseVO vo : list){
			if(StringUtil.equals(maskingUnlock,AdminConstants.COMM_YN_N)){
				vo.setAcctNo(MaskingUtil.getBankNo(vo.getAcctNo()));
			}
			if(CommonConstants.PAY_GB_30.equals(vo.getPayGbCd()) || CommonConstants.PAY_GB_40.equals(vo.getPayGbCd())) {	// 마이너스 환불 구분
				vo.setPayAmt02(vo.getPayAmt());
			}else {
				vo.setPayAmt01(vo.getPayAmt());
			}
		}
		return new GridResponse( list, so );

	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: ClaimController.java
	* - 작성일		: 2017. 6. 7.
	* - 작성자		: Administrator
	* - 설명			: 클레임 상세 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="/claim/claimDetailListGrid.do", method=RequestMethod.POST )
	public GridResponse claimDetailListGrid(ClaimDetailSO so) {

		Session session = AdminSessionUtil.getSession();

		if(CommonConstants.USR_GRP_20.equals(session.getUsrGrpCd())){
			
			if(CommonConstants.USR_GB_2010.equals(session.getUsrGbCd())){
				so.setUpCompNo(session.getCompNo());
			}else{
				so.setCompNo(session.getCompNo());
			}
		}

		so.setClmChainReprsntYn("Y"); //클레임 대표인것만 노출시킨다 - 2021.06.08 by kek01
		List<ClaimDetailVO> list = this.claimDetailService.listClaimDetail(so);
		return new GridResponse( list, so );
	}
	

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: ClaimController.java
	* - 작성일		: 2017. 6. 8.
	* - 작성자		: Administrator
	* - 설명			: 배송지 정보 조회
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="/claim/deliveryAddressListGrid.do", method=RequestMethod.POST )
	public GridResponse deliveryAddressListGrid(OrderDlvraSO so,String maskingUnlock) {

		List<OrderDlvraVO> dlvraList =  this.orderDlvraService.listOrderDlvra(so);
		if(StringUtil.equals(maskingUnlock,AdminConstants.COMM_YN_N)){
			for(OrderDlvraVO vo : dlvraList){
				vo.setAdrsNm(MaskingUtil.getName(vo.getAdrsNm()));
				vo.setTel(MaskingUtil.getTelNo(vo.getTel()));
				vo.setMobile(MaskingUtil.getTelNo(vo.getMobile()));
				vo.setFullPrclAddr(MaskingUtil.getAddress(vo.getPrclAddr(),vo.getPrclDtlAddr()));
				vo.setFullRoadAddr(MaskingUtil.getAddress(vo.getRoadAddr(),vo.getRoadDtlAddr()));

				vo.setRoadAddr(MaskingUtil.getAddress(vo.getRoadAddr(), vo.getRoadDtlAddr()));
				vo.setRoadDtlAddr(MaskingUtil.getMaskedAll(vo.getRoadDtlAddr()));

				vo.setPrclAddr(MaskingUtil.getAddress(vo.getPrclAddr(), vo.getPrclDtlAddr()));
				vo.setPrclDtlAddr(MaskingUtil.getMaskedAll(vo.getPrclDtlAddr()));
			}
		}
		return new GridResponse( dlvraList, so );

	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: ClaimController.java
	* - 작성일		: 2017. 6. 8.
	* - 작성자		: Administrator
	* - 설명			: 배송비 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="/claim/deliveryChargeListGrid.do", method=RequestMethod.POST )
	public GridResponse deliveryChargeListGrid(DeliveryChargeSO so) {

		Session session = AdminSessionUtil.getSession();

		if(CommonConstants.USR_GRP_20.equals(session.getUsrGrpCd())){
			
			if(CommonConstants.USR_GB_2010.equals(session.getUsrGbCd())){
				so.setUpCompNo(session.getCompNo());
			}else{
				so.setCompNo(session.getCompNo());
			}
		}
		
		so.setSearchType("CLAIM_ADMIN"); // 20.06.29 클레임 상세 해당 클레임만 조회로 변경
		List<DeliveryChargeVO> deliveryChargeList = this.deliveryChargeService.listDeliveryCharge(so);

		return new GridResponse( deliveryChargeList, so );

	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ClaimController.java
	 * - 작성일		: 2021. 03. 04.
	 * - 작성자		: valueFactory
	 * - 설명		: 첨부 이미지 레이어
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/claim/claimDetailImageLayerView.do")
	public String claimDetailImageLayerView(Model model,ClaimDetailSO so){
		model.addAttribute("imgPath", so.getRsnImgPath());
		return "/claim/claimDetailImageLayerView";
	}
	
//////////////////////////////////////////////////////////////////////////////////////////////









	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ClaimController.java
	 * - 작성일		:
	 * - 작성자		:
	 * - 설명		: CS 관리 - CS접수 처리완료
	 * </pre>
	 * @param orderSO
	 * @param counselPO
	 * @param br
	 * @return
	 */
	@Deprecated
	@RequestMapping("/claim/counselComplete.do")
	public String counselComplete(OrderSO orderSO, CounselPO counselPO, BindingResult br) {

		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		long time = System.currentTimeMillis();

		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String now = dayTime.format(new Date(time));

		String user = AdminSessionUtil.getSession().getUsrNm();

		claimService.counselComplete(orderSO, counselPO);

		CounselProcessPO po = new CounselProcessPO();

		po.setRplContent(counselPO.getContent());
		po.setPrcsContent("[작성자 : " + user + "]   [작성시간 : " + now + "]");
		po.setCusPrcsrNo(AdminSessionUtil.getSession().getUsrNo());
		po.setCusNo(counselPO.getCusNo());

//		counselProcessService.saveCounselProcessCc(po);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ClaimController.java
	 * - 작성일		: 2016. 5. 23.
	 * - 작성자		: dyyoun
	 * - 설명		: 클레임 전체(취소/교환/반품/AS) 리스트
	 * </pre>
	 * @param orderSO
	 * @param br
	 * @return
	 */
	@RequestMapping("/claim/claimAllListView.do")
	public String claimAllListView(
		OrderSO orderSO
		, BindingResult br
	) {

		if ( br.hasErrors() ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		// 화면 구분
		orderSO.setViewGb( "CLAIM_ALL" );

		return "/claim/claimReturnListView";

	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ClaimController.java
	 * - 작성일		: 2016. 5. 23.
	 * - 작성자		: dyyoun
	 * - 설명		: 클레임 전체(취소/교환/반품/AS) 리스트 grid
	 * </pre>
	 * @param orderSO
	 * @return
	 */
	@ResponseBody
	@RequestMapping( value="/claim/claimAllListGrid.do", method=RequestMethod.POST )
	public GridResponse claimAllListGrid(
			ClaimSO so
	) {

		List<ClaimListVO> list = claimService.pageClaim( so );

		return new GridResponse( list, so );
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ClaimController.java
	 * - 작성일		: 2021. 3. 09.
	 * - 작성자		: pse
	 * - 설명		: 클레임 상세 간략 정보
	 * </pre>
	 * @param ClmDtlCstrtPO
	 * @return
	 */
	@RequestMapping("/claim/claimDetailCstrtPopView.do")
	public String claimDetailCstrtPopView(ModelMap map, ClaimDetailSO so) {
		ClaimDetailVO claimDetail = claimDetailService.getClaimDetail(so);
		map.put("claimDetail", claimDetail);
		return "/claim/claimDetailCstrtPopView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ClaimController.java
	 * - 작성일		: 2021. 3. 09.
	 * - 작성자		: pse
	 * - 설명		: 클레임 상세 구성 그리드
	 * </pre>
	 * @param po
	 * @return
	 */
	@ResponseBody
	@RequestMapping( value="/claim/listClmDtlCstrt.do", method=RequestMethod.POST )
	public GridResponse orderDetailCstrtListGrid(ClaimDetailSO so) {

		List<ClmDtlCstrtPO> list = claimDetailService.listClmDtlCstrt(so);
		return new GridResponse( list, so );
	}
}

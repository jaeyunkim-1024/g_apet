package front.web.view.mypage.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.app.claim.model.ClaimDetailPO;
import biz.app.claim.model.ClaimRegist;
import biz.app.claim.model.ClaimRegist.ClaimSub;
import biz.app.claim.service.ClaimAcceptService;
import biz.app.claim.service.ClaimService;
import biz.app.counsel.service.CounselService;
import biz.app.order.service.OrderService;
import biz.app.system.service.CodeService;
import framework.common.annotation.LoginCheck;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명	: front.web.view.mypage.controller
* - 파일명		: MyClaimController.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 마이페이지 Controller
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("mypage")
public class MyClaimController {

	@Autowired
	private ClaimService claimService;

	@Autowired
	private CounselService csService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private MessageSourceAccessor messageSourceAccessor;
	
	@Autowired
	private ClaimAcceptService claimAcceptService;


	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: MyClaimController.java
	 * - 작성일		: 2016. 7. 18.
	 * - 작성자		: yhkim
	 * - 설명		: 교환/반품/AS 접수 실행
	 * </pre>
	 * @param orderSO
	 * @param br
	 * @return
	 */
	@LoginCheck
	@ResponseBody
	@RequestMapping(value="claimAcceptReturnExchange", method=RequestMethod.POST)
	public ModelMap claimAcceptReturnExchange(Session session, ClaimRegist clmRegist) {
		clmRegist.setAcptrNo(session.getMbrNo());
		clmRegist.setOrdMdaCd(CommonConstants.ORD_MDA_10);
		String clmNo = this.claimAcceptService.acceptClaim(clmRegist);

		ModelMap map = new ModelMap();
		map.put("clmNo",clmNo);

		return map;
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: MyClaimController.java
	 * - 작성일		: 2016. 6. 8.
	 * - 작성자		: yhkim
	 * - 설명		: 교환/반품/주문취소 접수 실행
	 * </pre>
	 * @param orderSO
	 * @param payCashRefundPO
	 * @param br
	 * @return
	 */
	//@LoginCheck
	@ResponseBody
	@RequestMapping(value="insertClaimCancelExchangeRefund", method=RequestMethod.POST)
	public ModelMap insertClaimCancelExchangeRefund(Session session, ClaimRegist clmRegist, Integer[] arrOrdDtlSeq, Integer[] arrClmQty, Long itemNo) {
		clmRegist.setAcptrNo(session.getMbrNo());		
		clmRegist.setOrdMdaCd(CommonConstants.ORD_MDA_10);

		if(arrOrdDtlSeq != null && arrOrdDtlSeq.length > 0){
			List<ClaimSub> claimSubList = new ArrayList<>();

			for(int i=0; i<arrOrdDtlSeq.length; i++){
				ClaimSub claimSub = new ClaimSub();
				claimSub.setOrdDtlSeq(arrOrdDtlSeq[i]);

				if(!ArrayUtils.isEmpty(arrClmQty)) {
					claimSub.setClmQty(arrClmQty[i]);
				}
				
				if (itemNo != null) {
					claimSub.setArrExcItemNo(new Long[] {itemNo});
					claimSub.setArrExcQty(new Integer[] {ObjectUtils.isEmpty(arrClmQty[i]) ? 0 : arrClmQty[i]});
				}
				
				if(claimSub.getClmQty() == null || claimSub.getClmQty() > 0){
					claimSubList.add(claimSub);
				}
				
				
			}
			clmRegist.setClaimSubList(claimSubList);
		}

		String clmNo = this.claimAcceptService.acceptClaim(clmRegist);
		
		ModelMap map = new ModelMap();
		map.put("clmNo",clmNo);
		return map;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: MyClaimController.java
	 * - 작성일		: 2016. 6. 15.
	 * - 작성자		: yhkim
	 * - 설명		: 주문 전체 취소
	 * </pre>
	 * @param orderSO
	 * @param payCashRefundPO
	 * @param br
	 * @return
	 */
	@LoginCheck
	@ResponseBody
	@RequestMapping(value="claimAllCancelAccept", method=RequestMethod.POST)
	public ModelMap claimAllCancelAccept(Session session, ClaimRegist clmRegist) {

		clmRegist.setAcptrNo(session.getMbrNo());
		clmRegist.setOrdMdaCd(CommonConstants.ORD_MDA_10);

		String clmNo = this.claimAcceptService.acceptClaim(clmRegist);

		ModelMap map = new ModelMap();
		map.put("clmNo",clmNo);

		return map;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: MyClaimController.java
	 * - 작성일		: 2016. 6. 15.
	 * - 작성자		: yhkim
	 * - 설명		: 교환/반품 신청 취소(회원)
	 * </pre>
	 * @param orderSO
	 * @param payCashRefundPO
	 * @param br
	 * @return
	 */
	@LoginCheck
	@ResponseBody
	@RequestMapping(value="refundExchangeCancelRequest", method=RequestMethod.POST)
	public ModelMap refundExchangeCancelRequest(Session session, String clmNo) {

		log.debug("clmNo>>"+clmNo);
		this.commonRefundExchangeCancelRequest(clmNo, session.getMbrNo());

		return new ModelMap();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: MyClaimController.java
	 * - 작성일		: 2016. 6. 15.
	 * - 작성자		: yhkim
	 * - 설명		: 교환/반품 신청 취소(비회원)
	 * </pre>
	 * @param orderSO
	 * @param payCashRefundPO
	 * @param br
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="noMemberRefundExchangeCancelRequest", method=RequestMethod.POST)
	public ModelMap noMemberRefundExchangeCancelRequest( String clmNo, Session session) {
//		String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, session.getNoMemOrderInfo().getOrdNo());
//
//		if(!newCheckCode.equals(session.getNoMemOrderInfo().getCheckCode())){
//			throw new CustomException(ExceptionConstants.ERROR_PARAM);
//		}

		this.commonRefundExchangeCancelRequest(clmNo, session.getMbrNo());

		return new ModelMap();
	}

	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyClaimController.java
	* - 작성일		: 2016. 8. 10.
	* - 작성자		: snw
	* - 설명		: 교환/반품 신청 취소
	* </pre>
	* @param clmTpCd
	* @param clmNo
	* @param clmDtlSeq
	* @param ordNo
	* @param ordDtlSeq
	*/
	private void commonRefundExchangeCancelRequest(String clmNo, Long cncrNo){

		claimService.cancelClaim(clmNo, cncrNo);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: MyClaimController.java
	 * - 작성일		: 2016. 6. 8.
	 * - 작성자		: yhkim
	 * - 설명		: 교환/반품/AS/주문취소 접수 실행
	 * </pre>
	 * @param orderSO
	 * @param payCashRefundPO
	 * @param br
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="noMemberInsertClaimCancelExchangeRefund", method=RequestMethod.POST)
	public ModelMap noMemberInsertClaimCancelExchangeRefund(Session session, ClaimRegist clmRegist, Integer[] arrOrdDtlSeq, Integer[] arrClmQty, Long itemNo) {
//		String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, clmRegist.getOrdNo());
//		System.out.println("newCheckCode :::::::::::: " +newCheckCode);
//		System.out.println("checkCode :::::::::::: " +session.getNoMemOrderInfo().getCheckCode());
//
//		if(!newCheckCode.equals(session.getNoMemOrderInfo().getCheckCode())){
//			throw new CustomException(ExceptionConstants.ERROR_PARAM);
//		}

		return insertClaimCancelExchangeRefund(session, clmRegist, arrOrdDtlSeq, arrClmQty, itemNo);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 31.front.web
	 * - 파일명		: MyClaimController.java
	 * - 작성일		: 2016. 6. 15.
	 * - 작성자		: yhkim
	 * - 설명		: 주문 전체 취소
	 * </pre>
	 * @param orderSO
	 * @param payCashRefundPO
	 * @param br
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="noMemberClaimAllCancelAccept", method=RequestMethod.POST)
	public ModelMap noMemberClaimAllCancelAccept( Session session, ClaimRegist clmRegist, String checkCode) {
		String newCheckCode = FrontSessionUtil.makeNoMemOrderCheckCode(session, clmRegist.getOrdNo());

		if(!newCheckCode.equals(checkCode)){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}

		clmRegist.setAcptrNo(session.getMbrNo());
		clmRegist.setOrdMdaCd(CommonConstants.ORD_MDA_10);

		String clmNo = this.claimAcceptService.acceptClaim(clmRegist);

		ModelMap map = new ModelMap();
		map.put("clmNo",clmNo);

		return map;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-31-front
	 * - 파일명		: GoodsController.java
	 * - 작성일		: 2021. 5. 6.
	 * - 작성자		: 
	 * - 설명		: 클레임 사유 이미지 등록
	 * </pre>
	 * @param view
	 * @param session
	 * @param clmRegist
	 * @return
	 */
	@LoginCheck
	@RequestMapping(value="appClaimImageSave")
	@ResponseBody
	public ModelMap appClaimImageSave(ViewBase view, Session session, ClaimRegist clmRegist) {
		ModelMap map = new ModelMap(); 

		// clmRegist.setSysRegrNo(session.getMbrNo());
		
		ClaimDetailPO po = new ClaimDetailPO();
		po.setClmNo(clmRegist.getClmNo());
		po.setSysRegrNo(session.getMbrNo());
		
		claimService.saveAllImgClaimDetail(po, clmRegist.getImgPaths());
		
		map.put("clmNo", clmRegist.getClmNo());
		map.put("view", view);
		return map;
	}

}
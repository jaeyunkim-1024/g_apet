package admin.web.view.claim.controller;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.claim.model.*;
import biz.app.claim.service.ClaimBaseService;
import biz.app.claim.service.ClaimDetailService;
import biz.app.claim.service.ClaimService;
import biz.app.order.model.OrderSO;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.ExcelViewParam;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.stream.Collectors;

/**
* <pre>
* - 프로젝트명	: 41.admin.web
* - 패키지명		: admin.web.view.claim.controller
* - 파일명		: ClaimExchangeController.java
* - 작성일		: 2017. 5. 10.
* - 작성자		: Administrator
* - 설명			: 클레임 교환 관련 Controller
* </pre>
*/
@Slf4j
@Controller
public class ClaimExchangeController {

	@Autowired	private ClaimService claimService;

	@Autowired	private ClaimBaseService claimBaseService;

	@Autowired	private ClaimDetailService claimDetailService;

	@Autowired	private MessageSourceAccessor messageSourceAccessor;
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ClaimExchangeController.java
	 * - 작성일		: 2017. 3. 21.
	 * - 작성자		: valuefactory 권성중
	 * - 설명			: 교환 리스트 화면
	 * </pre>
	 * @param orderSO
	 * @param br
	 * @return
	 */
	@RequestMapping("/claim/claimExchangeListView.do")
	public String claimExchangeListView(Model model, OrderSO orderSO, BindingResult br) {

		if ( br.hasErrors() ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		// 화면 구분
		orderSO.setViewGb( "EXCHANGE" );
		
		Session session = AdminSessionUtil.getSession();
		model.addAttribute("session", session);

		return "/claim/claimExchangeListView";

	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ClaimExchangeController.java
	 * - 작성일		: 2017. 3. 21.
	 * - 작성자		: valuefactory 권성중
	 * - 설명			: 클레임(교환) 리스트 그리드
	 * </pre>
	 * @param orderSO
	 * @return
	 */
	@ResponseBody
	@RequestMapping( value="/claim/claimExchangeListGrid.do", method=RequestMethod.POST )
	public GridResponse claimExchangeListGrid( ClaimSO claimSO ) {

		claimSO.setClmTpCd(CommonConstants.CLM_TP_30);
		List<ClaimListVO> list = claimService.pageClaim( claimSO );

		return new GridResponse( list, claimSO );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ClaimExchangeController.java
	 * - 작성일		: 2017. 3. 21.
	 * - 작성자		: valuefactory 권성중
	 * - 설명			: 교환 목록(엑셀 다운로드)
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/claim/claimExchangeListExcelDownload.do")
	public String claimExchangeListExcelDownload(ModelMap model, ClaimSO claimSO
			,@RequestParam(value="clmNos",required=false)String clmNos
	){
		// 화면 구분
		claimSO.setClmTpCd(CommonConstants.CLM_TP_30);
		claimSO.setRows(999999999);
		List<ClaimListVO> list = claimService.getClaimExcelList( claimSO );

		//선택 된 로우
		if(StringUtil.isNotEmpty(clmNos)){
			list = list.stream().filter(
					v-> clmNos.indexOf(v.getClmNo()+v.getClmDtlSeq())>-1
			).collect(Collectors.toList());
		}

		String[] headerName = {
				// 클래임번호
				  messageSourceAccessor.getMessage("column.clm_no")
				// 사이트명
				, messageSourceAccessor.getMessage("column.st_nm")
				// 주문 번호
				, messageSourceAccessor.getMessage("column.ord_no")
				// 회원번호
				, messageSourceAccessor.getMessage("column.user_no")
				// 주문자 이름
				, messageSourceAccessor.getMessage("column.ord_nm")
				// 회원 아이디
				, messageSourceAccessor.getMessage("column.login_id")
				// 클레임 유형 코드
				, messageSourceAccessor.getMessage("column.clm_tp_cd")
				// 클레임 상태 코드
				, messageSourceAccessor.getMessage("column.clm_stat_cd")
				// 클레임 접수 일시
				, messageSourceAccessor.getMessage("column.clm_acpt_dtm")
				// 클레임 완료 일시
				, messageSourceAccessor.getMessage("column.clm_cplt_dtm")
				// 클레임 취소 일시
				, messageSourceAccessor.getMessage("column.clm_cnc_dtm")
				// 클레임 상세 순번
				, messageSourceAccessor.getMessage("column.clm_dtl_seq")
				// 클레임 유형 코드
				, messageSourceAccessor.getMessage("column.clm_dtl_tp_cd")
				// 클레임 상세 상태 코드
				, messageSourceAccessor.getMessage("column.clm_dtl_stat_cd")
				// 클레임 사유 코드
				, messageSourceAccessor.getMessage("column.clm_rsn_cd")
				// 클레임 상세 사유
				, messageSourceAccessor.getMessage("column.clm_rsn_content")
				// 공급사 구분
				, messageSourceAccessor.getMessage("column.comp_tp_nm")
				// 매입 업체명
				, messageSourceAccessor.getMessage("column.goods.phsCompNo")
				// 상품 구성 유형
				, messageSourceAccessor.getMessage("column.goods.cstrt.tp.cd")
				// 상품아이디
				, messageSourceAccessor.getMessage("column.goods_id")
				// 상품명
				, messageSourceAccessor.getMessage("column.goods_nm")
				/* ( 단품 기능 없어 삭제(v0.6 )
				// 단품번호 
				, messageSourceAccessor.getMessage("column.item_no")
				// 단품명 
				, messageSourceAccessor.getMessage("column.item_nm")
				*/
				// 사은품 정보
				, messageSourceAccessor.getMessage("column.frb_goods_info")
				// 클레임 수량
				, messageSourceAccessor.getMessage("column.clm_qty")

		};
		String[] fieldName = {
				// 클래임번호
				  "clmNo"
				// 사이트명
				, "stNm"
				// 주문 번호
				, "ordNo"
				//회원번호
				, "mbrNo"
				//주문자 이름
				, "ordNm"
				//회원 아이디
				, "ordrId"
				// 클레임 유형 코드
				, "clmTpCd"
				// 클레임 상태 코드
				, "clmStatCd"
				// 클레임 접수 일시
				, "acptDtm"
				// 클레임 완료 일시
				, "cpltDtm"
				// 클레임 취소 일시
				, "cncDtm"
				// 클레임 상세 순번
				, "clmDtlSeq"
				// 클레임 유형 코드
				, "clmDtlTpCd"
				// 클레임 상세 상태 코드
				, "clmDtlStatCd"
				// 클레임 사유 코드
				, "clmRsnNm"
				//클레임 상세 사유
				,"clmRsnContent"
				//공급사 구분
				,"compTpNm"
				//매입업체명
				,"phsCompNm"
				//상품 구성 유형
				,"goodsCstrtTpNm"		
				// 상품아이디
				, "goodsId"
				// 상품명
				, "goodsNm"
				/* ( 단품 기능 없어 삭제(v0.6 )
				// 단품번호
				, "itemNo"
				// 단품명
				, "itemNm"
				*/
				//사은품 정보
				,"subGoodsNm"
				// 클레임 수량
				, "clmQty"
		};
		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("exchange", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "exchange");

		return View.excelDownload();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ClaimExchangeController.java
	 * - 작성일		: 2017. 3. 21.
	 * - 작성자		: valuefactory 권성중
	 * - 설명			: 교환 접수 취소 실행
	 * </pre>
	 * @param orderSO
	 * @param br
	 * @return
	 */
	@RequestMapping("/claim/claimExchangeCancelExec.do")
	public String claimExchangeCancelExec(String clmNo) {

		Session session = AdminSessionUtil.getSession();

		claimService.cancelClaim(clmNo, session.getUsrNo());

		return View.jsonView();
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: ClaimExchangeController.java
	* - 작성일		: 2017. 4. 7.
	* - 작성자		: snw
	* - 설명			: 교환 거부 팝업
	* </pre>
	* @param model
	* @param orderDetailSO
	* @return
	*/
	@RequestMapping("/claim/claimExchangeRefusePopView.do")
	public String claimExchangeRefusePopView(Model model, ClaimDetailSO claimDetailSO) {

		if(claimDetailSO.getArrClmDtlSeq() == null){
			throw new CustomException(ExceptionConstants.ERROR_PARAM);
		}

		/************************
		 *  클레임 기본 정보
		 ************************/
		ClaimBaseVO claimBase = this.claimBaseService.getClaimBase(claimDetailSO.getClmNo());
		model.addAttribute( "claimBase", claimBase );

		/************************
		 *  클레임 상품 목록 정보
		 ************************/
		List<ClaimDetailVO> listClaimDetail = claimDetailService.listClaimDetail(claimDetailSO);
		model.addAttribute( "listClaimDetail", listClaimDetail );


		return "/claim/claimExchangeRefusePopView";

	}
	
	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   	: admin.web.view.claim.controller
	* - 파일명      	: ClaimExchangeController.java
	* - 작성일      	: 2017. 3. 23.
	* - 작성자      	: valuefactory 권성중
	* - 설명     	 	: 교환 거부 완료
	* </pre>
	 */
	@RequestMapping("/claim/claimExchangeProductRejectionFinal.do")
	public String claimExchangeProductRejectionFinal( String clmNo , Integer[] arrClmDtlSeq, Integer[] arrRefuseQty, String clmDenyRsnContent, String clmChainYn , String ordNo, int ordDtlSeq) {
		Session session = AdminSessionUtil.getSession();
		if(CommonConstants.COMM_YN_Y.equals(clmChainYn)) {
			ClaimDetailSO so = new ClaimDetailSO();
			so.setClmNo(clmNo);
			so.setOrdNo(ordNo);
			so.setOrdDtlSeq(ordDtlSeq);
			so.setClmDtlTpCd(CommonConstants.CLM_DTL_TP_30);
			List<ClaimDetailVO> clist = claimDetailService.listClaimDetail(so);
			for (ClaimDetailVO cvo : clist) {
				try {
					Integer[] tmpClmDtlSeq = new Integer[1];
					tmpClmDtlSeq[0] = cvo.getClmDtlSeq();
					if (CommonConstants.CLM_DTL_STAT_340.equals(cvo.getClmDtlStatCd())) {
						claimService.completeClaimExchangeRefuse(clmNo, tmpClmDtlSeq, arrRefuseQty, clmDenyRsnContent, session.getUsrNo());
					}
				}catch (CustomException ce) {
					log.error("### claimProductRecoveryFinalExec exception ["+clmNo+","+ordNo+","+ordDtlSeq+"]");
					throw ce;
				}
			}
		}else {
			claimService.completeClaimExchangeRefuse(clmNo, arrClmDtlSeq, arrRefuseQty, clmDenyRsnContent, session.getUsrNo());
		}
		return View.jsonView();
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   	: admin.web.view.claim.controller
	* - 파일명      	: ClaimExchangeController.java
	* - 작성일      	: 2017. 3. 23.
	* - 작성자      	: valuefactory 권성중
	* - 설명     		:  교환 승인완료
	* </pre>
	 */
	@RequestMapping("/claim/claimExchangeProductApprove.do")
	public String claimExchangeProductApprove( String clmNo , Integer clmDtlSeq , String clmChainYn, String ordNo, int ordDtlSeq) {
		Session session = AdminSessionUtil.getSession();
		Long usrNo = session.getUsrNo() ;
		if(CommonConstants.COMM_YN_Y.equals(clmChainYn)) {
			ClaimDetailSO so = new ClaimDetailSO();
			so.setClmNo(clmNo);
			so.setOrdNo(ordNo);
			so.setOrdDtlSeq(ordDtlSeq);
			so.setClmDtlTpCd(CommonConstants.CLM_DTL_TP_30);
			List<ClaimDetailVO> clist = claimDetailService.listClaimDetail(so);
			for (ClaimDetailVO cvo : clist) {
				try {
					if (CommonConstants.CLM_DTL_STAT_340.equals(cvo.getClmDtlStatCd())) {
						claimService.completeClaimExchangeConfirm( cvo.getClmNo() , cvo.getClmDtlSeq() , usrNo);
					}
				}catch (CustomException ce) {
					log.error("### claimExchangeProductApprove exception ["+clmNo+","+ordNo+","+ordDtlSeq+"]");
					throw ce;
				}
			}
		}else {
			claimService.completeClaimExchangeConfirm(clmNo, clmDtlSeq, usrNo);
		}
		return View.jsonView();
	}

		

	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   	: admin.web.view.claim.controller
	* - 파일명      	: ClaimExchangeController.java
	* - 작성일      	: 2017. 3. 21.
	* - 작성자      	: valuefactory 권성중
	* - 설명      		: 홈 > 주문 관리 > 클레임 관리 > 반품목록   반품회수완료
	*                    홈 > 주문 관리 > 클레임 관리 > 교환목록  교환회수완료
	* </pre>
	 */
	@RequestMapping("/claim/claimProductRecoveryFinalExec.do")
	public String claimProductRecoveryFinalExec( String clmNo , Integer clmDtlSeq , String clmChainYn, String ordNo, int ordDtlSeq) {

		if(CommonConstants.COMM_YN_Y.equals(clmChainYn)) {
			ClaimDetailSO so = new ClaimDetailSO();
			so.setClmNo(clmNo);
			so.setOrdNo(ordNo);
			so.setOrdDtlSeq(ordDtlSeq);
			List<ClaimDetailVO> clist = claimDetailService.listClaimDetail(so);
			for (ClaimDetailVO cvo : clist) {
				try {
					if (CommonConstants.CLM_DTL_STAT_220.equals(cvo.getClmDtlStatCd()) || CommonConstants.CLM_DTL_STAT_230.equals(cvo.getClmDtlStatCd()) ||
						CommonConstants.CLM_DTL_STAT_320.equals(cvo.getClmDtlStatCd()) || CommonConstants.CLM_DTL_STAT_330.equals(cvo.getClmDtlStatCd())) {
						claimService.claimProductRecoveryFinalExec( cvo.getClmNo() , cvo.getClmDtlSeq() );
					}
				}catch (CustomException ce) {
					log.error("### claimProductRecoveryFinalExec exception ["+clmNo+","+ordNo+","+ordDtlSeq+"]");
					throw ce;
				}
			}
		}else {
			claimService.claimProductRecoveryFinalExec( clmNo , clmDtlSeq );
		}
		return View.jsonView();
	}
	
}

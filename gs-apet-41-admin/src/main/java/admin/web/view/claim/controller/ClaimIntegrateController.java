package admin.web.view.claim.controller;

import java.util.List;
import java.util.stream.Collectors;

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

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.claim.model.ClaimListVO;
import biz.app.claim.model.ClaimSO;
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

@Slf4j
@Controller
public class ClaimIntegrateController {
	
	@Autowired private ClaimService claimService;
	
	@Autowired	private MessageSourceAccessor messageSourceAccessor;
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ClaimIntegrateController.java
	 * - 작성일		: 2021. 8. 09.
	 * - 작성자		: lts
	 * - 설명		: 클레임 통합 조회 화면
	 * </pre>
	 * @param orderSO
	 * @param br
	 * @return
	 */
	@RequestMapping("/claim/claimIntegrateListView.do")
	public String claimIntegrateListView(Model model, OrderSO orderSO, BindingResult br) {

		if ( br.hasErrors() ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		// 화면 구분
		orderSO.setViewGb("INTEGRATE");
		
		Session session = AdminSessionUtil.getSession();
		model.addAttribute("session", session);

		return "/claim/claimIntegrateListView";
	}
	
	@ResponseBody
	@RequestMapping(value="/claim/claimIntegrateListGrid.do", method=RequestMethod.POST)
	public GridResponse claimIntegrateListGrid(ClaimSO claimSo) {
		
		List<ClaimListVO> list = claimService.pageClaimIntegrateList(claimSo);
		return new GridResponse(list, claimSo);
	}
	
	/**
	*
	* <pre>
	* 
	* - 프로젝트명	: 41.admin.web
	* - 패키지명	: admin.web.view.claim.controller
	* - 파일명		: ClaimCancelController.java
	* - 작성일		: 2021. 8. 10.
	* - 작성자		: LTS
	* - 설명		: 홈 > 주문 관리 > 클레임 통합 조회 > 클레임 통합 조회 목록 엑셀다운
	* </pre>
	*/
	@RequestMapping("/claim/claimIntegrateListExcelDownload.do")
	public String claimIntegrateListExcelDownload(ModelMap model, ClaimSO claimSo
			, @RequestParam(value="clmNos", required=false) String clmNos) {
		
		claimSo.setRows(999999999);
		List<ClaimListVO> list = claimService.getClaimIntegrateExcelList(claimSo);
		
		//선택 된 로우
		if(StringUtil.isNotEmpty(clmNos)) {
			list = list.stream().filter(
					v -> clmNos.indexOf(v.getClmNo() + v.getClmDtlSeq()) > -1
			).collect(Collectors.toList());
		}
		
		String[] headerName = {
				// 클래임번호
				messageSourceAccessor.getMessage("column.clm_no")
				// 사이트명
				, messageSourceAccessor.getMessage("column.st_nm")
				// 주문 번호
				, messageSourceAccessor.getMessage("column.ord_no")
				// 주문 일자
				, messageSourceAccessor.getMessage("column.ordDt")
				// 결제 완료 일자
				, messageSourceAccessor.getMessage("column.pay_end_date")
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
				// 주문수량
				, messageSourceAccessor.getMessage("column.orderQty")
				// 클레임 수량
				, messageSourceAccessor.getMessage("column.clm_qty")
				// 사은품 정보
				, messageSourceAccessor.getMessage("column.frb_goods_info")
				// 결제방법
				, messageSourceAccessor.getMessage("column.payMeansNm")
				// 결제금액
				, messageSourceAccessor.getMessage("column.pay_amt")
				// 현금 환불 금액
				, messageSourceAccessor.getMessage("column.cash_rfd_amt")
				// 카드 환불 금액
				, messageSourceAccessor.getMessage("column.card_rfd_amt")
				// 간편결제 환불 금액
				, messageSourceAccessor.getMessage("column.pay_rfd_amt")
				// 환불 예금주
				, messageSourceAccessor.getMessage("column.order_common.refund_name")
				// 환불 은행
				, messageSourceAccessor.getMessage("column.order_common.refund_bank")
				// 환불 계좌번호
				, messageSourceAccessor.getMessage("column.order_common.refund_account")
		};
		
		String[] fieldName = {
				// 클래임번호
				"clmNo"
				// 사이트명
				, "stNm"
				// 주문 번호
				, "ordNo"
				// 주문일자
				, "acptDtm"
				// 결제완료일자
				, "cpltDtm"
				// 회원번호
				, "mbrNo"
				// 주문자 이름
				, "ordNm"
				// 회원 아이디
				, "ordrId"
				// 클레임 유형 코드
				, "clmTpCd"
				// 클레임 상태 코드
				, "clmStatCd"
				// 클레임 접수 일시
				, "clmAcptDtm"
				// 클레임 완료 일시
				, "clmCpltDtm"
				// 클레임 취소 일시
				, "clmCncDtm"
				// 클레임 상세 순번
				, "clmDtlSeq"
				// 클레임 유형 코드
				, "clmDtlTpCd"
				// 클레임 상세 상태 코드
				, "clmDtlStatCd"
				// 클레임 사유 코드
				, "clmRsnNm"
				// 클레임 상세 사유
				, "clmRsnContent"
				// 공급사 구분
				, "compTpNm"
				// 매입업체명
				, "phsCompNm"
				// 상품 구성 유형
				, "goodsCstrtTpNm"
				// 상품아이디
				, "goodsId"
				// 상품명
				, "goodsNm"
				// 주문 수량
				, "ordQty"
				// 클레임 수량
				, "clmQty"
				// 사은품 정보
				, "subGoodsNm"
				// 결제방법
				, "payMeansNm"
				// 결제금액
				, "payAmt"
				// 현금 환불금액
				, "refundRfdAmtCash"
				// 카드 환불금액
				, "refundRfdAmtCard"
				// 간편결제 환불금액
				, "refundRfdAmtPay"
				// 환불계좌 예금주명
				, "refundOoaNm"
				// 환불계좌 은행명
				, "refundBankCd"
				// 환불계좌
				, "refundAcctNo"
		};
		
		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("integrate", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "integrate");
		
		return View.excelDownload();
	}

}

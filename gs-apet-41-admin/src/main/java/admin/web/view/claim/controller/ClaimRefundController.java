package admin.web.view.claim.controller;

import java.util.List;

import org.apache.ibatis.cache.CacheException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.order.model.OrderSO;
import biz.app.pay.model.PayCashRefundPO;
import biz.app.pay.model.PayCashRefundSO;
import biz.app.pay.model.PayCashRefundVO;
import biz.app.pay.service.PayCashRefundService;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.ExcelViewParam;
import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 41.admin.web
* - 패키지명		: admin.web.view.claim.controller
* - 파일명		: ClaimRefundController.java
* - 작성일		: 2017. 5. 10.
* - 작성자		: Administrator
* - 설명			: 클레임 환불 관련 Controller
* </pre>
*/
@Slf4j
@Controller
public class ClaimRefundController {

	@Autowired	private MessageSourceAccessor messageSourceAccessor;

	@Autowired private PayCashRefundService payCashRefundService;

	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ClaimRefundController.java
	 * - 작성일		: 2017. 3. 21.
	 * - 작성자		: valuefactory 권성중
	 * - 설명			: 환불 리스트 화면
	 * </pre>
	 * @param orderSO
	 * @param br
	 * @return
	 */
	@RequestMapping("/claim/claimRefundListView.do")
	public String claimRefundListView(OrderSO orderSO, BindingResult br) {

		if ( br.hasErrors() ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}

		// 화면 구분
		orderSO.setViewGb( "REFUND" );

		return "/claim/claimRefundListView";

	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ClaimRefundController.java
	 * - 작성일		: 2017. 3. 21.
	 * - 작성자		: valuefactory 권성중
	 * - 설명			: 환불 리스트 그리드
	 * </pre>
	 * @param orderSO
	 * @return
	 */
	@ResponseBody
	@RequestMapping( value="/claim/claimRefundListGrid.do", method=RequestMethod.POST )
	public GridResponse claimRefundListGrid(PayCashRefundSO so) {

		List<PayCashRefundVO> list = payCashRefundService.pagePayCashRefund(so);

		return new GridResponse( list, so );
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ClaimRefundController.java
	 * - 작성일		: 2017. 3. 21.
	 * - 작성자		: valuefactory 권성중
	 * - 설명			: 환불 목록(엑셀 다운로드)
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/claim/claimRefundListExcelDownload.do")
	public String claimRefundListExcelDownload(ModelMap model, PayCashRefundSO so){
		// 화면 구분
		//so.setViewGb( "REFUND" );
		so.setRows(999999999);

		List<PayCashRefundVO> list = payCashRefundService.pagePayCashRefund(so);
		String[] headerName = {
				// 현금 환불 번호
				  messageSourceAccessor.getMessage("column.cash_rfd_no")
				/* 결제 번호 */
				, messageSourceAccessor.getMessage("column.pay_no")
				// 환불 유형 코드
				, messageSourceAccessor.getMessage("column.rfd_tp_cd")
				// 환불 상태 코드
				, messageSourceAccessor.getMessage("column.rfd_stat_cd")
				// 은행 코드
				, messageSourceAccessor.getMessage("column.bank_cd")
				// 계좌 번호
				, messageSourceAccessor.getMessage("column.acct_no")
				// 예금주 명
				, messageSourceAccessor.getMessage("column.ooa_nm")
				// 예정 금액
				, messageSourceAccessor.getMessage("column.schd_amt")
				// 환불 금액
				, messageSourceAccessor.getMessage("column.rfd_amt")
				// 완료자 명
				, messageSourceAccessor.getMessage("column.cpltr_nm")
				// 완료 일시
				, messageSourceAccessor.getMessage("column.cplt_dtm")
				// 메모
				, messageSourceAccessor.getMessage("column.memo")
				// 등록자
				, messageSourceAccessor.getMessage("column.sys_regr_nm")
				// 등록 일시
				, messageSourceAccessor.getMessage("column.sys_reg_dtm")
				// 수정자
				, messageSourceAccessor.getMessage("column.sys_updr_nm")
				// 수정 일시
				, messageSourceAccessor.getMessage("column.sys_upd_dtm")
		};
		String[] fieldName = {
				// 현금 환불 번호
				  "cashRfdNo"
				/* 결제 번호 */
				, "payNo"
				// 환불 유형 코드
				, "rfdTpCd"
				// 환불 상태 코드
				, "rfdStatCd"
				// 은행 코드
				, "bankCd"
				// 계좌 번호
				, "acctNo"
				// 예금주 명
				, "ooaNm"
				// 예정 금액
				, "schdAmt"
				// 환불 금액
				, "rfdAmt"
				// 완료자 명
				, "cpltrNm"
				// 완료 일시
				, "cpltDtm"
				// 메모
				, "memo"
				// 등록자
				, "sysRegrNm"
				// 등록 일시
				, "sysRegDtm"
				// 수정자
				, "sysUpdrNm"
				// 수정 일시
				, "sysUpdDtm"
		};
		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("refund", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "refund");

		return View.excelDownload();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ClaimRefundController.java
	 * - 작성일		: 2017. 3. 21.
	 * - 작성자		: valuefactory 권성중
	 * - 설명			: 환불 실행 팝업
	 * </pre>
	 * @param model
	 * @param orderSO
	 * @return
	 */
	@RequestMapping("/claim/claimRefundExecPopView.do")
	public String claimRefundExecPopView(Model model	, PayCashRefundSO so) {

		PayCashRefundVO payCashRefund = payCashRefundService.getPayCashRefund( so );

		model.addAttribute( "payCashRefund", payCashRefund );

		return "/claim/claimRefundExecPopView";

	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ClaimRefundController.java
	 * - 작성일		: 2016. 6. 17.
	 * - 작성자		: dyyoun
	 * - 설명			: 환불 실행
	 * </pre>
	 * @param orderSO
	 * @param br
	 * @return
	 */
	@RequestMapping("/claim/claimRefundExec.do")
	public String claimRefundExec(PayCashRefundPO po, BindingResult br) {

		if ( br.hasErrors() ) {
			throw new CustomException( ExceptionConstants.ERROR_CODE_DEFAULT );
		}
		Session session = AdminSessionUtil.getSession();
		po.setCpltrNo(session.getUsrNo());
		this.payCashRefundService.compeltePayCashRefund(po);

		return View.jsonView();
	}

}

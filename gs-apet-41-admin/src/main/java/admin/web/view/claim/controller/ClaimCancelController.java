package admin.web.view.claim.controller;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.claim.model.ClaimListVO;
import biz.app.claim.model.ClaimSO;
import biz.app.claim.service.ClaimService;
import framework.common.constants.CommonConstants;
import framework.common.model.ExcelViewParam;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
* - 파일명		: ClaimCancelController.java
* - 작성일		: 2017. 5. 10.
* - 작성자		: Administrator
* - 설명			: 클레임 취소관련 Controller
* </pre>
*/
@Slf4j
@Controller
public class ClaimCancelController {

	@Autowired	private ClaimService claimService;

	@Autowired	private MessageSourceAccessor messageSourceAccessor;

	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   	: admin.web.view.claim.controller
	* - 파일명      	: ClaimCancelController.java
	* - 작성일      	: 2017. 3. 31.
	* - 작성자     	: valuefactory 권성중
	* - 설명      		: 취소 목록 화면  
	* </pre>
	 */
	@RequestMapping("/claim/claimCancelListView.do")
	public String claimCancelListView() {
		return "/claim/claimCancelListView";
	}
	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   	: admin.web.view.claim.controller
	* - 파일명      	: ClaimCancelController.java
	* - 작성일      	: 2017. 3. 31.
	* - 작성자      	: valuefactory 권성중
	* - 설명      		: 홈 > 주문 관리 > 클레임 관리 > 취소 목록
	* </pre>
	 */
	@ResponseBody
	@RequestMapping( value="/claim/claimCancelListGrid.do", method=RequestMethod.POST )
	public GridResponse claimCancelListGrid( ClaimSO claimSO ) {
		claimSO.setClmTpCd(CommonConstants.CLM_TP_10);
		List<ClaimListVO> list = claimService.pageClaim( claimSO );
		return new GridResponse( list, claimSO );
	}
	
	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.claim.controller
	* - 파일명      : ClaimCancelController.java
	* - 작성일      : 2017. 3. 31.
	* - 작성자      : valuefactory 권성중
	* - 설명      :홈 > 주문 관리 > 클레임 관리 > 취소 목록 엑셀다운
	* </pre>
	 */
	@RequestMapping("/claim/claimCancelListExcelDownload.do")
	public String claimCancelListExcelDownload(ModelMap model, ClaimSO claimSO
			,@RequestParam(value="clmNos",required=false)String clmNos
	){

		claimSO.setClmTpCd(CommonConstants.CLM_TP_10);
		claimSO.setRows(999999999);
		List<ClaimListVO> list = claimService.getClaimExcelList( claimSO );

		//선택 된 로우
		if(StringUtil.isNotEmpty(clmNos)){
			list = list.stream().filter(
					v -> clmNos.indexOf(v.getClmNo()+v.getClmDtlSeq())>-1
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
				//주문일자
				, "acptDtm"
				//결제완료일자
				, "cpltDtm"
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
				//주문 수량
				,"ordQty"
				// 클레임 수량
				, "clmQty"
				//사은품 정보
				,"subGoodsNm"
				//결제방법
				,"payMeansNm"
				//결제금액
				,"payAmt"
				//현금 환불금액
				,"refundRfdAmtCash"
				//카드 환불금액
				,"refundRfdAmtCard"
				//간편결제 환불금액
				,"refundRfdAmtPay"
				//환불계좌 예금주명
				,"refundOoaNm"
				//환불계좌 은행명
				,"refundBankCd"
				//환불계좌
				,"refundAcctNo"
		};
		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("return", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "return");

		return View.excelDownload();
	}
	
}

package admin.web.view.counsel.controller;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.claim.model.ClaimListVO;
import biz.app.claim.model.ClaimSO;
import biz.app.claim.service.ClaimService;
import biz.app.counsel.model.CounselOrderDetailVO;
import biz.app.counsel.model.CounselPO;
import biz.app.counsel.model.CounselProcessPO;
import biz.app.counsel.model.CounselProcessSO;
import biz.app.counsel.model.CounselProcessVO;
import biz.app.counsel.model.CounselSO;
import biz.app.counsel.model.CounselStatusSO;
import biz.app.counsel.model.CounselStatusVO;
import biz.app.counsel.model.CounselVO;
import biz.app.counsel.service.CounselOrderDetailService;
import biz.app.counsel.service.CounselProcessService;
import biz.app.counsel.service.CounselService;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberService;
import biz.app.order.model.OrderListSO;
import biz.app.order.model.OrderListVO;
import biz.app.order.service.OrderService;
import biz.app.st.model.StStdInfoSO;
import biz.app.st.model.StStdInfoVO;
import biz.app.st.service.StService;
import biz.common.service.CacheService;
import framework.admin.constants.AdminConstants;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.ExcelViewParam;
 
/**
* <pre>
* - 프로젝트명	: 41.admin.web
* - 패키지명		: admin.web.view.counsel.controller
* - 파일명		: CounselCcController.java
* - 작성일		: 2017. 5. 10.
* - 작성자		: Administrator
* - 설명			: 상담 콜센터 문의 관리 Controller
* </pre>
*/
@Controller
@RequestMapping("counsel/cc")
public class CounselCcController {

	@Autowired	private CounselService counselService;

	@Autowired	private CounselProcessService counselProcessService;

	@Autowired private CounselOrderDetailService counselOrderDetailService;
	
	@Autowired private OrderService orderService;
	
	@Autowired private ClaimService claimService;
	
	@Autowired private MemberService memberService;
	
	@Autowired private StService stService;
	
	@Autowired
	private MessageSourceAccessor messageSourceAccessor;
	
	@Autowired 
	private CacheService cacheService;	
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CounselCcController.java
	* - 작성일		: 2017. 5. 26.
	* - 작성자		: Administrator
	* - 설명			: CS 접수 화면
	* </pre>
	* @return
	*/
	@RequestMapping("counselCcAcceptView.do")
	public String counselCcAcceptView(ModelMap map, String stId, String stNm, String inCallType, String inCallNum, String cusTp) {
		
		map.put("stId", stId);
		map.put("stNm", stNm);
		map.put("inCallType", inCallType);
		map.put("inCallNum", inCallNum);
		map.put("cusTp", cusTp);
		
		StStdInfoSO stiso = new StStdInfoSO();
		List<StStdInfoVO> stList = this.stService.listStStdInfo(stiso);
		
		map.put("stList", stList);
		
		return "/counsel/counselCcAcceptView";
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CounselCcController.java
	* - 작성일		: 2017. 6. 27.
	* - 작성자		: Administrator
	* - 설명			: 상담 요약 정보 조회
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="getCounselStatus.do", method=RequestMethod.POST )
	public ModelMap getCounselStatus( CounselStatusSO so) {
		
		CounselStatusVO status = this.counselService.getCounselStatus(so);
		
		ModelMap map = new ModelMap();
		
		map.put("status", status);
		
		return map;
	}
	
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CounselCcController.java
	* - 작성일		: 2017. 5. 22.
	* - 작성자		: Administrator
	* - 설명			: CS 주문 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="orderListGrid.do", method=RequestMethod.POST )
	public GridResponse orderListGrid( OrderListSO so, String noSearch) {
		
		List<OrderListVO> list = null;
		
		if(!"Y".equals(noSearch)){
			list = orderService.pageOrderOrg( so );
		}
		
		return new GridResponse( list, so );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CounselCcController.java
	* - 작성일		: 2017. 5. 30.
	* - 작성자		: Administrator
	* - 설명			: 클레임 목록 조회
	* </pre>
	* @param so
	* @param noSearch
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="claimListGrid.do", method=RequestMethod.POST )
	public GridResponse claimListGrid( ClaimSO so, String noSearch) {
		
		List<ClaimListVO> list = null;
		
		if(!"Y".equals(noSearch)){
			list = claimService.pageClaim(so);
		}
		
		return new GridResponse( list, so );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CounselCcController.java
	* - 작성일		: 2017. 5. 22.
	* - 작성자		: Administrator
	* - 설명			: CS 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="counselListGrid.do", method=RequestMethod.POST )
	public GridResponse counselListGrid( CounselSO so, String noSearch) {
		List<CounselVO> list = null;
		
		if(!"Y".equals(noSearch)){
			list = this.counselService.pageCounsel(so);
		}
		
		return new GridResponse( list, so );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CounselCcController.java
	* - 작성일		: 2017. 5. 22.
	* - 작성자		: Administrator
	* - 설명			: 회원 정보 체크
	*                    단건으로 조회된 경우 회원번호 리턴
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="getMemberCheck.do", method=RequestMethod.POST )
	public ModelMap getMemberCheck( MemberBaseSO so) {
		
		List<Long> mbrNoList = this.memberService.listMemberBaseNo(so);
		Long mbrNo = -2L;
		
		ModelMap map = new ModelMap();
		
		if(CollectionUtils.isNotEmpty(mbrNoList)){
			
			if(mbrNoList.size() == 1){
				mbrNo = mbrNoList.get(0);
			}else{
				mbrNo = -1L;
			}
			
		}
		
		map.put("mbrNo", mbrNo);
		
		return map;
	}
	

	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CounselCcController.java
	* - 작성일		: 2017. 5. 29.
	* - 작성자		: Administrator
	* - 설명			: 회원정보 조회
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="getMemberInfo.do", method=RequestMethod.POST )
	public ModelMap getMemberInfo( MemberBaseSO so) {
		
		MemberBaseVO memberBase = this.memberService.getMemberBase(so);
		
		ModelMap map = new ModelMap();
		
		map.put("memberBase", memberBase);
		
		return map;
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CounselCcController.java
	* - 작성일		: 2017. 5. 29.
	* - 작성자		: Administrator
	* - 설명			: 상담 등록
	* </pre>
	* @param orderSO
	* @param counselPO
	* @param br
	* @return
	*/
	@RequestMapping("insertCounsel.do")
	public String insertcounsel(CounselPO cpo, CounselProcessPO cppo, String lastRplYn) {

		/*******************************
		 * 최종 완료 여부 판단 처리
		 *******************************/
		boolean lasRpl = false;
		
		if(CommonConstants.COMM_YN_Y.equals(lastRplYn)){
			lasRpl = true;
		}
		
		this.counselService.insertCounselCc(cpo, cppo, lasRpl);


		return View.jsonView();
	}
	
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CsController.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 콜센터 문의 목록 화면
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("counselCcListView.do")
	public String counselCcListView(ModelMap map) {
		
		StStdInfoSO stiso = new StStdInfoSO();
		List<StStdInfoVO> stList = this.stService.listStStdInfo(stiso);
		
		map.put("stList", stList);
		
		return "/counsel/counselCcListView";
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CsController.java
	* - 작성일		: 2017. 3. 30.
	* - 작성자		: snw
	* - 설명			: 콜센터 문의 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="counselCcListGrid.do", method=RequestMethod.POST )
	public GridResponse counselCcListGrid(CounselSO so) {
		so.setCusPathCd(CommonConstants.CUS_PATH_20);
		List<CounselVO> list = counselService.pageCounsel(so);
		return new GridResponse(list, so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CounselCcController.java
	* - 작성일		: 2017. 6. 1.
	* - 작성자		: Administrator
	* - 설명			: 상담 당당자 변경
	* </pre>
	* @param cusChrgNo
	* @param cusNos
	* @return
	*/
	@ResponseBody
	@RequestMapping( value="updateCounselChrg.do", method=RequestMethod.POST )
	public String updateCounselChrg(Long cusChrgNo, Long[] cusNos) {
		this.counselService.updateCounselChrg(cusNos, cusChrgNo);
		return View.jsonView();
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CounselCcController.java
	* - 작성일		: 2017. 5. 10.
	* - 작성자		: Administrator
	* - 설명			: 콜센터 문의 상세 화면
	* </pre>
	* @param model
	* @param so
	* @param counselProcessSO
	* @param br
	* @return
	*/
	@RequestMapping("counselCcView.do")
	public String counselCcView(Model model, Long cusNo, String viewGb, String popTitleYn) {
		
		/***************************
		 * 상담 내역 조회
		 ***************************/
		CounselSO cso = new CounselSO();
		cso.setCusNo(cusNo);
		
		CounselVO counsel = counselService.getCounsel(cso);

		if(counsel == null || CommonConstants.CUS_PATH_10.equals(counsel.getCusPathCd())) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		/***************************
		 * 상담 주문 조회
		 ****************************/
		List<CounselOrderDetailVO> counselOrderList = this.counselOrderDetailService.listCounselOrderDetail(cusNo);

		/*********************************
		 * 상담 처리 조회
		 *********************************/
		CounselProcessSO cpso = new CounselProcessSO();
		cpso.setCusNo(cusNo);
		List<CounselProcessVO> counselProcessList = this.counselProcessService.listCounselProcess(cpso);
		
		model.addAttribute("counsel", counsel);
		model.addAttribute("counselProcessList", counselProcessList);
		model.addAttribute("counselOrderList", counselOrderList);
		
		
		// LayOut 설정
		String layOut = AdminConstants.LAYOUT_DEFAULT;
		
		if(AdminConstants.VIEW_GB_POP.equals(viewGb)){
			layOut = AdminConstants.LAYOUT_POP;
			String titleYn = "Y";
			if(popTitleYn != null && !"".equals(popTitleYn)){
				titleYn = popTitleYn;
			}
			model.addAttribute("titleYn", titleYn);
		}
		model.addAttribute("viewGb", viewGb);
		model.addAttribute("popTitleYn", popTitleYn);
		
		model.addAttribute("layout", layOut);

		return "/counsel/counselCcView";
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: CounselCcController.java
	* - 작성일		: 2017. 5. 11.
	* - 작성자		: Administrator
	* - 설명			: 콜센터 문의 처리 등록
	* </pre>
	* @param model
	* @param po
	* @param br
	* @return
	*/
	@RequestMapping("insertCounselProcess.do")
	public String insertCounselProcess(Model model, CounselProcessPO po, String lastRplYn) {

		/*******************************
		 * 최종 완료 여부 판단 처리
		 *******************************/
		boolean lasRpl = false;
		
		if(CommonConstants.COMM_YN_Y.equals(lastRplYn)){
			lasRpl = true;
		}
		
		/*******************************
		 * 고객회신 내용이 없는 경우
		 *******************************/
		if(po.getRplContent() == null || "".equals(po.getRplContent())){
			po.setCusRplCd("");
		}
		this.counselProcessService.insertCounselProcess(po, lasRpl);
		
		return View.jsonView();
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CounselCcController.java
	 * - method		: councelCcListExcelDownload
	 * - 작성일		: 2017. 8. 21.
	 * - 작성자		: 류중규
	 * - 설명		: CS문의 엑셀 다운로드
	 * </pre>
	 * @param model
	 * @param so
	 * @return String
	 */
	@RequestMapping(value="counselCcListExcelDownload.do", method=RequestMethod.POST)
	public String councelCcListExcelDownload(Model model, CounselSO so) {
		so.setCusPathCd(CommonConstants.CUS_PATH_20);
		so.setRows(999999999);
		
		List<CounselVO> list = counselService.pageCounsel(so);
		
		String[] headerName = {
			//  사이트 명
			messageSourceAccessor.getMessage("column.st_nm"),
			//상담 상태 코드
			messageSourceAccessor.getMessage("column.cus_stat_cd"),
			//상담 유형 코드
			messageSourceAccessor.getMessage("column.cus_tp_cd"),
			// 응답 구분 코드
			messageSourceAccessor.getMessage("column.resp_gb_cd"),
			// 상담 카테고리1 코드
			messageSourceAccessor.getMessage("column.cus_ctg1_cd"),
			// 상담 카테고리2 코드
			messageSourceAccessor.getMessage("column.cus_ctg2_cd"),
			// 상담 카테고리3 코드
			messageSourceAccessor.getMessage("column.cus_ctg3_cd"),
			// 주문 번호
			messageSourceAccessor.getMessage("column.ord_no"),
			//제목
			messageSourceAccessor.getMessage("column.ttl"),
			//내용
			messageSourceAccessor.getMessage("column.content"),
			//처리내용
			messageSourceAccessor.getMessage("column.prcs_content"),
			//문의자 로그인 아이디
			messageSourceAccessor.getMessage("column.eqrr_id"),
			//문의자 명
			messageSourceAccessor.getMessage("column.eqrr_nm"),
			// 통화자 구분 코드
			messageSourceAccessor.getMessage("column.call_gb_cd"),
			//문의자 전화
			messageSourceAccessor.getMessage("column.eqrr_tel"),
			//문의자 휴대폰
			messageSourceAccessor.getMessage("column.eqrr_mobile"),
			//문의자 이메일
			messageSourceAccessor.getMessage("column.eqrr_email"),
			//상담 담당자명
			messageSourceAccessor.getMessage("column.cus_chrg_nm"),
			//상담 접수자
			messageSourceAccessor.getMessage("column.cus_acptr_nm"),
			//상담 접수 일시
			messageSourceAccessor.getMessage("column.cus_acpt_dtm"),
			//상담 취소자
			messageSourceAccessor.getMessage("column.cus_cncr_nm"),
			//상담 취소 일시
			messageSourceAccessor.getMessage("column.cus_cnc_dtm"),
			//상담 완료자
			messageSourceAccessor.getMessage("column.cus_cpltr_nm"),
			//상담 완료 일시
			messageSourceAccessor.getMessage("column.cus_cplt_dtm")				
		};

		String[] fieldName = {
			//  사이트 명
			"stNm",
			//상담 상태 코드
			"cusStatCd",
			//상담 유형 코드
			"cusTpCd",
			// 응답 구분 코드
			"respGbCd",
			// 상담 카테고리1 코드
			"cusCtg1Cd",
			// 상담 카테고리2 코드
			"cusCtg2Cd",
			// 상담 카테고리3 코드
			"cusCtg3Cd",
			// 주문 번호
			"ordNo",
			//제목
			"ttl",
			//내용
			"content",
			//처리내용
			"prcsContent",
			//문의자 로그인 아이디
			"loginId",
			//문의자 명
			"eqrrNm",
			// 통화자 구분 코드
			"callGbCd",
			//문의자 전화
			"eqrrTel",
			//문의자 휴대폰
			"eqrrMobile",
			//문의자 이메일
			"eqrrEmail",
			//상담 담당자명
			"cusChrgNm",
			//상담 접수자
			"cusAcptrNm",
			//상담 접수 일시
			"cusAcptDtm",
			//상담 취소자
			"cusCncrNm",
			//상담 취소 일시
			"cusCncDtm",
			//상담 완료자
			"cusCpltrNm",
			//상담 완료 일시
			"cusCpltDtm"
		};
		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("counsel", headerName, fieldName, list));
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "counsel");

		return View.excelDownload();
	}
	
	
	
}
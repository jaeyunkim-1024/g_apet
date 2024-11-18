package admin.web.view.promotion.controller;

import java.io.File;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.util.ServiceUtil;
import admin.web.config.view.View;
import biz.app.brand.model.BrandBaseVO;
import biz.app.company.model.CompanyBaseVO;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.goods.service.GoodsService;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.model.MemberCouponPO;
import biz.app.member.model.MemberCouponVO;
import biz.app.member.service.MemberCouponService;
import biz.app.member.service.MemberService;
import biz.app.promotion.model.CouponBasePO;
import biz.app.promotion.model.CouponBaseVO;
import biz.app.promotion.model.CouponIssueVO;
import biz.app.promotion.model.CouponSO;
import biz.app.promotion.model.CouponTargetVO;
import biz.app.promotion.model.DisplayCouponTreeVO;
import biz.app.promotion.model.ExhibitionVO;
import biz.app.promotion.service.CouponIssueService;
import biz.app.promotion.service.CouponService;
import biz.app.st.service.StService;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.admin.constants.AdminConstants;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.ExcelViewParam;
import framework.common.util.ExcelUtil;
import framework.common.util.MaskingUtil;
import framework.common.util.ObjectUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * 네이밍 룰
 * 업무명View		:	화면
 * 업무명Grid		:	그리드
 * 업무명Tree		:	트리
 * 업무명Insert		:	입력
 * 업무명Update		:	수정
 * 업무명Delete		:	삭제
 * 업무명Save		:	입력 / 수정
 * 업무명ViewPop		:	화면팝업
 */

/**
 * <pre>
 * - 프로젝트명	: 41.admin.web
 * - 패키지명	: admin.web.view.promotion.controller
 * - 파일명		: CouponController.java
 * - 작성일		: 2016. 3. 10.
 * - 작성자		: valueFactory
 * - 설명		: 쿠폰 리스트
 * </pre>
 */
@Slf4j
@Controller
public class CouponController {

	/**
	 * 쿠폰 서비스
	 */
	@Autowired
	private CouponService couponService;

	@Autowired
	private StService stService;

	@Autowired
	private MessageSourceAccessor messageSourceAccessor;

	// 상품 관리
	@Autowired
	private GoodsService goodsService;

	@Autowired
	private CouponIssueService couponIssueService;

	// 쿠폰 발급
	@Autowired
	private MemberCouponService memberCouponService;
	
	@Autowired
	private MemberService memberService;

	@Autowired
	private CacheService cacheService;
	
	@Autowired
	private BizService bizService;
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CouponController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 쿠폰 목록 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/promotion/couponListView.do")
	public String couponListView() {
		return "/promotion/couponListView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CouponController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 쿠폰 목록 팝업 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/promotion/couponListViewPop.do")
	public String couponListViewPop(Model model, MemberBasePO member,CouponSO so) {

		// 회원에게 쿠폰발급 하려고 쿠폰 검색할 때 회원의 사이트 정보/회원번호를 넘겨줌
		if (member.getStId() != null && member.getMbrNo() != null) {
			model.addAttribute("member",member);
		}
		model.addAttribute("coupon",so);

		return "/promotion/couponListViewPop";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CouponController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 쿠폰 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/promotion/couponListGrid.do", method=RequestMethod.POST)
	public GridResponse couponListGrid(CouponSO so) {
		List<CouponBaseVO> list = couponService.pageCouponBase(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CouponController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 쿠폰 상세 화면
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/promotion/couponView.do")
	public String couponView(Model model, CouponSO so) {

		if(Objects.isNull(so.getCpNo())) {
			return couponInsertView(model, so);
		}

		model.addAttribute("couponBase", couponService.getCouponBase(so));

		return "/promotion/couponView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CouponController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 쿠폰 등록 화면
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/promotion/couponInsertView.do")
	public String couponInsertView(Model model, CouponSO so) {
		
		model.addAttribute("couponBase", new CouponBaseVO());
		
		return "/promotion/couponView";
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CouponController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 쿠폰 등록
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/promotion/couponInsert.do")
	public String couponInsert(Model model, CouponBasePO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		couponService.insertCoupon(po);
		model.addAttribute("couponBase", po);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CouponController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 쿠폰 수정
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/promotion/couponUpdate.do")
	public String couponUpdate(Model model, CouponBasePO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		couponService.updateCoupon(po);
		model.addAttribute("couponBase", po);
		return View.jsonView();
	}

	@RequestMapping("/promotion/couponDelete.do")
	public String couponDelete(Model model, CouponBasePO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		couponService.deleteCoupon(po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CouponController.java
	 * - 작성일		: 2016. 4. 28.
	 * - 작성자		: valueFactory
	 * - 설명		: 쿠폰 전시 트리 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/promotion/couponDisplayTree.do", method=RequestMethod.POST)
	public List<DisplayCouponTreeVO> couponDisplayTree(CouponSO so) {
		List<DisplayCouponTreeVO> result = new ArrayList<>();
		List<CodeDetailVO> codeList = ServiceUtil.listCode(AdminConstants.DISP_CLSF);

		// 전시 목록 셋팅
		String dispClsfCd = StringUtils.isNotEmpty(so.getDispClsfCd()) ? so.getDispClsfCd() : AdminConstants.DISP_CLSF_10;
		if(CollectionUtils.isNotEmpty(codeList)) {
			for(CodeDetailVO code : codeList) {
				if(dispClsfCd.equals(code.getDtlCd())) {
					DisplayCouponTreeVO vo = new DisplayCouponTreeVO();
					vo.setId(code.getDtlCd());
					vo.setText(code.getDtlNm());
					vo.setParent("#");
					result.add(vo);
				}
			}
		}

		result.addAll(couponService.listCouponDisplayTree(so));

		return result;
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.promotion.controller
	* - 파일명      : CouponController.java
	* - 작성일      : 2017. 4. 7.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 홈 > 마케팅 관리 > 쿠폰 프로모션 > 쿠폰 등록
	* </pre>
	 */
	@ResponseBody
	@RequestMapping(value="/promotion/couponShowDispClsfGrid.do", method=RequestMethod.POST)
	public GridResponse listCouponShowDispClsf (Model model, CouponSO so ) {

		List<DisplayCouponTreeVO> list = couponService.listCouponShowDispClsf(so);
		return new GridResponse(list, so);
	}






	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CouponController.java
	 * - 작성일		: 2016. 5. 10.
	 * - 작성자		: valueFactory
	 * - 설명		: 쿠폰 상품 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/promotion/couponGoodsListGrid.do", method=RequestMethod.POST)
	public GridResponse couponGoodsListGrid(CouponSO so) {
		// 사이트정보의 USE_YN 이 Y 일 때 조회함.
		so.setStUseYn(CommonConstants.COMM_YN_Y);

		List<CouponTargetVO> list = couponService.listCouponGoods(so);
		return new GridResponse(list, so);
	}

	@ResponseBody
	@RequestMapping(value="/promotion/couponGoodsExListGrid.do", method=RequestMethod.POST)
	public GridResponse couponGoodsExListGrid(CouponSO so) {
		// 사이트정보의 USE_YN 이 Y 일 때 조회함.
		so.setStUseYn(CommonConstants.COMM_YN_Y);

		List<CouponTargetVO> list = couponService.listCouponGoodsEx(so);

		return new GridResponse(list, so);
	}

	@ResponseBody
	@RequestMapping(value="/promotion/couponMemberListGrid.do", method=RequestMethod.POST)
	public GridResponse couponMemberListGrid(CouponSO so) {
		List<MemberCouponVO> list = couponService.pageMemberCoupon(so);
		return new GridResponse(list, so);
	}

	// 수동쿠폰 다운받은 회원목록
	@ResponseBody
	@RequestMapping(value="/promotion/couponIssueListGrid.do", method=RequestMethod.POST)
	public GridResponse couponIssueListGrid(CouponSO so) {
		// 사이트정보의 USE_YN 이 Y 일 때 조회함.
		so.setStUseYn(CommonConstants.COMM_YN_Y);

		List<CouponIssueVO> list = couponService.pageCouponIssue(so);
		//회원명 마스킹처리
		if(list != null && list.size() > 0) {
			for(int i = 0; i < list.size(); i++) {
				CouponIssueVO tempVo =  list.get(i);
				 tempVo.setMbrNm(MaskingUtil.getName(tempVo.getMbrNm()));
				 list.set(i, tempVo);
			}
		}
		return new GridResponse(list, so);
	}

	// 다운로드/자동쿠폰 다운받은 회원목록
	@ResponseBody
	@RequestMapping(value="/promotion/downloadCouponIssueListGrid.do", method=RequestMethod.POST)
	public GridResponse pageDownCouponIssue(CouponSO so) {
		// 사이트정보의 USE_YN 이 Y 일 때 조회함.
		so.setStUseYn(CommonConstants.COMM_YN_Y);

		List<CouponIssueVO> list = couponService.pageDownCouponIssue(so);
		//회원명 마스킹처리
		if(list != null && list.size() > 0) {
			for(int i = 0; i < list.size(); i++) {
				CouponIssueVO tempVo =  list.get(i);
				 tempVo.setMbrNm(MaskingUtil.getName(tempVo.getMbrNm()));
				 list.set(i, tempVo);
			}
		}
		return new GridResponse(list, so);
	}

	@RequestMapping(value="/promotion/couponIssueListExcelDownload.do")
	public String couponIssueListExcelDownload(Model model,CouponSO so){
		String cpPvdMthCd = so.getCpPvdMthCd();
		// 사이트정보의 USE_YN 이 Y 일 때 조회함.
		so.setStUseYn(CommonConstants.COMM_YN_Y);
		so.setRows(9999999);

		//난수 생성 쿠폰
		if(StringUtil.equals(cpPvdMthCd,AdminConstants.CP_PVD_MTH_20)){
			List<CouponIssueVO> list = couponService.pageCouponIssue(so);
			//회원명 마스킹처리
			if(list != null && list.size() > 0) {
				for(int i = 0; i < list.size(); i++) {
					CouponIssueVO tempVo =  list.get(i);
					tempVo.setMbrNm(MaskingUtil.getName(tempVo.getMbrNm()));
					list.set(i, tempVo);
				}
			}

			String[] headerName = {"발급 일련 번호","회원 쿠폰 번호", "회원 번호", "회원 명","사용 여부","사용 일시", "주문 번호"};
			String[] fieldName = {"isuSrlNo", "mbrCpNo", "mbrNo", "mbrNm", "useYn", "useDtm", "ordNo"};
			model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("CouponIssueList", headerName, fieldName, list));
			model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "CouponIssueList");

		}else{
			List<CouponIssueVO> list = couponService.pageDownCouponIssue(so);
			//회원명 마스킹처리
			if(list != null && list.size() > 0) {
				for(int i = 0; i < list.size(); i++) {
					CouponIssueVO tempVo =  list.get(i);
					tempVo.setMbrNm(MaskingUtil.getName(tempVo.getMbrNm()));
					list.set(i, tempVo);
				}
			}

			String[] headerName = {"발급 일시","회원 쿠폰 번호", "회원 번호", "회원 명","사용 여부","사용 일시", "주문 번호"};
			String[] fieldName = {"sysRegDtm", "mbrCpNo", "mbrNo", "mbrNm", "useYn", "useDtm", "ordNo"};
			model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam("CouponIssueList", headerName, fieldName, list));
			model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, "CouponIssueList");
		}

		return View.excelDownload();
	}
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CouponController.java
	 * - 작성일		: 2016. 11. 15.
	 * - 작성자		:
	 * - 설명		: 배송비 쿠폰 적용 상품 배송비 결제 방법 조회
	 * </pre>
	 * @param goodsId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/promotion/goodsDlvrcPayMth.do", method=RequestMethod.POST)
	public String goodsDlvrcPayMth(String goodsId) {

		String result = couponService.goodsDlvrcPayMth(goodsId);
		if (StringUtils.isEmpty(result)) {
			result = CommonConstants.DLVRC_PAY_MTD_10;
		}
		return result;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CouponController.java
	 * - 작성일		: 2017. 1. 31.
	 * - 작성자		: hongjun
	 * - 설명			: 쿠폰 검색 Layer
	 * </pre>
	 *
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/promotion/couponSearchLayerView.do")
	public String couponSearchLayerView(Model model, CouponSO so) {
		model.addAttribute("so", so);
		return "/promotion/couponSearchLayerView";
	}


	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.promotion.controller
	* - 파일명      : CouponController.java
	* - 작성일      : 2017. 4. 19.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 홈 > 마케팅 관리 > 쿠폰 프로모션 > 쿠폰 등록    // 쿠폰대상인 업체 인  업체 리스트
	* </pre>
	 */
	@ResponseBody
	@RequestMapping(value="/promotion/couponTargetCompNoListGrid.do", method=RequestMethod.POST)
	public GridResponse couponTargetCompNoListGrid (Model model, CouponSO so ) {
		List<CompanyBaseVO> list = couponService.listCouponTargetCompNo(so);
		return new GridResponse(list, so);
	}

	@ResponseBody
	@RequestMapping(value="/promotion/couponTargetBndNoListGrid.do", method=RequestMethod.POST)
	public GridResponse couponTargetBndNoListGrid (Model model, CouponSO so ) {
		List<BrandBaseVO> list = couponService.listCouponTargetBndNo(so);
		return new GridResponse(list, so);
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.promotion.controller
	* - 파일명      : CouponController.java
	* - 작성일      : 2017. 5. 24.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 제외상품 엑셀 업로드
	* </pre>
	 */
	@RequestMapping("/promotion/goodsExListExcelUploadView.do")
	public String goodsExListExcelUploadView( ) {
 		return "/promotion/goodsExListExcelUploadView";

	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.promotion.controller
	* - 파일명      : CouponController.java
	* - 작성일      : 2017. 5. 24.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 엑셀 샘플파일 다운로드
	* </pre>
	 */
	@RequestMapping("/promotion/goodsExListExcelSampleDownload.do")
	public String deliveryInvoiceCompanyExcelDownload(Model model, GoodsBaseSO so ) {
		if ( log.isDebugEnabled() ) {
			log.debug( "==================================================" );
			log.debug( "= {}", "goodsExListExcelSampleDownload" );
			log.debug( "==================================================" );
		}
		String[]	headerName	= null;
		String[]	fieldName	= null;
		String		sheetName	= "goodsExListExcelSampleDownload";
		String		fileName	= "goodsExListExcelSampleDownload";
		headerName = new String[] {
				// 상품 번호
			    messageSourceAccessor.getMessage("column.goods_id" )
		};
		fieldName = new String[] {
				// 상품 번호
				  "goodsId"
		};
	    List<GoodsBaseVO> list = null;
		model.addAttribute( CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam( sheetName, headerName, fieldName, list, CommonConstants.COMM_YN_Y ) );
		model.addAttribute( CommonConstants.EXCEL_PARAM_FILE_NAME, fileName );
		return View.excelDownload();
	}
	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.promotion.controller
	* - 파일명      : CouponController.java
	* - 작성일      : 2017. 5. 24.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 상품 등록 전 엑셀데이타 확인
	* </pre>
	 */
	@RequestMapping("/promotion/goodsExListExcelUploadExec.do")
	public String goodsExListExcelUploadExec(
		Model model
		, GoodsBaseSO so
		, @RequestParam("fileName") String fileName
		, @RequestParam("filePath") String filePath
	) {
		List<GoodsBaseVO> resultList = new ArrayList<>();



		//List<DeliveryUploadResult> resultList = new ArrayList<DeliveryUploadResult>();
		//DeliveryUploadResult result = null;

		if ( log.isDebugEnabled() ) {
			log.debug( "==================================================" );
			log.debug( "= fileName : {}", fileName );
			log.debug( "= filePath : {}", filePath );
			log.debug( "==================================================" );
		}

		int cntTotal=0;
        int cntSuccess=0;
		if ( StringUtil.isNotEmpty( filePath ) ) {

			String[] headerMap = null;

			headerMap = new String[] {
					// 상품 번호
					  "goodsId"
			};
			File excelFile = new File(filePath);		// 파싱할 Excel File
			List<GoodsBaseVO> goodsExcelListVO = null;
			try {
				// 엑셀데이타
				goodsExcelListVO = ExcelUtil.parse( excelFile, GoodsBaseVO.class, headerMap, 1 );
			} catch (Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			}


			List<String> goodsList = new ArrayList<>();

			if (CollectionUtils.isNotEmpty(goodsExcelListVO)) {
				for ( GoodsBaseVO goodsBaseVO : goodsExcelListVO ) {
					goodsList.add(goodsBaseVO.getGoodsId());
				}
			}

			so.setGoodsIds(goodsList.toArray(new String[goodsList.size()]) );

			//쿼리 데이타
			List<GoodsBaseVO> goodsBaseVOList = goodsService.pageGoodsBase(so);


			BeanUtilsBean.getInstance().getConvertUtils().register( false, true, 0 );


            if (CollectionUtils.isNotEmpty(goodsBaseVOList)) {
            	for ( GoodsBaseVO goodsBaseCheckVO : goodsExcelListVO ) {
            		cntTotal = cntTotal + 1 ;
            		GoodsBaseVO result = new GoodsBaseVO();
            		boolean check = false ;
            		for ( GoodsBaseVO goodsBaseVO : goodsBaseVOList ) {
        			   if (   goodsBaseVO.getGoodsId() != null && !"".equals(goodsBaseVO.getGoodsId())
        					&&goodsBaseCheckVO.getGoodsId() != null && !"".equals(goodsBaseCheckVO.getGoodsId())
        					&&goodsBaseVO.getGoodsId().equals(   goodsBaseCheckVO.getGoodsId() )
        				  ){
        				   		check = true;
        				   		try {
									BeanUtils.copyProperties( result, goodsBaseVO );
								} catch (IllegalAccessException | InvocationTargetException e) {
									log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
								}
        			   	   }
            		}
            		if(check){
     				   cntSuccess++;
     				   result.setResultYN("성공");
     				   result.setResultMsg("");
     			   }else{
     				   result.setGoodsId( goodsBaseCheckVO.getGoodsId() );
     				   result.setResultYN("실패");
     				   result.setResultMsg("상품번호가 없는 상품입니다.");
     			   }
            		resultList.add(result);
            	}
            }
			// 읽은 파일 삭제
			if(!excelFile.delete()) {
				log.error("Fail to delete of file. CounponController.goodsExListExcelUploadExec::excelFile.delete {}");
			}
		}

        model.addAttribute( "cntTotal", cntTotal );
        model.addAttribute( "cntSuccess", cntSuccess );
        model.addAttribute( "cntFail", cntTotal - cntSuccess );
        model.addAttribute( "resultList", resultList );
		return View.jsonView();
	}

	@RequestMapping("/promotioin/memberCouponIssue.do")
	public String memberCouponIssue(Model model, MemberCouponPO memberCouponPO, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		memberCouponPO.setCpNo(memberCouponPO.getCpNo());
		memberCouponPO.setMbrNo(memberCouponPO.getMbrNo());
		memberCouponPO.setSysRegrNo(AdminSessionUtil.getSession().getUsrNo());
		memberCouponPO.setIsuTpCd(CommonConstants.ISU_TP_30);		// 발급유형  ISU_TP_30 : CS

		Long mbrCpNo = 0L;
		mbrCpNo = this.memberCouponService.insertMemberCoupon(memberCouponPO);

		model.addAttribute("mbrCpNo", mbrCpNo);

		return View.jsonView();
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.promotion.controller
	* - 파일명      : CouponController.java
	* - 작성일      : 2017. 7. 6.
	* - 작성자      : valuefactory 권성중
	* - 설명      : 쿠폰 기획전
	* </pre>
	 */
	@ResponseBody
	@RequestMapping(value="/promotion/couponTargetExhbtNoListGrid.do", method=RequestMethod.POST)
	public GridResponse couponTargetExhbtNoListGrid (Model model, CouponSO so ) {
		List<ExhibitionVO> list = couponService.listCouponTargetExhbtNo(so);
		return new GridResponse(list, so);
	}
	
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.promotion.controller
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: JinHong
	 * - 설명		: 쿠폰 복사
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping(value="/promotion/copyCoupon.do", method=RequestMethod.POST)
	public String couponUpdate(Model model, CouponSO so) {
		CouponBasePO po = couponService.copyCoupon(so);
		model.addAttribute("couponBase", po);
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.promotion.controller
	 * - 작성일		: 2021. 08. 12.
	 * - 작성자		: 김세영
	 * - 설명		: 쿠폰발급 삭제
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/promotion/couponIssueDelete.do")
	public String couponIssueDelete (Model model, @RequestBody ArrayList<CouponIssueVO> so ) {

		int delCnt = 0;

		if(so != null && so.size() > 0 ) {
			delCnt = couponIssueService.deleteCouponIssueStb(so);
		}

		model.addAttribute("delCnt", delCnt );
		return View.jsonView();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.promotion.controller
	 * - 작성일		: 2021. 08. 12.
	 * - 작성자		: 김세영
	 * - 설명		: 쿠폰 일괄발급 팝업 호출
	 * </pre>
	 * @param map
	 * @param cpNo
	 * @param popupGbn
	 * @return
	 */
	@RequestMapping("/promotion/couponIssuePop.do")
	public String memberSearchLayerView(ModelMap map, @RequestParam(value="cpNo")  Long cpNo, @RequestParam(value="popupGbn") String popupGbn ) {
		
		String viewName = "couponIssueMemberSearchLayerView";
		if("02".equals(popupGbn)) viewName = "couponIssueExcelUploadLayerView";
		
		CouponSO cso = new CouponSO();
		cso.setCpNo(cpNo);
		map.put("coupon", couponService.getCoupon(cso));
		
		return "/promotion/"+viewName;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.promotion.controller
	 * - 작성일		: 2021. 08. 12.
	 * - 작성자		: 김세영
	 * - 설명		: 쿠폰 일괄 발급 회원 조회
	 * </pre>
	 * @param model
	 * @param cpNo
	 * @param mbrNos
	 * @return
	 */
	@RequestMapping("/promotion/couponIssueMemberList.do")
	public String couponIssueMemberList(Model model, @RequestParam(value="cpNo") Long cpNo, @RequestParam(value="mbrNos") Long[] mbrNos ) {
		
		List<Long> mbrNoArray = new ArrayList<Long>();
		int sussCnt = 0;
		
		for(Long mbrNo : mbrNos) {
			if(couponIssueService.selectCouponIssueStbYn(cpNo, mbrNo)){
				mbrNoArray.add(mbrNo);
			}
		}
		
		if(mbrNoArray.size() > 0) {
			sussCnt = couponIssueService.insertMemberCouponList(cpNo, mbrNoArray.toArray(new Long[mbrNoArray.size()]));
		}
		
		model.addAttribute("totCnt", mbrNos.length);
		model.addAttribute("sussCnt", sussCnt);
		model.addAttribute("failCnt", mbrNos.length - sussCnt);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.promotion.controller
	 * - 작성일		: 2021. 08. 12.
	 * - 작성자		: 김세영
	 * - 설명		: 쿠폰 일괄 발급 엑셀업로드 템플릿 다운로드
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/promotion/couponTmplExcelDownload.do")
	public String couponTmplExcelDownload(Model model) {

		String[] headerName = null;
		String[] fieldName = null;
		String sheetName = "couponIssueTmplExcelDownload";
		String fileName = "couponIssueTmplExcelDownload";

		headerName = new String[] {
			messageSourceAccessor.getMessage("column.mbr_no" )
			, messageSourceAccessor.getMessage("column.display_view.estm_id" )
			, messageSourceAccessor.getMessage("column.mobile2" )
		};

		fieldName = new String[] {
			"mbrNo"		// 회원번호
			, "loginId"	// 회원ID
			, "mobile"	// 핸드폰
		};
		
		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam(sheetName, headerName, fieldName, null) );
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, fileName );

		return View.excelDownload();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.promotion.controller
	 * - 작성일		: 2021. 08. 12.
	 * - 작성자		: 김세영
	 * - 설명		: 쿠폰 일괄 발급 엑셀업로드 결과 다운로드
	 * </pre>
	 * @param model
	 * @param resultList
	 * @return
	 */
	@RequestMapping("/promotion/couponIssueUploadExcelDownload.do")
	public String couponIssueUploadExcelDownload(Model model
			, @RequestParam(value="cpNo") Long[] cpNo
			, @RequestParam(value="mbrNo") String[] mbrNo
			, @RequestParam(value="loginId") String[] loginId
			, @RequestParam(value="mobile") String[] mobile
			, @RequestParam(value="mbrLevRsnCd") String[] mbrLevRsnCd
			, @RequestParam(value="mbrLevContent") String[] mbrLevContent
			) {

		String[] headerName = null;
		String[] fieldName = null;
		String sheetName = "couponIssueUploadExcelDownload";
		String fileName = "";
		
		List<MemberBaseVO> list = new ArrayList<MemberBaseVO>();
		for(int i = 0; i < mbrLevRsnCd.length; i++) {
			MemberBaseVO vo = new MemberBaseVO();
			
			if(mbrNo.length > 0 && !ObjectUtil.isEmpty(mbrNo[i])) {
				vo.setStNm(mbrNo[i]);
			}
			
			if(loginId.length > 0 && !ObjectUtil.isEmpty(loginId[i])) {
				vo.setLoginId(loginId[i]);
			}
			
			if(mobile.length > 0 && !ObjectUtil.isEmpty(mobile[i])) {
				vo.setMbrGrdNm(mobile[i]);
			}
			vo.setMbrStatNm(cacheService.getCodeName(CommonConstants.REQ_RST, mbrLevRsnCd[i]));
			
			if(mbrLevContent.length > 0 && !ObjectUtil.isEmpty(mbrLevContent[i])) {
				vo.setMbrLevContent(mbrLevContent[i]);
			}
			list.add(vo);
		}

		headerName = new String[] {
			messageSourceAccessor.getMessage("column.mbr_no" )
			, messageSourceAccessor.getMessage("column.display_view.estm_id" )
			, messageSourceAccessor.getMessage("column.mobile2" )
			, messageSourceAccessor.getMessage("column.rst_cd" )
			, "메세지"
		};

		fieldName = new String[] {
			"stNm"		// 회원번호
			, "loginId"	// 회원ID
			, "mbrGrdNm"	// 핸드폰
			, "mbrStatNm"	// 결과
			, "mbrLevContent"	// 메세지
		};
		
		// 쿠폰 정보 조회 - 파일명 세팅
		CouponSO cso = new CouponSO();
		cso.setCpNo(cpNo[0]);
		CouponBaseVO coupon = couponService.getCoupon(cso);
		fileName = "couponIssue_"+coupon.getCpNo() + "_" + coupon.getCpNm();
		
		model.addAttribute(CommonConstants.EXCEL_PARAM_NAME, new ExcelViewParam(sheetName, headerName, fieldName, list) );
		model.addAttribute(CommonConstants.EXCEL_PARAM_FILE_NAME, fileName );

		return View.excelDownload();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.promotion.controller
	 * - 작성일		: 2021. 08. 12.
	 * - 작성자		: 김세영
	 * - 설명		: 쿠폰 일괄 발급 엑셀업로드
	 * </pre>
	 * @param model
	 * @param fileName
	 * @param filePath
	 * @param cpNo
	 * @param isuTgCd
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/promotion/couponIssueExcelUpload.do", method = RequestMethod.POST)
	public String couponIssueExcelUpload(Model model, @RequestParam("fileName") String fileName,
			@RequestParam("filePath") String filePath,
			@RequestParam("cpNo") Long cpNo,
			@RequestParam("isuTgCd") String isuTgCd
			) {

		List<MemberBaseVO> couponIssueExcelListVO = null;

		File excelFile = null;
		if (StringUtil.isNotEmpty(filePath)) {
			excelFile = new File(filePath);
		}
		
		String[] headerMap = new String[]{
				messageSourceAccessor.getMessage("column.mbr_no" )
				, messageSourceAccessor.getMessage("column.display_view.estm_id" )
				, messageSourceAccessor.getMessage("column.mobile2" )
					};
		String[] fieldMap = new String[]{
				"mbrNo"		// 회원번호
				, "loginId"	// 회원ID
				, "mobile"	// 핸드폰
			};
		
			
		try {
			// 엑셀데이타
			couponIssueExcelListVO = ExcelUtil.parse(excelFile, MemberBaseVO.class, fieldMap, 1);
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			throw new CustomException(ExceptionConstants.ERROR_FILE_NOT_FOUND);
		}
		
		ArrayList<String> headerList = ExcelUtil.getHeaderList(excelFile);
		boolean validateYn = true;
		
		// 기존 엑셀 양식과 업로드 받은 엑셀 양식 비교
		if(headerMap.length != headerList.size()) {
			validateYn = false;
		}else {
			for(int i = 0 ; i < headerMap.length ; i ++) {
				log.info("headerMap : " + headerMap[i]);
				log.info("headerList : " + headerList.get(i));
				log.info("equals : " + StringUtil.equals(headerMap[i], headerList.get(i)));
				if(!StringUtil.equals(headerMap[i], headerList.get(i))) {
					validateYn = false;
				}
			}
		}
		
		// 엑셀 양식이 맞지 않을 경우
		if(!validateYn) {
			throw new CustomException(ExceptionConstants.ERROR_EXCEL_TEMPLATE_NOT_MATCHED);
		}

		// 읽은 파일 삭제
		if (!excelFile.delete()) {
			log.error("Fail to delete of file. CouponController.couponIssueExcelUpload::excelFile.delete {}");
		}
		
		List<MemberBaseVO> resultList = new ArrayList<MemberBaseVO>();
		int sussCnt = 0;
		int failCnt = 0;
		if (CollectionUtils.isNotEmpty(couponIssueExcelListVO)) {
			
			// 쿠폰 정보 조회
			CouponSO cso = new CouponSO();
			cso.setCpNo(cpNo);
			CouponBaseVO coupon = couponService.getCoupon(cso);
			
			for(MemberBaseVO excelMemberVO : couponIssueExcelListVO) {

				boolean isMbrNo = ObjectUtil.isEmpty(excelMemberVO.getMbrNo());
				boolean isLoginId = ObjectUtil.isEmpty(excelMemberVO.getLoginId());
				boolean isMobile = ObjectUtil.isEmpty(excelMemberVO.getMobile());
				
				// 휴대폰번호 하이픈 치환
				if(!isMobile){
					excelMemberVO.setMobile(excelMemberVO.getMobile().replaceAll("-", ""));
					// 하이픈,공백 치환 후 여부세팅 
					isMobile = (ObjectUtil.isEmpty(excelMemberVO.getMobile().trim()));
				}
				
				// 회원ID 공백 체크
				if(!isLoginId){
					isLoginId = (ObjectUtil.isEmpty(excelMemberVO.getLoginId().trim()));
				}
				
				// 회원번호 공백 처리
				if(!isMbrNo && excelMemberVO.getMbrNo() == 0L) {
					excelMemberVO.setMbrNo(null);
					isMbrNo = true;
				}
				
				if (isMbrNo && isLoginId && isMobile) {
					continue;
				}

				// 회원번호 중복 체크
				if(!isMbrNo) {
					long mbrNoCnt = couponIssueExcelListVO.stream().filter(vo -> 
								(ObjectUtil.isNotEmpty(vo.getMbrNo()) && vo.getMbrNo().equals(excelMemberVO.getMbrNo())
								 && ObjectUtil.isNotEmpty(vo.getMbrLevRsnCd()))
							).count();
					if(mbrNoCnt > 0) {
						this.setExcelMemberResult(resultList, excelMemberVO, false, "엑셀 데이터 중복 : 회원번호");
						failCnt++;
						continue;
						
					}
				}
				
				// 회원ID 중복 체크
				if(!isLoginId) {
					long loginIdCnt = couponIssueExcelListVO.stream().filter(vo -> 
								(ObjectUtil.isNotEmpty(vo.getLoginId()) && vo.getLoginId().equals(excelMemberVO.getLoginId())
								 && ObjectUtil.isNotEmpty(vo.getMbrLevRsnCd()))
							).count();
					if(loginIdCnt > 0) {
						this.setExcelMemberResult(resultList, excelMemberVO, false, "엑셀 데이터 중복 : 회원ID");
						failCnt++;
						continue;
					}
				}
				
				// 핸드폰 중복 체크
				if(!isMobile) {
					long mobileCnt = couponIssueExcelListVO.stream().filter(vo -> 
								(ObjectUtil.isNotEmpty(vo.getMobile()) && vo.getMobile().equals(excelMemberVO.getMobile())
								 && ObjectUtil.isNotEmpty(vo.getMbrLevRsnCd()))
							).count();
					if(mobileCnt > 0) {
						this.setExcelMemberResult(resultList, excelMemberVO, false, "엑셀 데이터 중복 : 핸드폰번호");
						failCnt++;
						continue;
					}
				}

				MemberBaseSO so = new MemberBaseSO();
				if(!isMbrNo) so.setMbrNo(excelMemberVO.getMbrNo());
				if(!isLoginId) so.setLoginId(bizService.twoWayEncrypt(excelMemberVO.getLoginId()));
				if(!isMobile) so.setMobile(bizService.twoWayEncrypt(excelMemberVO.getMobile()));
				MemberBaseVO memberInfo = null;
				
				try {
					memberInfo = memberService.getMemberBase(so);
				} catch (Exception e) {
					this.setExcelMemberResult(resultList, excelMemberVO, false, "회원정보 유효하지 않음");
					failCnt++;
					continue;
				}

				if (memberInfo == null || memberInfo.getMbrNo() == null) {
					this.setExcelMemberResult(resultList, excelMemberVO, false, "회원정보 유효하지 않음");
					failCnt++;
					continue;
				}else {
					// 회원정보 조회 후 회원번호 체크
					long searchMbrNo = memberInfo.getMbrNo();
					excelMemberVO.setMbrNo(searchMbrNo);
					long mbrNoCnt = couponIssueExcelListVO.stream().filter(vo -> 
							( ObjectUtil.isNotEmpty(vo.getMbrNo()) && vo.getMbrNo().equals(searchMbrNo)
							 && ObjectUtil.isNotEmpty(vo.getMbrLevRsnCd()))
							 ).count();
					if(mbrNoCnt > 0) {
						this.setExcelMemberResult(resultList, excelMemberVO, false, "엑셀 데이터 중복 : 회원번호");
						failCnt++;
						continue;
						
					}
					
				}
				
				// 발급 대상 체크
				if (!"00".equals(isuTgCd) && isuTgCd.equals(memberInfo.getMbrGbCd()) ) {
					this.setExcelMemberResult(resultList, excelMemberVO, false, "발급 대상 회원 아님");
					failCnt++;
					continue;
				}
				
				// 회원 상태 체크
				if (!"10".equals(memberInfo.getMbrStatCd()) ) {
					String userStatNm = "회원 상태 : "+cacheService.getCodeName(CommonConstants.MBR_STAT_CD, memberInfo.getMbrStatCd());
					this.setExcelMemberResult(resultList, excelMemberVO, false, userStatNm);
					failCnt++;
					continue;
				}
				
				// 이전 발급 체크
				if(!couponIssueService.selectCouponIssueStbYn(cpNo, excelMemberVO.getMbrNo())){
						this.setExcelMemberResult(resultList, excelMemberVO, false, "이전 발급");
						failCnt++;
						continue;
				}

				// 발급 대상 체크
				if (coupon.getMbrGrdCd() != null && coupon.getMbrGrdCd().length() > 0) {
					String[] arrMbrGrdCd = coupon.getMbrGrdCd().split(",");
					String mbrGrdCd = memberInfo.getMbrGrdCd();
					int cntMbrGrdCd = 0;
					for (String cpMbrGrdCd : arrMbrGrdCd) {
						if(StringUtil.equals(mbrGrdCd, cpMbrGrdCd)){
							cntMbrGrdCd++;
						}
					}
					if(cntMbrGrdCd == 0){
						this.setExcelMemberResult(resultList, excelMemberVO, false, "발급 회원 등급 아님");
						failCnt++;
						continue;
					}
				}
				
				this.setExcelMemberResult(resultList, excelMemberVO, true, "");
				sussCnt++;

			}
			
		} else {
			throw new CustomException(ExceptionConstants.ERROR_EXCEL_TEMPLATE_NOT_MATCHED);
		}

		model.addAttribute("resultList", resultList);
		model.addAttribute("sussCnt", sussCnt);
		model.addAttribute("failCnt", failCnt);

		return View.jsonView();
	}
	
	private void setExcelMemberResult(List<MemberBaseVO> resultList, MemberBaseVO excelMemberVO, boolean isSuss, String Msg) {

		MemberBaseVO result = new MemberBaseVO();
		result.setMbrNo(excelMemberVO.getMbrNo());
		result.setLoginId(excelMemberVO.getLoginId());
		result.setMobile(excelMemberVO.getMobile());
		result.setMbrLevRsnCd(isSuss?"S":"F");
		result.setMbrLevContent(Msg);
		excelMemberVO.setMbrLevRsnCd(isSuss?"S":"F");
		resultList.add(result);
	}
	
	
}
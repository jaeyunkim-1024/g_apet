package admin.web.view.brand.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.util.ServiceUtil;
import admin.web.config.view.View;
import biz.app.brand.model.BrandBasePO;
import biz.app.brand.model.BrandBaseSO;
import biz.app.brand.model.BrandBaseVO;
import biz.app.brand.model.BrandGoodsSO;
import biz.app.brand.model.BrandGoodsVO;
import biz.app.brand.model.BrandSO;
import biz.app.brand.model.DisplayBrandTreeVO;
import biz.app.brand.service.BrandService;
import biz.app.st.model.StStdInfoSO;
import biz.app.st.service.StService;
import biz.app.system.model.CodeDetailVO;
import framework.admin.constants.AdminConstants;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.admin.util.LogUtil;
import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BrandController {

	@Autowired
	private BrandService brandService;

	@Autowired
	private StService stService;

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: BrandController.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 등록
	* </pre>
	* @param model
	* @return
	*/
	@RequestMapping("/brand/brandInsertView.do")
	public String brandInsertView (Model model) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "BRAND 등록");
			log.debug("==================================================");
		}

		// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.
		Session session = AdminSessionUtil.getSession();
		if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {

			model.addAttribute("loginCompNo", session.getCompNo());
		}

		StStdInfoSO stso = new StStdInfoSO();
		//List<StStdInfoVO> stIdList = stService.getStList(stso);
		model.addAttribute("stIdList", stService.getStList(stso));

		return "/brand/brandInsertView";
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: BrandController.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 등록
	* </pre>
	* @param model
	* @param po
	* @return
	*/
	@RequestMapping("/brand/brandInsert.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String brandInsert (Model model, BrandBasePO brandBasePO) {

		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "BRAND 등록");
			log.debug("==================================================");
		}
		//등록 전 동일한 브랜드명 존재 여부 확인
		BrandSO so = new BrandSO();
		so.setBndNm(brandBasePO.getBndNmKo().trim());
		int duplBrandNmCnt = brandService.getSameBrandNameCount(so);		
		if(duplBrandNmCnt > 0) {
			model.addAttribute("duplYn", "Y");
		}else {
			Long bndNo = null;
			brandBasePO.setUseYn(CommonConstants.COMM_YN_Y);

			bndNo = brandService.insertBrand(brandBasePO);
			model.addAttribute("bndNo", bndNo );
			model.addAttribute("duplYn", "N");
		}
		return View.jsonView();
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: BrandController.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 등록
	* </pre>
	* @param model
	* @param po
	* @return

	@RequestMapping("/brand/brandInsert.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
//	public String brandInsert (Model model
//			, @RequestParam("brandBasePO") String brandBaseStr
//			, @RequestParam("companyBrandPO") String companyBrandStr ) {
	public String brandInsert (Model model, BrandBasePO brandBasePO, CompanyBrandPO companyBrandPO) {

		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "BRAND 등록");
			log.debug("==================================================");
		}

		JsonUtil jsonUt = new JsonUtil();
		Long bndNo = null;

//		// Brand 기본
//		BrandBasePO brandBasePO = (BrandBasePO)jsonUt.toBean(BrandBasePO.class, brandBaseStr );
//
//		// 업체 Brand
//		CompanyBrandPO companyBrandPO = (CompanyBrandPO)jsonUt.toBean(CompanyBrandPO.class, companyBrandStr );

		bndNo = brandService.insertBrand(brandBasePO, companyBrandPO );

		model.addAttribute("bndNo", bndNo );

		return View.jsonView();
	}
*/

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: BrandController.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 상세
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/brand/brandDetailView.do")
	public String brandDetailView (Model model, BrandBaseSO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "BRAND 상세");
			log.debug("==================================================");
		}

		// 브랜드 기본 조회
		Long bndNo = so.getBndNo();
		BrandBaseVO brandBaseVO = brandService.getBrandBase(bndNo );

		// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.
		if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {

			brandBaseVO.setCompNo(AdminSessionUtil.getSession().getCompNo());
			brandBaseVO.setCompNm(AdminSessionUtil.getSession().getCompNm());
		}

		// 브랜드 업체 조회 hjko 주석처리/ 20170201. 업체브랜드는 업체쪽으로 이동
		//CompanyBrandVO companyBrandVO = brandService.getCompanyBrand(bndNo );

		model.addAttribute("brandBase", brandBaseVO );
		//model.addAttribute("companyBrand", companyBrandVO );  hjko 주석처리/ 20170201. 업체브랜드는 업체쪽으로 이동

		StStdInfoSO stso = new StStdInfoSO();
		//List<StStdInfoVO> stIdList = stService.getStList(stso);
		model.addAttribute("stIdList", stService.getStList(stso));



		return "/brand/brandDetailView";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: BrandController.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 관리
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/brand/brandListView.do")
	public String brandListView (Model model, BrandBaseSO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "BRAND 관리");
			log.debug("==================================================");
		}

		return "/brand/brandListView";
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: BrandController.java
	* - 작성일		: 2016. 5. 3.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 리스트 GRID
	* </pre>
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value="/brand/brandBaseGrid.do", method=RequestMethod.POST)
	public GridResponse brandBaseGrid (BrandBaseSO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("########## : {} ", so.toString());
		}

		if(!StringUtil.isEmpty(so.getBndNmArea()) ) {
			String[] bndNmList = StringUtil.splitEnter(so.getBndNmArea());
			so.setBndNms(bndNmList );
		}

		if(!StringUtil.isEmpty(so.getBndNoArea()) ) {
			String[] bndNoList = StringUtil.splitEnter(so.getBndNoArea());
			Long[] bndNos = null;
			if(bndNoList != null && bndNoList.length > 0 ) {
				bndNos = new Long[bndNoList.length];
				for(int i = 0; i < bndNoList.length; i++ ) {
					bndNos[i] = Long.valueOf(bndNoList[i] );
				}
				so.setBndNos(bndNos );
			}
		}

		// 업체사용자일 때 업체번호를 항상 조회조건에 사용하도록 수정함.
		if (StringUtils.equals(CommonConstants.USR_GRP_20, AdminSessionUtil.getSession().getUsrGrpCd())) {

			so.setCompNo(AdminSessionUtil.getSession().getCompNo());
		}

		// 브랜드 리스트 조회
		List<BrandBaseVO> list = brandService.pageBrandBase(so );
		return new GridResponse(list, so );
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: BrandController.java
	* - 작성일		: 2016. 5. 4.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 삭제
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/brand/brandDelete.do")
	public String brandDelete (Model model, BrandBaseSO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "BOM Delete");
			log.debug("==================================================");
			LogUtil.log(so );
		}

		Long[] bndNos = so.getBndNos();
		int delCnt = 0;
		if(bndNos != null && bndNos.length > 0 ) {
			delCnt = brandService.deleteBrand(bndNos );
		}

		model.addAttribute("delCnt", delCnt );
		return View.jsonView();
	}


	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: BrandController.java
	* - 작성일		: 2016. 5. 4.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 수정
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/brand/brandUpdate.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String brandUpdate(Model model, BrandBasePO brandBasePO ) {

		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "BRAND 수정");
			log.debug("==================================================");
		}

		Long bndNo = null;

		// Brand 기본
		// BrandBasePO brandBasePO = (BrandBasePO)jsonUt.toBean(BrandBasePO.class, brandBaseStr );

		// 업체 Brand
		// CompanyBrandPO companyBrandPO = (CompanyBrandPO)jsonUt.toBean(CompanyBrandPO.class, companyBrandStr );

		//bndNo = brandService.updateBrand(brandBasePO, companyBrandPO, orgBndItrdcImgPath );
		//등록 전 동일한 브랜드명 존재 여부 확인
		BrandSO so = new BrandSO();
		so.setBndNm(brandBasePO.getBndNmKo().trim());
		so.setBndNo(brandBasePO.getBndNo());
		int duplBrandNmCnt = brandService.getSameBrandNameCount(so);		
		if(duplBrandNmCnt > 0) {
			model.addAttribute("duplYn", "Y");
		}else {
			bndNo = brandService.updateBrand(brandBasePO);
			model.addAttribute("bndNo", bndNo );
			model.addAttribute("duplYn", "N");
		}
		

		return View.jsonView();
	}

	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: BrandController.java
	* - 작성일		: 2016. 5. 4.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 수정
	* </pre>
	* @param model
	* @param so
	* @return

	@RequestMapping("/brand/brandUpdate.do")
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String brandUpdate(Model model, BrandBasePO brandBasePO, CompanyBrandPO companyBrandPO, String orgBndItrdcImgPath) {

		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "BRAND 수정");
			log.debug("==================================================");
		}

		JsonUtil jsonUt = new JsonUtil();
		Long bndNo = null;

		// Brand 기본
		// BrandBasePO brandBasePO = (BrandBasePO)jsonUt.toBean(BrandBasePO.class, brandBaseStr );

		// 업체 Brand
		// CompanyBrandPO companyBrandPO = (CompanyBrandPO)jsonUt.toBean(CompanyBrandPO.class, companyBrandStr );

		//bndNo = brandService.updateBrand(brandBasePO, companyBrandPO, orgBndItrdcImgPath );
		bndNo = brandService.updateBrand(brandBasePO, orgBndItrdcImgPath );
		model.addAttribute("bndNo", bndNo );

		return View.jsonView();
	}
*/
	/**
	* <pre>
	* - 프로젝트명	: 41.admin.web
	* - 파일명		: BrandController.java
	* - 작성일		: 2016. 5. 4.
	* - 작성자		: valueFactory
	* - 설명			: 브랜드 검색 Layer
	* </pre>
	* @param model
	* @param so
	* @return
	*/
	@RequestMapping("/brand/brandSearchLayerView.do")
	public String brandSearchLayerView (Model model, BrandBaseSO so ) {
		if(log.isDebugEnabled() ) {
			log.debug("==================================================");
			log.debug("= {}", "Brand Search");
			log.debug("==================================================");
		}

		model.addAttribute("brandBase", so );
		return "/brand/brandSearchLayerView";
	}

	/**
	 * 브랜드
	 * 카테고리 트리
	 */
	@ResponseBody
	@RequestMapping(value="/brand/brandDisplayTree.do", method=RequestMethod.POST)
	public List<DisplayBrandTreeVO> brandDisplayTree(BrandSO so) {
		List<DisplayBrandTreeVO> result = new ArrayList<>();
		List<CodeDetailVO> codeList = ServiceUtil.listCode(AdminConstants.DISP_CLSF);

		// 전시 목록 셋팅
		String dispClsfCd = StringUtils.isNotEmpty(so.getDispClsfCd()) ? so.getDispClsfCd() : AdminConstants.DISP_CLSF_40;
		if(CollectionUtils.isNotEmpty(codeList)) {
			for(CodeDetailVO code : codeList) {
				if(dispClsfCd.equals(code.getDtlCd())) {
					DisplayBrandTreeVO vo = new DisplayBrandTreeVO();
					vo.setId(code.getDtlCd());
					vo.setText(code.getDtlNm());
					vo.setParent("#");
					result.add(vo);
				}
			}
		}
		// 쿠폰등록일 경우 전체 전시대상이 선택되지 않은 상태로 트리를 만들어야 함
		if (so.getBndNo() == null) {
			final Long ALL = -1L;
			so.setBndNo(ALL);
		}
		result.addAll(brandService.listBrandDisplayTree(so) );

		return result;
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.brand.controller
	* - 파일명      : BrandController.java
	* - 작성일      : 2017. 2. 16.
	* - 작성자      : valuefctory 권성중
	* - 설명        : 브랜드 전시분류 리스트
	* </pre>
	 */
	@ResponseBody
	@RequestMapping(value="/brand/brandShowDispClsfGrid.do", method=RequestMethod.POST)
	public GridResponse brandShowDispClsfGrid (Model model, BrandBaseSO so ) {
		if (log.isDebugEnabled()) {
			log.debug("########## : {} ", so.toString());
		}

		Long bndNo = so.getBndNo();
		List<DisplayBrandTreeVO> list = brandService.listBrandShowDispClsf(bndNo );

		return new GridResponse(list, so);
	}

	/**
	 * 브랜드 상품 리스트
	 */
	@ResponseBody
	@RequestMapping(value="/brand/brandGoodsListGrid.do", method=RequestMethod.POST)
	public GridResponse brandGoodsListGrid(BrandGoodsSO so) {
		List<BrandGoodsVO> list = brandService.listBrandGoods(so);

		return new GridResponse(list, so);
	}

}

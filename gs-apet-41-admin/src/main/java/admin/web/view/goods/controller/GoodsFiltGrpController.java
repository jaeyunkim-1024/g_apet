package admin.web.view.goods.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.goods.model.GoodsFiltGrpPO;
import biz.app.goods.model.GoodsFiltGrpSO;
import biz.app.goods.model.GoodsFiltGrpVO;
import biz.app.goods.service.GoodsFiltGrpServiceImpl;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class GoodsFiltGrpController {

	@Autowired
	private GoodsFiltGrpServiceImpl goodsFiltGrpService;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CodeController.java
	 * - 작성일		: 2016. 3. 11.
	 * - 작성자		: valueFactory
	 * - 설명		: 공통 코드 시작 페이지
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/goods/filtListView.do")
	public String goodsFiltListView(Model model , GoodsFiltGrpSO so) {
		log.debug("================================");
		log.debug("= {}", "상품 필터 시작 페이지");
		log.debug("================================");
		GoodsFiltGrpVO data = goodsFiltGrpService.createAutoSearchKeyWord(so);
		model.addAttribute("filtGrpMngNms",data.getFiltGrpMngNms());
		model.addAttribute("filtGrpShowNms",data.getFiltGrpShowNms());

		return "/goods/goodsFiltListView";
	}

	@ResponseBody
	@RequestMapping( value="/goods/getFiltGrpList.do", method=RequestMethod.POST)
	public GridResponse getFiltGrpList(Model model, GoodsFiltGrpSO so) {
//		so.setSidx("GRP.FILT_GRP_MNG_NM");
//		so.setSord("ASC");
		List<GoodsFiltGrpVO> list = goodsFiltGrpService.getFiltGrpList(so);
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("상품 그룹 리스트 조회 : {}", list.size() );
			log.debug("==================================================");
		}
		return new GridResponse(list, so);
	}

	@RequestMapping("/goods/filtGrpInfoView.do")
	public String getFiltGrpInfo(Model model, GoodsFiltGrpSO so, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		GoodsFiltGrpVO vo = goodsFiltGrpService.getFiltGrpInfo(so);
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("상품 그룹 조회 : {}", (vo != null ? vo.toString() : null) );
			log.debug("==================================================");
		}
		model.addAttribute("codeGroup", vo );
		return "/goods/goodsFiltGrpView";
	}

	@RequestMapping( value="/goods/filtGrpInsert.do", method= RequestMethod.POST )
	public String filtGrpInsert(Model model, GoodsFiltGrpPO po, BindingResult br) {

		po.setSysRegrNo(AdminSessionUtil.getSession().getUsrNo());
		po.setSysRegDtm(DateUtil.getTimestamp());
		int filtGrpNo = goodsFiltGrpService.insertFiltGrp(po);
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("상품 그룹 등록 : {}", filtGrpNo );
			log.debug("==================================================");
		}

		model.addAttribute("filtGrpNo", filtGrpNo );
		return View.jsonView();
	}

	@RequestMapping( value="/goods/filtGrpUpdate.do", method= RequestMethod.POST )
	public String filtGrpUpdate(Model model, GoodsFiltGrpPO po, BindingResult br) {

		po.setSysUpdrNo(AdminSessionUtil.getSession().getUsrNo());
		po.setSysUpdDtm(DateUtil.getTimestamp());
		int filtGrpNo = goodsFiltGrpService.updateFiltGrp(po);
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("상품 그룹 수정 : {}", filtGrpNo );
			log.debug("==================================================");
		}

		model.addAttribute("filtGrpNo", filtGrpNo );
		return View.jsonView();
	}

	@RequestMapping( value="/goods/filtGrpDelete.do", method= RequestMethod.POST )
	public String filtGrpDelete(Model model, GoodsFiltGrpPO po, BindingResult br) {

		int filtGrpNo = goodsFiltGrpService.deleteFiltGrp(po);
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("상품 그룹 삭제 : {}", filtGrpNo );
			log.debug("==================================================");
		}

		model.addAttribute("filtGrpNo", filtGrpNo );
		return View.jsonView();
	}
	
	/**
	* <pre>
	* - 프로젝트명	: gs-apet-41-admin
	* - 파일명	: GoodsFiltGrpController.java
	* - 작성일	: 2020. 12. 29.
	* - 작성자 	: valfac
	* - 설명 		: 필터 조회
	* </pre>
	*
	* @param so
	* @return
	*/
	@ResponseBody
	@RequestMapping(value = "/goods/searchGoodsFiltList.do", method = RequestMethod.POST)
	public List<GoodsFiltGrpVO> searchGoodsFiltList(GoodsFiltGrpSO so) {

		List<GoodsFiltGrpVO> filtList = goodsFiltGrpService.listFilt(so); 

		return filtList;
	}

}

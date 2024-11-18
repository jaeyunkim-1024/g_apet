package admin.web.view.goods.controller;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.goods.model.*;
import biz.app.goods.service.GoodsFiltAttrServiceImpl;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 *
 */
@Slf4j
@Controller
public class GoodsFiltAttrController {

	@Autowired
	private GoodsFiltAttrServiceImpl goodsFiltAttrService;

	@ResponseBody
	@RequestMapping(value="/goods/getFiltAttrList.do", method=RequestMethod.POST)
	public GridResponse goodsFiltListView(Model model , GoodsFiltAttrSO so) {
//		so.setSidx("ATTR.FILT_ATTR_NM");
//		so.setSord("ASC");

		List<GoodsFiltAttrVO> list = goodsFiltAttrService.getFiltAttrList(so);
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("상품 그룹 속성 리스트 조회 : {}", list.size() );
			log.debug("==================================================");
		}

		return new GridResponse(list, so);
	}

	@RequestMapping("/goods/filtAttrInfoView.do")
	public String getFiltAttrInfo(Model model, GoodsFiltAttrSO so, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		GoodsFiltAttrVO vo = goodsFiltAttrService.getFiltAttrInfo(so);
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("상품 그룹 속성 조회 : {}", (vo != null ? vo.toString() : null) );
			log.debug("==================================================");
		}
		model.addAttribute("codeDetail", vo );
		model.addAttribute("codeDetailSo", so );
		return "/goods/goodsFiltAttrView";
	}

	@RequestMapping( value="/goods/filtAttrInsert.do", method= RequestMethod.POST )
	public String filtAttrInsert(Model model, GoodsFiltAttrPO po, BindingResult br) {

		po.setSysRegrNo(AdminSessionUtil.getSession().getUsrNo());
		po.setSysRegDtm(DateUtil.getTimestamp());
		int filtAttrNo = goodsFiltAttrService.insertFiltAttr(po);
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("상품 그룹 속성등록 : {}", filtAttrNo );
			log.debug("==================================================");
		}

		model.addAttribute("filtAttrNo", filtAttrNo );
		return View.jsonView();
	}

	@RequestMapping( value="/goods/filtAttrUpdate.do", method= RequestMethod.POST )
	public String filtAttrUpdate(Model model, GoodsFiltAttrPO po, BindingResult br) {

		po.setSysUpdrNo(AdminSessionUtil.getSession().getUsrNo());
		po.setSysUpdDtm(DateUtil.getTimestamp());
		int filtAttrNo = goodsFiltAttrService.updateFiltAttr(po);
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("상품 그룹 속성수정 : {}", filtAttrNo );
			log.debug("==================================================");
		}

		model.addAttribute("filtAttrNo", filtAttrNo );
		return View.jsonView();
	}

	@RequestMapping( value="/goods/filtAttrDelete.do", method= RequestMethod.POST )
	public String filtAttrDelete(Model model, GoodsFiltAttrPO po, BindingResult br) {

		int filtAttrNo = goodsFiltAttrService.deleteFiltAttr(po);
		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("상품 그룹 속성삭제 : {}", filtAttrNo );
			log.debug("==================================================");
		}

		model.addAttribute("filtAttrNo", filtAttrNo );
		return View.jsonView();
	}

}

package admin.web.view.system.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.system.model.DeliverAreaSetPO;
import biz.app.system.model.DeliverAreaSetSO;
import biz.app.system.model.DeliverAreaSetVO;
import biz.app.system.model.ZipcodeMappingPO;
import biz.app.system.model.ZipcodeMappingSO;
import biz.app.system.model.ZipcodeMappingVO;
import biz.app.system.service.DirectDeliverAreaService;
import framework.admin.util.JsonUtil;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.StringUtil;

/**
 * 네이밍 룰
 * 업무명View		:	화면
 * 업무명Grid		:	그리드
 * 업무명Tree		:	트리
 * 업무명Insert		:	입력
 * 업무명Update		:	수정
 * 업무명Delete		:	삭제
 * 업무명Save		:	입력 / 수정
 * 업무명ViewPop	:	화면팝업
 */

@Controller
public class DirectDeliverAreaController {

	@Autowired
	private DirectDeliverAreaService directrDeliverAreaService;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DirectrDeliverAreaController.java
	 * - 작성일		: 2016. 5. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 직배송지역 화면
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/system/directDeliverAreaView.do")
	public String directDeliverAreaView(Model model) {
		return "/system/directDeliverAreaView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DirectDeliverAreaController.java
	 * - 작성일		: 2016. 6. 1.
	 * - 작성자		: valueFactory
	 * - 설명		: 직배송지역 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/system/directDeliverAreaListGrid.do", method=RequestMethod.POST)
	public GridResponse directDeliverAreaListGrid(DeliverAreaSetSO so) {
		List<DeliverAreaSetVO> list = directrDeliverAreaService.listDirectDeliverArea(so);

		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DirectDeliverAreaController.java
	 * - 작성일		: 2016. 6. 2.
	 * - 작성자		: valueFactory
	 * - 설명		: 직배송지역 삭제
	 * </pre>
	 * @param model
	 * @param directDeliverAreaPOListStr
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/system/directDeliverAreaDelete.do")
	public String directDeliverAreaDelete(Model model, @RequestParam("directDeliverAreaPOList") String directDeliverAreaPOListStr) {
		JsonUtil jsonUt = new JsonUtil();
		DeliverAreaSetPO deliverAreaSetPO = new DeliverAreaSetPO();

		if(StringUtil.isNotEmpty(directDeliverAreaPOListStr)) {
			List<DeliverAreaSetPO> directDeliverAreaPOList = jsonUt.toArray(DeliverAreaSetPO.class, directDeliverAreaPOListStr);
			deliverAreaSetPO.setDirectDeliverAreaPOList(directDeliverAreaPOList);
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		directrDeliverAreaService.deleteDirectDeliverArea(deliverAreaSetPO);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DirectDeliverAreaController.java
	 * - 작성일		: 2016. 6. 1.
	 * - 작성자		: valueFactory
	 * - 설명		: 직배송지역 추가/수정 팝업
	 * </pre>
	 * @param model
	 * @param po
	 * @param so
	 * @return
	 */
	@RequestMapping("/system/directDeliverAreaViewPop.do")
	public String directDeliverAreaViewPop(Model model, @ModelAttribute("directDeliverAreaResult") DeliverAreaSetPO po, DeliverAreaSetSO so) {
		if(so.getAreaId() != null) {
			model.addAttribute("directDeliverArea",  directrDeliverAreaService.listDirectDeliverArea(so));
		}

		return "/system/directDeliverAreaViewPop";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DirectDeliverAreaController.java
	 * - 작성일		: 2016. 6. 1.
	 * - 작성자		: valueFactory
	 * - 설명		: 창고 검색 팝업
	 * </pre>
	 * @param model
	 * @param po
	 * @param so
	 * @return
	 */
	@RequestMapping("/system/wareHouseViewPop.do")
	public String wareHouseViewPop(Model model, @ModelAttribute("directDeliverAreaResult") DeliverAreaSetPO po, DeliverAreaSetSO so) {
		return "/system/wareHouseViewPop";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DirectDeliverAreaController.java
	 * - 작성일		: 2016. 6. 2.
	 * - 작성자		: valueFactory
	 * - 설명		: 창고 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/system/wareHouseListGrid.do", method=RequestMethod.POST)
	public GridResponse wareHouseListGrid(DeliverAreaSetSO so) {
		List<DeliverAreaSetVO> list = directrDeliverAreaService.listWareHouse(so);

		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DirectDeliverAreaController.java
	 * - 작성일		: 2016. 6. 2.
	 * - 작성자		: valueFactory
	 * - 설명		: 직배송지역 추가/수정
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/system/directDeliverAreaSave.do")
	public String directDeliverAreaSave(Model model, DeliverAreaSetPO po) {
		directrDeliverAreaService.saveDirectDeliverArea(po);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DirectDeliverAreaController.java
	 * - 작성일		: 2016. 6. 3.
	 * - 작성자		: valueFactory
	 * - 설명		: 등록지역 수정 팝업(우편번호)
	 * </pre>
	 * @param model
	 * @param po
	 * @param so
	 * @return
	 */
	@RequestMapping("/system/deliverAreaZipCodeViewPop.do")
	public String deliverAreaZipCodeViewPop(Model model, @ModelAttribute("zipCodeResult") ZipcodeMappingPO po, ZipcodeMappingSO so) {
		DeliverAreaSetSO deliverAreaSetSO = new DeliverAreaSetSO();

		// 직배송 지역 리스트
		model.addAttribute("deliverArea", directrDeliverAreaService.listDirectDeliverArea(deliverAreaSetSO));

		return "/system/deliverAreaZipCodeViewPop";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DirectDeliverAreaController.java
	 * - 작성일		: 2016. 6. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 우편번호 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/system/zipCodeListGrid.do", method=RequestMethod.POST)
	public GridResponse zipCodeListGrid(ZipcodeMappingSO so) {
		List<ZipcodeMappingVO> list = directrDeliverAreaService.iistZipCodeGrid(so);

		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DirectDeliverAreaController.java
	 * - 작성일		: 2016. 6. 8.
	 * - 작성자		: valueFactory
	 * - 설명		: 직배송 지역 저장
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("/system/deliverAreaZipCodeSave.do")
	public String deliverAreaZipCodeSave(Model model, @RequestParam("zipCodePOList") String zipCodePOListStr) {
		JsonUtil jsonUt = new JsonUtil();
		ZipcodeMappingPO zipcodeMappingPO = new ZipcodeMappingPO();

		if(StringUtil.isNotEmpty(zipCodePOListStr)) {
			List<ZipcodeMappingPO> zipCodePOList = jsonUt.toArray(ZipcodeMappingPO.class, zipCodePOListStr);
			zipcodeMappingPO.setZipCodePOList(zipCodePOList );
		} else {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		directrDeliverAreaService.saveDeliverAreaZipCode(zipcodeMappingPO);

		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: DirectDeliverAreaController.java
	 * - 작성일		: 2016. 6. 9.
	 * - 작성자		: valueFactory
	 * - 설명		: 신우편번호 추가
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/system/deliverAreaZipCodeInsert.do")
	public String deliverAreaZipCodeInsert(Model model, ZipcodeMappingPO po) {
		directrDeliverAreaService.insertDeliverAreaZipCode(po);

		return View.jsonView();
	}
}
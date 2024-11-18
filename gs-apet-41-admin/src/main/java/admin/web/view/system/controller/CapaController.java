package admin.web.view.system.controller;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import admin.web.config.view.View;
import biz.app.system.model.DeliverAreaSetSO;
import biz.app.system.model.DeliverAreaSetVO;
import biz.app.system.model.DeliverDateSetPO;
import biz.app.system.model.DeliverDateSetSO;
import biz.app.system.model.DeliverDateSetVO;
import biz.app.system.model.HolidayPO;
import biz.app.system.model.HolidaySO;
import biz.app.system.model.HolidayVO;
import biz.app.system.service.CapaService;
import biz.app.system.service.DirectDeliverAreaService;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;

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
public class CapaController {

	@Autowired
	private CapaService capaService;

	@Autowired
	private DirectDeliverAreaService directrDeliverAreaService;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CapaMgmtController.java
	 * - 작성일		: 2016. 5. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 케파관리 화면
	 * </pre>
	 * @param model
	 * @return
	 */
	@RequestMapping("/system/capitalCapaView.do")
	public String capitalCapaView() {
		return "/system/capitalCapaView";
	}

	@RequestMapping("/system/countryCapaView.do")
	public String countryCapaView() {
		return "/system/countryCapaView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CapaMgmtController.java
	 * - 작성일		: 2016. 5. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 케파관리 리스트
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/system/capaCalendar.do")
	public String capaCalendar(Model model, HolidaySO holidaySO, DeliverDateSetSO deliverDateSetSO, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		List<DeliverDateSetVO> deliverDateSetList = capaService.listCalendarDeliverDateSet(deliverDateSetSO);
		List<HolidayVO> holidayList = capaService.listHolidayCalendar(holidaySO);
		model.addAttribute("holidayList", holidayList);
		model.addAttribute("deliverDateSetList", deliverDateSetList);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CapaController.java
	 * - 작성일		: 2016. 6. 17.
	 * - 작성자		: valueFactory
	 * - 설명		: 케파관리 환경 설정
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/system/capaSettingLayerView.do")
	public String capaMgmtLayerView(Model model, DeliverAreaSetSO so) {
		model.addAttribute("listDirectDeliverArea", directrDeliverAreaService.listDirectDeliverArea(so));
		return "/system/capaSettingLayerView";
	}

	@RequestMapping("/system/capaLayerView.do")
	public String capaLayerView(Model model, DeliverAreaSetSO deliverAreaSetSO, HolidaySO holidaySO, DeliverDateSetSO deliverDateSetSO, BindingResult br) {
		model.addAttribute("holiday", capaService.getHolidayCalendar(holidaySO));

		List<DeliverAreaSetVO> listDirectDeliverArea = directrDeliverAreaService.listDirectDeliverArea(deliverAreaSetSO);
		model.addAttribute("listDirectDeliverArea", listDirectDeliverArea);

		if(CollectionUtils.isNotEmpty(listDirectDeliverArea)) {
			deliverDateSetSO.setAreaId(listDirectDeliverArea.get(0).getAreaId());
			model.addAttribute("deliverDateSet", capaService.getCalendarDeliverDateSet(deliverDateSetSO));
		}

		return "/system/capaLayerView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: CapaController.java
	 * - 작성일		: 2016. 6. 17.
	 * - 작성자		: valueFactory
	 * - 설명		: 케파 관리 등록
	 * </pre>
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/deliverDateSetSettingSave.do")
	public String deliverDateSetSettingSave(Model model, DeliverDateSetPO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		capaService.saveDeliverDateSetSetting(po);

		return View.jsonView();
	}

	@RequestMapping("/system/deliverDateSetResult.do")
	public String deliverDateSetResult(Model model, DeliverDateSetSO so, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		model.addAttribute("deliverDateSet", capaService.getCalendarDeliverDateSet(so));
		return View.jsonView();
	}

	@RequestMapping("/system/deliverDateSetHolidaySave.do")
	public String deliverDateSetHolidaySave(Model model, DeliverDateSetPO deliverDateSetPO, HolidayPO holidayPO, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		capaService.saveDeliverDateSetHoliday(deliverDateSetPO, holidayPO);
		return View.jsonView();
	}

}
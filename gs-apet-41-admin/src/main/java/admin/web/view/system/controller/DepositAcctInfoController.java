package admin.web.view.system.controller;

 
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
import biz.app.system.model.DepositAcctInfoPO;
import biz.app.system.model.DepositAcctInfoSO;
import biz.app.system.model.DepositAcctInfoVO;
import biz.app.system.service.DepositAcctInfoService;
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
 * 업무명ViewPop		:	화면팝업
 */

 
@Controller
public class DepositAcctInfoController {

	/**
	 * 무통장 계좌 서비스 
	 */
	@Autowired
	private DepositAcctInfoService depositAcctInfoService;
 
	
	
	/**
	 *  무통장 계좌 목록화면 
	 * @return
	 */
	@RequestMapping("/system/depositAcctInfoListView.do")
	public String depositAcctInfoListView() {
		return "/system/depositAcctInfoListView";
	}
	
	
	/**
	 *  무통장 계좌 목록 그리드
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/system/depositAcctInfoListGrid.do", method=RequestMethod.POST)
	public GridResponse depositAcctInfoListGrid(DepositAcctInfoSO so) {
		List<DepositAcctInfoVO> list = depositAcctInfoService.pageDepositAcctInfo(so);
		return new GridResponse(list, so);
	}
 
	/**
	 *  무통장 계좌 상세화면 
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/system/depositAcctInfoView.do")
	public String depositAcctInfoView(Model model, DepositAcctInfoSO so) {
		if(so.getAcctInfoNo() != null) {
			model.addAttribute("depositAcctInfo", depositAcctInfoService.getDepositAcctInfo(so));
		}
		
		return "/system/depositAcctInfoView";
	}

	/**
	 *  무통장 계좌 등록
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/depositAcctInfoInsert.do")
	public String depositAcctInfoInsert(Model model, DepositAcctInfoPO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		depositAcctInfoService.insertDepositAcctInfo(po);
		model.addAttribute("depositAcctInfo", po);
		
		return View.jsonView();
	}

	/**
	 * 무통장 계좌 수정 
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/depositAcctInfoUpdate.do")
	public String depositAcctInfoUpdate(Model model, DepositAcctInfoPO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		depositAcctInfoService.updateDepositAcctInfo(po);
		model.addAttribute("depositAcctInfo", po);
		return View.jsonView();
	}
	/**
	 * 무통장 계좌 삭제 
	 * @param model
	 * @param po
	 * @param br
	 * @return
	 */
	@RequestMapping("/system/depositAcctInfoDelete.do")
	public String couponDelete(Model model, DepositAcctInfoPO po, BindingResult br) {
		if (br.hasErrors()) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		depositAcctInfoService.deleteDepositAcctInfo(po);
		return View.jsonView();
	}
 
	
}
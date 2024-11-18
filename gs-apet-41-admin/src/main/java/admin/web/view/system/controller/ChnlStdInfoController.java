package admin.web.view.system.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.system.model.ChnlStdInfoPO;
import biz.app.system.model.ChnlStdInfoSO;
import biz.app.system.model.ChnlStdInfoVO;
import biz.app.system.service.ChnlStdInfoService;

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
 * - 패키지명	: admin.web.view.system.controller
 * - 파일명		: ChnlStdInfoController.java
* - 작성일		: 2017. 2. 22.
* - 작성자		: hongjun
 * - 설명		: 채널 기준 정보
 * </pre>
 */
@Controller
public class ChnlStdInfoController {

	/**
	 * 채널 기준 정보 서비스
	 */
	@Autowired
	private ChnlStdInfoService chnlStdInfoService;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ChnlStdInfoController.java
	* - 작성일		: 2017. 2. 22.
	* - 작성자		: hongjun
	 * - 설명		: 채널 기준 정보 목록 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/system/chnlStdInfoListView.do")
	public String chnlStdInfoListView() {
		return "/system/chnlStdInfoListView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ChnlStdInfoController.java
	* - 작성일		: 2017. 2. 22.
	* - 작성자		: hongjun
	 * - 설명		: 채널 기준 정보 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/system/chnlStdInfoListGrid.do", method=RequestMethod.POST)
	public GridResponse chnlStdInfoListGrid(ChnlStdInfoSO so) {
		List<ChnlStdInfoVO> list = chnlStdInfoService.pageChnlStdInfo(so);
		return new GridResponse(list, so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ChnlStdInfoController.java
	* - 작성일		: 2017. 2. 22.
	* - 작성자		: hongjun
	 * - 설명		: 채널 기준 정보 상세 화면
	 * </pre>
	 * @param model
	 * @param so
	 * @return
	 */
	@RequestMapping("/system/chnlStdInfoView.do")
	public String chnlStdInfoView(Model model, ChnlStdInfoSO so) {
		if(so.getChnlId() != null) {
			model.addAttribute("chnlStdInfo", chnlStdInfoService.pageChnlStdInfo(so).get(0));
		}
		
		return "/system/chnlStdInfoView";
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ChnlStdInfoController.java
	* - 작성일		: 2017. 2. 22.
	* - 작성자		: hongjun
	 * - 설명		: 채널 기준 정보 등록
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/system/chnlStdInfoInsert.do")
	public String chnlStdInfoInsert(Model model, ChnlStdInfoPO po) {
		chnlStdInfoService.insertChnlStdInfo(po);
		model.addAttribute("chnlStdInfo", po);
		
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ChnlStdInfoController.java
	* - 작성일		: 2017. 2. 22.
	* - 작성자		: hongjun
	 * - 설명		: 채널 기준 정보 수정
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/system/chnlStdInfoUpdate.do")
	public String chnlStdInfoUpdate(Model model, ChnlStdInfoPO po) {
		chnlStdInfoService.updateChnlStdInfo(po);
		model.addAttribute("chnlStdInfo", po);
		return View.jsonView();
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ChnlStdInfoController.java
	* - 작성일		: 2017. 2. 22.
	* - 작성자		: hongjun
	 * - 설명		: 채널 기준 정보 삭제
	 * </pre>
	 * @param model
	 * @param po
	 * @return
	 */
	@RequestMapping("/system/chnlStdInfoDelete.do")
	public String chnlStdInfoDelete(Model model, ChnlStdInfoPO po) {
		chnlStdInfoService.deleteChnlStdInfo(po);
		return View.jsonView();
	}
	
}
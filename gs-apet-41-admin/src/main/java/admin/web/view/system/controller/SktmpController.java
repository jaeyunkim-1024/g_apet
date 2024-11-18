package admin.web.view.system.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import biz.interfaces.sktmp.model.SktmpLnkHistSO;
import biz.interfaces.sktmp.model.SktmpLnkHistVO;
import biz.interfaces.sktmp.service.SktmpService;


/**
 * <pre>
 * - 프로젝트명	: gs-apet-41-admin
 * - 패키지명	: admin.web.view.system.controller
 * - 파일명		: SktmpController.java
 * - 작성일		: 2021. 07. 23.
 * - 작성자		: JinHong
 * - 설명		: 우주코인 SKTMP Controller
 * </pre>
 */
@Controller
public class SktmpController {

	@Autowired SktmpService sktmpService;

	@Autowired private MessageSourceAccessor message;

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.system.controller
	 * - 작성일		: 2021. 07. 23.
	 * - 작성자		: JinHong
	 * - 설명		: 우주코인 연동이력 검색 화면
	 * </pre>
	 * @return
	 */
	@RequestMapping("/system/sktmpLinkedHistroyListView.do")
	public String sktmpLinkedHistroyListView() {
		return "/system/sktmpLinkedHistroyListView";
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.system.controller
	 * - 작성일		: 2021. 07. 23.
	 * - 작성자		: JinHong
	 * - 설명		: 우주코인 연동이력 그리드 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/system/sktmpLinkedHistoryGrid.do")
	public GridResponse sktmpLinkedHistoryGrid(SktmpLnkHistSO so){
		List<SktmpLnkHistVO> list = sktmpService.pageSktmpLnkHist(so);
		return new GridResponse(list,so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-41-admin
	 * - 파일명		: admin.web.view.system.controller
	 * - 작성일		: 2021. 08. 24.
	 * - 작성자		: JinHong
	 * - 설명		: 에러 처리 재전송
	 * </pre>
	 * @param so
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/system/reReqSktmpLnkHist.do")
	public SktmpLnkHistVO reReqSktmpLnkHist(SktmpLnkHistSO so){
		SktmpLnkHistVO vo = sktmpService.reReqSktmpLnkHist(so);
		return vo;
	}
	
}
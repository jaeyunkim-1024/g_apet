package admin.web.view.system.controller;

import admin.web.config.grid.GridResponse;
import biz.interfaces.gsr.model.GsrLnkHistSO;
import biz.interfaces.gsr.model.GsrLnkHistVO;
import biz.interfaces.gsr.service.GsrService;
import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

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
public class GsrController {

	@Autowired GsrService gsrService;

	@Autowired private MessageSourceAccessor message;

	@RequestMapping("/system/gsrLinkedHistroyListView.do")
	public String gsrLinkedHistoryListView() {
		return "/system/gsrLinkedHistoryList";
	}
	
	@ResponseBody
	@RequestMapping("/system/gsrLinkedHistoryGrid.do")
	public GridResponse gsrLinkedHistoryGrid(GsrLnkHistSO so){
		so.setSidx("SYS_REG_DTM");
		so.setSord("DESC");
		List<GsrLnkHistVO> list = gsrService.gsrLinkedHistoryGrid(so);
		for(GsrLnkHistVO vo : list){
			if(StringUtil.equals(vo.getRstCd(), CommonConstants.GSR_RST_OK[0])){
				vo.setRstMsg("성공");
			}else{
				vo.setRstMsg(message.getMessage("business.exception."+vo.getRstCd()));
			}
		}
		return new GridResponse(list,so);
	}
	
}
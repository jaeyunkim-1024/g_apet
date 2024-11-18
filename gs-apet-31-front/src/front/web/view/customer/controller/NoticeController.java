package front.web.view.customer.controller;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import biz.app.counsel.service.CounselService;
import biz.app.system.model.BbsLetterSO;
import biz.app.system.model.BbsLetterVO;
import biz.app.system.service.BoardService;
import biz.common.model.AttachFilePO;
import biz.common.model.AttachFileSO;
import biz.common.model.AttachFileVO;
import biz.common.service.BizService;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import framework.front.model.Session;
import front.web.config.constants.FrontWebConstants;
import front.web.config.view.ViewBase;
import lombok.extern.slf4j.Slf4j;


/**
* <pre>
* - 프로젝트명	: 31.front.web
* - 패키지명		: front.web.view.customer.controller
* - 파일명		: NoticeController.java
* - 작성일		: 2017. 4. 20.
* - 작성자		: Administrator
* - 설명			: 고객센터 공지사항 Controller
* </pre>
*/
@Slf4j
@Controller
@RequestMapping("customer/notice")
public class NoticeController {
	@Autowired private CacheService cacheService;
	@Autowired private BoardService boardService;
	@Autowired private CounselService counselService;
	@Autowired private BizService bizService;
	/**
	* <pre>
	* - 프로젝트명	: 31.front.web
	* - 파일명		: MyCcController.java
	* - 작성일		: 2016. 4. 6.
	* - 작성자		: snw
	* - 설명		: 공지사항 목록 화면
	* </pre>
	* @param map
	* @param so
	* @param session
	* @param view
	* @return
	* @throws Exception
	*/
	@RequestMapping(value="indexNoticeList")
	public String indexNoticeList(Model model, Session session , ViewBase view , Integer page){
		String url;
		BbsLetterSO so = new BbsLetterSO();
		so.setBbsId("dwNotice");
		so.setBbsStatCd(CommonConstants.BBS_STAT_SHOW);
		so.setSiteGubun("FO");
		
		if(StringUtil.isEmpty(page)) {
			url = "customer/indexNoticeList";
		}else {
			url = "customer/indexNoticeListPaging";
			so.setPage(page);
		}
		
		List<BbsLetterVO> list = boardService.pageBbsLetter(so);
		
		String today = DateUtil.getNowDate();
		
		for(Iterator<BbsLetterVO> it = list.iterator() ; it.hasNext() ;) {
			BbsLetterVO vo = it.next();
			String stringRegDtm = DateUtil.timeStamp2Str(vo.getSysRegDtm(), "yyyyMMdd");
			int regYear = Integer.valueOf(stringRegDtm.substring(0,4));
			int todayYear = Integer.valueOf(today.substring(0,4));
			int intervalDay = DateUtil.intervalDay(today, stringRegDtm) + ((regYear - todayYear) * 365);
			
			if(StringUtil.isNotEmpty(vo.getBbsGbNo())) {
				vo.setStringRegDtm(stringRegDtm);
				vo.setIntervalDay(intervalDay);
				// 일반 공지사항일 경우
				if(StringUtil.equals(String.valueOf(vo.getBbsGbNm()) , CommonConstants.BBS_GB_NM_NOTICE)){
					vo.setBbsGbNm(null);
				// 입점 제휴 문의 일 경우
				}else if(StringUtil.equals(String.valueOf(vo.getBbsGbNm()), CommonConstants.BBS_GB_NM_PARTNER)){
					AttachFileSO fileSO = new AttachFileSO();
					fileSO.setFlNo(vo.getFlNo());
					List<AttachFileVO> attachFileList = bizService.listAttachFile(fileSO);
					if(attachFileList.size() > 0 ) {
						vo.setFilePath(attachFileList.get(attachFileList.size()-1).getPhyPath());
						vo.setFileName(attachFileList.get(attachFileList.size()-1).getOrgFlNm());
					}
					vo.setBbsGbNm(null);
					model.addAttribute("partner" , vo);
					it.remove();
				// 장애 , 긴급 공지일 경우	
				}else {
					vo.setBbsGbNm("[" +vo.getBbsGbNm().substring(0 , 2) + "]");
				}
			}
		}
		
		view.setSeoSvcGbCd(FrontWebConstants.SEO_SVC_GB_CD_40);
		model.addAttribute("session" , session);
		model.addAttribute("view" , view);
		model.addAttribute("noticeList", list);
		return url;
	}
	
	//입점제휴문의 팝업 
	@RequestMapping(value="indexPartnerNoticeList")
	public String indexPartnerNoticeList(Model model, Session session , ViewBase view , Integer page){
		String url;
		BbsLetterSO so = new BbsLetterSO();
		so.setBbsGbNm(CommonConstants.BBS_GB_NM_PARTNER);
		so.setTtl(CommonConstants.BBS_GB_NM_PARTNER_INFO);
		so.setBbsId("dwNotice");
		so.setBbsStatCd(CommonConstants.BBS_STAT_SHOW);
		so.setSiteGubun("FO");
		
		//게시글 목록 & 파일path,name 조회 
		BbsLetterVO data = boardService.getBbsPopupDetail(so);
		
		String stringRegDtm = DateUtil.timeStamp2Str(data.getSysRegDtm(), "yyyyMMdd");
		data.setStringRegDtm(stringRegDtm);
		
		model.addAttribute("notice", data);
		
		return "introduce/indexPartnerApply";
	}
}
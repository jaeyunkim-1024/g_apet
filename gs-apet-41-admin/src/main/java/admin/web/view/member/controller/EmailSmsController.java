package admin.web.view.member.controller;

import java.lang.reflect.InvocationTargetException;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import admin.web.config.grid.GridResponse;
import admin.web.config.view.View;
import biz.app.sms.service.SmsHistService;
import biz.app.st.model.StStdInfoSO;
import biz.app.st.service.StService;
import biz.common.model.EmSmtLogSO;
import biz.common.model.EmSmtLogVO;
import biz.common.model.EmailSend;
import biz.common.model.EmailSendMap;
import biz.common.model.LmsSendPO;
import biz.common.model.SmsSendPO;
import biz.common.service.BizService;
import framework.admin.constants.AdminConstants;
import framework.admin.util.JsonUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;


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
@Slf4j
@Controller
public class EmailSmsController {

	@Autowired
	private BizService bizService;

	@Autowired private SmsHistService smsHistService;

	@Autowired private StService stService;

	@RequestMapping("/member/emailSmsListView.do")
	public String emailSmsListView() {
		return "/member/emailSmsListView";
	}

	@RequestMapping("/member/smsLayerView.do")
	public String smsLayerView(Model model, @RequestParam(value="arrSmsStr", required=false) String arrSmsStr) {

		if(StringUtil.isNotEmpty(arrSmsStr) ) {
			JsonUtil<SmsSendPO> jsonUt = new JsonUtil<>();
			List<SmsSendPO> list = jsonUt.toArray(SmsSendPO.class, arrSmsStr );
			model.addAttribute("listSms", list);
		}
		StStdInfoSO so  = new StStdInfoSO();
		so.setUseYn("Y");
		// 사이트 리스트 조회
		model.addAttribute("StStdInfoVOList", stService.pageStStdInfo(so));

		return "/member/smsLayerView";
	}

	@RequestMapping("/member/emailLayerView.do")
	public String emailLayerView(Model model, @RequestParam(value="arrEmailStr", required=false) String arrEmailStr) {

		if(StringUtil.isNotEmpty(arrEmailStr) ) {
			JsonUtil<EmailSend> jsonUt = new JsonUtil<>();
			List<EmailSend> list = jsonUt.toArray(EmailSend.class, arrEmailStr );
			model.addAttribute("listEmail", list);
		}

		return "/member/emailLayerView";
	}

	@RequestMapping("/member/smsListSend.do")
	public String smsListSend(Model model, SmsSendPO po, BindingResult br) {
		if ( br.hasErrors() ) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		int result =   0 ;
		//log.debug( "StringUtil.getByteLength( po.getMsg()  ) >>>>>>>> {}",  StringUtil.getByteLength( po.getMsg()  )  );
		//int result = bizService.sendSms(po);
		if ( StringUtil.getByteLength( po.getMsg()  )  <= 80  ){
			result = bizService.sendSms(po);
		}else{
			LmsSendPO lmsPO  = new LmsSendPO();
			try {
				BeanUtils.copyProperties(lmsPO, po);
				lmsPO.setSubject( StringUtil.cutText(lmsPO.getMsg() , 30, true) );
			} catch (IllegalAccessException | InvocationTargetException e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			}
			result = bizService.sendLms(lmsPO);
		}

		model.addAttribute("resultCode", result);
		String message = "";

		switch (result) {
			case -1:
				message = "예약시간 없습니다.";
				break;
			case -2:
				message = "예약시간 형식 오류 입니다.";
				break;
			case -3:
				message = "수신자정보가 없습니다.";
				break;
			case -4:
				message = "수신번호수와 수신자명수가 일치하지 않습니다.";
				break;
			case -5:
				message = "메세지를 입력해 주세요";
				break;
			default:
				message = "정상적으로 발송되었습니다.";
				break;
		}
		model.addAttribute("resultMessage", message);

		return View.jsonView();
	}

	@RequestMapping("/member/smsView.do")
	public String smsView() {
		return "/member/smsView";
	}

	@RequestMapping("/member/emailView.do")
	public String emailView() {
		return "/member/emailView";
	}

	@RequestMapping("/member/emailListSend.do")
	public String emailListSend(Model model
		, @RequestParam("emailTitle") String emailTitle
		, @RequestParam(value="emailContent", required=false) String emailContent
		, @RequestParam(value="arrEmailStr", required=false) String arrEmailStr) {

		 List<EmailSendMap> mapList = null;

		if(StringUtil.isNotEmpty(arrEmailStr) ) {
			JsonUtil<EmailSend> jsonUt = new JsonUtil<>();
			List<EmailSend> list = jsonUt.toArray(EmailSend.class, arrEmailStr );
			if(CollectionUtils.isNotEmpty(list)) {
				for(EmailSend email : list) {
					email.setEmailTpCd(AdminConstants.EMAIL_TP_110);
					email.setSubject(emailTitle);
					email.setContents(emailContent);
					this.bizService.sendEmail(email,mapList);
				}
			}
		}
		model.addAttribute("resultMessage", "정상적으로 발송되었습니다.");
		return View.jsonView();
	}


	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.member.controller
	* - 파일명      : EmailSmsController.java
	* - 작성일      : 2017. 6. 27.
	* - 작성자      : valuefactory 권성중
	* - 설명      :  SMS 발송 이력 조회
	* </pre>
	 */
	@RequestMapping("/emailSms/smsListView.do")
	public String smsListView(Model model) {
		 List<String> tableNames = smsHistService.getEmSmtLogTableName();
		 model.addAttribute("tableNames", tableNames);

		return "/member/smsListView";
	}

	/**
	 *
	* <pre>
	* - 프로젝트명   : 41.admin.web
	* - 패키지명   : admin.web.view.member.controller
	* - 파일명      : EmailSmsController.java
	* - 작성일      : 2017. 6. 27.
	* - 작성자      : valuefactory 권성중
	* - 설명      : SMS 발송 이력 조회 그리드
	* </pre>
	 */
	@ResponseBody
	@RequestMapping(value="/emailSms/smsListGrid.do")
	public GridResponse smsListGrid(EmSmtLogSO so) {

		if (log.isDebugEnabled()) {
			log.debug("==================================================");
			log.debug("= {}", "smsListGrid");
			log.debug("==================================================");
		}
		so.setRecipientNum(so.getRecipientNum().replaceAll("-", ""));
		List<EmSmtLogVO> list = smsHistService.pageEmSmtLogBase(so);
		return new GridResponse(list, so);
	}






}
package biz.app.counsel.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.appweb.dao.PushDao;
import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.counsel.dao.CounselDao;
import biz.app.counsel.dao.CounselProcessDao;
import biz.app.counsel.model.CounselPO;
import biz.app.counsel.model.CounselProcessPO;
import biz.app.counsel.model.CounselProcessSO;
import biz.app.counsel.model.CounselProcessVO;
import biz.app.counsel.model.CounselSO;
import biz.app.counsel.model.CounselVO;
import biz.app.member.dao.MemberBaseDao;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.st.dao.StDao;
import biz.app.st.model.StStdInfoVO;
import biz.common.model.EmailSend;
import biz.common.model.LmsSendPO;
import biz.common.model.PushTargetPO;
import biz.common.model.SendPushPO;
import biz.common.model.SmsSendPO;
import biz.common.service.BizService;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service("counselProcessService")
public class CounselProcessServiceImpl implements CounselProcessService {

	@Autowired
	private CounselDao counselDao;

	@Autowired
	private CounselProcessDao counselProcessDao;

	@Autowired
	private BizService bizService;

	@Autowired
	private MessageSourceAccessor messageSource;

	@Autowired
	private StDao stDao;
	
	@Autowired
	private PushDao pushDao;
	
	@Autowired
	private MemberBaseDao memberBaseDao;
	

	/*
	 * 상담 처리 목록 조회
	 * 
	 * @see
	 * biz.app.counsel.service.CounselProcessService#listCounselProcess(biz.app.
	 * counsel.model.CounselProcessSO)
	 */
	@Override
	public List<CounselProcessVO> listCounselProcess(CounselProcessSO so) {
		return this.counselProcessDao.listCounselProcess(so);
	}

	/*
	 * 상담 처리 등록
	 * 
	 * @see
	 * biz.app.counsel.service.CounselProcessService#insertCounselProcess(biz.app.
	 * counsel.model.CounselProcessPO, boolean)
	 */
	@Override
	public void insertCounselProcess(CounselProcessPO po, boolean lastPrcsYn) {
		int result = 0;

		Long prcsrNo = AdminSessionUtil.getSession().getUsrNo();

		/********************************
		 * 상담 처리
		 ********************************/
		/*
		 * 원 상담 내역 조회
		 */
		CounselSO cso = new CounselSO();
		cso.setCusNo(po.getCusNo());
		CounselVO counsel = this.counselDao.getCounsel(cso);

		/*
		 * 상담내역이 존재하는지 체크
		 */
		if (counsel == null) {
			throw new CustomException(ExceptionConstants.ERROR_COUNSEL_NO_DATA);
		}

		/*
		 * 완료된 건에 대해서는 처리내용 등록 불가
		 */
		/*
		 * if(CommonConstants.CUS_STAT_20.equals(counsel.getCusStatCd())){ throw new
		 * CustomException(ExceptionConstants.ERROR_COUNSEL_PROCESS_NO_INSERT); }
		 */
		

		/*
		 * 상담처리내역 등록
		 */
		po.setCusPrcsrNo(prcsrNo);

		// 회신 내용이 존재하지 않은 경우 회신 코드 null 처리
		if (po.getRplContent() == null || "".equals(po.getRplContent())) {
			po.setCusRplCd(null);
		}

		CounselProcessSO so = new CounselProcessSO();
		so.setCusNo(po.getCusNo());
		
		int count = this.checkCounselProcess(so);
		
		if(count > 0) {
			result = this.counselProcessDao.updateCounselProcess(po);
		} else {
			result = this.counselProcessDao.insertCounselProcess(po);
		}

		/*
		 * if (result != 1) { throw new
		 * CustomException(ExceptionConstants.ERROR_CODE_DEFAULT); }
		 */

		/*
		 * 웹 상담의 경우 처리내용이 1개만 등록 되므로 최종 완료 처리
		 */
		if (CommonConstants.CUS_PATH_10.equals(counsel.getCusPathCd())) {
			lastPrcsYn = true;
		}

		/*
		 * 최종 상담 처리인 경우 상담내역 완료 처리
		 */
		if (lastPrcsYn) {
			CounselPO cpo = new CounselPO();
			cpo.setCusNo(po.getCusNo());
			cpo.setCusCpltrNo(prcsrNo);
			result = this.counselDao.updateCounselComplete(cpo);

			if (result != 1) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
		}
		
		/*
		 * 1:1문의 알림 발송
		 */
		if(StringUtil.equals(po.getInfoRcvYn(), CommonConstants.COMM_YN_Y) && StringUtil.equals(po.getPstAgrYn(), CommonConstants.COMM_YN_Y)) {	//정보성 수신동의 Y이고 1:1문의 답변 알림 수신 여부가 Y일 경우
			MemberBaseSO mbso = new MemberBaseSO();
			mbso.setMbrNo(po.getEqrrMbrNo());
			MemberBaseVO mbvo = Optional.ofNullable(memberBaseDao.getMemberBase(mbso)).orElseGet(()-> new MemberBaseVO());
			
			if(!StringUtil.equals(mbvo.getMbrStatCd(), CommonConstants.MBR_STAT_50) && StringUtil.equals(mbvo.getInfoRcvYn(), CommonConstants.COMM_YN_Y) && mbvo.getMbrNo() != null) {
				PushSO pso = new PushSO();
				pso.setTmplNo(136L);
				PushVO template = Optional.ofNullable(pushDao.getNoticeTemplate(pso)).orElseGet(()->new PushVO());
				
				if(StringUtil.isNotBlank(template.getSubject()) && StringUtil.isNotBlank(template.getContents())) {
					List<PushTargetPO> ptpoList = new ArrayList<>();
					PushTargetPO ptpo = new PushTargetPO();
					
					ptpo.setTo(mbvo.getMbrNo().toString());
					ptpo.setImage(template.getImgPath());
					
					String movPath = StringUtil.replaceAll(template.getMovPath(), CommonConstants.PUSH_TMPL_VRBL_380 , String.valueOf(po.getCusNo()));
					ptpo.setLandingUrl(movPath);
					
					
					Map<String,String> map = new HashMap<String, String>();
					map.put(CommonConstants.PUSH_TMPL_VRBL_80, mbvo.getNickNm());
					ptpo.setParameters(map);
					ptpoList.add(ptpo);
					
					SendPushPO sppo = new SendPushPO();
					sppo.setTitle(template.getSubject());
					sppo.setMessageType("NOTIF");
					sppo.setType("USER");
					sppo.setTmplNo(pso.getTmplNo());
					sppo.setTarget(ptpoList);
					
					if(StringUtil.isNotEmpty(mbvo.getDeviceTpCd())) {
						if(mbvo.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_10)) {
							sppo.setDeviceType("GCM");
						} else if(mbvo.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_20)) {
							sppo.setDeviceType("APNS");
						}
					}
					
					String noticeSendNo = bizService.sendPush(sppo);
					
					if(noticeSendNo == "null") {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		}
		

		/*******************************************
		 * SMS 또는 Email발송
		 *******************************************/
		/*
		 * if(CommonConstants.CUS_PATH_10.equals(counsel.getCusPathCd())){
		 *//*********************
			 * 웹상담 E-mail 발송
			 *********************/
		/*
		 * EmailSend email = new EmailSend();
		 * email.setEmailTpCd(CommonConstants.EMAIL_TP_400);
		 * email.setStId(counsel.getStId()); email.setMbrNo(counsel.getEqrrMbrNo());
		 * email.setReceiverNm(counsel.getEqrrNm());
		 * email.setReceiverEmail(counsel.getEqrrEmail());
		 * email.setMap01(DateUtil.getTimestampToString(counsel.getCusAcptDtm(),
		 * "yyyy-MM-dd HH:mm")); email.setMap02(counsel.getContent());
		 * 
		 * String message = "";
		 * 
		 * if(StringUtil.isNotBlank(po.getRplHdContent())) { message =
		 * po.getRplHdContent(); message += "<br/>"; message += "<br/>"; }
		 * 
		 * message += po.getRplContent(); message = StringUtil.decodingHTML(message);
		 * 
		 * if(StringUtil.isNotBlank(po.getRplFtContent())) { message += "<br/>"; message
		 * += "<br/>"; message += po.getRplFtContent(); } email.setMap03(message);
		 * 
		 * this.bizService.sendEmail(email, null);
		 * 
		 * } else {
		 *//**********************
			 * CallCenter 상담 처리
			 **********************//*
									 * if(CommonConstants.CUS_RPL_10.equals(po.getCusRplCd())){ StStdInfoVO stInfo =
									 * this.stDao.getStStdInfo(counsel.getStId());
									 * 
									 * LmsSendPO lmspo = new LmsSendPO(); lmspo.setReceiveName( counsel.getEqrrNm()
									 * ); lmspo.setReceivePhone( counsel.getEqrrMobile() );
									 * lmspo.setSendPhone(stInfo.getCsTelNo()); lmspo.setSysRegrNo(prcsrNo); String
									 * message = "";
									 * 
									 * if(StringUtil.isNotBlank(po.getRplHdContent())) { message =
									 * po.getRplHdContent(); message += "\n"; }
									 * 
									 * message += po.getRplContent();
									 * 
									 * if(StringUtil.isNotBlank(po.getRplFtContent())) { message += "\n"; message +=
									 * po.getRplFtContent(); }
									 * 
									 * lmspo.setMsg(message);
									 * 
									 * if(StringUtil.getByteLength(message) > 80){ //String subject = "";
									 * 
									 * lmspo.setSubject("["+stInfo.getStNm()+"] 고객센터입니다.");
									 * log.debug(">>>>>>>>>>>>>lmspo2="+lmspo.toString());
									 * log.debug(">>>>>>>>>>>>>lmspo="+lmspo.getReceivePhone());
									 * this.bizService.sendLms(lmspo); }else{ SmsSendPO smspo = lmspo;
									 * log.debug(">>>>>>>>>>>>>smspo="+smspo.toString());
									 * this.bizService.sendSms(smspo); }
									 * 
									 * }else if(CommonConstants.CUS_RPL_20.equals(po.getCusRplCd())){ StStdInfoVO
									 * stInfo = this.stDao.getStStdInfo(counsel.getStId());
									 * 
									 * EmailSend email = new EmailSend();
									 * email.setReceiverEmail(counsel.getEqrrEmail());
									 * email.setReceiverNm(counsel.getEqrrNm());
									 * email.setEmailTpCd(CommonConstants.EMAIL_TP_110);
									 * email.setStId(counsel.getStId()); email.setMbrNo(counsel.getEqrrMbrNo());
									 * 
									 * String subject = "["+stInfo.getStNm()+"] 고객센터입니다."; String contents = "";
									 * 
									 * email.setSubject(subject);
									 * 
									 * // 내용 if(StringUtil.isNotBlank(po.getRplHdContent())) { contents =
									 * po.getRplHdContent(); contents += "<br/>"; contents += "<br/>"; }
									 * 
									 * contents += po.getRplContent(); contents = StringUtil.decodingHTML(contents);
									 * 
									 * if(StringUtil.isNotBlank(po.getRplFtContent())) { contents += "<br/>";
									 * contents += "<br/>"; contents += po.getRplFtContent(); }
									 * 
									 * email.setContents(contents);
									 * 
									 * this.bizService.sendEmail(email, null); }
									 * 
									 * 
									 * }
									 */

	}

	@Override
	public int checkCounselProcess(CounselProcessSO so) {
		return counselProcessDao.checkCounselProcess(so);
	}

	@Override
	public int updateCounselProcess(CounselProcessPO po) {
		Long prcsrNo = AdminSessionUtil.getSession().getUsrNo();
		po.setCusPrcsrNo(prcsrNo);
		return counselProcessDao.updateCounselProcess(po);
	}

}
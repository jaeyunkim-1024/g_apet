package biz.app.appweb.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.httpclient.util.DateUtil;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.appweb.dao.PushDao;
import biz.app.appweb.model.NoticeSendCommonVO;
import biz.app.appweb.model.NoticeSendListVO;
import biz.app.appweb.model.NoticeSendSO;
import biz.app.appweb.model.PushDetailPO;
import biz.app.appweb.model.PushPO;
import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberService;
import biz.app.st.model.StStdInfoVO;
import biz.app.st.service.StService;
import biz.common.model.EmailRecivePO;
import biz.common.model.EmailSendPO;
import biz.common.model.PushTargetPO;
import biz.common.model.SendPushPO;
import biz.common.model.SsgMessageSendPO;
import biz.common.service.BizService;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.FileUtil;
import framework.common.util.FtpImgUtil;
import framework.common.util.MaskingUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.service
 * - 파일명		: PushServiceImpl.java
 * - 작성일		: 2020. 12. 21. 
 * - 작성자		: hjh
 * - 설 명		: push/문자 발송 서비스
 * </pre>
 */
@Slf4j
@Service
@Transactional
public class PushServiceImpl implements PushService {
	@Autowired
	private PushDao pushDao;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BizService bizService;
	
	@Autowired
	private Properties bizConfig;
	
	@Autowired
	private StService stService;
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushServiceImpl.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<PushVO> pageNoticeSendList(PushSO so) {
		return pushDao.pageNoticeSendList(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushServiceImpl.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송현황 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public PushVO getPushMessage(PushSO so) {
		return pushDao.getPushMessage(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushServiceImpl.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송건수 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<PushVO> pageNoticeCnt(PushSO so) {
		List<PushVO> noticeCntList = pushDao.pageNoticeCnt(so);
		if (CollectionUtils.isNotEmpty(noticeCntList)) {
			for(int i=0; i<noticeCntList.size(); i++) {
				// 로그인 아이디 복호화
				String replaceLoginId = bizService.twoWayDecrypt(noticeCntList.get(i).getLoginId());
				if (StringUtil.isNotEmpty(replaceLoginId)) {
					noticeCntList.get(i).setLoginId(replaceLoginId);
				}
			}
		}
		return noticeCntList;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushServiceImpl.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<PushVO> pageNoticeTemplate(PushSO so) {
		return pushDao.pageNoticeTemplate(so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushServiceImpl.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 단건 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public PushVO getNoticeTemplate(PushSO so) {
		return pushDao.getNoticeTemplate(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushServiceImpl.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 등록/수정
	 * </pre>
	 * @param po
	 * @return
	 */
	@Override
	public void saveNoticeTemplate(PushPO po) {
		int result = 0;
		
		PushVO vo = null;
		PushSO so = new PushSO();
		if (StringUtil.isNotEmpty(po.getTmplNo())) {
			so.setTmplNo(po.getTmplNo());
			vo = pushDao.getNoticeTemplate(so);
		}
		
		if (vo == null) {
			po.setTmplNo(bizService.getSequence(CommonConstants.SEQUENCE_NOTICE_TMPL_INFO_SEQ));
		}
		
		FtpImgUtil ftpImgUtil = new FtpImgUtil();
		String filePath = po.getImgPath();
		if (filePath.startsWith(bizConfig.getProperty("common.file.upload.base"))) {
			if ((StringUtil.equals(po.getSndTypeCd(), CommonConstants.SND_TYPE_10)
					|| StringUtil.equals(po.getSndTypeCd(), CommonConstants.SND_TYPE_20))
					&& po.getImgPath() != null) {
				filePath = ftpImgUtil.uploadFilePath(po.getImgPath(), CommonConstants.PUSH_FILE_PATH + FileUtil.SEPARATOR + po.getTmplNo());
				ftpImgUtil.upload(po.getImgPath(), filePath);
				po.setImgPath(filePath);
			}
		}
		
		if (vo != null) {
			po.setSysUpdrNo(AdminSessionUtil.getSession().getUsrNo());
			result = pushDao.updateNoticeTemplate(po);
		} else {
			if (!StringUtil.equals(po.getSndTypeCd(), CommonConstants.SND_TYPE_30)) {
				po.setTmplCd("TMPL" + po.getTmplNo());
			}
			po.setSysRegrNo(AdminSessionUtil.getSession().getUsrNo());
			po.setSysUpdrNo(AdminSessionUtil.getSession().getUsrNo());
			result = pushDao.insertNoticeTemplate(po);
		}
		
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushServiceImpl.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	@Override
	public void deleteNoticeTemplate(PushPO po) {
		int result = 0;
		
		result = pushDao.deleteNoticeTemplate(po);
		
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushServiceImpl.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송 화면 정보 목록
	 * </pre>
	 * @param po
	 * @return
	 */
	@Override
	public List<PushVO> listPushMsgSendView(PushSO so) {
		String receiverStr = "";
		List<PushVO> pushList = pushDao.listPushMsgSendView(so);
		
		if (CollectionUtils.isNotEmpty(pushList)) {
			for(int i=0; i<pushList.size(); i++) {
				// app push의 경우 jsonStr jsonData로 변환
				if (StringUtil.equals(pushList.get(i).getSndTypeCd(), CommonConstants.SND_TYPE_10)) {
					JSONObject jsonObj = new JSONObject(pushList.get(i).getSndInfo());
					pushList.get(i).setImgPath(jsonObj.getString("image"));
					pushList.get(i).setMovPath(jsonObj.getString("landingUrl"));
				}
				
				// 복호화 처리
				String replaceMbrNm = bizService.twoWayDecrypt(pushList.get(i).getMbrNm());
				if (StringUtil.isNotEmpty(replaceMbrNm)) {
					pushList.get(i).setMbrNm(replaceMbrNm);
				}
				String replaceLoginId = bizService.twoWayDecrypt(pushList.get(i).getLoginId());
				if (StringUtil.isNotEmpty(replaceLoginId)) {
					pushList.get(i).setLoginId(replaceLoginId);
				}
				
				// 마스킹 처리
				pushList.get(i).setMbrNm(MaskingUtil.getName(pushList.get(i).getMbrNm()));
				pushList.get(i).setLoginId(MaskingUtil.getId(pushList.get(i).getLoginId()));
				
				receiverStr += pushList.get(i).getMbrNm() + "(" + pushList.get(i).getLoginId() + ")";
				if (i == pushList.size()-1) {
					pushList.get(i).setReceiverStr(receiverStr);
					break;
				}
				receiverStr += ", ";
			}
			pushList.get(0).setReceiverStr(receiverStr);
		}
		
		return pushList;
	}
	
	@Override
	public List<NoticeSendCommonVO> pageNoticeSendListByDailiy(NoticeSendSO so) {
		List<NoticeSendCommonVO> list = Optional.ofNullable(pushDao.pageNoticeSendListByDailiy(so)).orElseGet(()->new ArrayList<NoticeSendCommonVO>());
		return list;
	}

	@Override
	public List<NoticeSendCommonVO> pageNoticeSendListForMbr(NoticeSendSO so) {
		List<NoticeSendCommonVO> list = Optional.ofNullable(pushDao.pageNoticeSendListForMbr(so)).orElseGet(()->new ArrayList<NoticeSendCommonVO>());
		list.stream().forEach(v->{
				/* 데이터 정제 */
				String rcvrNo = Optional.ofNullable(v.getRcvrNo()).orElseGet(()->"")
					.replaceFirst("(^02|[0-9]{3})([0-9]{3,4})([0-9]{4})$", "$1-$2-$3");
//				v.setMbrNm(MaskingUtil.getName(bizService.twoWayDecrypt(v.getMbrNm())));
				v.setMbrNm(bizService.twoWayDecrypt(v.getMbrNm()));
				if(v.getMbrNm().length() > 1)	v.setMbrNm(MaskingUtil.getName(v.getMbrNm())); 
				v.setLoginId(MaskingUtil.getId(bizService.twoWayDecrypt(v.getLoginId())));
				v.setRcvrNo(MaskingUtil.getTelNo(rcvrNo));
				v.setReceiverEmail(MaskingUtil.getEmail(bizService.twoWayDecrypt(v.getReceiverEmail())));
		});
		return list;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushServiceImpl.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송 정보 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	@Override
	public void updateNoticeSendList(PushPO po) {
		int result = 0;
		if (po.getMbrNos() == null) {
			if (StringUtil.equals(po.getNoticeTypeCd(), CommonConstants.NOTICE_TYPE_10)) {
				PushSO pso = new PushSO();
				pso.setNoticeSendNo(po.getNoticeSendNo());
				List<PushVO> pvoList = pushDao.listPushMsgSendView(pso);
				String[] mbrNos = new String[pvoList.size()];
				
				if (StringUtil.equals(po.getSndTypeCd(), CommonConstants.SND_TYPE_10)) {
					List<PushTargetPO> ptpoList = new ArrayList<>();
					for(int i=0; i<pvoList.size(); i++) {
						PushTargetPO ptpo = new PushTargetPO();
						ptpo.setTo(pvoList.get(i).getMbrNo().toString());
						ptpo.setImage(po.getImgPath());
						ptpo.setLandingUrl(po.getMovPath());
						ptpoList.add(ptpo);
						mbrNos[i] = pvoList.get(i).getMbrNo().toString();
					}
					po.setTarget(ptpoList);
				} else {
					for(int i=0; i<pvoList.size(); i++) {
						mbrNos[i] = pvoList.get(i).getMbrNo().toString();
					}
				}
				
				// 예약발송(배치or사용자 발송)에서 즉시 발송으로 변경 시 등록자를 BO 사용자로 발송
				po.setSysRegrNo(AdminSessionUtil.getSession().getUsrNo());
				po.setSysUseYn(CommonConstants.SYS_USE_YN_N);
				
				po.setMbrNos(mbrNos);
				deleteAllNoticeSendList(po);
			} else {
				PushDetailPO pdpo = new PushDetailPO();
				po.setSysUpdrNo(AdminSessionUtil.getSession().getUsrNo());
				pdpo.setSysUpdrNo(AdminSessionUtil.getSession().getUsrNo());
				
				// 발송 리스트 업데이트
				po.setSendReqDtm(po.getSendReqDtmTotal());
				result = pushDao.updateNoticeSendList(po);
				
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				
				String sndInfoStr = "{\"image\":\"" + po.getImgPath() + "\",\"landingUrl\":\"" + po.getMovPath() + "\"}";
				pdpo.setSndInfo(sndInfoStr);
				pdpo.setSubject(po.getSubject());
				pdpo.setContents(po.getContents());
				pdpo.setSendReqDtm(po.getSendReqDtmTotal());
				pdpo.setNoticeSendNo(po.getNoticeSendNo());
				result = pushDao.updateNoticeSendDetailList(pdpo);
				
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		} else {
			// 예약발송(배치or사용자 발송)에서 수신자를 변경하여 즉시or예약 발송 시 BO 사용자 번호로 발송
			po.setSysRegrNo(AdminSessionUtil.getSession().getUsrNo());
			po.setSysUseYn(CommonConstants.SYS_USE_YN_N);
			
			deleteAllNoticeSendList(po);
		}
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushServiceImpl.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송 정보 삭제
	 * </pre>
	 * @param po
	 */
	@Override
	public void deleteAllNoticeSendList(PushPO po) {
		int result = 0;
		// 발송 리스트 삭제
		result = pushDao.deleteNoticeSendList(po);
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		// 발송 상세 리스트 삭제
		PushDetailPO pdpo = new PushDetailPO();
		pdpo.setNoticeSendNo(po.getNoticeSendNo());
		result = pushDao.deleteNoticeSendDetailList(pdpo);
		
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		// 발송 정보 삭제 후 알림 새로 발송
		sendPushMessage(po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushServiceImpl.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송 정보 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	@Override
	public void deleteNoticeSendList(PushPO po) {
		int result = 0;
		result = pushDao.deleteNoticeSendList(po);
		
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		PushDetailPO pdpo = new PushDetailPO();
		pdpo.setNoticeSendNo(po.getNoticeSendNo());
		result = pushDao.deleteNoticeSendDetailList(pdpo);
		
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushServiceImpl.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송하기
	 * </pre>
	 * @param po
	 * @return
	 */
	@Override
	public void sendPushMessage(PushPO po) {
		if (po.getMbrNos() == null || po.getMbrNos().length == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		if (po.getSndTypeCd().equals(CommonConstants.SND_TYPE_10)) { // APP PUSH
			MemberBaseSO so = new MemberBaseSO();
			so.setMbrNos(po.getMbrNos());
			
			//정보성 APP PUSH 수신동의
			if(po.getReceiverSendInfo().equals(CommonConstants.INFO_TP_CD_10)) {
				so.setInfoRcvYn(CommonConstants.COMM_YN_Y);
			}
			//광고성 마케팅 수신동의
			else if(po.getReceiverSendInfo().equals(CommonConstants.INFO_TP_CD_20)) {
				so.setMkngRcvYn(CommonConstants.COMM_YN_Y);
			}
			so.setRows(po.getMbrNos().length);
			so.setMaskingUnlock(CommonConstants.COMM_YN_Y);
			List<MemberBaseVO> memberList = memberService.pageMemberBase(so);
			
			if (CollectionUtils.isNotEmpty(memberList)) {
				List<PushTargetPO> appPushList = new ArrayList<PushTargetPO>();
				for(int i=0; i<memberList.size(); i++) {
					if (!StringUtil.equals(memberList.get(i).getMbrStatCd(), CommonConstants.MBR_STAT_50)) {
						PushTargetPO ptpo = new PushTargetPO();
						ptpo.setTo(memberList.get(i).getMbrNo().toString());
						ptpo.setImage(po.getImgPath());
						//2021.09.24 - APETQA-7164 , landing Url 없을 시 파라미터 SET X , kjy01
						if(StringUtil.isNotEmpty(Optional.ofNullable(po.getMovPath()).orElseGet(()->""))){
							ptpo.setLandingUrl(po.getMovPath());
						}
						appPushList.add(ptpo);
					}
				}
				
				if (appPushList.size() > 0) {
					SendPushPO sppo = new SendPushPO();
					sppo.setTitle(po.getSubject());
					sppo.setBody(po.getContents());
					sppo.setMessageType("NOTIF");
					sppo.setType("USER");
					if (StringUtil.isNotEmpty(po.getTmplNo())) {
						sppo.setTmplNo(po.getTmplNo());
					}
					sppo.setSysRegrNo(po.getSysRegrNo());
					
					if (po.getDeviceTypeCd().equals(CommonConstants.DEVICE_TYPE_10)) {
						sppo.setDeviceType("GCM");
					} else if (po.getDeviceTypeCd().equals(CommonConstants.DEVICE_TYPE_20)) {
						sppo.setDeviceType("APNS");
					}
					
					FtpImgUtil ftpImgUtil = new FtpImgUtil();
					String filePath = appPushList.get(0).getImage();
					if (StringUtil.isNotEmpty(filePath)) {
						if (filePath.startsWith(bizConfig.getProperty("common.file.upload.base"))) {
							filePath = ftpImgUtil.uploadFilePath(appPushList.get(0).getImage(), CommonConstants.PUSH_FILE_PATH);
							ftpImgUtil.upload(appPushList.get(0).getImage(), filePath);
							
							String cdnDomain = bizConfig.getProperty("naver.cloud.cdn.domain.folder");
							filePath = cdnDomain + filePath;
							appPushList.get(0).setImage(filePath);
						}
					}
					
					sppo.setTarget(appPushList);
					
					if (po.getNoticeTypeCd().equals(CommonConstants.NOTICE_TYPE_20)) {
						sppo.setReservationDateTime(DateUtil.formatDate(po.getSendReqDtmTotal(), "yyyy-MM-dd HH:mm:ss"));
						sppo.setSendReqDtm(po.getSendReqDtmTotal());
					}
					
					//알림발송 수동여부
					if(StringUtil.isNotEmpty(po.getPushGb())) {
						sppo.setPushGb(po.getPushGb());
					}
					
					sppo.setInfoTpCd(po.getReceiverSendInfo());
					String result = bizService.sendPush(sppo);
					
					if (result == "null") {
						log.error("send push error : {}", result);
					}
					
				}
				
			}
		} else if (po.getSndTypeCd().equals(CommonConstants.SND_TYPE_20)) { // 문자(MMS/LMS/SMS)
			MemberBaseSO so = new MemberBaseSO();
			so.setMbrNos(po.getMbrNos());
			if(po.getReceiverSendInfo().equals(CommonConstants.INFO_TP_CD_20)) {
				so.setMkngRcvYn(CommonConstants.COMM_YN_Y);
			}
			so.setRows(po.getMbrNos().length);
			so.setMaskingUnlock(CommonConstants.COMM_YN_Y);
			List<MemberBaseVO> memberList = memberService.pageMemberBase(so);
			
			if (CollectionUtils.isNotEmpty(memberList)) {
				for(int i=0; i<memberList.size(); i++) {
					if (!StringUtil.equals(memberList.get(i).getMbrStatCd(), CommonConstants.MBR_STAT_50)) {
						SsgMessageSendPO msg = new SsgMessageSendPO();
						if (StringUtil.isNotEmpty(po.getTmplNo())) {
							msg.setTmplNo(po.getTmplNo());
						}
						msg.setMbrNo(memberList.get(i).getMbrNo());
						msg.setUsrNo(po.getSysRegrNo());
						msg.setSysUseYn(po.getSysUseYn());
						
						String message2 = po.getContents(); //템플릿 내용
						msg.setFmessage(message2);// 템플릿 내용 replace(데이터 바인딩)
						msg.setFsubject(po.getSubject()); // 제목
						
						if (po.getNoticeTypeCd().equals(CommonConstants.NOTICE_TYPE_20)) {
							msg.setFsenddate(po.getSendReqDtmTotal()); //예약 발송일 경우만 set
							msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_20);// 예약
						} else {
							msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_10);// 즉시
						}
						
						msg.setFdestine(memberList.get(i).getMobile());
						//msg.setFcallback("발신자번호");//어바웃 펫 대표번호 1644-9601 일 때만 발송 됨. service 에서 자동처리 하고 있음.
						msg.setSndTypeCd(CommonConstants.SND_TYPE_20); // MMS/LMS/SMS
						if (StringUtil.isNotEmpty(po.getImgPath())) {
							String filePath = po.getImgPath();
							if (filePath.startsWith(bizConfig.getProperty("common.file.upload.base"))) {
								FtpImgUtil ftpImgUtil = new FtpImgUtil();
								filePath = ftpImgUtil.uploadFilePath(po.getImgPath(), CommonConstants.PUSH_FILE_PATH);
								ftpImgUtil.upload(po.getImgPath(), filePath);
								
								String cdnDomain = bizConfig.getProperty("naver.cloud.cdn.domain.folder");
								filePath = cdnDomain + filePath;
								po.setImgPath(filePath);
							}
							msg.setFfilepath(po.getImgPath());
						}
						
						msg.setInfoTpCd(po.getReceiverSendInfo());
						int result = bizService.sendMessage(msg);
						
						if (result == 0) {
							log.error("SSG send message error : {}", msg.getMbrNo());
						}
						
					}
				}
				
			}
		} else if (po.getSndTypeCd().equals(CommonConstants.SND_TYPE_30)) { // 알림톡
			MemberBaseSO so = new MemberBaseSO();
			so.setMbrNos(po.getMbrNos());
			so.setMkngRcvYn(CommonConstants.COMM_YN_Y);
			so.setRows(po.getMbrNos().length);
			so.setMaskingUnlock(CommonConstants.COMM_YN_Y);
			List<MemberBaseVO> memberList = memberService.pageMemberBase(so);
			
			if (CollectionUtils.isNotEmpty(memberList)) {
				for(int i=0; i<memberList.size(); i++) {
					if (!StringUtil.equals(memberList.get(i).getMbrStatCd(), CommonConstants.MBR_STAT_50)) {
						SsgMessageSendPO msg = new SsgMessageSendPO();
						if (StringUtil.isNotEmpty(po.getTmplNo())) {
							PushSO pso = new PushSO();
							pso.setTmplNo(po.getTmplNo());
							PushVO template = Optional.ofNullable(pushDao.getNoticeTemplate(pso)).orElseGet(()->new PushVO());
							
							msg.setTmplNo(po.getTmplNo());
							msg.setFtemplatekey(template.getTmplCd());
						}
						msg.setMbrNo(memberList.get(i).getMbrNo());
						msg.setUsrNo(po.getSysRegrNo());
						msg.setSysUseYn(po.getSysUseYn());
						
						String subject2 = po.getContents().split("\\n")[0];
						subject2 = StringUtil.cutText(subject2, 80, true);
						if (subject2 != po.getSubject()) {
							msg.setFkkosubject(po.getSubject());
						}
						String message2 = po.getContents(); //템플릿 내용
						msg.setFmessage(message2);// 템플릿 내용 replace(데이터 바인딩)
						
						if (po.getNoticeTypeCd().equals(CommonConstants.NOTICE_TYPE_20)) {
							msg.setFsenddate(po.getSendReqDtmTotal()); //예약 발송일 경우만 set
							msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_20);// 예약
						} else {
							msg.setNoticeTypeCd(CommonConstants.NOTICE_TYPE_10);// 즉시
						}
						
						msg.setFdestine(memberList.get(i).getMobile());
						//msg.setFcallback("발신자번호");//어바웃 펫 대표번호 1644-9601 일 때만 발송 됨. service 에서 자동처리 하고 있음.
						msg.setSndTypeCd(CommonConstants.SND_TYPE_30); // 알림톡
						
						/*
						템플릿에 버튼이 있는 경우만
						SsgKkoBtnPO buttonPo = new SsgKkoBtnPO();
						buttonPo.setBtnName("버튼 명");
						buttonPo.setBtnType("버튼 타입"); // CommonConstants.KKO_BTN_TP_
						buttonPo.setPcLinkUrl("Pc Link Url"); // 필수
						buttonPo.setMobileLinkUrl("Mobile Link Url"); // 비필수
						List list = new ArrayList<>();
						list.add(buttonPo);
						msg.setButtionList(list);
						*/
						
						int result = bizService.sendMessage(msg);
						
						if (result == 0) {
							log.error("SSG send message error : {}", msg.getMbrNo());
						}
						
					}
				}
				
			}
		} else { // EMAIL
			EmailSendPO email = new EmailSendPO();
			MemberBaseSO so = new MemberBaseSO();
			so.setMbrNos(po.getMbrNos());
			if(po.getReceiverSendInfo().equals(CommonConstants.INFO_TP_CD_20)) {
				so.setMkngRcvYn(CommonConstants.COMM_YN_Y);
			}
			so.setRows(po.getMbrNos().length);
			so.setMaskingUnlock(CommonConstants.COMM_YN_Y);
			List<MemberBaseVO> memberList = memberService.pageMemberBase(so);
			List<EmailRecivePO> recList = new ArrayList<EmailRecivePO>();
			
			if (CollectionUtils.isNotEmpty(memberList)) {
				for(int i=0; i<memberList.size(); i++) {
					if (!StringUtil.equals(memberList.get(i).getMbrStatCd(), CommonConstants.MBR_STAT_50)) {
						EmailRecivePO erpo = new EmailRecivePO();
						erpo.setAddress(memberList.get(i).getEmail());
						erpo.setName(memberList.get(i).getMbrNm());
						erpo.setMbrNo(memberList.get(i).getMbrNo());
						Map<String, String> map = new HashMap<String, String>();
						// TO-DO : 변수 바인딩
						erpo.setParameters(map);
						erpo.setType("R");
						
						recList.add(erpo);
						
					}
				}
				
				if (recList.size() > 0) {
					email.setRecipients(recList);
					
					if (po.getNoticeTypeCd().equals(CommonConstants.NOTICE_TYPE_20)) {
						email.setReservationDateTime(po.getSendReqDtmTotal().toString());
						email.setSendReqDtm(po.getSendReqDtmTotal());
						po.setSendReqYn(CommonConstants.COMM_YN_Y);
					} else {
						po.setSendReqYn(CommonConstants.COMM_YN_N);
					}
					
					StStdInfoVO ssivo = Optional.ofNullable(stService.getStStdInfo(CommonConstants.DEFAULT_ST_ID)).orElseGet(()->new StStdInfoVO());
					email.setSenderAddress(ssivo.getDlgtEmail());
					email.setTitle(po.getSubject());
					email.setBody(po.getContents());
					if (StringUtil.isNotEmpty(po.getTmplNo())) {
						email.setTmplNo(po.getTmplNo());
					}
					
					//이메일 발송 수동여부
					if(StringUtil.isNotEmpty(po.getPushGb())) {
						email.setPushGb(po.getPushGb());
					}
					
					email.setSysRegrNo(po.getSysRegrNo());
					email.setInfoTpCd(po.getReceiverSendInfo());
					String result = bizService.sendEmail(email); // noticeSendNo
					
					if (result == "null") {
						log.error("send email error : {}", result);
					}
					
				}
				
			}
		}
	}

	
	@Override
	public List<NoticeSendListVO> listRsrvNotice(PushSO so) {
		return pushDao.listRsrvNotice(so);
	}
	
	
	@Override
	public List<PushVO> getFrontPushList(PushSO so){
		return pushDao.getFrontPushList(so);
	}
}

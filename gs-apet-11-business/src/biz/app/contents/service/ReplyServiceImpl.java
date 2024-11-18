package biz.app.contents.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.app.appweb.dao.PushDao;
import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.contents.dao.ReplyDao;
import biz.app.contents.model.ContentsReplyPO;
import biz.app.contents.model.ContentsReplySO;
import biz.app.contents.model.ContentsReplyVO;
import biz.app.member.dao.MemberBaseDao;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.common.model.PushTargetPO;
import biz.common.model.SendPushPO;
import biz.common.service.BizService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.contents.service
 * - 파일명		: ReplyServiceImpl.java
 * - 작성일		: 2020. 12. 14. 
 * - 작성자		: hjh
 * - 설 명		: 콘텐츠 댓글 관리 서비스
 * </pre>
 */
@Slf4j
@Service
@Transactional
public class ReplyServiceImpl implements ReplyService {
	@Autowired
	private ReplyDao replyDao;
	
	@Autowired
	private BizService bizService;
	
	@Autowired
	private PushDao pushDao;
	
	@Autowired
	private MemberBaseDao memberBaseDao;

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyServiceImpl.java
	 * - 작성일		: 2020. 12. 14.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<ContentsReplyVO> listApetReplyGrid(ContentsReplySO so) {
		if (!StringUtil.isEmpty(so.getLoginId())) {
			so.setLoginId(bizService.twoWayEncrypt(so.getLoginId()));
		}
		List<ContentsReplyVO> apetReplyList = replyDao.listApetReplyGrid(so);
		if (CollectionUtils.isNotEmpty(apetReplyList)) {
			for(int i=0; i<apetReplyList.size(); i++) {
				// 로그인 아이디 복호화
				String replaceLoginId = bizService.twoWayDecrypt(apetReplyList.get(i).getLoginId());
				if (StringUtil.isNotEmpty(replaceLoginId)) {
					apetReplyList.get(i).setLoginId(replaceLoginId);
				}
			}
		}
		return apetReplyList;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyServiceImpl.java
	 * - 작성일		: 2020. 12. 14.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글 단건 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public ContentsReplyVO getApetReply(ContentsReplySO so) {
		ContentsReplyVO crvo = replyDao.getApetReply(so);
		if (StringUtil.isNotEmpty(crvo)) {
			// 로그인 아이디 복호화
			String replaceLoginId = bizService.twoWayDecrypt(crvo.getLoginId());
			if (StringUtil.isNotEmpty(replaceLoginId)) {
				crvo.setLoginId(replaceLoginId);
			}
		}
		return crvo;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyServiceImpl.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫로그 댓글 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<ContentsReplyVO> listPetLogReplyGrid(ContentsReplySO so) {
		if (!StringUtil.isEmpty(so.getLoginId())) {
			so.setLoginId(bizService.twoWayEncrypt(so.getLoginId()));
		}
		List<ContentsReplyVO> petlogReplyList = replyDao.listPetLogReplyGrid(so);
		if (CollectionUtils.isNotEmpty(petlogReplyList)) {
			for(int i=0; i<petlogReplyList.size(); i++) {
				// 로그인 아이디 복호화
				String replaceLoginId = bizService.twoWayDecrypt(petlogReplyList.get(i).getLoginId());
				if (StringUtil.isNotEmpty(replaceLoginId)) {
					petlogReplyList.get(i).setLoginId(replaceLoginId);
				}
			}
		}
		return petlogReplyList;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyServiceImpl.java
	 * - 작성일		: 2020. 12. 14.
	 * - 작성자		: hjh
	 * - 설명			: 펫로그 댓글 단건 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public ContentsReplyVO getPetLogReply(ContentsReplySO so) {
		return replyDao.getPetLogReply(so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyServiceImpl.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글 전시 상태 일괄 변경
	 * </pre>
	 * @param po
	 * @return
	 */
	@Override
	public void updateApetReplyContsStat(ContentsReplyPO po) {
		int result = 0;
		result = replyDao.updateApetReplyContsStat(po);
		
		if (result > 0 && StringUtil.equals(po.getContsStatCd(), CommonConstants.CONTS_STAT_10)) {
			int rptpCnt = 0;
			for(int i=0; i<po.getArrReplySeq().length; i++) {
				rptpCnt = replyDao.getApetReplyRptpCnt(po);
				
				if (rptpCnt > 0) {
					result = replyDao.apetReplyRptpCntRefresh(po);
				}
				
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		} else if (result > 0 && StringUtil.equals(po.getContsStatCd(), CommonConstants.CONTS_STAT_20)) {
			// 회원 번호 조회
			List<Long> mbrNoList = replyDao.listApetReplyMbrNo(po);
			for(int i=0; i<po.getArrReplySeq().length; i++) {
				// 미노출로 수정된 댓글의 작성자에게 AppPush 알림 발송 (탈퇴한 회원이 아닌 경우)
				MemberBaseSO mbso = new MemberBaseSO();
				mbso.setMbrNo(mbrNoList.get(i));
				MemberBaseVO mbvo = Optional.ofNullable(memberBaseDao.getMemberBase(mbso)).orElseGet(()->new MemberBaseVO());
				
				if (!StringUtil.equals(mbvo.getMbrStatCd(), CommonConstants.MBR_STAT_50) && mbvo.getMbrNo() != null) {
					PushSO pso = new PushSO();
					pso.setTmplNo(86L);
					PushVO template = Optional.ofNullable(pushDao.getNoticeTemplate(pso)).orElseGet(()->new PushVO());
					
					if (StringUtil.isNotBlank(template.getSubject()) && StringUtil.isNotBlank(template.getContents())) {
						List<PushTargetPO> ptpoList = new ArrayList<>();
						PushTargetPO ptpo = new PushTargetPO();
						
						ptpo.setTo(mbvo.getMbrNo().toString());
						ptpo.setImage(template.getImgPath());
						ptpo.setLandingUrl(template.getMovPath());
						
						Map<String,String> map =new HashMap<String, String>();
						map.put(CommonConstants.PUSH_TMPL_VRBL_80, mbvo.getNickNm());
						ptpo.setParameters(map);
						ptpoList.add(ptpo);
						
						SendPushPO sppo = new SendPushPO();
						sppo.setTitle(template.getSubject());
						sppo.setMessageType("NOTIF");
						sppo.setType("USER");
						sppo.setTmplNo(pso.getTmplNo());
						sppo.setTarget(ptpoList);
						
						if (StringUtil.isNotEmpty(mbvo.getDeviceTpCd())) {
							if (mbvo.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_10)) {
								sppo.setDeviceType("GCM");
							} else if (mbvo.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_20)) {
								sppo.setDeviceType("APNS");
							}
						}
						
						sppo.setReservationDateTime(DateUtil.getNowDateTime());
						String noticeSendNo = bizService.sendPush(sppo);
						
						if (noticeSendNo == "null") {
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}
					}
					
				}
				
			}
			
		}
		
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyServiceImpl.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫로그 댓글 전시 상태 일괄 변경
	 * </pre>
	 * @param po
	 * @return
	 */
	@Override
	public void updatePetLogReplyContsStat(ContentsReplyPO po) {
		int result = 0;
		result = replyDao.updatePetLogReplyContsStat(po);
		
		if (result > 0 && StringUtil.equals(po.getContsStatCd(), CommonConstants.CONTS_STAT_10)) {
			int rptpCnt = 0;
			for(int i=0; i<po.getArrReplySeq().length; i++) {
				rptpCnt = replyDao.getPetLogReplyRptpCnt(po);
				
				if (rptpCnt > 0) {
					result = replyDao.petLogReplyRptpCntRefresh(po);
				}
				
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
			}
		} else if (result > 0 && StringUtil.equals(po.getContsStatCd(), CommonConstants.CONTS_STAT_20)) {
			// 회원 번호 조회
			List<Long> mbrNoList = replyDao.listPetLogReplyMbrNo(po);
			for(int i=0; i<po.getArrReplySeq().length; i++) {
				// 미노출로 수정된 댓글의 작성자에게 AppPush 알림 발송 (탈퇴한 회원이 아닌 경우)
				MemberBaseSO mbso = new MemberBaseSO();
				mbso.setMbrNo(mbrNoList.get(i));
				MemberBaseVO mbvo = Optional.ofNullable(memberBaseDao.getMemberBase(mbso)).orElseGet(()->new MemberBaseVO());
				
				if (!StringUtil.equals(mbvo.getMbrStatCd(), CommonConstants.MBR_STAT_50) && mbvo.getMbrNo() != null) {
					PushSO pso = new PushSO();
					pso.setTmplNo(86L);
					PushVO template = Optional.ofNullable(pushDao.getNoticeTemplate(pso)).orElseGet(()->new PushVO());
					
					if (StringUtil.isNotBlank(template.getSubject()) && StringUtil.isNotBlank(template.getContents())) {
						List<PushTargetPO> ptpoList = new ArrayList<>();
						PushTargetPO ptpo = new PushTargetPO();
						
						ptpo.setTo(mbvo.getMbrNo().toString());
						ptpo.setImage(template.getImgPath());
						ptpo.setLandingUrl(template.getMovPath());
						
						Map<String,String> map =new HashMap<String, String>();
						map.put(CommonConstants.PUSH_TMPL_VRBL_80, mbvo.getNickNm());
						ptpo.setParameters(map);
						ptpoList.add(ptpo);
						
						SendPushPO sppo = new SendPushPO();
						sppo.setTitle(template.getSubject());
						sppo.setMessageType("NOTIF");
						sppo.setType("USER");
						sppo.setTmplNo(pso.getTmplNo());
						sppo.setTarget(ptpoList);
						
						if (StringUtil.isNotEmpty(mbvo.getDeviceTpCd())) {
							if (mbvo.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_10)) {
								sppo.setDeviceType("GCM");
							} else if (mbvo.getDeviceTpCd().equals(CommonConstants.DEVICE_TYPE_20)) {
								sppo.setDeviceType("APNS");
							}
						}
						
						sppo.setReservationDateTime(DateUtil.getNowDateTime());
						String noticeSendNo = bizService.sendPush(sppo);
						
						if (noticeSendNo == "null") {
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}
					}
					
				}
				
			}
						
		}
		
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyServiceImpl.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 운영자 댓글 등록/수정
	 * </pre>
	 * @param po
	 * @return
	 */
	@Override
	public void saveApetReply(ContentsReplyPO po) {
		int result = 0;
		ContentsReplySO so = new ContentsReplySO();
		so.setAplySeq(po.getAplySeq());
		ContentsReplyVO vo = replyDao.getApetReply(so);
		
		if (vo.getRpl() != null) {
			result = replyDao.updateApetReply(po);
		} else {
			result = replyDao.insertApetReply(po);
		}
		
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyServiceImpl.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 운영자 댓글 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	@Override
	public void deleteApetReply(ContentsReplyPO po) {
		int result = 0;
		result = replyDao.deleteApetReply(po);
		
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyServiceImpl.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 댓글 신고 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<ContentsReplyVO> pageApetReplyRptp(ContentsReplySO so) {
		if (!StringUtil.isEmpty(so.getLoginId())) {
			so.setLoginId(bizService.twoWayEncrypt(so.getLoginId()));
		}
		List<ContentsReplyVO> apetRptpList = replyDao.pageApetReplyRptp(so);
		if (CollectionUtils.isNotEmpty(apetRptpList)) {
			for(int i=0; i<apetRptpList.size(); i++) {
				// 로그인 아이디 복호화
				String replaceLoginId = bizService.twoWayDecrypt(apetRptpList.get(i).getLoginId());
				if (StringUtil.isNotEmpty(replaceLoginId)) {
					apetRptpList.get(i).setLoginId(replaceLoginId);
				}
			}
		}
		return apetRptpList;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: ReplyServiceImpl.java
	 * - 작성일		: 2020. 12. 15.
	 * - 작성자		: hjh
	 * - 설명			: 펫로그 댓글 신고 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public List<ContentsReplyVO> pagePetLogReplyRptp(ContentsReplySO so) {
		if (!StringUtil.isEmpty(so.getLoginId())) {
			so.setLoginId(bizService.twoWayEncrypt(so.getLoginId()));
		}
		List<ContentsReplyVO> petLogRptpList = replyDao.pagePetLogReplyRptp(so);
		if (CollectionUtils.isNotEmpty(petLogRptpList)) {
			for(int i=0; i<petLogRptpList.size(); i++) {
				// 로그인 아이디 복호화
				String replaceLoginId = bizService.twoWayDecrypt(petLogRptpList.get(i).getRptpLoginId());
				if (StringUtil.isNotEmpty(replaceLoginId)) {
					petLogRptpList.get(i).setRptpLoginId(replaceLoginId);
				}
			}
		}
		return petLogRptpList;
	}

}

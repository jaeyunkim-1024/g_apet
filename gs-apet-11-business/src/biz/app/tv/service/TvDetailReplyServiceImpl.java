package biz.app.tv.service;

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
import biz.app.member.dao.MemberBaseDao;
import biz.app.member.dao.MemberDao;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.tag.dao.TagDao;
import biz.app.tag.model.TagBasePO;
import biz.app.tag.model.TagBaseSO;
import biz.app.tag.model.TagBaseVO;
import biz.app.tv.dao.TvDetailReplyDao;
import biz.app.tv.model.TvDetailReplyMentionMbrPO;
import biz.app.tv.model.TvDetailReplyMentionMbrVO;
import biz.app.tv.model.TvDetailReplyPO;
import biz.app.tv.model.TvDetailReplyRptpPO;
import biz.app.tv.model.TvDetailReplyRptpSO;
import biz.app.tv.model.TvDetailReplySO;
import biz.app.tv.model.TvDetailReplyVO;
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
 * - 패키지명		: biz.app.tv.service
 * - 파일명		: TvDetailReplyServiceImpl.java
 * - 작성일		: 2021. 01. 19. 
 * - 작성자		: hjh
 * - 설 명		: 펫TV 상세 댓글 서비스
 * </pre>
 */
@Slf4j
@Service
@Transactional
public class TvDetailReplyServiceImpl implements TvDetailReplyService {
	@Autowired
	private TvDetailReplyDao tvDetailReplyDao;
	
	@Autowired
	private BizService bizService;
	
	@Autowired
	private MemberBaseDao memberBaseDao;
	
	@Autowired
	private PushDao pushDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private TagDao tagDao;
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 목록 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<TvDetailReplyVO> selectTvDetailReplyList(TvDetailReplySO so) {
		List<TvDetailReplyVO> tvDetailReplyList = tvDetailReplyDao.selectTvDetailReplyList(so);
		if (CollectionUtils.isNotEmpty(tvDetailReplyList)) {
			for(int i=0; i<tvDetailReplyList.size(); i++) {
				boolean updateFlag = false;
				
				// 로그인 아이디 복호화
				String replaceLoginId = bizService.twoWayDecrypt(tvDetailReplyList.get(i).getLoginId());
				if (StringUtil.isNotEmpty(replaceLoginId)) {
					tvDetailReplyList.get(i).setLoginId(replaceLoginId);
				}
				
				String[] aplySplit = tvDetailReplyList.get(i).getAply().split("@"); //화면에 보내질 댓글
				String[] updateAplySplit = tvDetailReplyList.get(i).getAply().split("@"); //멘션한 닉네임이 변경되었을때 업데이트에 사용
				
				//멘션 추출
				List<String> nickNmList = StringUtil.getTags(tvDetailReplyList.get(i).getAply(), "@");
				
				//댓글 멘션 회원정보 조회
				TvDetailReplyMentionMbrPO mentionMbrPO = new TvDetailReplyMentionMbrPO();
				mentionMbrPO.setVdId(tvDetailReplyList.get(i).getVdId());
				mentionMbrPO.setAplyNo(tvDetailReplyList.get(i).getAplySeq());
				mentionMbrPO.setMetnMbrNo(tvDetailReplyList.get(i).getMbrNo());
				List<TvDetailReplyMentionMbrVO> mentionMbrList = tvDetailReplyDao.selectTvDetailReplyMentionMbrList(mentionMbrPO);
				
				if((!nickNmList.isEmpty() && nickNmList.size() > 0)) {
					//댓글 멘션 회원정보 테이블이 생기고 난 후 등록된 멘션 처리 & 댓글 멘션 회원정보 테이블의 값이 있을때 멘션 처리
					if(!mentionMbrList.isEmpty() && mentionMbrList.size() > 0) {
						for(int j=0; j<nickNmList.size(); j++) {
							for(int k=0; k<mentionMbrList.size(); k++) {
								if((j+1) == mentionMbrList.get(k).getMetnSeq()) {
									if(!mentionMbrList.get(k).getNickNm().equals("어바웃펫회원")) {
										aplySplit[j+1] = StringUtil.replaceAll(aplySplit[j+1], nickNmList.get(j), mentionMbrList.get(k).getNickNm()+"|");
									}else {
										aplySplit[j+1] = StringUtil.replaceAll(aplySplit[j+1], nickNmList.get(j), mentionMbrList.get(k).getNickNm());
									}
									
									if(!nickNmList.get(j).equals(mentionMbrList.get(k).getNickNm()) && !mentionMbrList.get(k).getNickNm().equals("어바웃펫회원")) {
										updateFlag = true;
										updateAplySplit[j+1] = StringUtil.replaceAll(updateAplySplit[j+1], nickNmList.get(j), mentionMbrList.get(k).getNickNm());
									}
								}
							}
						}
						
						//닉네임이 변경되었으면 업데이트
						if(updateFlag) {
							TvDetailReplyPO replyPO = new TvDetailReplyPO();
							replyPO.setAplySeq(tvDetailReplyList.get(i).getAplySeq());
							replyPO.setVdId(tvDetailReplyList.get(i).getVdId());
							replyPO.setMbrNo(tvDetailReplyList.get(i).getMbrNo());
							replyPO.setAply(String.join("@", updateAplySplit));
							tvDetailReplyDao.updateTvDetailReply(replyPO);
						}
					}
					//댓글 멘션 회원정보 테이블이 없었을때 등록된 멘션 처리 & 댓글 멘션 회원정보 테이블에 값이 없을때 멘션 처리
					else {
						for(int j=0; j<nickNmList.size(); j++) {
							MemberBaseVO mbvo = memberDao.getMentionInfo(nickNmList.get(j));
							if(mbvo == null) {
								//2021-09-08일 이전에 등록된 댓글은 의미없는 닉네임 & 탈퇴회원은 어바웃펫회원으로 표시
								//2021-09-08일 이후에 등록된 댓글은 그냥 텍스트로 표시
								//2021-09-08에 [APETQA-6601] 이슈관련 검증반영으로 인하여 기준을 2021-09-08일로 정함.
								if(tvDetailReplyList.get(i).getSysRegDt().compareTo("2021-09-08") < 0){
									aplySplit[j+1] = StringUtil.replaceAll(aplySplit[j+1], nickNmList.get(j), "어바웃펫회원");
								}
							}else {
								aplySplit[j+1] = StringUtil.replaceAll(aplySplit[j+1], nickNmList.get(j), nickNmList.get(j)+"|");
							}
						}
					}
				}
				
				tvDetailReplyList.get(i).setAply(String.join("@", aplySplit));
			}
		}
		
		return tvDetailReplyList;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 신고 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	@Override
	public int insertTvDetailReplyRptp(TvDetailReplyRptpPO po) {
		int result = 0;
		int rptpCnt = 0;
		result = tvDetailReplyDao.insertTvDetailReplyRptp(po);
		
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		} else {
			rptpCnt = tvDetailReplyDao.getTvDetailReplyRptpCnt(po);
			
			if (rptpCnt > 4) {
				// 5개 신고된 댓글의 작성자 회원 번호 조회
				Long rptpMbrNo = tvDetailReplyDao.getReplyRptpMbrNo(po);
				
				// 신고된 댓글의 작성자에게 AppPush 알림 발송
				MemberBaseSO mbso = new MemberBaseSO();
				mbso.setMbrNo(rptpMbrNo);
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
						
						String noticeSendNo = bizService.sendPush(sppo);
						
						if (noticeSendNo == "null") {
							throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
						}
					}
					
				}
				
				// 5개 신고된 댓글 신고 차단
				result = tvDetailReplyDao.updateTvDetailReplyRptpStat(po);
				
				if (result == 0) {
					throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
				}
				
			}
		}
		
		return rptpCnt;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 등록/수정
	 * </pre>
	 * @param po
	 * @return
	 */
	@Override
	public int saveTvDetailReply(TvDetailReplyPO po) {
		int replyResult = 0;
		if (po.getAplySeq() != null) {
			replyResult = updateTvDetailReply(po);
			
			if (replyResult == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			if (replyResult > 0) {
				replyResult = 2;
				replyTagMentionPrcs(po);
			}
		} else {
			po.setContsStatCd(CommonConstants.CONTS_STAT_10);
			replyResult = insertTvDetailReply(po);
			
			if (replyResult == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			if (replyResult > 0) {
				replyResult = 1;
				replyTagMentionPrcs(po);
			}
		}
		
		return replyResult;
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 등록 태그,멘션 존재 시 태그 등록 & APP PUSH 발송 & 댓글 멘션 닉네임 회원정보 저장
	 * </pre>
	 * @param po
	 * @return
	 */
	@Override
	public void replyTagMentionPrcs(TvDetailReplyPO po) {
		// 댓글 태그 존재 시 태그 등록
		if (po.getTagNmArr() != null && po.getTagNmArr().length != 0) {
			for(int i=0; i<po.getTagNmArr().length; i++) {
				String tagNm = po.getTagNmArr()[i];
				TagBaseSO tbso = new TagBaseSO();
				tbso.setTagNm(tagNm);
				TagBaseVO tbvo = tagDao.getTagInfo(tbso);
				if (tbvo == null) {
					int tagInsertResult = 0;
					TagBasePO tbpo = new TagBasePO();
					tbpo.setTagNm(po.getTagNmArr()[i]);
					tbpo.setStatCd("U");
					tbpo.setSrcCd("M");
					tagInsertResult = tagDao.insertTagBase(tbpo);
					
					if (tagInsertResult == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				} else {
					// 등록된 태그가 있는 경우, USE_CNT+1 로 update
					int tagUpdateResult = 0;
					TagBasePO tbpo = new TagBasePO();
					tbpo.setTagNo(tbvo.getTagNo());
					tbpo.setUseCnt(1);
					tagUpdateResult = tagDao.updateTagBase(tbpo);
					
					if (tagUpdateResult == 0) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
				}
			}
		}
		
		// 댓글 멘션 존재 시 해당 멘션 회원에게 APP PUSH 발송 & 댓글 멘션 닉네임 회원정보 저장
		if (po.getNickNmArr() != null && po.getNickNmArr().length != 0) {
			PushSO pso = new PushSO();
			pso.setTmplNo(85L);
			PushVO template = Optional.ofNullable(pushDao.getNoticeTemplate(pso)).orElseGet(()->new PushVO());
			
			//댓글 멘션 회원정보 삭제
			tvDetailReplyDao.deleteTvDetailReplyMentionMbr(po);
			
			for(int i=0; i<po.getNickNmArr().length; i++) {
				MemberBaseVO mbvo = Optional.ofNullable(memberDao.getMentionInfo(po.getNickNmArr()[i])).orElseGet(()->new MemberBaseVO());
				
				if (!StringUtil.equals(mbvo.getMbrStatCd(), CommonConstants.MBR_STAT_50) && mbvo.getMbrNo() != null) {
					//댓글 멘션 닉네임 회원정보 저장
					TvDetailReplyMentionMbrPO replyMentionMbrPO = new TvDetailReplyMentionMbrPO();
					replyMentionMbrPO.setVdId(po.getVdId());
					replyMentionMbrPO.setAplyNo(po.getAplySeq());
					replyMentionMbrPO.setMetnMbrNo(po.getMbrNo());
					replyMentionMbrPO.setMetnTgMbrNo(mbvo.getMbrNo());
					replyMentionMbrPO.setMetnSeq(i+1);
					int result = tvDetailReplyDao.insertTvDetailReplyMentionMbr(replyMentionMbrPO);
					
					if(result != 1) {
						throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
					}
					
					//댓글 멘션 존재 시 해당 멘션 회원에게 APP PUSH 발송
					if (StringUtil.isNotBlank(template.getSubject()) && StringUtil.isNotBlank(template.getContents())) {
						List<PushTargetPO> ptpoList = new ArrayList<>();
						PushTargetPO ptpo = new PushTargetPO();
						ptpo.setTo(mbvo.getMbrNo().toString());
						ptpo.setImage(template.getImgPath());
						ptpo.setLandingUrl(po.getLandingUrl());
						
						Map<String,String> map =new HashMap<String, String>();
						map.put(CommonConstants.PUSH_TMPL_VRBL_80, po.getNickNm());
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
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	@Override
	public int insertTvDetailReply(TvDetailReplyPO po) {
		int result = 0;
		result = tvDetailReplyDao.insertTvDetailReply(po);
		
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		return result;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	@Override
	public int updateTvDetailReply(TvDetailReplyPO po) {
		int result = 0;
		result = tvDetailReplyDao.updateTvDetailReply(po);
		
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		
		return result;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	@Override
	public void deleteTvDetailReply(TvDetailReplyPO po) {
		int result = 0;
		result = tvDetailReplyDao.deleteTvDetailReply(po);
		
		if (result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}else {
			//댓글 멘션 회원정보 삭제
			tvDetailReplyDao.deleteTvDetailReplyMentionMbr(po);
		}
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: TvDetailReplyServiceImpl.java
	 * - 작성일		: 2021. 01. 19.
	 * - 작성자		: hjh
	 * - 설명			: 펫TV 영상 상세 댓글 신고 중복 체크
	 * </pre>
	 * @param so
	 * @return
	 */
	@Override
	public int tvDetailReplyRptpDupChk(TvDetailReplyRptpSO so) {
		int result = 0;
		result = tvDetailReplyDao.tvDetailReplyRptpDupChk(so);
		
		return result;
	}
}

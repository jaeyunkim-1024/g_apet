package biz.app.event.service;

import biz.app.appweb.dao.PushDao;
import biz.app.appweb.model.PushSO;
import biz.app.appweb.model.PushVO;
import biz.app.event.dao.FrontEventDao;
import biz.app.event.model.EventBaseSO;
import biz.app.event.model.EventBaseVO;
import biz.app.event.model.EventEntryWinInfoPO;
import biz.app.event.model.EventEntryWinInfoVO;
import biz.app.event.model.EventMentionMemberPO;
import biz.app.event.model.EventMentionMemberSO;
import biz.app.event.model.EventMentionMemberVO;
import biz.app.member.dao.MemberDao;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import biz.app.member.service.MemberService;
import biz.app.petlog.model.PetLogMemberVO;
import biz.app.tv.model.TvDetailReplyPO;
import biz.common.model.PushTargetPO;
import biz.common.model.SendPushPO;
import biz.common.service.BizService;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.util.DateUtil;
import framework.common.util.MaskingUtil;
import framework.common.util.StringUtil;
import framework.front.constants.FrontConstants;
import lombok.extern.slf4j.Slf4j;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;
import java.util.stream.Collectors;

@Slf4j
@Transactional
@Service("FrontEventService")
public class FrontEventServiceImpl implements FrontEventService{
    @Autowired private FrontEventDao frontEventDao;

    @Autowired private BizService bizService;

    @Autowired private Properties bizConfig;
    
    @Autowired private PushDao pushDao;
    
	@Autowired private MemberDao memberDao;
	
	@Autowired private MemberService memberService;


    @Override
    public List<EventBaseVO> listIngEvent(EventBaseSO so) {
        //이벤트 정렬 기준 - 없으면, D-DAY 남은 순으로
        String eventSortType = Optional.ofNullable(so.getEventSortType()).orElseGet(()->"");
        if(StringUtil.isEmpty(eventSortType)){
            so.setSidx("E.SYS_REG_DTM");
            so.setSord("DESC");
        }
        so.setEventStatCd(CommonConstants.EVENT_STAT_20);
        return Optional.ofNullable(frontEventDao.listEvent(so)).orElseGet(()->new ArrayList<>());
    }

    @Override
    public List<EventBaseVO> listEndEvent(EventBaseSO so) {
        //이벤트 정렬 기준 - 없으면, 등록 순
        String eventSortType = Optional.ofNullable(so.getEventSortType()).orElseGet(()->"");
        if(StringUtil.isEmpty(eventSortType)){
            so.setSidx("E.SYS_REG_DTM");
            so.setSord("DESC");
        }
        so.setEventStatCd(CommonConstants.EVENT_STAT_40);
        return Optional.ofNullable(frontEventDao.listEvent(so)).orElseGet(()->new ArrayList<>());
    }

    @Override
    public EventBaseVO getEventDetail(EventBaseSO so) {
        EventBaseVO vo = Optional.ofNullable(frontEventDao.getEventDetail(so)).orElseGet(()->new EventBaseVO());
        if(vo.getContent().indexOf("/_images/common/event_img")>-1){
            vo.setIsKaKaoChannelYn(FrontConstants.COMM_YN_Y);
        }
        return Optional.ofNullable(frontEventDao.getEventDetail(so)).orElseGet(()->new EventBaseVO());
    }

    @Override
    public List<EventEntryWinInfoVO> listEventReply(Long eventNo) {
    	List<EventEntryWinInfoVO> eventReplyList = frontEventDao.listEventReply(eventNo);
    	
    	if(eventReplyList.size() > 0) {
    		for(int i=0; i < eventReplyList.size(); i++) {
    			boolean updateFlag = false;
    			
    			String[] aplySplit = eventReplyList.get(i).getEnryAply().split("@"); //화면에 보내질 댓글
    			String[] updateAplySplit = eventReplyList.get(i).getEnryAply().split("@"); //멘션한 닉네임이 변경되었을때 업데이트에 사용
    			
    			//멘션 추출
    			List<String> nickNmList = StringUtil.getTags(eventReplyList.get(i).getEnryAply(), "@");
    			
    			//댓글 멘션 회원정보 조회
    			EventMentionMemberPO mentionMbrPO = new EventMentionMemberPO(); 
            	mentionMbrPO.setEventNo(eventNo);
            	mentionMbrPO.setAplyNo(eventReplyList.get(i).getPatiNo().intValue());
            	
            	List<EventMentionMemberVO> mentionMbrList = frontEventDao.selectEventMentionList(mentionMbrPO);
    		
            	//멘션 추출한 닉네임이 값이 있는경우 
            	if((!nickNmList.isEmpty() && nickNmList.size() > 0)) {
            		//댓글 멘션 회원정보 테이블이 생기고 난 후 등록된 멘션 처리
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
							EventEntryWinInfoPO replyPO = new EventEntryWinInfoPO();
							replyPO.setPatiNo(eventReplyList.get(i).getPatiNo()); 
							replyPO.setEventNo(eventNo);
							replyPO.setMbrNo(eventReplyList.get(i).getMbrNo()); 
							replyPO.setEnryAply(String.join("@", updateAplySplit)); 
							
							frontEventDao.updateEventDetailReply(replyPO);
						}
            			
            		}
            		//댓글 멘션 회원정보 테이블이 없었을때 등록된 멘션 처리
            		else{
            			
            			for(int j=0; j < mentionMbrList.size(); j++){
            				
            				//탈퇴한 회원인 경우
                    		MemberBaseVO mbvo = memberDao.getMentionSearchInfo(mentionMbrList.get(i).getMbrNo());
                    		
                    		if(mbvo == null) {
                    			aplySplit[j+1] = StringUtil.replaceAll(aplySplit[j+1], mentionMbrList.get(i).getNickNm(), "어바웃펫회원");
                    		}else {
                    			aplySplit[j+1] = StringUtil.replaceAll(aplySplit[j+1], mentionMbrList.get(i).getNickNm(), mentionMbrList.get(i).getNickNm()+"|");
                    		}
                    		
//                    		MemberBaseVO vo = Optional.ofNullable(memberDao.getMentionInfo(nickNm)).orElseGet(()-> new MemberBaseVO());
            				//탈퇴한 회원인 경우
                        	/*	if(StringUtil.equals(vo.getMbrStatCd(), CommonConstants.MBR_STAT_50)) {
                        			v.setEnryAply(StringUtil.replaceAll(v.getEnryAply(), "@"+nickNm, "@어바웃펫회원"));
                        		}*/
                    	}
            		}
            	}
    		
            	eventReplyList.get(i).setEnryAply(String.join("@", aplySplit));
    		}
    	}
    	return eventReplyList;
    }

    @Override
    public Long saveEventEntryInfo(EventEntryWinInfoPO po) {
    	
        Long patiNo = Optional.ofNullable(po.getPatiNo()).orElseGet(()->0L);
        
        if(Long.compare(patiNo,0L) == 0){
        	//댓글 insert 
        	List<String> nickNmList = StringUtil.getTags(po.getEnryAply(), "@"); 
        	List<String> nickNms = new ArrayList<String>(); 
        	if( nickNmList != null && nickNmList.size() > 0) {			
    			for(String nickNm : nickNmList) {
    				//esacpe처리된 ' 문자가 태그 구분을 위한 #에 걸려 unescape처리 후 닉네임으로 회원 조회 시 다시 escape처리
    				if(StringEscapeUtils.unescapeHtml4(nickNm).indexOf("#") > -1) {
    					nickNm = StringEscapeUtils.unescapeHtml4(nickNm).substring(0, nickNm.indexOf("#"));
    				}
    				nickNms.add(nickNm);
    			}
    			nickNms = nickNms.stream().distinct().collect(Collectors.toList());
    		}
        	//이벤트 기존테이블 댓글등록 
        	int result = frontEventDao.insertEventEntryInfo(po);
        	
        	if(result != 1) {
        		throw new CustomException(ExceptionConstants.ERROR_CODE_FRONT_DEFAULT);
        	}else {
        		MemberBaseSO mbso = new MemberBaseSO();
        		mbso.setMbrNo(po.getMbrNo());
        		MemberBaseVO mbvo = Optional.ofNullable(memberService.getMemberBase(mbso)).orElseGet(()->new MemberBaseVO());
        		
        		//댓글 멘션 insert 
        		if( nickNms != null && nickNms.size() > 0) {	
	        		EventMentionMemberPO mntMbrPo = null;
	        		MemberBaseSO mb = null;
	        		for(int i = 0; i < nickNms.size(); i++) {
	        			mb = new MemberBaseSO();
	        			mb.setNickNm(nickNms.get(i));
	        			MemberBaseVO mvo = frontEventDao.getMbrBaseInfo(mb); 
	        		
	        		if(!StringUtil.isEmpty(mvo)) {
	        		mntMbrPo = new EventMentionMemberPO();
	        		mntMbrPo.setEventNo(po.getEventNo()); 
	        		mntMbrPo.setAplyNo(po.getPatiNo().intValue()); 
	        		mntMbrPo.setMetnSeq(i+1); 
	        		mntMbrPo.setMetnTgMbrNo(mvo.getMbrNo());
	        		mntMbrPo.setMetnMbrNo(po.getMbrNo()); 
	        		int mntnResult = frontEventDao.insertEventReplyMention(mntMbrPo);
	        		
	        		if(mntnResult != 1) {
	        			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
	        		}else {
	        			replyMetionEvnet(po); 
	        		}
	        		
	        		}
        		}
    		}
    	}
        	
        }else{
        	//update 
        	EventMentionMemberSO etmnSO = new EventMentionMemberSO();
        	etmnSO.setEventNo(po.getEventNo());
        	etmnSO.setAplyNo(po.getPatiNo().intValue());
        	List<EventMentionMemberVO> etmnList = frontEventDao.eventReplyMentionList(etmnSO);
        	frontEventDao.deleteEventMention(etmnSO); 
        	
        	
        	//댓글 update 
        	List<String> pushNickNms = new ArrayList<>();
        	List<String> nickNmList = StringUtil.getTags(po.getEnryAply(), "@"); 
        	List<String> nickNms = new ArrayList<String>(); 
        	if( nickNmList != null && nickNmList.size() > 0) {			
    			for(String nickNm : nickNmList) {
    				//esacpe처리된 ' 문자가 태그 구분을 위한 #에 걸려 unescape처리 후 닉네임으로 회원 조회 시 다시 escape처리
    				if(StringEscapeUtils.unescapeHtml4(nickNm).indexOf("#") > -1) {
    					nickNm = StringEscapeUtils.unescapeHtml4(nickNm).substring(0, nickNm.indexOf("#"));
    				}
    				nickNms.add(nickNm);
    			}
    			nickNms = nickNms.stream().distinct().collect(Collectors.toList());
    		}
        	
        	int result = frontEventDao.updateEventEntryInfo(po);
        
        	if(result == 0) {
        		throw new CustomException(ExceptionConstants.ERROR_CODE_FRONT_DEFAULT);
        	}else {
        		MemberBaseSO mbso = new MemberBaseSO();
        		mbso.setMbrNo(po.getMbrNo());
        		MemberBaseVO mbvo = Optional.ofNullable(memberService.getMemberBase(mbso)).orElseGet(()->new MemberBaseVO());
        			
        			
	        		EventMentionMemberPO mntMbrPo = null;
	        		MemberBaseSO mb = null;
	        		
	        		for(int i=0; i < nickNms.size(); i++){

	        			mb = new MemberBaseSO();
	        			mb.setNickNm(nickNms.get(i));
	        			MemberBaseVO mvo = frontEventDao.getMbrBaseInfo(mb); 
	        		
		        		if(!StringUtil.isEmpty(mvo)) {
			        		mntMbrPo = new EventMentionMemberPO();
			        		mntMbrPo.setEventNo(po.getEventNo()); 
			        		mntMbrPo.setAplyNo(po.getPatiNo().intValue()); 
			        		mntMbrPo.setMetnSeq(i+1);
			        		mntMbrPo.setMetnTgMbrNo(mvo.getMbrNo()); 
			        		mntMbrPo.setMetnMbrNo(po.getMbrNo()); 
			        		int mntnResult = frontEventDao.insertEventReplyMention(mntMbrPo);
			        		
			        		if(mntnResult != 1) {
			        			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			        		}else {
			        			//List<String> nickArr = new ArrayList<String>();
			        			
			        			for(EventMentionMemberVO v : etmnList) {
			        				//업데이트 전 멘션된 회원은 push보내지 않음 
			        				if(v.getMetnTgMbrNo() != mvo.getMbrNo()) {
			        					pushNickNms.add(mvo.getNickNm()); 
			        				}
			        			}
			        		
			        			//po.PushNickNmList(nickArr);
			        			replyMetionEvnet(po);
			        	}
		        	}
        		}	
        	}
        }
      ;
        return po.getPatiNo();
    }

    private void replyMetionEvnet(EventEntryWinInfoPO po) {
		if(po.getNickNmArr() != null && po.getNickNmArr().length != 0) {
			PushSO pso = new PushSO();
			pso.setTmplNo(168L);
			PushVO template = Optional.ofNullable(pushDao.getNoticeTemplate(pso)).orElseGet(()->new PushVO());
			
			if (StringUtil.isNotBlank(template.getSubject()) && StringUtil.isNotBlank(template.getContents())) {
				for(int i=0; i<po.getNickNmArr().length; i++) {
					MemberBaseVO mbvo = Optional.ofNullable(memberDao.getMentionInfo(po.getNickNmArr()[i])).orElseGet(()->new MemberBaseVO());
					
					if (!StringUtil.equals(mbvo.getMbrStatCd(), CommonConstants.MBR_STAT_50) && mbvo.getMbrNo() != null) {
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

	@Override
    public void deleteEventEntryInfo(EventEntryWinInfoPO po) {
   
		int result = frontEventDao.deleteEventEntryInfo(po);
		
		if(result == 0) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_FRONT_DEFAULT);
		}else {
			EventMentionMemberSO mntMbrSo = new EventMentionMemberSO();
			mntMbrSo.setEventNo(po.getEventNo());
			mntMbrSo.setAplyNo(po.getPatiNo().intValue());
			int mentionResult = frontEventDao.deleteEventReplyMention(mntMbrSo); 
		}
    }
}

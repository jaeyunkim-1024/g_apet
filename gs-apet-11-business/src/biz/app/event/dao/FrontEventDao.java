package biz.app.event.dao;

import biz.app.event.model.EventBaseSO;
import biz.app.event.model.EventBaseVO;
import biz.app.event.model.EventEntryWinInfoPO;
import biz.app.event.model.EventEntryWinInfoVO;
import biz.app.event.model.EventMentionMemberPO;
import biz.app.event.model.EventMentionMemberSO;
import biz.app.event.model.EventMentionMemberVO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBaseVO;
import framework.common.dao.MainAbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FrontEventDao extends MainAbstractDao {
    private static final String BASE_DAO_PACKAGE = "frontEvent.";

    public List<EventBaseVO> listEvent(EventBaseSO so){
        return selectListPage(BASE_DAO_PACKAGE + "listEvent",so);
    }

    public EventBaseVO getEventDetail(EventBaseSO so){
        return selectOne(BASE_DAO_PACKAGE + "getEventDetail",so);
    }

    public List<EventEntryWinInfoVO> listEventReply(Long eventNo){
        return selectList(BASE_DAO_PACKAGE + "listEventReply",eventNo);
    }

    public int insertEventEntryInfo(EventEntryWinInfoPO po){
        return insert(BASE_DAO_PACKAGE + "insertEventEntryInfo",po);
    }

    public int updateEventEntryInfo(EventEntryWinInfoPO po){
        return update(BASE_DAO_PACKAGE + "updateEventEntryInfo",po);
    }

    public int deleteEventEntryInfo(EventEntryWinInfoPO po){
        return delete(BASE_DAO_PACKAGE + "deleteEventEntryInfo",po);
    }

	public int insertEventReplyMention(EventMentionMemberPO po) {
		return insert(BASE_DAO_PACKAGE + "insertEventReplyMention" , po);
	}

	public MemberBaseVO getMbrBaseInfo(MemberBaseSO mb) {
		return selectOne(BASE_DAO_PACKAGE + "getMbrBaseInfo" , mb);
	}

	public int deleteEventReplyMention(EventMentionMemberSO mntMbrSo) {
		return delete(BASE_DAO_PACKAGE + "deleteEventReplyMention" , mntMbrSo);
	}

	public List<EventMentionMemberVO> eventReplyMentionList(EventMentionMemberSO etmnSO) {
		return selectList(BASE_DAO_PACKAGE + "eventReplyMentionList" , etmnSO);
	}

	public int deleteEventMention(EventMentionMemberSO etmnSO) {
		return delete(BASE_DAO_PACKAGE + "deleteEventgMention" , etmnSO); 
	}

	public List<EventMentionMemberVO> selectEventMentionList(EventMentionMemberPO mentionMbrPO) {
		return selectList(BASE_DAO_PACKAGE + "selectEventMentionList", mentionMbrPO);
	}

	public int updateEventDetailReply(EventEntryWinInfoPO replyPO) {	
		return update(BASE_DAO_PACKAGE + "updateEventDetailReply", replyPO);
	}

	
}

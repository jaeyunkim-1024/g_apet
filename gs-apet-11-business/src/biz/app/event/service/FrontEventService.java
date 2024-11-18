package biz.app.event.service;

import biz.app.event.model.EventBaseSO;
import biz.app.event.model.EventBaseVO;
import biz.app.event.model.EventEntryWinInfoPO;
import biz.app.event.model.EventEntryWinInfoVO;

import java.util.List;

public interface FrontEventService {

    public List<EventBaseVO> listIngEvent(EventBaseSO so);

    public List<EventBaseVO> listEndEvent(EventBaseSO so);

    public EventBaseVO getEventDetail(EventBaseSO so);

    public List<EventEntryWinInfoVO> listEventReply(Long eventNo);

    public Long saveEventEntryInfo(EventEntryWinInfoPO po);

    public void deleteEventEntryInfo(EventEntryWinInfoPO po);
}

package biz.app.event.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class EventEntryWinInfoSO extends BaseSearchVO<EventEntryWinInfoSO> {
    /** UID */
    private static final long serialVersionUID = 1L;

    /** 이벤트 번호*/
    private Long eventNo;

    /** 참여자 이름*/
    private String patirNm;

    /** 핸드폰 번호*/
    private String ctt;
}

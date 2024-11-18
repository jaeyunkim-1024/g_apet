package biz.app.event.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class EventCollectItemVO extends BaseSysVO {
    /** UID */
    private static final long serialVersionUID = 1L;

    /** 항목 번호 */
    private Long itemNo;

    /** 이벤트 번호 */
    private Long eventNo;

    /** 수집 항목 코드 */
    private String collectItemCd;
}

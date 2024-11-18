package biz.app.event.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class EventAddFieldPO extends BaseSysVO {
    /** UID */
    private static final long serialVersionUID = 1L;

    /** 필드 번호*/
    private Long fldNo;

    /** 이벤트 번호 */
    private Long eventNo;

    /** 필드 그룹 */
    private String fldGrp;

    /** 필드 타입 코드 */
    private String fldTpCd;

    /** 필드 명*/
    private String fldNm;

    /** 필드 값 */
    private String fldVal;

    /** 이미지 설명*/
    private String imgDscrt;

    /** 코멘트 */
    private String fldDscrt;

    /** 필드 값 배열 */
    private String fldVals;

    private String originalPath;
}

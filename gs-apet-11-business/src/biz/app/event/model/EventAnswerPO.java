package biz.app.event.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class EventAnswerPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 답변 번호*/
	private Long rplNo;

	/** 문항 번호 */
	private Long qstNo;

	/** 이벤트 번호 */
	private Long eventNo;

	/** 답변 내용 */
	private String rplContent;

	/** 정답 여부 */
	private String rghtansYn;

}
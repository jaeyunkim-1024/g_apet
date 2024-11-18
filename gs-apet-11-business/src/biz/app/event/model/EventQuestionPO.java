package biz.app.event.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class EventQuestionPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 문항 번호 */
	private Long qstNo;

	/** 이벤트 번호 */
	private Long eventNo;

	/** 문항 명 */
	private String qstNm;

	/** 문항 타입 코드 */
	private String qstTpCd;

	/** 답변 내용*/
	private String rplContents;

	/** 정답 여부*/
	private String rghtansYns;

	/** 답변 개수 */
	private Integer rplCnt;

}
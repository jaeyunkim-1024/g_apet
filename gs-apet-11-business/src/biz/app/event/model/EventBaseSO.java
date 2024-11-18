package biz.app.event.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class EventBaseSO extends BaseSearchVO<EventBaseSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 이벤트 번호 */
	private Long eventNo;

	/** 제목 */
	private String ttl;

	/** 이벤트 유형 코드 */
	private String eventTpCd;

	/** 이벤트 구분 코드 */
	private String eventGbCd;

	/** 이벤트 구분2 코드 */
	private String eventGb2Cd;

	/** 이벤트 상태 코드*/
	private String eventStatCd;

	/** 대표 이미지 경로 */
	private String dlgtImgPath;

	/** 전시 여부 */
	private String dispYn;

	/** 내용 */
	private String content;

	/** 댓글 사용 여부 */
	private String aplyUseYn;

	/** 적립금 */
	private Long saveAmt;

	/** 전시 시작 일시 */
	private Timestamp dispStrtDtm;

	/** 전시 종료 일시 */
	private Timestamp dispEndDtm;

	/** 시작 일시 */
	private Timestamp strtDate;

	/** 종료 일시 */
	private Timestamp endDate;

	/** 사이트 아이디 */
	private Long stId;

	/** 이벤트 당첨자 발표 여부 */
	private String eventWinYn;

	/** 이벤트 정렬 기준 */
	private String eventSortType;

	private Timestamp sysRegDtm;

	/** 전시 분류 번호 */
	private Long dispClsfNo;

	/** 전시 분류 번호 LNB */
	private Long lnbDispClsfNo;

}
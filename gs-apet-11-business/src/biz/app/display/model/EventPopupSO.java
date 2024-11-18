package biz.app.display.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class EventPopupSO extends BaseSearchVO<EventPopupSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 이벤트팝업번호 */
	private Long evtpopNo;

	/** 이벤트 팝업 구분코드(게시구분) */
	private String evtpopGbCd;

	/** 이벤트팝업 개시위치 코드 */
	private String evtpopLocCd;

	/** 제목 */
	private String evtpopTtl;

	/** 이미지경로 */
	private String evtpopImgPath;

	/** 연결화면 경로 */
	private String evtpopLinkUrl;

	/** 게시 시작일시 */
	private Timestamp displayStrtDtm;

	/** 게시 종료 일시 */
	private Timestamp displayEndDtm;

	/** 이벤트 상태 코드(게시여부) */
	private String evtpopStatCd;

	/** 이벤트 진행 여부 */
	private String progressStatCd;

	/** 정렬 순서 */
	private int evtpopSortSeq;
	
	private String excelYn;

}
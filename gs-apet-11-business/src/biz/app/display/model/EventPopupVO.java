package biz.app.display.model;

import java.sql.Timestamp;
import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class EventPopupVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 이벤트팝업번호 */
	private Long evtpopNo;

	/** 이벤트 팝업 구분코드(게시구분) */
	private String evtpopGbCd;
	private String evtpopGbNm;

	/** 이벤트팝업 개시위치 코드 */
	private String evtpopLocCd;
	private String evtpopLocNm;

	/** 제목 */
	private String evtpopTtl;

	/** 이미지경로 */
	private String evtpopImgPath;

	/** 이미지 파일명 */
	private String evtpopImgNm;

	/** 연결화면 경로 */
	private String evtpopLinkUrl;

	/** 게시 시작일시 */
	private Timestamp displayStrtDtm;

	/** 게시 종료 일시 */
	private Timestamp displayEndDtm;
	private String strtEndDtm;

	/** 이벤트 상태 코드(게시여부) */
	private String evtpopStatCd;
	private String evtpopStatNm;
	
	/** 이벤트 진행 여부 */
	private String progressStatCd;
	private String progressStatNm;

	/** 정렬 순서 */
	private int evtpopSortSeq;
	
	/** 원본파일명 */
	private String orgFileNm;
	
	/** 원본 경로 */
	private String phyPath;
	
	/** 원본 사이즈 */
	private Long flSz; 
	
	private Long flNo;
	
	private Long rowIndex;

}
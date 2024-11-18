package biz.app.appweb.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.model
 * - 파일명		: PushSO.java
 * - 작성일		: 2020. 12. 21. 
 * - 작성자		: hjh
 * - 설 명		: push/문자 발송 Search Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class PushSO extends BaseSearchVO<PushSO> {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 이력 통지 번호 */
	private Long noticeSendNo;
	
	/** 발송 방식 */
	private String noticeTypeCd;
	
	/** 전송 방식 */
	private String sndTypeCd;
	
	/** 카테고리 */
	private String ctgCd;
	
	/** 메시지 타이틀 */
	private String subject;
	
	/** 발송 건수 */
	private Integer noticeMsgCnt;
	
	/** 발송 요청 여부 */
	private String sendReqYn;
	
	/** 발송일자 */
	private Timestamp sendReqDtm;
	
	/** 검색어 */
	private String searchTxt;
	
	/** 검색 구분 */
	private String searchGb;
	
	/** 기간 검색 구분 */
	private String dateSearchGb;
	
	/** 발송일자/예약일자 시작 시간 */
	private Timestamp strtDate;
	
	/** 발송일자/예약일자 종료 시간 */
	private Timestamp endDate;
	
	/** 엑셀 sheetname */
	private String sheetName;
	
	/** 엑셀 fileName */
	private String fileName;
	
	/** 엑셀 headerName (배열) */
	private String[] headerName;
	
	/** 엑셀 fieldName (배열) */
	private String[] fieldName;
	
	/** push 구분 */
	private String pushTpGb;
	
	/** 외부API 요청 아이디 */
	private String outsideReqId;
	
	/** 템플릿 번호 */
	private Long tmplNo;
	
	/** 템플릿 일련번호 */
	private String tmplCd;
	
	/** 템플릿 목록 팝업 구분 */
	private String tmplPopGb;
	
	/** 발송 결과 코드 없음 */
	private String sndRstCdNullYn;
	
	private Long mbrNo;
	
	private String sysCd;
}

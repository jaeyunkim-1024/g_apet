package biz.app.appweb.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.model
 * - 파일명		: PushVO.java
 * - 작성일		: 2020. 12. 21. 
 * - 작성자		: hjh
 * - 설 명		: push/문자 발송 Value Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class PushVO extends NoticeSendCommonVO {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 발송 건수 */
	private Integer noticeMsgCnt;
	
	/** 발송 결과 : 성공 */
	private Integer successCnt;
	
	/** 발송 결과 : 실패 */
	private Integer failCnt;
	
	/** 엑셀 다운로드 결과 */
	private String resultYN;
	
	/** 엑셀 다운로드 결과 메시지 */
	private String resultMsg;
	
	/** 로그인 아이디 */
	private String loginId;
	
	/** 회원 구분 */
	private String mbrGbCd;
	
	/** 등록자 명 */
	private String sysRegrNm;
	
	/** 수정자 명 */
	private String sysUpdrNm;
	
	/** 엑셀 다운로드 시스템 코드 */
	private String sysCode;
	
	/** 엑셀 다운로드 템플릿 일련번호 */
	private String tmplCode;
	
	/** 회원 명 */
	private String mbrNm;
	
	/** 수신대상자 정보  */
	private String receiverStr;
	
	/** 알람 수신 여부 */
	private String almRcvYn;
	
	private Integer dateDiff;
	
	private String landingUrl;
	
	private String strDateDiff;
}

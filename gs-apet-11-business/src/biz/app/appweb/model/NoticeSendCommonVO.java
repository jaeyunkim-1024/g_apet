package biz.app.appweb.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.model
 * - 파일명		: NoticeSendCommonVO.java
 * - 작성일		: 2020. 12. 21. 
 * - 작성자		: hjh
 * - 설 명		: Push 공통 Value Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class NoticeSendCommonVO extends BaseSysVO {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 이력 통지 번호 */
	private Long noticeSendNo;
	
	/** 이력 상세 번호 */
	private Long histDtlNo;
	
	/** 발송 방식 */
	private String noticeTypeCd;
	
	/** 디바이스 종류 */
	private String deviceTypeCd;
	
	/** 디바이스 토큰 */
	private String deviceTkn;
	
	/** 템플릿 번호 */
	private Long tmplNo;
	
	/** 제목 */
	private String subject;
	
	/** 내용 */
	private String contents;
	
	/** 회원 번호 */
	private Long mbrNo;
	
	/** 발신자 번호 */
	private String sndrNo;
	
	/** 수신자 번호 */
	private String rcvrNo;
	
	/** 발신자 이메일 */
	private String senderEmail;
	
	/** 수신자 이메일 */
	private String receiverEmail;
	
	/** 발송 요청 여부 */
	private String sendReqYn;
	
	/** 발송 요청 일시 */
	private Timestamp sendReqDtm;

	/*팝업 전용 문자열 날짜*/
	private String sendReqTime;
	
	/** 요청 결과 코드 */
	private String reqRstCd;
	
	/** 발송 결과 코드 */
	private String sndRstCd;

	/*발송 결과 이름*/
	private String sndRstNm;
	
	/** 외부API 요청 아이디 */
	private String outsideReqId;
	
	/** 사이트 아이디 */
	private Long stId;
	
	/** 카테고리 */
	private String ctgCd;
	
	/** 전송 방식 */
	private String sndTypeCd;

	/*발송 수단*/
	private String sndTypeNm;

	/*대상자 수*/
	private Long cnt;

	/** 템플릿 시작 일자 */
	private String tmplStrtDt;
	
	/** 템플릿 종료 일자 */
	private String tmplEndDt;
	
	/** 사용 여부 */
	private String useYn;
	
	/** 템플릿 일련번호 */
	private String tmplCd;
	
	/** 시스템 코드 */
	private String sysCd;
	
	/** 시스템 사용 여부 */
	private String sysUseYn;

	/*로그인 아이디*/
	private String loginId;

	/*회원 이름*/
	private String mbrNm;

	private String receiverInfo;

	private Long rowNum;
	
	/** 이미지 경로 */
	private String imgPath;
	
	/** 이동 경로 */
	private String movPath;

	/** 발송 정보 json*/
	private String sndInfo;
}

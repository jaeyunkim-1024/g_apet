package biz.app.appweb.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.appweb.model
 * - 파일명		: NoticeSendListVO.java
 * - 작성일		: 2021. 02. 16. 
 * - 작성자		: KKB
 * - 설 명		: 알림 발송 상세 리스트 Value Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class NoticeSendListDetailVO extends BaseSysVO {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 이력 상세 번호 */
	private Long histDtlNo;
	
	/** 이력 통지 번호 */
	private Long noticeSendNo;
	
	/** 제목 */
	private String subject;
	
	/** 내용 */
	private String contents;
	
	/** 발신 정보 */
	private String sndInfo;
	
	/** 회원 번호 */
	private Long mbrNo;
	
	/** 디바이스 종류 */
	private String deviceTypeCd;
	
	/** 디바이스 토큰 */
	private String deviceTkn;
	
	/** 수신자 번호 */
	private String rcvrNo;
	
	/** 수신자 이메일 */
	private String receiverEmail;
	
	/** 발송 요청 여부 */
	private String sendReqYn;
	
	/** 발송 요청 일시 */
	private Timestamp sendReqDtm;
	
	/** 발송 결과 코드 */
	private String sndRstCd;
	
	/** 외부API 요청 상세 아이디 */
	private String outsideReqDtlId;
	
	/** 외부API 요청 아이디 */
	private String outsideReqId;
	
	/** 전송 방식 */
	private String sndTypeCd;
	
}

package biz.common.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.common.model
* - 파일명		: SsgSmsSendPO.java
* - 작성일		: 2021. 1. 27.
* - 작성자		: snw
* - 설명		: SMS 전송 PO
* </pre>
*/
@Data
public class SsgSmsSendPO  implements Serializable{

	private static final long serialVersionUID = 1L;

	/* GW 일련번호 */
	private Long fserial;

	/* 그룹일련번호 (SSG_SEND_TRAN_GROUP 이용시에만 사용)*/
	private Long fgroupseq;

	/** USER계정 */
	private String	fuserid;

	/** 계층코드, SINC로부터 부여받은 코드값 */
	private String fsectioncode;

	/** 캠페인코드, CRM전송등에 이용 */
	private String fcampcode;

	/* 메시지타입
	 * 0: SMS
	 * 2: LMS
	 * 3: MMS
	 * 4: KKO
	 * 6: KKF
	 * 7: KKI
	 */
	private Long fmsgtype;

	/** 메시지본문 */
	private String fmessage;

	/** 메시지 발송할 시간(예약메시지인경우 해당 예약일시) */
	private Timestamp fsenddate;

	/* 전송상태
	 * 0: 전송대기
	 * 2: 결과대기(GW전송완료)
	 * 3: 결과수신완료
	 * 4: 로그 이동 실패 
	 */
	private Long fsendstat;

	/** 수신자 전화번호 */
	private String fdestine;

	/** 발신자 전화번호(회신번호) */
	private String fcallback;

	/** 전송처리결과 (06 성공, 기타 실패) */
	private String frsltstat;

	/** 착신통신사정보 (SKT, KTF, LGT, ETC) */
	private String fmobilecomp;

	/** 최초레코드입력시간(현재시간 기본값) */
	private Timestamp finsertdate;

	/** 통신사 메시지 처리시간 */
	private Timestamp frsltdate;

	/** 전송테이블에서 로그테이블로 이동된 시간 */
	private Timestamp fmodidate;

	/** 메시지내용에 %%%CHANGEWORDNAME%%% 이 포함된경우 해당 필드 내용으로 치환 */
	private String fchangeword1;

	/** 메시지내용에 %%%CHANGEWORDETC1%%% 이 포함된경우 해당 필드 내용으로 치환 */
	private String fchangeword2;

	/** 메시지내용에 %%%CHANGEWORDETC2%%% 이 포함된경우 해당 필드 내용으로 치환 */
	private String fchangeword3;

	/** 메시지내용에 %%%CHANGEWORDETC3%%% 이 포함된경우 해당 필드 내용으로 치환 */
	private String fchangeword4;

	/** 메시지내용에 %%%CHANGEWORDETC4%%% 이 포함된경우 해당 필드 내용으로 치환 */
	private String fchangeword5;

	/** 사용자 자유 입력 필드 */
	private String fetc1;

	/** 사용자 자유 입력 필드 */
	private String fetc2;

	/** 사용자 자유 입력 필드 */
	private String fetc3;

	/** 사용자 자유 입력 필드 */
	private String fetc4;

	/** 사용자 자유 입력 필드 */
	private String fetc5;

	/** 사용자 자유 입력 필드 */
	private String fetc6;

	/** 사용자 자유 입력 필드 */
	private String fetc7;

	/** 사용자 자유 입력 필드 */
	private String fetc8;
	
	/** 메세지 구분 코드 */
	private String sndTypeCd;

	/** 수신 정보 */
	private List<SsgMessageRecivePO> recipients;

	/** 템플릿 번호 */
	private Long tmplNo;
}
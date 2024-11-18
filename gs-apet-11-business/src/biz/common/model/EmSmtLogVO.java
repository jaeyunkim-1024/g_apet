package biz.common.model;

import java.io.Serializable;
import java.sql.Timestamp;

import lombok.Data;



/**
 *
* <pre>
* - 프로젝트명   : 11.business
* - 패키지명   : biz.common.model
* - 파일명      : EmSmtLogVO.java
* - 작성일      : 2017. 6. 26.
* - 작성자      : valuefactory 권성중
* - 설명      : em_sms_log_yyyymm 테이블
* </pre>
 */
@Data
public class EmSmtLogVO implements Serializable {

	private static final long serialVersionUID = 1L;
	/** 마스터키 */
	private String mtPr;
	/** 전송예약시간 */
	private Timestamp dateClientReq;
	/** 발신자전화번호 */
	private String callback;
	/** 전송메세지 */
	private String content;
	/** 수신자전화번호 */
	private String recipientNum;
	/** 메세지상태 1-전송대기,2-결과대기 ,3-완료*/
	private String msgStatus;

	private String mtSeq;
	private String msgKey;
	private String inputType;
	private String mtRefkey;
	private String priority;
	private String serviceType;
	private String broadcastYn;
	private String changeWord1;
	private String changeWord2;
	private String changeWord3;
	private String changeWord4;
	private String changeWord5;
	private String dateMtSent;
	private String dateRslt;
	private String dateMtReport;
	private String mtReportCodeIb;
	private String mtReportCodeIbtype;
	private String carrier;
	private String rsId;
	private String recipientNet;
	private String recipientNpsend;
	private String countryCode;
	private String charset;
	private String msgType;
	private String cryptoYn;
	private String ttl;
	private String emmaId;
	private String regDateTran;
	private String regDate;
	private String mtResCnt;
	private String gubun;
}
package biz.common.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import framework.common.constants.CommonConstants;
import framework.common.model.BaseSysVO;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.common.model
* - 파일명		: PushPO.java
* - 작성일		: 2021. 01. 18.
* - 작성자		: KKB
* - 설명		: PUSH PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class SendPushPO extends BaseSysVO{

	private static final long serialVersionUID = 1L;

	/** 메시지 타입 : NOTIF - 알림 메시지, AD - 광고성 메시지*/
	private String messageType;
	
	/** target */
	private List<PushTargetPO> target;
	
	/** 제목 */
	private String title;
	
	/** 메시지 내용*/
	private String body;

	
	/** 탬플릿 번호 */
	private Long tmplNo;
	
	/** 수신대상 타입 :  ALL - 서비스에 등록된 모든 디바이스, CHANNEL - 채널에 등록된 모든 디바이스, USER - 사용자에 바인딩된 모든 디바이스*/
	private String type = "USER";
	
	/** 수신대상 디바이스 타입 :GCM - Android, APNS - iOS, (null 일 경우 모든 디바이스) */
	private String deviceType;
	
	/** 수신대상 국가코드 */
	private String country;
	
	/** 예약 발송 일시 yyyy-MM-dd HH:mm:ss **/
	private String reservationDateTime;
	
	/** 예약 발송 일시 **/
	private Timestamp sendReqDtm;
	
	public Timestamp getSendReqDtm() {		
		return (StringUtil.isNotEmpty(this.sendReqDtm))? this.sendReqDtm : (StringUtil.isNotEmpty(this.reservationDateTime))?DateUtil.getTimestamp(this.reservationDateTime, "yyyy-MM-dd HH:mm:ss"):null;
	}
	
	/** 라이브 여부 */
	private String liveYn;
	
	/** 정보성 구분  코드 */
	private String infoTpCd;
	
	/** 알림메시지 발송 구분(수동) */
	private String pushGb;
	
}
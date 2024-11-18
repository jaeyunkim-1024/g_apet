package biz.common.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

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
public class NaverPushPO implements Serializable {

	private static final long serialVersionUID = 1L;

	/** 메시지 타입 : NOTIF - 알림 메시지, AD - 광고성 메시지*/
	private String messageType = "NOTIF";
	
	/** target */
	private NaverPushTargetPO target;
	
	/** 발송 공통메시지 : message.default.XXX, message.gcm.XXX, message.apns.XXX로 구분이 가능하며, message.default는 필수로 작성해야한다. 적용 우선순위는 gcm = apns > default 이다.*/
	private Map<String, PushMessagePO> message;	
	
	/** 예약 일시 */
	private String reserveTime;
	
	/** 예약 일시 : 미사용 */
	private String reserveTimeZone;
}
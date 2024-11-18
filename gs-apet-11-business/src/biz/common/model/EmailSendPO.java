package biz.common.model;

import java.sql.Timestamp;
import java.util.List;

import framework.common.model.BaseSysVO;
import framework.common.util.DateUtil;
import framework.common.util.StringUtil;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.common.model
* - 파일명		: EmailSend.java
* - 작성일		: 2021. 01. 18.
* - 작성자		: KKB
* - 설명		: 이메일 전송 PO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class EmailSendPO extends BaseSysVO{

	private static final long serialVersionUID = 1L;

	/** 템플릿 번호 */
	private Long tmplNo;
	
	/** 발신자 주소 */
	private String senderAddress;
	
	/** 예약 발송 일시 **/
	private String reservationDateTime;
	
	/** 예약 발송 일시 **/
	private Timestamp sendReqDtm;
	
	/** 이메일 정보 */
	private List<EmailRecivePO> recipients;
	
	/** title */
	private String title;
	
	/** body */
	private String body;
	
	public Timestamp getSendReqDtm() {		
		return (StringUtil.isNotEmpty(this.sendReqDtm))? this.sendReqDtm : (StringUtil.isNotEmpty(this.reservationDateTime))?DateUtil.getTimestamp(this.reservationDateTime, "yyyy-MM-dd HH:mm:ss"):null;
	}
	
	/** 정보성 구분  코드 */
	private String infoTpCd;
	
	/** 알림메시지 발송 구분(수동) */
	private String pushGb;

}
package biz.app.emma.model;

import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.emma.model
* - 파일명		: SmtTranPO.java
* - 작성일		: 2017. 2. 2.
* - 작성자		: WilLee
* - 설명			: SMS 전송(EMMA)
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SmtTranPO extends BaseSysVO {

	private static final long serialVersionUID = 1L;

	// primary key
	private Integer mtPr;

	// 전송 예약 시간
	private String dateClientReq;

	// 메시지 제목
	private String subject;

	// 전송 메시지
	private String content;

	// 발신자 전화 번호(회신 번호)
	private String callback;

	// 서비스 메시지 전송 타입 (0-SMS MT, 1-CALLBACK URL)
	private String serviceType;

	// 동보발송유무 ('N' : 단일건, 'Y' :동보건)
	private String broadcastYn;

	// 메시지 상태 (1-전송대기, 2-결과대기, 3-완료)
	private String msgStatus;

	// 수신자 전화 번호(수신번호) - 단일 발송인 경우 사용
	private String recipientNum;

	private List<SmtClientPO> smtClients;

}
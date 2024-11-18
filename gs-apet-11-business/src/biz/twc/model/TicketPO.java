package biz.twc.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class TicketPO {
	/** API 사용자 Key */
	private String apiKey;
	
	/** 티켓 디스플레이 아이디  */
	private String ticketDispId;
	
	/** 이벤트 코드 */
	private Long eventCode;
	
	/** 티켓 사건 추가 입력사항 */
	private String content;
	
	/** 상담사 로그인 아이디 */
	private String agentLoginId;
}
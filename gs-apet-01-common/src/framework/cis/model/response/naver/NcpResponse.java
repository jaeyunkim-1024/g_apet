package framework.cis.model.response.naver;

import lombok.Data;

@Data
public class NcpResponse<T> {
	
	/** 호출 아이디 */
	private String callId;

	/** 결과 코드 */
	private String resCd;

	/** 결과 메시지 */
	private String resMsg;
	
	/** 응답 resTxt */
	private String resTxt;
}

package biz.app.pay.model;

import java.sql.Timestamp;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.pay.model
* - 파일명		: PayBaseVO.java
* - 작성일		: 2017. 1. 12.
* - 작성자		: snw
* - 설명			: 결제 기본 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class PayIfLogVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private Long	logNo         ; // 로그번호
	private String	ordNo		  ; // 주문번호
	private String	tid			  ; // 트랜잭션아이디
	private String	resCd         ; // 결과코드
	private String	resMsg        ; // 결과메시지
	private String	reqJson       ; // 요청 JSON
	private String	resJson       ; // 응답 JSON
	private Timestamp	sysReqDtm ; // 요청시간
	private Timestamp	sysResDtm ; // 응답시간
	
}
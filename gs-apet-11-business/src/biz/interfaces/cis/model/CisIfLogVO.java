package biz.interfaces.cis.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.interfaces.cis.model
* - 파일명		: CisIfLogVO.java
* - 작성일		: 2021. 1. 15.
* - 작성자		: kek01
* - 설명			: CIS IF LOG VO
* </pre>
*/

@Data
@EqualsAndHashCode(callSuper=false)
public class CisIfLogVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	private Long   logNo;			 /* 로그 번호 */
	private String step;			 /* 단계 */
	private String httpsStatusCd;	 /* 응답 HTTP Status Code */
	private String cisResCd;		 /* CIS 결과코드 */
	private String cisResMsg;		 /* CIS 결과 메시지 */
	private String requestUrl;		 /* 호출 URL */
	private String callId;			 /* CIS Call ID */
	private String reqJson;			 /* 요청 JSON */
	private String resJson;			 /* 응답 JSON */
	private String sysReqStartDtm;	 /* 요청시작일시 */
	private String sysReqEndDtm;	 /* 요청종료일시 */
	private String sysResDtm;		 /* 응답일시 */
	
}

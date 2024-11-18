package biz.app.order.model.interfaces.ob;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.order.model.interfaces.ob
* - 파일명	: ObApiBasePO.java
* - 작성일	: 2017. 9. 19.
* - 작성자	: schoi
* - 설명		: Outbound API 이력 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class ObApiBasePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/****************************
	 * Outbound API 이력 정보
	 ****************************/

	/* Outbound 이력 일련번호 */
	private Integer obApiSeq;

	/* Outbound API 사이트 (10:11번가,20:기타) */
	private Integer obApiStCd;
	
	/* Outbound API 업무 구분(10:상품,20:주문,30:클레임,40:배송 */
	private Integer obApiGb;

	/* Outbound API 이력 구분(20:발주확인할내역(결재완료_목록조회),21:발주확인처리,22:발송처리(배송중_처리),23:판매불가처리,30:취소신청목록조회,31:취소승인처리,32:취소거부처리,33:교환신청목록조회,34:교환승인처리,35:교환거부처리,36:반품신청목록조회,37:반품승인처리,38:반품거부처리) */
	private Integer obApiCd;

	/* Outbound API 요청 내용 */
	private String obApiReqCont;

	/* Outbound API 응답 내용 */
	private String obApiResCont;
	
	/* 처리자 IP */
	private String sysRemoteIp;

}
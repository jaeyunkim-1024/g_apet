package admin.web.view.delivery.controller.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

import framework.common.model.PopParam;

/**
* <pre>
* - 프로젝트명   : 41.admin.web
* - 패키지명   : admin.web.view.delivery.controller.model
* - 파일명      : DeliveryUploadResult.java
* - 작성일      : 2017. 5. 18.
* - 작성자      : valuefactory 권성중
* - 설명      : 배송 일괄 업로드 결과
* </pre>
*/
@Data
public class DeliveryUploadResult implements Serializable {


	private static final long serialVersionUID = 1L;
	
	/** 클레임구분코드 */
	private String ordClmGbCd;
	/** 주문번호 */
	private String ordNo;
	/** 배송번호 */
	private Long dlvrNo;
	/** 주문상세일련번호 */
	private Long ordDtlSeq;
	/** 주문내역상태코드 */
	private String ordDtlStatCd;
	/** 클레임번호 */
	private String clmNo;
	/** 클레임상세일련번호 */
	private String clmDtlSeq;
	/** 클레임상태코드 */
	private String clmDtlStatCd;
	/** 송장번호 */
	private String invNo;
	
	/** 택배사명 */
	private String hdcNm;
	
	/** 성공여부 **/
	private String resultYN;
	/** 결과메세지 **/
	private String resultMsg;
	
}
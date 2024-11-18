package biz.app.delivery.model;

import java.util.List;

import biz.app.order.model.OrderDetailDivVO;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.delivery.model
* - 파일명		: DeliveryVO.java
* - 작성일		: 2017. 1. 12.
* - 작성자		: snw
* - 설명			: 배송 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class DeliveryDivVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 배송 번호 */
	private Long dlvrNo;

	/** 주문 배송지정보 */
	private Integer ordDlvrNo;
	
	/** 주문 클레임 구분 코드 */
	private String ordClmGbCd;

	/** 클레임 번호 */
	private String clmNo;

	/** 배송 처리 유형 코드 */
	private String dlvrPrcsTpCd;

	/** 택배사 코드 */
	private String hdcCd;

	/** 송장 번호 */
	private String invNo;

	/** 배송정책번호 */
	private Integer dlvrcPlcNo;

	/** 우편 번호 구 */
	private String postNoOld;

	/** 우편 번호 신 */
	private String postNoNew;

	/** 도로 주소 */
	private String roadAddr;

	/** 도로 상세 주소 */
	private String roadDtlAddr;

	/** 지번 주소 */
	private String prclAddr;

	/** 지번 상세 주소 */
	private String prclDtlAddr;

	/** 전화 */
	private String tel;

	/** 휴대폰 */
	private String mobile;

	/** 이메일 */
	private String email;

	/** 수취인 명 */
	private String adrsNm;

	/** 배송 메모 */
	private String dlvrMemo;

	/** 직배송아이디 */
	private Integer areaId;

	/** 주문 상세 List VO */
	private List<OrderDetailDivVO> orderDetailDivListVO;

}
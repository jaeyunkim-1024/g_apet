package biz.app.order.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.order.model
 * - 파일명		: OrderDlvrAreaPO.java
 * - 작성일		: 2021. 03. 01.
 * - 작성자		: JinHong
 * - 설명		: 주문 배송 권역 PO
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class OrderDlvrAreaPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 배송 일자 */
	private String ordDt;
	
	/** 배송 권역 번호 */
	private Long dlvrAreaNo;
	
	/** 주문 번호 */
	private String ordNo;
	
	/** 배송 처리 유형 코드 */
	private String dlvrPrcsTpCd;
	
	/** 배송 권역 코드 */
	private String dlvrAreaCd;
	
	/** 배송 권역 이름 */
	private String dlvrAreaNm;
	
	/** 배송 센터 코드 */
	private String dlvrCntrCd;
	
	/** 배송 센터 이름 */
	private String dlvrCntrNm;
	
	/** 슬롯 수량 */
	private Long slotQty;
	
	/** 사용 여부 */
	private String useYn;
	
	/** 우편 번호 */
	private String postNo;
	
	/** 시도 */
	private String sido;
	
	/** 구군 */
	private String gugun;
	
	/** 동 */
	private String dong;
	/** 휴무 시작 일자 */
	private String clsdStrtDt;
	
	/** 휴무 종료 일자 */
	private String clsdEndDt;
	
	/** 처리 여부 */
	private String prcsYn;
	

}
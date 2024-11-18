package biz.app.order.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.order.model
 * - 파일명		: OrderDlvrAreaSO.java
 * - 작성일		: 2021. 03. 01.
 * - 작성자		: JinHong
 * - 설명		: 주문 배송 권역 SO
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class OrderDlvrAreaSO extends BaseSearchVO<OrderDlvrAreaSO> {

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
	
	/** 배송 처리 유형 코드 s */
	private String [] arrDlvrPrcsTpCd;
	
	/** 우편 번호 */
	private String postNo;
	
	/** 휴무 시작 일자 */
	private String clsdStrtDt;
	
	/** 휴무 종료 일자 */
	private String clsdEndDt;
	
	/** 현재 시간 */
	private Timestamp nowDateTime;
	
	/** 휴무일 조회- 마감시간 체크 여부 */
	private String timeCheckYn;
	
	/** 배송 권역 코드 */
	private String dlvrAreaCd;

}
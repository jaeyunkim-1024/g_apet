package biz.app.order.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.order.model
 * - 파일명		: OrderDlvrAreaVO.java
 * - 작성일		: 2021. 03. 01.
 * - 작성자		: JinHong
 * - 설명		: 주문 배송 권역 VO
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class OrderDlvrAreaVO extends BaseSysVO {

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
	
	/** 슬롯 수량
	 * CIS 조회 후 체크 어바웃펫 수량 체크 안함 */
	@Deprecated
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
	
	
	/** 시간 체크 return value - ordDt,dlvrPrcsTpCd  */
	/** 휴무일 여부 */
	private Boolean isHoliday = false;
	
	/** 우편번호 권역 포함 여부 */
	private Boolean isPostArea = false;
	
	/** 슬롯 마감 여부 */
	@Deprecated
	private Boolean isSlotClose = false;
	
	/** cis 슬롯 마감 여부 */
	private Boolean isCisSlotClose = false;
	
	/** 주문 요일 */
	private String ordDayOfWeek;
	
	/** 마감 시간 노출 문구 00시 00분*/
	private String restTimeShowText;
	
	/** 마감 시간 노출 문구 시*/
	private String restTimeHour;
	
	/** 마감 시간 노출 문구 분*/
	private String restTimeMinute;
	
	/** 배송 예정 노출 문구 */
	private String dlvrTimeShowText; 
	
	/** 주문서 배송 예정 노출 문구 */
	private String ordDlvrTimeShowText; 
	
	/** 마감 대상 시간 */
	private Timestamp targetCloseDtm;
	
	/** 배송 일시 */
	private Timestamp ordDateTime;
	
	/** 삭제 여부 */
	private String delYn;
	
	/** 배송 valid Check exCode */
	private String exCode;
	/** 배송 valid Check exCode Msg */
	private String exMsg;
	
}
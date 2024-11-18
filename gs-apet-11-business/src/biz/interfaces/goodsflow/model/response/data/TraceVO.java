package biz.interfaces.goodsflow.model.response.data;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.goodsflow.model.response.data
* - 파일명		: TraceResultVO.java
* - 작성일		: 2017. 6. 20.
* - 작성자		: WilLee
* - 설명		:
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class TraceVO implements Serializable {

	private static final long serialVersionUID = 1L;

	// 2.0 -> 3.0
	// 코멘트 ex) : 자료구분(2) -> 2.0 에만 존재
	//			   자료구분(3) -> 3.0 에만 존재
	//			   자료구분       -> 둘 다 존재
	
	// 고객사용번호(3) : 상품에 대한 고유번호(결과보고 단위)
	private String transUniqueCode;
	// 고객사용번호(2) : 상품에 대한 고유번호(결과보고 단위)
	private String itemUniqueCode;
	
	// 일련번호
	private Integer seq;
	
	// 관리구분코드
	private String sectionCode;

	// 주문번호(2)
	private String ordNo;

	// 주문행번호(2)
	private Integer ordLineNo;

	// 배송사코드
	private String logisticsCode;

	// 운송장 번호
	private String invoiceNo;

	// 처리수량(2)
	private Integer itemQty;

	// 배송상태 : 집화(30), 배달완료(70), 오류(99)
	//@Deprecated
	private String dlvStatCode;		/* 2.0 */
	private String dlvStatType;		/* 3.0 */

	// 처리일시(2)
	private String procDateTime;
	
	// 지점연락처(3)
	private String branchTel;
	
	// 배달기사이름(3)
	private String employeeName;
	
	// 배달기사연락처(3)
	private String employeeTel;

	// 수령인 정보
	private String taker;

	// 예외코드(2)
	private String exceptionCode;

	// 예외코드명(2)
	private String exceptionName;

	// 오류코드 : 배송상태가 오류(99)일 때
	private String errorCode;

	// 오류코드명
	private String errorName;

	// 생성일시 : YYYYMMDDHHMMSS 예)20190101083000
	private String createDateTime;
}

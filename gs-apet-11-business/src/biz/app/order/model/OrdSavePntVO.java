package biz.app.order.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.order.model
 * - 파일명		: OrdSavePntVO.java
 * - 작성일		: 2021. 03. 15.
 * - 작성자		: JinHong
 * - 설명		: 적립 포인트 VO
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class OrdSavePntVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 주문 번호 */
	private String ordNo;
	
	/** 주문 상세 순번 */
	private Integer ordDtlSeq;
	
	/** 주문 적립 포인트 */
	private Integer ordSavePnt;
	
	/** GS 포인트 이력 번호 */
	private Long gsPntHistNo;
	
	/** 적립 사용 구분 코드 */
	private String saveUseGbGbCd;

	/** 원 적립 GS 포인트 이력 번호 */
	private Long orgGsPntHistNo;
	
	/** 거래 구분 코드 **/
	private String dealGbCd;
	
	/** 회원 번호 */
	private Long mbrNo;
	
	/** GS포인트 연계 번호 */
	private String gspntNo;
	
	/** 결제 금액 */
	private Long payAmt;
	
	/** 적립 포인트 */
	private Integer pnt;
	
	/** 거래일시 */
	private Timestamp dealDtm;
	
	/** 거래번호 */
	private String dealNo;

	/** 클레임 번호 */
	private String clmNo;
	
	/** 클레임 상세 순번 */
	private Integer clmDtlSeq;
	
	//추가
	
}
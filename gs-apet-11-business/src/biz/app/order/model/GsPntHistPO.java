package biz.app.order.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.order.model
 * - 파일명		: GsPntHisVO.java
 * - 작성일		: 2021. 04. 08.
 * - 작성자		: dhkim
 * - 설명		: GS 포인트 히스토리 PO
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class GsPntHistPO extends BaseSysVO implements Serializable {

	/** GS 포인트 이력번호 */
	private Long gsPntHistNo;
	
	/** 적립사용구분코드 */
	private String saveUseGbCd;
	
	/** 원 GS 포인트이력번호 */
	private Long orgGsPntHistNo;
	
	/** 거래 구분 코드 */
	private String dealGbCd;

	/** 회원번호 */
	private Long mbrNo;
	
	/** GS포인트 연계 번호 */
	private String gspntNo;
	
	/** 결재금액 */
	private Long payAmt;
	
	/** 포인트 */
	private Integer pnt;
	
	/** 거래일시 */
	private Timestamp dealDtm;
	
	/** 거래번호 */
	private String dealNo;
	
	/** 주문 번호 */
	private String ordNo;
	
	/** 주문 상세 순번 */
	private Integer ordDtlSeq;
	
	/** 주문 적립 포인트 */
	private Integer ordSavePnt;
	
	/** 클레임 번호 */
	private String clmNo;
	
	/** 클레임 상세 순번 */
	private Integer clmDtlSeq;		
	
	/** Interface No */
	private String rcptNo;
}

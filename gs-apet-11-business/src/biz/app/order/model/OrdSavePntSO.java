package biz.app.order.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.order.model
 * - 파일명		: OrdSavePntSO.java
 * - 작성일		: 2021. 03. 15.
 * - 작성자		: JinHong
 * - 설명		: 적립 포인트 SO
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class OrdSavePntSO extends BaseSearchVO<OrdSavePntSO> {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 주문 번호 */
	private String ordNo;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;
	
	/** GS 포인트 이력 번호 */
	private Long gsPntHistNo;
	
	/** 적립 사용 구분 코드 */
	private String saveUseGbCd;

	/** DEAL_GB_CD */
	private String dealGbCd;
	
	/** 원 GS 포인트 이력 번호가 null인경우 */
	private boolean orgGsPntHistNoIsNull;
}
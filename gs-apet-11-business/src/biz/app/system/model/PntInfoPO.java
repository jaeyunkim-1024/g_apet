package biz.app.system.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.app.system.model
 * - 파일명		: PntInfoPO.java
 * - 작성일		: 2021. 07. 20.
 * - 작성자		: JinHong
 * - 설명		: 포인트 관리 PO
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class PntInfoPO extends BaseSysVO {

	private static final long serialVersionUID = 1L;

	/** 포인트 번호 */
	private Long pntNo;
	
	/** 포인트 유형 코드 */
	private String pntTpCd;

	/** 적립률 */
	private Double saveRate;
	
	/** 초과 적립률 */
	private Double addSaveRate;

	/** 사용율 */
	private Double useRate;
	
	/** 연동 상품 코드 */
	private String ifGoodsCd;
	
	/** 대체 연동 상품 코드 */
	private String altIfGoodsCd;
	
	/** 포인트 프로모션 구분 코드 */
	private String pntPrmtGbCd;
	
	/** 최대 적립 포인트 */
	private Integer maxSavePnt;
	
	/** 적용 시작 일시 */
	private Timestamp aplStrtDtm;
	
	/** 적용 종료 일시 */
	private Timestamp aplEndDtm;
	
	/** 사용 여부 */
	private String useYn;
}
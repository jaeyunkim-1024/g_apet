package biz.app.order.model.interfaces;

import biz.interfaces.cis.model.request.order.ReturnInsertPO;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.order.model.interfaces
* - 파일명		: CisOrderReturnCmdVO.java
* - 작성일		: 2021. 3. 10.
* - 작성자		: KEK01
* - 설명			: CIS 회수 지시 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class CisOrderReturnCmdVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 클레임 번호 */
	private String clmNo;

	/** 클레임 상세 순번 */
	private Integer clmDtlSeq;
	
	/** 클레임 구성 순번 */
	private Integer clmCstrtSeq;
	
	/** 클레임 상세 구성 번호 */
	private Long clmDtlCstrtNo;
	
	/** 배송 처리 유형 코드 */
	private String dlvrPrcsTpCd;
	
	/** 주문 배송지 번호 */
	private Long ordDlvraNo;
	
	/** 업체 구분 코드 */
	private String compGbCd;
	
	/** 교환 회수 여부 */
	private String exchgRtnYn;
	
	
	/** CIS IF 반품등록 항목 VO */
	private ReturnInsertPO returnInsertPO;
	
}
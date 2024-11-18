package biz.app.member.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.member.model
* - 파일명		: MemberGradeVO.java
* - 작성일		: 2017. 8. 4.
* - 작성자		: Administrator
* - 설명			: 회원 등급 정보
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class MemberGradeVO extends BaseSysVO{

	private static final long serialVersionUID = 1L;

	/** 회원 등급 코드 */
	private String grdCd;

	/** 회원 등급 명 */
	private String grdNm;

	/** 기준 주문 금액 : 등급산정 */
	private String stdOrdAmt;

	/** 기준 주문 수 : 등급산정 */
	private String stdOrdCnt;

	/** 적립 율 */
	private String svmnRate;

	/** 적립 유효 기간 */
	private String svmnVldPrd;

	/** 적립 유효 기간 코드 */
	private String svmnVldPrdCd;

}

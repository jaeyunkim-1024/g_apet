package biz.app.member.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.member.model
* - 파일명		: MemberSavedMoneyVO.java
* - 작성일		: 2017. 3. 13.
* - 작성자		: snw
* - 설명			: 회원 적립금 VO
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class MemberSavedMoneyVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Long mbrNo;
	
	/** 적립금 순번 */
	private Long svmnSeq;

	/** 적립금 사유 코드 */
	private String svmnRsnCd;

	/** 기타 사유 */
	private String etcRsn;

	/** 적립 금액 */
	private Long saveAmt;

	/** 잔여 금액 */
	private Long rmnAmt;
	
	/** 유효 일시 */
	private Timestamp vldDtm;

	/** 유효 여부 */
	private String	vldYn;
	
	/** 주문 번호 */
	private String ordNo;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;
	
	/** 상품 평가 번호 */
	private Long goodsEstmNo;
	
	/** 적립금 처리 코드 */
	private String svmnPrcsCd;
	
	/** 적립금 처리 사유 코드 */
	private String 	svmnPrcsRsnCd;
	
	/** 테이블 구분 */
	private String tblDvs;
	
	/** 유효 기간 */
	private String vldPrd;

}
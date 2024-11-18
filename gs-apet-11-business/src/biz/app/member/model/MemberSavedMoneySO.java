package biz.app.member.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberSavedMoneySO extends BaseSearchVO<MemberSavedMoneySO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Long mbrNo;

	/** 적립금 순번 */
	private Long	 svmnSeq;

	/** 주문 번호 */
	private String ordNo;

	/** 주문 순번 */
	private Integer ordDtlSeq;

	/** 적립금 처리 코드 10:적립, 20: 차감 */
	private String svmnPrcsCd;

	/** 적립금 사유코드 :  회원적립금 테이블 */
	private String svmnRsnCd;

	/** 적립금 처리 사유 코드 */
	private String svmnPrcsRsnCd;

	/** 기간 검색 예>1,3,6,12개월 */
	private Long periodParam;

	/** 적립금 형태 조회 코드*/
	private String svmnPrcsParam;














	/** 기간별 검색 */
	private String period;

	/** 검색용 처리 일시 : Start */
	private Timestamp prcsDtmStart;

	/** 검색용 처리 일시 : End */
	private Timestamp prcsDtmEnd;

}
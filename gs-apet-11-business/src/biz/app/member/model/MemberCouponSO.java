package biz.app.member.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberCouponSO extends BaseSearchVO<MemberCouponSO>{

	private static final long serialVersionUID = 1L;

	/** 회원 쿠폰 번호 */
	private Long mbrCpNo;

	/** 쿠폰 번호*/
	private Long cpNo;

	/** 회원 번호*/
	private Long mbrNo;

	/**사용 여부*/
	private String useYn;

	/** 쿠폰 종류 코드*/
	private String cpKindCd;

	/** 쿠폰 적용 코드*/
	private String cpAplCd;

	/** 유효 기간 코드*/
	private String vldPrdCd;

	/** 쿠폰 지급 방식*/
	private String cpPvdMthCd;

	/** 중복 사용 여부*/
	private String dupleUseYn;

	/** 발급 주체 코드*/
	private String isuHostCd;

	/** 쿠폰 발급 코드*/
	private String cpIsuCd;

	/** 발급 대상 코드*/
	private String isuTgCd;

	/** 만료 안내 여부*/
	private String exprItdcYn;

	/** 외부 쿠폰 여부*/
	private String outsideCpYn;

	/** 발급 일련 번호*/
	private String isuSrlNo;

	/** 웹모바일 구분코드 */
	private String webMobileGbCd;

	/** 사이트 아이디 */
	private Long stId;
}

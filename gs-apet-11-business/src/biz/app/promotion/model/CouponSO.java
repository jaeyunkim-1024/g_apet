package biz.app.promotion.model;

import java.sql.Timestamp;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import biz.app.st.model.StStdInfoVO;
import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.promotion.model
* - 파일명		: CouponSO.java
* - 작성일		: 2016. 4. 22.
* - 작성자		: phy
* - 설명		:
* </pre>
*/
@Data
@EqualsAndHashCode(callSuper=false)
public class CouponSO extends BaseSearchVO<CouponSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 쿠폰 번호 */
	private Long cpNo;

	/** 쿠폰 번호 */
	public Long getAplNo() {
		return this.cpNo;
	}

	/** 쿠폰 명 */
	private String cpNm;

	/** 쿠폰 종류 코드 */
	private String cpKindCd;

	/** 쿠폰 대상 코드 */
	private String cpTgCd;

	/** 쿠폰 상태 코드 */
	private String cpStatCd;

	/** 쿠폰 적용 코드 */
	private String cpAplCd;

	/** 적용 값 */
	private Long aplVal;

	/** 최소 구매 금액 */
	private Long minBuyAmt;

	/** 최대 할인 금액 */
	private Long maxDcAmt;

	/** 적용 시작 일시 */
	private Timestamp aplStrtDtm;

	/** 적용 종료 일시 */
	private Timestamp aplEndDtm;

	/** 상위 전시 분류 번호 */
	private Long upDispClsfNo;

	/** 회원 번호 */
	private Long mbrNo;

	/** 회원 쿠폰 번호 */
	private Long mbrCpNo;

	/** 웹 모바일 구분 코드 */
	private String webMobileGbCd;

	/** 웹 모바일 구분 코드 */
	private List<String> webMobileGbCdList;

	/** 프로모션 매핑 적용 구분 코드 (프로모션-사은품 : 10) */
	private String prmtAplGbCd;

	/** 사이트 아이디 */
	private Long stId;

	/** 사이트 정보 목록 */
	private List<StStdInfoVO> stStdList;

	/** 전시 분류 코드 */
	private String dispClsfCd;

	/** 쿠폰 지급 방식 */
	private String cpPvdMthCd;

	/** 쿠폰 등록 일자 */
	private Timestamp sysRegDtm;

	/**  쿠폰존 노출 여부 */
	private String cpShowYn;

	private String stUseYn;
	
	private Boolean isReadonlyCpPvdMthCd;
	
	private Boolean isReadonlyStId;

	/** 발급 대상 코드*/
	private String isuTgCd;

	/** 메세지 발송 여부*/
	private String msgSndYn;

	/** 만료 안내 여부*/
	private String exprItdcYn;

	/** 외부 쿠폰 여부*/
	private String outsideCpYn;

	/** 외부 쿠폰 코드*/
	private String outsideCpCd;

	public String getStUseYn () {
		return StringUtils.isEmpty(stUseYn) ? StringUtils.EMPTY : stUseYn;
	}

	/** 쿠폰 발급 제한 수 */
	private Long cpIsuQty;
}
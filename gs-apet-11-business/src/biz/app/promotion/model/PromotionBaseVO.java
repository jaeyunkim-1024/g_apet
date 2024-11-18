package biz.app.promotion.model;

import java.sql.Timestamp;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;

import biz.app.st.model.StStdInfoVO;
import framework.admin.constants.AdminConstants;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PromotionBaseVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 프로모션 번호 */
	private Integer prmtNo;

	/** 프로모션 종류 코드 */
	private String prmtKindCd;

	/** 프로모션 상태 코드 */
	private String prmtStatCd;

	/** 프로모션 명 */
	private String prmtNm;

	/** 최소 구매 금액 */
	private Long minBuyAmt;

	/** 최대 구매 금액 */
	private Long maxBuyAmt;

	/** 프로모션 적용 코드 */
	private String prmtAplCd;

	/** 적용 값 */
	private Long aplVal;

	/** 프로모션대상코드 */
	private Long prmtTgCd;

	/** 공급업체 분담율 */
	private Double splCompDvdRate;

	/** 적용 시작 일시 */
	private Timestamp aplStrtDtm;

	/** 적용 종료 일시 */
	private Timestamp aplEndDtm;

	/** 프로모션 매핑 적용 구분 코드 (프로모션-사은품 : 10) */
	private String prmtAplGbCd;

	/**  역 마진 허용 여부 */
	private String rvsMrgPmtYn;

	/** 사이트 아이디 */
	private List<StStdInfoVO> stStdList;

	/** 편집가능 여부 */
	public boolean isEditable() {
		boolean editable = false;

		if (StringUtils.isEmpty(this.prmtStatCd) || StringUtils.equals(this.prmtStatCd, AdminConstants.PRMT_STAT_10)) {
			editable = true;
		}

		return editable;
	}

	/** 사이트 아이디 */
	public String getStNms() {
		if (hasManySite()) {
			return "복수 사이트";
		} else {
			return getFirstStStdInfo();
		}
	}

	private boolean hasManySite() {

		return CollectionUtils.isNotEmpty(this.stStdList) && CollectionUtils.size(this.stStdList) > 1 ? true : false;
	}

	private String getFirstStStdInfo() {

		if (CollectionUtils.isEmpty(this.stStdList) || CollectionUtils.sizeIsEmpty(this.stStdList)) {
			return StringUtils.EMPTY;
		}

		return this.stStdList.get(0).getStNm();
	}

}
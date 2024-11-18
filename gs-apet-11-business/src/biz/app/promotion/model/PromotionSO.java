package biz.app.promotion.model;

import java.sql.Timestamp;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import biz.app.st.model.StStdInfoVO;
import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PromotionSO extends BaseSearchVO<PromotionSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 프로모션 번호 */
	private Long prmtNo;

	/** 프로모션 번호 리턴 */
	public Long getAplNo() {
		return this.prmtNo;
	}

	/** 프로모션 종류 코드 */
	private String prmtKindCd;

	/** 프로모션 상태 코드 */
	private String prmtStatCd;

	/** 프로모션 명 */
	private String prmtNm;

	/** 프로모션 적용 코드 */
	private String prmtTgCd;

	/** 프로모션 적용 코드 */
	private String prmtAplCd;

	/** 적용 시작 일시 */
	private Timestamp aplStrtDtm;

	/** 적용 종료 일시 */
	private Timestamp aplEndDtm;

	/** 프로모션 매핑 적용 구분 코드 (프로모션-사은품 : 10) */
	private String prmtAplGbCd;

	/** 사이트 아이디 */
	private Integer stId;

	/** 사이트 정보 목록 */
	private List<StStdInfoVO> stStdList;

	/** 전시 분류 코드 */
	private String dispClsfCd;

	private String stUseYn;

	public String getStUseYn () {
		return StringUtils.isEmpty(stUseYn) ? StringUtils.EMPTY : stUseYn;
	}

}
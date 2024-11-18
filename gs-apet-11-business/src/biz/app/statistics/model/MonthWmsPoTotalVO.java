package biz.app.statistics.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class MonthWmsPoTotalVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 집계년월 */
	private String baseYm;

	/** 업체/시리즈명 */
	private String sumTgNm;

	/** 1차 발주금액 */
	private int firstPoAmt;

	/** 2차 발주금액 */
	private int secondPoAmt;

	/** 3차 발주금액 */
	private int thirdPoAmt;

	/** 추가 발주금액 */
	private int addPoAmt;
	
	/** 합계 */
	private int sumAmt;

	/** 구성비 */
	private double rate;

	/** 증감률 */
	private double incRatio;

}
package biz.interfaces.nicepay.model.response.data;

import lombok.Data;

@Data
public class InterestFreeInfoItemResVO {
	private String fnCd;		/** 카드사코드 */
	private String fnNm;		/** 카드사명 */
	private String instmntMon;	/** 개월 수 */
	private String instmntType;	/** 할부 유형 */
	private Integer minAmt;		/** 최소 금액 */
}

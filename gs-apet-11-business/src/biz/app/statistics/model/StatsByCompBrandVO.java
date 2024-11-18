package biz.app.statistics.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class StatsByCompBrandVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 집계 일자 */
	private String totalDt;

	/** 사이트 아이디 */
	private long stId;

	private long compNo;
	private String compNm;

	private long bndNo;
	private String bndNm;

	/** 주문매체 코드 */
	private String ordMdaCd;

	/** 주문수량 */
	private long ordQty;

	/** 주문 금액*/
	private long ordAmt;

	/** 취소 수량 */
	private long cncQty;

	/** 취소 금액*/
	private long cncAmt;

	/** 반품 수량*/
	private long rtnQty;

	/** 반품 금액 */
	private long rtnAmt;

	/** 주문 금액 - 취소 금액 - 반품 금액 */
  	private long totAmt;

	private long rownum;

}
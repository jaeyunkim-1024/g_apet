package biz.app.statistics.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class StatsGoodsVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private String statsRank; 			// 순위
	private Integer ordQty; 			// 주문수량
	private Integer sumOrdQty; 			// 총주문수량
	private String goodsBomCd; 			// BomCd
	private String goodsBomNm;			// BomNm
	private String insertYmd;			// 등록일
	private Double dayAvg;				// 일간평균판매량
	private Double monthAvg;			// 월간평균판매량
	private String sumDate;				// 년/월/주/일
}
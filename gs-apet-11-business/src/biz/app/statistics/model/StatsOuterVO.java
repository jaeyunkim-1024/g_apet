package biz.app.statistics.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class StatsOuterVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private String statsRank; 			// 순위
	private String pageGbNm; 			// 외부몰 업체명
	private Double statsRate; 			// 비율
	private Integer ordGoodsQty; 		// 주문상품수
	private Long saleAmt; 				// 판매금액
	private Integer ordQty; 			// 주문수량
	private String pageGbCd; 			// 판매공간
	private String sumDay; 				// 일자/월/년
	private String itemNm; 				// 옵션명
	private String goodsId; 			// 상품 아이디
	private String goodsNm; 			// 상품명
	private String goodsBomCd; 			// BomCd
	private String goodsBomNm;			// BomNm
	private String sumDate;				// 년/월/주/일
}
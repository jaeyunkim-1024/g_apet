package biz.app.statistics.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class StatsByGoodsVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	private String goodsId;
	private String goodsNm;
	private long ordQty;
	private long saleAmt;
	private String dispClsfNm;
	private String bndNm;
	private String seriesNm;
	private String ordMdaCd;
	private String pageGbCd;
	private String memberYn;
	private String orderArea;

}

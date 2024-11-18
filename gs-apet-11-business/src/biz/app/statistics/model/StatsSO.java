package biz.app.statistics.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class StatsSO extends BaseSearchVO<StatsSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	private String pageGbCd;
	private String pageCheck;
	private String dateCheck;
	private String startDtm;
	private String endDtm;
	private String ordMdaCd;
	private String[] orderArea;
	private String memberYn;

	private String goodsCheck;
	private String searchGoodsValue;

	private String compTpCd;

	/** 업체 번호 */
	private Long compNo;
	private Integer searchRank;
	private Integer dispNo;
	private String dispLvl;

	//tobemall
	private Long stId;
	private Long bndNo;


}
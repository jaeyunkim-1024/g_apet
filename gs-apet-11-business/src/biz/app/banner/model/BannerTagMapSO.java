package biz.app.banner.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BannerTagMapSO extends BaseSearchVO<BannerTagMapSO> {

	private static final long serialVersionUID = 1L;

	/** 배너 번호*/
	private Long bnrNo;
	
	/** 태그 번호*/
	private String tagNo;
	
}

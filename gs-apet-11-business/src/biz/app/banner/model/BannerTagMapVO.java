package biz.app.banner.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BannerTagMapVO extends BaseSysVO {

	private static final long serialVersionUID = 1L;
	
	/** 배너 번호*/
	private Long bnrNo;
	
	/** 태그 번호*/
	private String tagNo;
}

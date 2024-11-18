package biz.app.banner.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BannerTagMapPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 배너 번호*/
	private Long BnrNo;
	
	/** 태그 번호*/
	private String tagNo;
}

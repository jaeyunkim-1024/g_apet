package biz.app.brand.model;

import java.util.List;

 
import biz.app.st.model.StStdInfoVO;
 
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BrandTop10VO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 집계일 */
	private String totalDt;
	
	/** 브랜드 번호 */
	private Integer bndNo;

	/** 브랜드 명 국문 */
	private String bndNmKo;
	
	/** 브랜드 명 영문 */
	private String bndNmEn;

	/** 주간판매량 순위 */
	private Integer saleQtyRank;
	 
}
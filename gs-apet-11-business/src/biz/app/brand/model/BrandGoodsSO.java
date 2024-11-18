package biz.app.brand.model;

 
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import biz.app.st.model.StStdInfoVO;
import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class BrandGoodsSO extends BaseSearchVO<BrandGoodsSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품아이디 */
	private String goodsId;         
	/** 브랜드번호 */
	private Long bndNo;        
	/** 브랜드상품전시구분 */
	private String bndGoodsDispGb; 
	/** 전시우선순위 */
	private Long dispPriorRank ;    
	
	/** 사이트 아이디 */
	private Integer stId;
	
	
	/** 사이트 정보 목록 */
	private List<StStdInfoVO> stStdList;
	
	private String stUseYn;
	 
	public String getStUseYn () {
		return StringUtils.isEmpty(stUseYn) ? StringUtils.EMPTY : stUseYn;
	}   

}
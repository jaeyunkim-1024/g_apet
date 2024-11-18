package biz.app.brand.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BrandCntsItemSO extends BaseSearchVO<BrandCntsItemSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 아이템 번호 */
	private Long itemNo;

	/** 브랜드 콘텐츠 번호 */
	private Long bndCntsNo;
	
	private Long[] itemNos;
	
	/** 회원번호 */
	private Long mbrNo;
}
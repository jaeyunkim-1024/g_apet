package biz.app.brand.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class BrandCntsItemPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 아이템 번호 */
	private Long itemNo;

	/** 브랜드 콘텐츠 번호 */
	private Long bndCntsNo;
	
	/** 상품 아이디 */
	private String goodsId;
	
	/** 아이템 이미지 경로 */
	private String itemImgPath;
	
	/** 아이템 모바일 이미지 경로 */
	private String itemMoImgPath;
}
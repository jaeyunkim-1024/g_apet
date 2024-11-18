package biz.app.brand.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BrandCntsItemVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 아이템 번호 */
	private Long itemNo;

	/** 브랜드 콘텐츠 번호 */
	private Long bndCntsNo;
	
	/** 상품 아이디 */
	private String goodsId;
	
	/** 상품 명 */
	private String goodsNm;
	
	/** 상품 이미지 순번 */
	private Long goodsImgSeq;
	
	/** 상품 이미지 경로 */
	private String goodsImgPath;
	
	/** 아이템 이미지 경로 */
	private String itemImgPath;
	
	/** 아이템 모바일 이미지 경로 */
	private String itemMoImgPath;

	/** 위시리스트 여부 */
	private String interestYn;
	
}
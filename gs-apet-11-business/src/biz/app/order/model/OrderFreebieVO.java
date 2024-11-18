package biz.app.order.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class OrderFreebieVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사은품 번호 */
	private Integer frbNo;

	/** 주문 클레임 구분 코드 */
	private String ordClmGbCd;

	/** 주문 번호 */
	private String ordNo;

	/** 주문 상세 순번 */
	private Integer ordDtlSeq;

	/** 클레임 번호 */
	private String clmNo;

	/** 클레임 상세 순번 */
	private Integer clmDtlSeq;

	/** 상품번호 */
	private String goodsId;
	
	/** 상품명 */
	private String goodsNm;
	
	/** 이미지 순번 */
	private Integer imgSeq;
	
	/** 이미지 경로 */
	private String imgPath;

}
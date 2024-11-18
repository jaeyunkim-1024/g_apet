package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsCstrtInfoPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 아이디 */
	private String goodsId;

	/** 상품 명 */
	private String goodsNm;

	/** 제조사 */
	private String mmft;

	/** 상품 구성 구분 코드 */
	private String goodsCstrtGbCd;

	/** 구성 상품 아이디 */
	private String cstrtGoodsId;

	/** 사용 여부 */
	private String useYn;

	/** 전시 순서 */
	private Integer dispPriorRank;
	
	/** 구성상품 가격 */
	private Long saleAmt;

	/** 품절 여부 */
	private String soldOutYn;

	/** 위시리스트(찜) 여부 **/
	private String interestYn; //위시리스트 여부

	/** 이미지 순번 **/
	private Long imgSeq;

	/** 이미지 경로*/
	private String imgPath;


}
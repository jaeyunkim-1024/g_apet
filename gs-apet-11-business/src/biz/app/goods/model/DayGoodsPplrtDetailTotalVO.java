package biz.app.goods.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DayGoodsPplrtDetailTotalVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 집계 일자 */
	private String sumDt;

	/** 페이지 구분 코드 */
	private String pageGbCd;

	/** 전시 분류 번호 */
	private Integer dispClsfNo;

	private Integer compNo;

	/** 상품 아이디 */
	private String goodsId;

	/** 회원 여부 - 비회원 N */
	private String memberYn;

	/** 연령대 */
	private Integer ageGroup;

	/** 성별 */
	private String gdGbCd;

	/** 지역 구분 코드 */
	private Integer areaId;

	/** 판매금 */
	private Integer saleAmt;

	/** 판매 수량 */
	private Integer saleQty;

	/** 판매 금액 순위 */
	private Integer saleAmtRank;

	/** 판매 수량 순위 */
	private Integer saleQtyRank;

}
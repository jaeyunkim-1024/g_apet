package biz.app.goods.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsPriceSO extends BaseSearchVO<GoodsPriceSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 가격 번호 */
	private Long goodsPrcNo;

	/** 원가 금액 */
	private Long costAmt;

	private String goodsAmtTpCd;

	private Long orgSaleAmt;

	/** 판매 금액 */
	private Long saleAmt;

	/** 공급 금액 */
	private Long splAmt;

	/** 상품 아이디 */
	private String goodsId;

	/** 판매 시작 일시 */
	private Timestamp saleStrtDtm;

	/** 판매 종료 일시 */
	private Timestamp saleEndDtm;

	/** 수수료 율 */
	private Double cmsRate;

	/** 혜택 적용 방식 코드 */
	private String fvrAplMethCd;

	/** 혜택 값 */
	private Long fvrVal;

	/** 추가 */

	/** 상품 유형 코드 */
	private String goodsTpCd;
	private String changeFutureYn;
	private String changeCurrentSaleYn;
	private Timestamp sysDatetime;

	/** 시스템 등록자 번호 */
	private Integer sysRegrNo;

	/** 시스템 등록자 명 */
	private String sysRegrNm;

	/** 시스템 등록 일시 */
	private Timestamp sysRegDtm;

	/** 시스템 수정자 번호 */
	private Integer sysUpdrNo;

	/** 시스템 수정자 명 */
	private String sysUpdrNm;

	/** 시스템 수정 일시 */
	private Timestamp sysUpdDtm;

	private String[] goodsIds;
	
	/** 삭제여부 */
	private String delYn;

}
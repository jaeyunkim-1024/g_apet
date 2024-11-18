package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsGiftVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 순번 */
	private Long rownum;

	/** 상품 아이디 */
	private String goodsId;

	/** 상품명 */
	private String goodsNm;

	/** 사은품번호 			*/
	private Long prmtNo;

	/** 사은품명 			*/
	private String prmtNm;
	/** 사은품여부20 	*/
	private String prmtKindCd;
	/** 승인여부 			*/
	private String prmtStatCd;
	/** 정률,정액 여부 	*/
	private String prmtAplCd;
	/** 적용값 			*/
	private Long aplVal;
	/** 역 마진 허용 여부 	*/
	private String rvsMrgPmtYn;
	/** 프로모션 대상 코드 */
	private String prmtTgCd;
	/** 적용 시작 일시 	*/
	private String aplStrtDtm;
	/** 적용 종료 일시 	*/
	private String aplEndDtm;
	/** 공급 업체 분담 율 	*/
	private Double splCompDvdRate;
	/** 사은품 안받기 사용 여부 */
	private String frbDenyUseYn;

	private Long frbQty;

	private String imgPath;
	private String soldOutYn;

}
package biz.app.display.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayGoodsPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 전시 분류 번호 */
	private Long dispClsfNo;

	/** 전시 분류 코드 */
	private String dispClsfCd;

	/** 상품 번호 */
	private String goodsId;

	/** 전시 우선 순위 */
	private Long dispPriorRank;

	/** 대표 전시 여부 */
	private String dlgtDispYn;

	/** 쇼룸 전시 분류 번호 */
	private String srDispClsfNo;

	/** 쇼룸 전시 분류 화면값 */
	private String srDispClsfNoArr;

	/** 쇼룸 전시 분류 번호값 */
	private String[] arrSrDispClsfNo;

	/** 엑세 업로드 성공여부 */
	private String successYn;

	/** 엑세 업로드 결과메세지 */
	private String resultMessage;
	
	/** 상품타입코드  딜상품때문에...추가함*/
	private String goodsTpCd;
}
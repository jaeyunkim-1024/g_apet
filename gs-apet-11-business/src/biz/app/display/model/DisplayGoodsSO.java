package biz.app.display.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;

import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayGoodsSO extends BaseSearchVO<DisplayGoodsSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 전시 분류 번호 */
	private Integer dispClsfNo;
	
	/** 상위 전시 분류 번호 **/
	private Long upDispClsfNo;

	/** 상품 번호 */
	private String goodsId;

	/** 전시 우선 순위 */
	private Integer dispPriorRank;

	/** 대표 전시 여부 */
	private String dlgtDispYn;

	/** 쇼룸 전시 분류 번호 */
	private String srDispClsfNo;
	
	/** 전시 분류 코드 */
	private String dispClsfCd;
	
	/** 신상품 전시 코너 번호 **/
	private Long dispCornNoNew;
	
	/** 베스트 상품 전시 코너 번호 **/
	private Long dispCornNoBest;
	
	/** 사이트 아이디 **/
	private Long stId;
	
	private List<String> webMobileGbCds;
	private String webMobileGbCd;
	private Long mbrNo;

}
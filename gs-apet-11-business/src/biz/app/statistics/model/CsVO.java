package biz.app.statistics.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CsVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 접수검색 */
	private String cusPathCd;

	/** 주문매체 */
	private String compGb;

	/** 접수방법 */
	private String ordMdaCd;

	/** 상담사 */
	private String cusCpltrNm;

	/** 대분류 */
	private String cusCtg1Cd;

	/** 중분류 */
	private String cusCtg2Cd;

	/** 소분류 */
	private String cusCtg3Cd;

	/** 상품명 */
	private String goodsNm;

	/** 업체명 */
	private String bndNm;

	/** 건수 */
	private Long csCount;

	/** 비율 */
	private Double csRate;
}
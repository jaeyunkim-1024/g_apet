package biz.app.brand.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BrandCntsSO extends BaseSearchVO<BrandCntsSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 브랜드 콘텐츠 번호 */
	private Long bndCntsNo;

	/** 콘텐츠 타이틀 */
	private String cntsTtl;

	/** 브랜드 번호 */
	private Long bndNo;

	/** 브랜드 명 */
	private String bndNm;

	/** 콘텐츠 구분 코드 */
	private String cntsGbCd;

	/** 아이템 번호 */
	private Long itemNo;

	/** 노출 개수 */
	private Integer limitCnt;

	/** 업체 번호 */
	private Long compNo;
}
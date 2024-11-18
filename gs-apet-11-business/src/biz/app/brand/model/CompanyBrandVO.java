package biz.app.brand.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class CompanyBrandVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 업체 번호 */
	private Long compNo;

	/** 브랜드 번호 */
	private Long bndNo;

	/** 추가 */
	private String compNm;
	
	/** 브랜드 명 한글 */
	private String bndNmKo;
	
	/** 브랜드 명 영문 */
	private String bndNmEn;
	
	private String useYn;
	
	/** 대표 브랜드 여부 */
	private String dlgtBndYn;

}
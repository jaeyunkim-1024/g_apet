package biz.app.brand.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class BrandCntsPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 브랜드 콘텐츠 번호 */
	private Long bndCntsNo;

	/** 브랜드 번호 */
	private Long bndNo;
	
	/** 콘텐츠 구분 코드 */
	private String cntsGbCd;
	
	/** 콘텐츠 타이틀 */
	private String cntsTtl;
	
	/** 콘텐츠 설명 */
	private String cntsDscrt;
	
	/** 콘텐츠 이미지 경로 */
	private String cntsImgPath;
	
	/** 콘텐츠 모바일 이미지 경로 */
	private String cntsMoImgPath;
	
	/** 썸네일 이미지 경로 */
	private String tnImgPath;
	
	/** 썸네일 모바일 이미지 경로 */
	private String tnMoImgPath;

	/** 아이템 번호 */
	private Long itemNo;

}
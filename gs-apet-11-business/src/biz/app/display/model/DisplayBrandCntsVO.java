package biz.app.display.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayBrandCntsVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 브랜드 콘텐츠 번호 */
	private Integer bndCntsNo;
	
	/** 브랜드 번호 */
	private Integer bndNo;
	
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
	
	/** 썸네일 모바일 이미지 경로*/
	private String tnMoImgPath;
	
	/** 전시 노출 타입 코드*/
	private String dispShowTpCd;
	
	/** 아이템 번호*/
	private Integer itemNo;
	
	/** 썸네일 모바일 이미지 경로*/
	private String goodsId;
	
	/** 아이템 모바일 이미지 경로*/
	private String itemMoImgPath;
	
	/** CNTS_GB코드 그룹 - 코드명*/
	private String dtlNm;
	
	/** 찜 등록 여부*/
	private String interestYn;


}
package biz.app.contents.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class SeriesPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 시리즈 번호 */
	private Long srisNo;
	
	/** 시리즈 ID */
	private String srisId;
			
	/** 시리즈 전시여부 */
	private String dispYn;
	
	/** 시리즈 타입코드 */
	private String tpCd;
	
	/** 시리즈 프로필 이미지 경로 */
	private String srisPrflImgPath;
	
	/** 시리즈 이미지 경로 */
	private String srisImgPath;
	
	/** 시리즈 명 */
	private String srisNm;
	
	/** 시리즈 설명 */
	private String srisDscrt;
	
	/** 시리즈 태그 */
	private String[] tagNos;
	
	/** 시리즈 태그 */
	private String tagNo;
	
	/** 파일 번호 */
	private Long flNo;
	
	/** 파일 수정여부 */
	private String flModYn;
	
	/** 파일 수정여부 */
	private String[] flModYns;
	
	private String[] orgFlNms;
	private String[] phyPaths;
	private Long[] flSzs;
	private String[] imgGbs;
	
	/** 광고노출여부 */
	private String adYn;
	
	private Long histNo;
	
	/******************************/
	/**     시즌				      */
	/******************************/
	
	/** 시즌 번호 */
	private Long sesnNo;
	
	/** 시즌 명 */
	private String sesnNm;
	
	/** 시즌 이미지 경로 */
	private String sesnImgPath;
	
	/** 시즌 설명 */
	private String sesnDscrt;

}
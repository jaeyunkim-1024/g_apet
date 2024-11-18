package biz.app.contents.model;

import java.util.List;
import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class SeriesVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** rownum */
	private Long rowIndex;
	
	/** 시리즈 번호 */
	private Long srisNo;
	
	/** 시리즈 ID */
	private String srisId;
			
	/** 시리즈 전시여부 */
	private String dispYn;
	
	/** 시리즈 타입코드 */
	private String tpCd;
	
	/** 시리즈 타입명 */
	private String tpNm;
	
	/** 시리즈 프로필 이미지 경로 */
	private String srisPrflImgPath;
	
	/** 시리즈 이미지 경로 */
	private String srisImgPath;
	
	/** 시리즈 프로필 이미지 파일명 */
	private String srisPrflImgNm;
	
	/** 시리즈 이미지 파일명 */
	private String srisImgNm;
	
	/** 시리즈 명 */
	private String srisNm;
	
	/** 시리즈 설명 */
	private String srisDscrt;
	
	/** 시즌수  */
	private Long sesnCnt;
	
	/** 등록수정일 */
	private String regModDtm;
	
	/** 파일 번호 */
	private Long flNo;
	
	/** 시리즈 태그 */
	private String tagNo;
	
	/** 시리즈 태그명 */
	private String tagNm;
	
	/* 조회수*/
	private Integer hits;
	
	/** 광고노출여부 */
	private String adYn;
	
	/******************************/
	/**     시즌				      */
	/******************************/
	
	/** 시즌 번호 */
	private Long sesnNo;
	
	/** 시즌 명 */
	private String sesnNm;
	
	/** 시즌 이미지 경로 */
	private String sesnImgPath;
	
	/** 시즌 이미지명 */
	private String sesnImgNm;
	
	/** 시즌 설명 */
	private String sesnDscrt;
	
	/** 시즌 리스트 */
	private List<SeriesVO> seasonList;
	
	/** 시즌 동영상 개수 */
	private Long vdCnt;
	
}
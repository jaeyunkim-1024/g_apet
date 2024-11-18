package biz.app.contents.model;

import java.sql.Timestamp;
import java.util.List;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class SeriesSO extends BaseSearchVO<SeriesSO> {

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
	
	/* 시스템 등록 일시 : Start */
	private Timestamp sysRegDtmStart;
	
	/* 시스템 등록 일시 : End */
	private Timestamp sysRegDtmEnd;
	
	/** 시리즈 번호 */
	private Long[] srisNos;
	
	/** 파일 번호 */
	private Long flNo;
	
	/** 광고노출여부 */
	private String adYn;
	
	private Long[] flNos;
	
	/******************************/
	/**     시즌				      */
	/******************************/
	
	/** 시즌 번호 */
	private Long sesnNo;
	
	/** 시즌 번호 */
	private Long[] sesnNos;
	
	/** 시즌 명 */
	private String sesnNm;
	
	/** 시즌 이미지 경로 */
	private String sesnImgPath;
	
	/** 시즌 설명 */
	private String sesnDscrt;
	
	/** 중복 시리즈 제거*/
	private List<Long> seriesList;
	
	/** App & 펫TV 영상상세 화면에서 호출일때만 callParam값이 있다. */
	private String callParam;
	
	
}
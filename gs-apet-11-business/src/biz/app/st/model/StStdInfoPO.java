package biz.app.st.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class StStdInfoPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사이트 ID */
	private Long stId;

	/** 사이트 명 */
	private String stNm;

	/** 사이트 URL */
	private String stUrl;

	/** 사이트 URL */
	private String stMoUrl;
	
	/** 대표이메일 */
	private String dlgtEmail;
	
	/** 사이트 약어 */
	private String stSht;

	/** 업체번호 */
	private Long compNo;

	/** 브랜드 번호 */
	private Long bndNo;

	/** 쿠폰 번호 */
	private Long cpNo;

	/** 이벤트 번호 */
	private Long eventNo;

	/** 프로모션(사은품) 번호 */
	private Long prmtNo;

	/** 사용 여부 */
	private String useYn;

	/** 로고 이미지 */
	private String logoImgPath;

	/** 고객 센터 번호 */
	private String csTelNo;

}
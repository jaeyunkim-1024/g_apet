package biz.app.st.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class StStdInfoSO extends BaseSearchVO<StStdInfoSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사이트 ID */
	private Long stId;

	/** 사이트 명 */
	private String stNm;

	/** 사이트 URL */
	private String stUrl;

	/** 사이트 약어 */
	private String stSht;

	/** 사용 여부 */
	private String useYn;

	/** 업체 번호 */
	private Long compNo;

	/** 업체 명 */
	private String compNm;

	/** 업체 상태 */
	private String compStatCd;

	/** 사이트 ID 검색 */
	private String stIdArea;
	private Long[] stIds;

	/** 사이트 명 검색 */
	private String stNmArea;
	private String[] stNms;

	/** 고객 센터 번호 */
	private String csTelNo;
}
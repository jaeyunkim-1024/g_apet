package biz.app.st.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class StPolicyVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사이트 정책 번호 */
	private Long stPlcNo;
	/** 사이트id */
	private Long stId;
	/** 사이트 명 */
	private String stNm;
	/** 사이트 URL */
	private String stUrl;
	/** 사이트 약어 */
	private String stSht;


	/** 사이트 정책 구분 코드 */
	private String stPlcGbCd;
	/** 내용 */
	private String content;
	/** 정렬 순서 */
	private Integer sortSeq;
	/** 전시 여부 */
	private String dispYn;



	/** 업체 기본택배사 코드 */
	private String hdcCd;


	private String delYn;
}
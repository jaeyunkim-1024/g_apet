package biz.app.contents.model;

import org.apache.commons.lang3.StringEscapeUtils;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ApetContentsDetailVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 영상 ID */
	private String vdId;
	
	/** 단계 번호 */
	private Long stepNo;

	/** 파일 번호 */
	private Long flNo;
	
	/** 제목 */
	private String ttl;
	
	/** 설명 */
	private String dscrt;
	
	/** 순번 */
	private Long seq;

	/** 컨텐츠 유형 코드 */
	private String contsTpCd;

	/** 물리 경로 */
	private String phyPath;

	/** 원 파일 명 */
	private String orgFlNm;

	/** 파일 크기 */
	private Long flSz;
	
	/** 영상 외부 ID */
	private String outsideVdId;

	/** 영상 길이 */
	private Long vdLnth;

	/** 이력 번호 */
	private Long histNo;
	
	/** 펫스쿨 완료 여부 */
	private String cpltYn;
	
	public String getTtl() {
		return StringEscapeUtils.unescapeHtml4(ttl);
	}
	public String getDscrt() {
		return StringEscapeUtils.unescapeHtml4(dscrt);
	}
}
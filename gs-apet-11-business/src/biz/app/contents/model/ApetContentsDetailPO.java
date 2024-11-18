package biz.app.contents.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ApetContentsDetailPO extends BaseSysVO {

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
	
	/** 회원번호 */
	private Long mbrNo;

}
package biz.app.contents.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class ApetAttachFileVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 파일 번호 */
	private Long flNo;

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

	/** 영상 길이 */
	private Long vdLnth;

	/** SGR 영상 ID */
	private String outsideVdId;

	/** 시스템 삭제 여부 */
	private String sysDelYn;

	/** 시스템 삭제자 번호 */
	private Integer sysDelrNo;

	/** 시스템 삭제 일시 */
	private Timestamp sysDelDtm;

	/** 이력 번호 */
	private Long histNo;

}
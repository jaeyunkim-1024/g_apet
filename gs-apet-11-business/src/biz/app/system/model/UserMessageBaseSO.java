package biz.app.system.model;

import java.sql.Timestamp;

import org.apache.commons.lang.StringUtils;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class UserMessageBaseSO extends BaseSearchVO<UserBaseSO> {

	/** UID */
	private static final long serialVersionUID = 1L;


	/** 수신자 번호 */
	private Long usrNo;
	/** 쪽지 번호 */
	private Long noteNo;
	/** 수신 여부 */
	private String rcvYn;
	/** 수신 일시 */
	private Timestamp rcvDtm;
	/** 삭제 여부 */
	private String delYn;

	/** 목록 조회 모드 */
	private String mode;

	// 기본값은 받은 메시지 읽기
	public String getMode() {
		return StringUtils.isEmpty(this.mode) ? "RCV" : mode;
	}



}
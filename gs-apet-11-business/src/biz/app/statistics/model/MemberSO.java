package biz.app.statistics.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberSO extends BaseSearchVO<MemberSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 가입 시작 일시 */
	private Timestamp sysRegDtmStart;

	/** 가입 종료 일시 */
	private Timestamp sysRegDtmEnd;
}
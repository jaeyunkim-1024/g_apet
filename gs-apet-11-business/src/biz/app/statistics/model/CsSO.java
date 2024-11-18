package biz.app.statistics.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CsSO extends BaseSearchVO<CsSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** CS 접수 시작 일시 */
	private Timestamp cusAcptDtmStart;

	/** CS 접수 종료 일시 */
	private Timestamp cusAcptDtmEnd;

	/** CS 완료 시작 일시 */
	private Timestamp cusCpltDtmStart;

	/** CS 완료 종료 일시 */
	private Timestamp cusCpltDtmEnd;
}
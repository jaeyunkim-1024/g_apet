package biz.app.statistics.model;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberFlowReportVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 집계 일자 */
	private String totalDt;

	/**회원 현황 구분코드  10: 총 회원수 ,20: 신규회원수 ,30:이메일 수신 동의자수 ,40: sms 수신 동의자수 ,50: 탈퇴 회원수 ,60: 휴면 계정 전환자수 */
	private String mbrFlowGbCd;

	private long totMbrCnt;

	/** 20대 여성 */
	private long fm20;

	/** 30대 여성 */
	private long fm30;

	private long fm40;

	private long fm50;

	private long fm60;

	private long femaleSum;

	/** 20대 남성 */
	private long ml20;

	private long ml30;

	private long ml40;

	private long ml50;

	private long ml60;

	private long maleSum;


}

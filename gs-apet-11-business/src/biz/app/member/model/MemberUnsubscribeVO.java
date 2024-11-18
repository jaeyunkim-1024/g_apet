package biz.app.member.model;

import java.sql.Timestamp;
import java.util.List;

import framework.common.constants.CommonConstants;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberUnsubscribeVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Long mbrNo;

	/** 회원 명 */
	private String mbrNm;

	/** 로그인 아이디 */
	private String loginId;
	
	private String mobile;

	private String clientTelNo;
	
	private String[] clientTelNos;

	/** 이메일 */
	private String email;

	/** SMS 수신 여부 */
	private String smsRcvYn;

	/** SMS 수신 동의/거부 일시 */
	private Timestamp smsRcvDt;

	/** 마스킹 해제*/
	private String maskingUnlock = CommonConstants.COMM_YN_N;

	/** 마케팅 수신 여부*/
	private String mkngRcvYn;
	
	/** 080 수신거부 등록 시간 */
	private Timestamp registerTime;
	
	/** 080 수신거부 등록 수단*/
	private String registerType;
	
	private List<MemberBaseVO> unsubscribesList;
	
	private int totalCnt = 0;
	
	private int updateCnt = 0;
	
	private int failCnt = 0;
	
}
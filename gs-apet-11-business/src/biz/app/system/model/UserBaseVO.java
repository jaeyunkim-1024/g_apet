package biz.app.system.model;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class UserBaseVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사용자 번호 */
	private Long usrNo;

	/** 사용자 명 */
	private String usrNm;

	/** 비밀번호 */
	private String pswd;

	/** 사용자 상태 코드 */
	private String usrStatCd;
	
	/** 사용자 상태 명 */
	private String usrStatNm;

	/** 업체 번호 */
	private Long compNo;

	/** 업체명 */
	private String compNm;

	/** 업체 상태 코드 */
	private String compStatCd;

	/** 로그인 실패 수 */
	private Long loginFailCnt;

	/** 사용자 구분 코드 */
	private String usrGbCd;
	
	/** 사용자 구분 명 */
	private String usrGbNm;

	/** 비밀번호 초기화 여부 */
	private String pswdInitYn;
	
	/** 비밀번호 3개월 변경 여부 */
	private String pswdChgSchdYn;

	/** 로그인 아이디 */
	private String loginId;

	/** 사용자 그룹 코드 */
	private String usrGrpCd;

	/** 조직 번호 */
	private Long orgNo;

	/** 전화 */
	private String tel;

	/** 휴대폰 */
	private String mobile;

	/** 팩스 */
	private String fax;

	/** 이메일 */
	private String email;

	/** CTI ID : 상담원 */
	private String ctiId;

	/** CTI 내선 번호 : 상담원 */
	private String ctiExtNo;

	/** 비밀번호 변경 일시 */
	private Timestamp pswdChgDtm;

	/** 권한 번호 */
	private Long authNo;

	/** 권한명 */
	private String authNm;
	
	/** 상위 업체 번호 */
	private Long upCompNo;

	/** 상위 업체명 */
	private String upCompNm;

	/** MD 사용자 번호 */
	private Long mdUsrNo;
	
	/** 소속 명 */
	private String dpNm;
	
	/** 사용자 IP */
	private String usrIp;
	
	/** 유효기간 시작 */ 
	private String validStDtm;
	
	/** 유효기간 종료 */
	private String validEnDtm;
	
	/** 유효기간 시작~유효기간 종료 */
	private String validDtm;
	
	/** 최종 로그인 일시 */
	private Timestamp lastLoginDtm;
	
	/** 로그인 30일지났는지 여부*/
	private String loginAMonthYn;
	
	/** 접속 유효기간 지났는지 여부*/
	private String validYn;
	


	/** 시스템 등록자 명 */
	private String		sysRegrNm;

	/** 시스템 등록 일시 */
	private Timestamp	sysRegDtm;

	/** 시스템 수정자 명 */
	private String		sysUpdrNm;

	/** 시스템 수정 일시 */
	private Timestamp	sysUpdDtm;
	
	
	/** 1 Depth */
	private String menuNmOne;
	
	/** 2 Depth */
	private String menuNmTwo;
	
	/** 3 Depth */
	private String menuNmThree;	
	
	/** 최근2회 비밀번호 이력*/
	private List<String> pswdHist;
	
	
	/** row number */
	private int rowNum;
}
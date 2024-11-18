package biz.app.system.model;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class UserBasePO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사용자 번호 */
	private Long usrNo;

	/** 사용자 명 */
	private String usrNm;

	/** 비밀번호 */
	private String pswd;
	
	/** 이전 패스워드 */
	private String prePswd;

	/** 사용자 상태 코드 */
	private String usrStatCd;

	/** 업체 번호 */
	private Long compNo;

	/** 로그인 실패 수 */
	private Long loginFailCnt;

	/** 사용자 구분 코드 */
	private String usrGbCd;

	/** 비밀번호 초기화 여부 */
	private String pswdInitYn;

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
	
	/** 소속 명 */
	private String dpNm;
	
	/** 사용자 IP */
	private String usrIp;
	
	/** 유효기간 시작 */
	private String validStDtm;
	
	/** 유효기간 종료 */
	private String validEnDtm;
	
	/** 최종 로그인 일시 */
	private Timestamp lastLoginDtm;
	
	private String lastLoginDtmStr;
	
	/** 권한 리스트 */
	private List<Long> authorityPOList;
	
	/*사용자 서브 구분 코드*/
	private String usrSubGbCd;
}
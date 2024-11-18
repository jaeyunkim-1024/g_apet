package framework.admin.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

/**
 * Admin Session 정보
 *
 * @author valueFactory
 * @since 2015. 06. 13
 *
 */
@Data
public class Session implements Serializable {

	private static final long serialVersionUID = 1L;

	private String	sessionId;

	/** 사용자 번호 */
	private Long	usrNo;

	/** 사용자 명 */
	private String	usrNm;

	/** 사용자 상태 코드 */
	private String	usrStatCd;

	/** 업체 번호 */
	private Long	compNo;

	/** 로그인 아이디 */
	private String	loginId;

	/** 사용자 그룹 코드 */
	private String	usrGrpCd;

	/** 업체 번호 */
	private String	compNm;

	/** 업체 상태 코드 */
	private String	compStatCd;

	/** 권한 번호 */
	private Long authNo;

	/** 권한 번호 리스트 */
	private List<Long> authNos;

	/** 사용자 구분 코드 */
	private String	usrGbCd;

	/** CTI ID */
	private String	ctiId;

	/** CTI 내선 번호 */
	private String	ctiExtNo;

	/** 상위 업체 번호 */
	private Long	upCompNo;

	/** 상위 업체명 */
	private String	upCompNm;

	/** MD 사용자 번호 */
	private Long	mdUsrNo;

	/** 최종 로그인 일시 */
	private Timestamp lastLoginDtm;

	/*메뉴 번호*/
	private Long menuNo;

	/*기능 번호*/
	private Long actNo;
}
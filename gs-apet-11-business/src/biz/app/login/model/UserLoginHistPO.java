package biz.app.login.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class UserLoginHistPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사용자 번호 */
	private Long usrNo;

	/** 로그인 IP */
	private String loginIp;

	/** 로그인 일시 */
	private Timestamp loginDtm;

}
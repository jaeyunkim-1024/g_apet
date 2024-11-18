package biz.app.system.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class UserLoginHistVO extends UserBaseVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 로그인 IP */
	private String loginIp;

	/** 로그인 일시 */
	private Timestamp loginDtm;

}
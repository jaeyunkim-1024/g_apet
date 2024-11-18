package biz.app.member.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberLoginHistVO extends BaseSysVO {
	
	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Long mbrNo;

	/** 태그번호  */
	private Timestamp loginDtm;
	
	private String loginIp;
	
	private String loginPathCd;
	
	private Long sysRegrNo;
	
	private Timestamp sysRegDtm;

}

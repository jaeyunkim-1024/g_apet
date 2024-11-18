package biz.app.system.model;

import java.sql.Timestamp;
import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class UserAgreeInfoVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 사용자 번호 */
	private Long usrNo;
	
	/** 약관 번호 */
	private String termsNo;
}

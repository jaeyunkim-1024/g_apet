package biz.app.system.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class UserAuthHistVO extends BaseSysVO {
	
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** rownum */
	private Long rowIndex;
	
	/** 이력 번호*/
	private Long histNo;
	
	/** 로그인 아이디*/
	private String loginId;
	
	/** 사용자 번호*/
	private Integer usrNo;
	
	/** 사용자 명*/
	private String usrNm;
	
	/** 권한 번호*/
	private Integer authNo;
	
	/** 권한 명*/
	private String authNm;
	
	/** 이전 권한 번호*/
	private Integer bfrAuthNo;
	
	/** 이전 권한 명*/
	private String bfrAuthNm;
	
}

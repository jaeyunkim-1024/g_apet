package biz.app.system.model;


import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class UserAuthHistSO extends BaseSearchVO<UserAuthHistSO> {
	
	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사용자 번호*/
	private Integer usrNo;
	
	/** 사용자 명*/
	private String usrNm;
	
	/** 사용자 ID*/
	private String loginId;
	
	/** 변경자 명*/
	private String sysRegrNm;
	
	/** 변경자 ID*/
	private String sysRegrId;
}

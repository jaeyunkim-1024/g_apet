package biz.app.member.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class TermsRcvHistoryPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 동의이력번호 */
	private Long termsAgreeHistNo;
	
	/** 회원 번호 */
	private Long mbrNo;

	/** 메뉴코드 */
	private String menuCd;
	
	/** 이용약관번호 */
	private int termsNo;
	
	/** 이름 */
	private String name;
	
	/** 휴대폰 */
	private String mobile;
	
	/** 이메일 */
	private String email;

	/** 동의여부 */
	
	private String rcvYn;
	/** 동의/거부일시 */
	private Timestamp rcvDt;

	

}
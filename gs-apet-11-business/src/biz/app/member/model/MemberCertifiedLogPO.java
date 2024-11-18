package biz.app.member.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberCertifiedLogPO extends BaseSysVO{
	
	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Long mbrNo;

	/** 인증로그번호 */
	private Long ctfLogNo;

	/** 인증방법코드 */
	private String ctfMtdCd;
	
	/** 인증유형코드 */
	private String ctfTpCd;
	
	/** CI인증값 */
	private String ciCtfVal;
	
	/** DI인증값 */
	private String diCtfVal;
	
	/** 인증키 */
	private String ctfKey;
	
	/** 인증결과코드 */
	private String ctfRstCd;

}

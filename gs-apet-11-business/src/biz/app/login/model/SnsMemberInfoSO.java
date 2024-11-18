package biz.app.login.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class SnsMemberInfoSO extends BaseSysVO {
	
	/** UID */
	private static final long serialVersionUID = 1L;


	/** sns 고유식별자 */
	private String snsUuid;

	/** 가입경로 */
	private String snsLnkCd;

	/** sns로 가입여부 */
	private String snsJoinYn;
	
	/** 회원번호*/
	private Long mbrNo;
	
	/** 이메일 */
	private String email;

	/** 애플 비공개 이메일 */
	private String emailApple;
	
	/** CI코드*/
	private String ciCtfVal;
	
	/** 회원명*/
	private String mbrNm;
	
	/** 성별*/
	private String gender;
	
	/** 생년월일*/
	private String birth;
	
	/** 핸드폰번호*/
	private String mobile;
	
	/** SNS상태코드*/
	private String snsStatCd ; 
	
	/** 어바웃펫 로그인 id*/
	private String loginId;

	/** 닉네임*/
	private String nickNm;

}

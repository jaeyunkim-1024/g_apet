package biz.twc.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CounslorPO {
	/** API 사용자 Key */
	private String apiKey;
	
	/** 브랜드 아이디 */
	private Long brandId;
	
	/** 고객 아이디 */
	private String loginId;
	
	/** 이름 */
	private String name;
	
	/** 비밀번호 */
	private String password;
	
	/** 비밀번호 확인 */
	private String retryPassword;
	
	/** 이메일 */
	private String email;
	
	/** 전화번호 */
	private String phoneNumber;
}
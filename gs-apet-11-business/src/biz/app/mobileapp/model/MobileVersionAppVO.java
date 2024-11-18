package biz.app.mobileapp.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper=false)
@Data
public class MobileVersionAppVO {
	
	@SuppressWarnings("unused")
	private static final long serialVersionUID = 1L;
	
	/** 앱 버전 번호 */
	private Long	verNo;
	
	/** 단말 OS 정보 (A:안드로이드, I:iOS) */
	private String	mobileOs = "";
	
	/** 앱 버전 */
	private String	appVer = "";
	
	/** 업데이트 내용 */
	private String	message = "";
	
	/** 강제 업데이트 여부 (N:선택, Y:강제) */
	private String	requiredYn = "";
	
	/** 업데이트 URL */
	private String	updateUrl = "";
	
	/** 업데이트 등록일시 */
	private String	marketRegDtm = "";
	
}
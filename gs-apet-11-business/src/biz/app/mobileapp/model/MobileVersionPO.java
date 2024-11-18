package biz.app.mobileapp.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
@Data
public class MobileVersionPO extends BaseSysVO {
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
	
	/** 앱 버전 번호 n개 스트링 */
	private String	verNos = "";
	
	/** 업데이트 일자 */
	private String	verStrtDt = ""; 
	
	/** 업데이트 시간 */
	private String	verStrtHr = ""; 
	
	/** 업데이트 분 */
	private String	verStrtMn = ""; 
}
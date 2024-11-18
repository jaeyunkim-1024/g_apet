package biz.app.mobileapp.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
@Data
public class MobileVersionVO extends BaseSysVO {
	
	/** 앱 버전 번호 */
	private Long	verNo;
	
	/** 단말 OS 정보 (A:안드로이드, I:iOS) */
	private String	mobileOs = "";
	
	/** 단말 OS 정보명 (A:안드로이드, I:iOS) */
	private String  mobileOsNm = "";
	
	/** 앱 버전 */
	private String	appVer = "";
	
	/** 업데이트 내용 */
	private String	message = "";
	
	/** 강제 업데이트 여부 (N:선택, Y:강제) */
	private String	requiredYn = "";
	
	/** 강제 업데이트명 (N:선택, Y:강제) */
	private String	requiredYnNm = "";
	
	/** 업데이트 URL */
	private String	updateUrl = "";
	
	/** 업데이트 등록일시 */
	private String	marketRegDtm = "";
	
	/** 시스템 등록자 명 */
	private String sysRegrNm = "";
	
	/** 등록일 */
	private String	sysRegDt = "";
	
	/** 시스템 수정자 명 */
	private String sysUpdrNm = "";
	
	/** 수정일 */
	private String 	sysUpdDt = ""; 
	
	/** 등록자ID */
	private String 	sysRegrId = "";
	
	/** 시스템 등록자 명 */
	private String	sysUpdrId = "";
	
	/** 최신버전여부 */
	private String nowVerYn;
	
}
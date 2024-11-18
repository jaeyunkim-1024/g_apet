package biz.app.mobileapp.model;

import java.sql.Timestamp;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.mobileapp.model
* - 파일명	: MobileVersionSO.java
* - 작성일	: 2017. 05. 11.
* - 작성자	: wyjeong
* - 설명		: 모바일 앱 버전 Search Object
* </pre>
*/
@SuppressWarnings("serial")
@EqualsAndHashCode(callSuper=false)
@Data
public class MobileVersionSO extends BaseSearchVO<MobileVersionSO> {
	
	/** 앱 버전 번호 */
	private Long verNo;
	
	/** 단말 OS 정보 (A:안드로이드, I:iOS) */
	private String mobileOs = "";
	
	/** 앱 버전 */
	private String appVer = "";
	
	/** 단말 OS 정보 (A:안드로이드, I:iOS) 배열 */
	private String[] arrMobileOs;
	
	/** 업데이트 일 : Start */
	private Timestamp verUpStrtDtm;

	/** 업데이트 일 : End */
	private Timestamp verUpEndDtm;
	
	/** 버전 등록 후 저장된 업데이트 일자 */
	private String returnDt = "";
}